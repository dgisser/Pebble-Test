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


@end
