//
//  CacheController.h
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheController : NSObject

+ (instancetype)sharedCache;
- (NSMutableArray*)cachedElementsForKey:(NSString*)cacheKey;
- (void)setCachedElements:(NSMutableArray*)elementsToCache ForKey:(NSString*)cacheKey;
- (int) getCacheSize;
- (int)getUserInputValue;
- (void)setUserInputValue: (int)enteredMaxNumber;

@end

NS_ASSUME_NONNULL_END
