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
    self.cells = [[NSMutableArray alloc] init];
    [super viewDidLoad];
    [StreamHandlerSingleton sharedSingleton].viewController = self;
    self.commandTableView.delegate = self;
    self.commandTableView.dataSource = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receivedCommand
{
    [self.commandTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)receivedAbsoluteCommand
{
    NSArray* selectedRows = [self.commandTableView indexPathsForSelectedRows];
    for (NSIndexPath* path in selectedRows)
    {
        [self.commandTableView deselectRowAtIndexPath:path animated:NO];
    }
    [self.commandTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //return [self.some count];
    return [self.cells count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.textLabel.text = self.cells[indexPath.row];
    
    return cell;
}

@end
