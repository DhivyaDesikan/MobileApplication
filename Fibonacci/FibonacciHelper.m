//
//  FibonacciHelper.m
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import "FibonacciHelper.h"
#import "CacheController.h"

@implementation FibonacciHelper

/* Generates the Fibonacci Series based on start and end index */
-(NSMutableArray*)generateFibonacci:(int)start_index andEnd:(int)end_index
{
    NSMutableArray *fibSeries = [NSMutableArray new];
    int counter = 0;
    long double  prev = 0;
    long double  total = 1;
    int cache_size = [[CacheController sharedCache]getCacheSize];

    if(start_index <= 1)
    {
        [fibSeries addObject:[NSNumber numberWithDouble:prev]];
        [fibSeries addObject:[NSNumber numberWithDouble:total]];
        counter+= 2;
    }
    else
    {
        int previousKey = (start_index/cache_size) -1;
        NSMutableArray *tempArray = [self getFibboSeriesforKey:previousKey];
        NSString *totalStr = [tempArray objectAtIndex:([tempArray count]-1)];
        total = [totalStr doubleValue];
        NSString *previousStr = [tempArray objectAtIndex:([tempArray count]-2)];
        prev = [previousStr doubleValue];
        
    }
    for(int loopCount = counter; loopCount < cache_size; loopCount++)
    {
        total = total + prev;
        prev = total - prev;
        [fibSeries addObject:[NSNumber numberWithDouble:total]];
    }

    return fibSeries;
}

/* Retrieves the generated Fibonacci sequence*/
-(NSMutableArray*) getFibboSeriesforKey : (long)key
{
    return [[CacheController sharedCache] cachedElementsForKey:[NSString stringWithFormat:@"%ld",key]];
}

/*Returns the required UI data from cache. Data is generated if not available*/
-(NSMutableArray*)fetchFibonacci:(int) start_index
{
    int cache_size =  [[CacheController sharedCache]getCacheSize];
    int cacheIndex = start_index/ cache_size;
    NSMutableArray *fetchedArray ;
    if(![self getFibboSeriesforKey:cacheIndex])
        [self generateAndCacheFibo:cacheIndex];
    fetchedArray = [self getFibboSeriesforKey:cacheIndex];
    NSMutableArray *tempArray = [NSMutableArray new];
    int ui_count = [[[NSBundle mainBundle]objectForInfoDictionaryKey:@"UI_COUNT"]intValue];
    
    if(start_index >= cache_size)
        start_index = start_index % cache_size;
    for(int counter = start_index;counter<ui_count+start_index;counter++)
    {
        [tempArray addObject:[fetchedArray objectAtIndex:counter]];
    }
    
    return  tempArray;
}

/*Calls the Fibonacci generator and caches the sequence generated for the cache index*/
-(void)generateAndCacheFibo:(int)cache_index
{
    int cache_size =  [[CacheController sharedCache]getCacheSize];
    int fibo_index = cache_index*cache_size;
    NSMutableArray *fiboArray = [self generateFibonacci:fibo_index andEnd:fibo_index+cache_size];
    [self setFibboSeries:fiboArray forKey:cache_index];
}

/* Sets the generated series in the Cache */
-(void) setFibboSeries: (NSMutableArray*)generatedArray forKey : (long)key
{
     [[CacheController sharedCache] setCachedElements:generatedArray ForKey:[NSString stringWithFormat:@"%ld", key]];
}

@end
 
