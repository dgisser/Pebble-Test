//
//  ViewController.h
//  PebbleTest
//
//  Created by David Gisser on 4/7/15.
//  Copyright (c) 2015 Pebble. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *commandTableView;
@property (strong, nonatomic) NSMutableArray* cells;

- (void)receivedCommand;
- (void)receivedAbsoluteCommand;

@end

