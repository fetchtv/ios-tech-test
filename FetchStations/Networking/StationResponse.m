//
//  StationResponse.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import "StationResponse.h"
#import "Station.h"

@implementation StationResponse

- (nullable instancetype)initWithData:(NSData *)data {
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [self initWithDictionary:jsonObject];
}

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSArray *stationsData = dictionary[@"stations"];
        NSMutableArray<Station *>* stations = [NSMutableArray new];

        for (NSDictionary *stationData in stationsData) {
            Place *place = [[Place alloc] initWithDictionary: stationData[@"place"]];
            Station *station = [[Station alloc] initWithPlace: place];
            [stations addObject:station];
        }

        self.stations = stations;
    }
    return self;
}


@end
