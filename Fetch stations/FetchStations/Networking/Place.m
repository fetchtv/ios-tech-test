//
//  Place.m
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@implementation Place

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.type = dictionary[@"type"];
        self.id = dictionary[@"id"];
    }
    return self;
}

@end
