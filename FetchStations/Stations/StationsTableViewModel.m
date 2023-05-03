//
//  StationsTableViewModel.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationsTableViewModel.h"

@implementation StationsTableViewModel

- (instancetype)initWithNetworkService:(NetworkService *)networkService {
    self = [super init];
    if (self) {
        _networkService = networkService;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return  5;
}

- (NSInteger)numberOfSections {
    return 1;
}

@end
