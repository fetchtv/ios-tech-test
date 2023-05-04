//
//  StationsTableViewController.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationsTableViewController.h"
#import "StationTableViewCell.h"

@interface StationsTableViewController () <StationsTableViewModelDelegate>

@end

@implementation StationsTableViewController

- (instancetype)initWithViewModel:(StationsTableViewModel *)viewModel {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _viewModel = viewModel;
        _viewModel.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Fetch Stations";
    self.view.backgroundColor = [UIColor redColor];

    [self.tableView registerClass:[StationTableViewCell class] forCellReuseIdentifier:@"StationTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_viewModel numberOfRowsInSection:section];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StationTableViewCell" forIndexPath:indexPath];

    Station *station = self.viewModel.stations[indexPath.row];

    [cell configureWithStation:station];

    return cell;
}

#pragma mark - ViewModel delegate methods

- (void)stationsDidLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)stationsDidFailWithError:(NSError *)error {
    // handle the error as appropriate
}

@end
