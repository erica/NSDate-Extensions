//
//  FRPSystemCalendarCache.m
//
//  Created by Francisco José  Rodríguez Pérez on 30/03/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "FRPSystemCalendarCache.h"

@interface FRPSystemCalendarCache ()

- (void)handleSignificantTimeChange;

@end

@implementation FRPSystemCalendarCache

+ (FRPSystemCalendarCache *)sharedInstance
{
    static FRPSystemCalendarCache *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[FRPSystemCalendarCache alloc] init];
    });
    
    return _instance;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleSignificantTimeChange)
                                                     name:UIApplicationSignificantTimeChangeNotification
                                                   object:nil];
    }
    return self;
}

- (NSCalendar *)currentCalendarCached
{
    if (!_currentCalendarCached) {
        _currentCalendarCached = [NSCalendar currentCalendar];
    }
    
    return _currentCalendarCached;
}

#pragma mark - Private methods

- (void)handleSignificantTimeChange
{
    _currentCalendarCached = nil;
}

@end
