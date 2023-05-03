//
//  StationsTableViewModel.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "FetchStations-Swift.h"

@interface StationsTableViewModel : NSObject

@property (nonatomic, strong) NetworkService *networkService;

- (instancetype)initWithNetworkService:(NetworkService *)networkService;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end
