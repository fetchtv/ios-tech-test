//
//  StationsTableViewController.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <UIKit/UIKit.h>
#import "StationsTableViewModel.h"

@interface StationsTableViewController : UITableViewController

@property (nonatomic, strong) StationsTableViewModel *viewModel;

@end
