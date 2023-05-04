//
//  Station.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "Place.h"

@interface Station : NSObject <NSCoding>

@property (nonatomic, strong) Place *place;

- (instancetype)initWithPlace:(Place *)place;

@end
