//
//  Station.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@implementation Station

- (instancetype)initWithPlace:(Place *)place {
    self = [super init];
    if (self) {
        self.place = place;
    }
    return self;
}

@end
