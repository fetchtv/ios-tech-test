//
//  StationResponse.h
//  FetchStations
//
//  Created by Waylan Sands on 3/5/2023.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@interface StationResponse : NSObject

@property (nonatomic, copy) NSArray<Station *>* _Nullable stations;

- (nullable instancetype)initWithData:(NSData *_Nonnull)data;

@end
