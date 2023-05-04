//
//  NetworkServiceObjc.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationsTableViewModel.h"
#import "StationResponse.h"

@implementation NetworkServiceObjc

static NSString *const kApiKey = @"vLCKJbdVz94Wskr_X3hLV3bk7aYD5Fm6eDiTSbpuIcg";

- (void)getStationsFromLocation:(CLLocation *)location completion:(void (^)(NSArray<Station *> *stations, NSError *error))completion {
    [self fetchStationDataForLocation:location completion:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error fetching station data: %@", error.localizedDescription);
            if (completion) {
                completion(nil, error);
            }
        } else {
            NSArray<Station *> *stations = [self stationsFromData:data];
            if (completion) {
                completion(stations, nil);
            }
        }
    }];
}

- (void)fetchStationDataForLocation:(CLLocation *)location completion:(void (^)(NSData *data, NSError *error))completion {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://transit.hereapi.com/v8/stations?in=%f,%f&apiKey=%@", location.coordinate.latitude, location.coordinate.longitude, kApiKey]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (completion) {
            completion(data, error);
        }
    }];
    [task resume];
}

- (NSArray<Station *>*)stationsFromData:(NSData *)data {
    StationResponse *stationResponse = [[StationResponse alloc] initWithData:data];
    return stationResponse.stations;
}

@end


