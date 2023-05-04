//
//  StationsTableViewController.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationsTableViewController.h"

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

#pragma mark - ViewModel delegate methods

- (void)stationsDidLoad {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"stationsDidLoad");
        [self.tableView reloadData];
    });
}

- (void)stationsDidFailWithError:(NSError *)error {
    // handle the error as appropriate
}

@end
