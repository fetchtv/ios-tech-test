//
//  StationsTableViewModel.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <CoreLocation/CoreLocation.h>
#import "NetworkServiceObjc.h"

@protocol StationsTableViewModelDelegate <NSObject>

- (void)stationsDidFailWithError:(NSError *)error;
- (void)stationsDidLoad;

@end

@interface StationsTableViewModel : NSObject

@property (nonatomic, weak) id<StationsTableViewModelDelegate> delegate;
@property (nonatomic, strong) NetworkServiceObjc *networkService;
@property (nonatomic, copy) NSArray<Station *>* stations;

- (instancetype)initWithNetworkService:(NetworkServiceObjc *)networkService;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

- (void)fetchDataFromLocation:(CLLocation *)location;

@end
