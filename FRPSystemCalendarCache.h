//
//  FRPSystemCalendarCache.h
//
//  Created by Francisco José  Rodríguez Pérez on 30/03/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FRPSystemCalendarCache : NSObject

@property (nonatomic) NSCalendar *currentCalendarCached;

+ (FRPSystemCalendarCache *)sharedInstance;

@end
