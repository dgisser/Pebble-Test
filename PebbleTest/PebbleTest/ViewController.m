//
//  ViewController.m
//  PebbleTest
//
//  Created by David Gisser on 4/7/15.
//  Copyright (c) 2015 Pebble. All rights reserved.
//

#import "ViewController.h"
#import "StreamHandlerSingleton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [StreamHandlerSingleton sharedSingleton].viewController = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
