//
//  StationsTableViewController.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationsTableViewController.h"
#import "StationsTableViewModel.h"

@interface StationsTableViewController ()

@end

@implementation StationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Fetch Stations";

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfRowsInSection:section];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    return cell;
}

@end
