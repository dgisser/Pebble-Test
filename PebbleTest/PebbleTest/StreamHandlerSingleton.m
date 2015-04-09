//
//  StreamHandlerSingleton.m
//  PebbleTest
//
//  Created by David Gisser on 4/8/15.
//  Copyright (c) 2015 Pebble. All rights reserved.
//

#import "StreamHandlerSingleton.h"
#include <CoreFoundation/CoreFoundation.h>
#include <sys/socket.h>
#include <netinet/in.h>

@implementation StreamHandlerSingleton
@synthesize inputStream;
static StreamHandlerSingleton *_sharedSingleton = nil;

- (id) init
{
    if (self = [super init])
    {
        self.colors = @[@127,@127,@127];
        [self initNetworkCommunication];
    }
    return self;
}

+ (StreamHandlerSingleton *)sharedSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSingleton = [[StreamHandlerSingleton alloc] init];
    });
    return _sharedSingleton;
}


- (void) initNetworkCommunication {
    
    CFReadStreamRef readStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"localhost", 1234, &readStream, NULL);
    
    inputStream = (__bridge NSInputStream *)readStream;
    [inputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    
}

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSLog(@"stream event %lu", streamEvent);
    
    switch (streamEvent) {
            
        case NSStreamEventOpenCompleted:
            NSLog(@"Stream opened");
            break;
        case NSStreamEventHasBytesAvailable:
            
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                long len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    NSLog(@"LENGTH: %ld",len);
                    if (len > 0) {
                        
                        [self messageReceived:buffer];
                    }
                }
            }
            break;
            
            
        case NSStreamEventErrorOccurred:
            
            NSLog(@"Can not connect to the host!");
            break;
            
        case NSStreamEventEndEncountered:
            
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            theStream = nil;
            
            break;
        default:
            NSLog(@"Unknown event");
    }
    
}

- (void) messageReceived:(uint8_t *)message {
    NSString* text;
    if (message[0] == 0x01) {
        int16_t red = message[1] << 8;
        red |= message[2];
        int16_t blue = message[3] << 8;
        blue |= message[4];
        int16_t green = message[5] << 8;
        green |= message[6];
        self.colors = @[@([self.colors[0] intValue] + red), @([self.colors[1] intValue] + blue),@([self.colors[2] intValue] + green)];
        NSLog(@"1, red:%d; blue: %d; green %d",red, blue, green);
        text = [NSString stringWithFormat:@"1, red:%d; blue: %d; green %d",red, blue, green];
    }
    else
    {
        self.colors = @[@(message[1]),@(message[2]),@(message[3])];
        NSLog(@"2, red: %d; blue: %d; green %d",message[1],message[2],message[3]);
        text = [NSString stringWithFormat:@"2, red: %d; blue: %d; green %d",message[1],message[2],message[3]];
    }
    [self.viewController.cells insertObject:text atIndex:0];
    
    [self.viewController.commandTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (message[0] == 0x01)
        [self.viewController receivedCommand];
    else
        [self.viewController receivedAbsoluteCommand];
    [self.secondViewController.colorLabel setBackgroundColor:[UIColor colorWithRed:[self.colors[0] intValue]/255.0 green:[self.colors[1] intValue]/255.0 blue:[self.colors[2] intValue]/255.0 alpha:1.0]];
}
@end
