//
//  NetworkServiceObjc.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <CoreLocation/CoreLocation.h>
#import "Station.h"

@interface NetworkServiceObjc : NSObject

- (void)getStationsFromLocation:(CLLocation *)location completion:(void (^)(NSArray<Station *> *stations, NSError *error))completion;

@end
