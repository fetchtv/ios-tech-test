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
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate stationsDidFailWithError:error];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.stations = stations;
                [self.delegate stationsDidLoad];
            });
        }
    }];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (self.stations) {
        NSLog(@"added count %lu", (unsigned long)self.stations.count);
        return self.stations.count;
    } else {
        NSLog(@"zero rows");
        return 0;
    }
}

- (NSInteger)numberOfSections {
    return 1;
}

@end
