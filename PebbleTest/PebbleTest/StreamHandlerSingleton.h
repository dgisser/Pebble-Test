//
//  StreamHandlerSingleton.h
//  PebbleTest
//
//  Created by David Gisser on 4/8/15.
//  Copyright (c) 2015 Pebble. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "SecondViewController.h"

@interface StreamHandlerSingleton : NSObject<NSStreamDelegate>{
    
    NSInputStream *inputStream;
    
}

@property (weak, nonatomic) ViewController* viewController;
@property (weak, nonatomic) SecondViewController* secondViewController;
@property (retain, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSArray* colors; //[uint8_t r, g, b]

- (void) initNetworkCommunication;
- (void) messageReceived:(uint8_t *)message;
+ (StreamHandlerSingleton *)sharedSingleton;

@end
