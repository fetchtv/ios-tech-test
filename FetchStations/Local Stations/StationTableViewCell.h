//
//  StationTableViewCell.h
//  FetchStations
//
//  Created by Waylan Sands on 4/5/2023.
//

#import "StationTableViewCell.h"
#import <UIKit/UIKit.h>
#import "Station.h"

@interface StationTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *placeNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeTypeLabel;

- (void)configureWithStation:(Station *)station;

@end
