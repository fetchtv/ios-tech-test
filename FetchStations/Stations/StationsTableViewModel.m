//
//  StationsTableViewModel.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "StationsTableViewModel.h"

@implementation StationsTableViewModel

- (instancetype)initWithNetworkService:(NetworkServiceObjc *)networkService {
    self = [super init];
    if (self) {
        _networkService = networkService;
    }
    return self;
}

- (void)fetchDataFromLocation:(CLLocation *)location {
    [self->_networkService getStationsFromLocation:location completion:^(NSArray<Station *> *stations, NSError *error) {
        if (error) {
            [self.delegate stationsDidFailWithError:error];
        } else {
            self.stations = stations;
            [self.delegate stationsDidLoad];
        }
    }];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (self.stations) {
        return self.stations.count;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSections {
    return 1;
}

@end
