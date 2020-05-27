//
//  FibonacciHelper.h
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FibonacciHelper : NSObject
//-(void)generateFibonacci:(long)key;
-(NSMutableArray*)generateFibonacci:(int)start_index andEnd:(int)end_index;
-(NSMutableArray*)fetchFibonacci:(int) start_index;
-(void)generateAndCacheFibo:(int)cache_index;
-(NSMutableArray*) getFibboSeriesforKey : (long)key;
-(void) setFibboSeries: (NSMutableArray*)generatedArray forKey : (long)key;
//-(int)getGeneratedSequenceCount;
//-(NSString*)getElementAtIndex:(long)rowIndex;
@end

NS_ASSUME_NONNULL_END
