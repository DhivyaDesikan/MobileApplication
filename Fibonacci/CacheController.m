//
//  CacheController.m
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import "CacheController.h"

@interface CacheController()
{
NSCache *fibboCache;
int userInputValue;
int cache_size;
}
@end

@implementation CacheController
+ (instancetype)sharedCache
{
    static CacheController *sharedInstance = nil;
    static dispatch_once_t dispatchToken;
    
    dispatch_once(&dispatchToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        fibboCache = [[NSCache alloc]init];
        int ui_count =  [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"UI_COUNT"] intValue];
        int cache_multiplication_factor =  [[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CACHE_MULTIPLICATION_FACTOR"] intValue];
        cache_size = ui_count * cache_multiplication_factor;


    }
    return self;
}

/* Returns the cached elements in the cacheKey */
- (NSMutableArray*)cachedElementsForKey:(NSString*)cacheKey
{

    return [fibboCache objectForKey:cacheKey];
}

/* Returns the cache size */
- (int) getCacheSize
{
    return  cache_size;
}

- (int)getUserInputValue
{
    return userInputValue;
}

/* Sets the user input value for display */
- (void)setUserInputValue: (int)enteredMaxNumber
{
    userInputValue = enteredMaxNumber;
}

/* Caches the generated sequence for the cacheKey */
- (void)setCachedElements:(NSMutableArray*)elementsToCache ForKey:(NSString*)cacheKey {
    
    [fibboCache setObject:elementsToCache forKey:cacheKey];
}

@end
