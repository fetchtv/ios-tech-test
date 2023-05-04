//
//  StationTableViewCell.m
//  FetchStations
//
//  Created by Waylan Sands on 4/5/2023.
//

#import "StationTableViewCell.h"

@implementation StationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)configureWithStation:(Station *)station {
    self.placeNameLabel.text = station.place.name;
    self.placeTypeLabel.text = station.place.type;
}

@end
