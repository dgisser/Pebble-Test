//
//  SecondViewController.m
//  PebbleTest
//
//  Created by David Gisser on 4/7/15.
//  Copyright (c) 2015 Pebble. All rights reserved.
//

#import "SecondViewController.h"
#import "StreamHandlerSingleton.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [StreamHandlerSingleton sharedSingleton].secondViewController = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateColor
{
    NSArray* colors = [StreamHandlerSingleton sharedSingleton].colors;
    [self.colorLabel setBackgroundColor:[UIColor colorWithRed:[colors[0] intValue]/255.0 green:[colors[1] intValue]/255.0 blue:[colors[2] intValue]/255.0 alpha:1.0]];
}


@end
