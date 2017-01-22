//
//  main.m
//  LeetCode
//
//  Created by Neo on 11/24/16.
//  Copyright © 2016 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

/* [1,3], [2,6], [8,10], [15,18] */
NSArray* merged_interval( NSArray* intervals ){
    
    NSMutableSet *uniqueInterval = [NSMutableSet set];
    for( NSArray* interval in intervals ){
        for( NSInteger i=[interval[0] integerValue];i<=[interval[1] integerValue];i++ ){
            [uniqueInterval addObject:@(i)];
        }
    }
    
    NSArray*sortedArray = [[uniqueInterval allObjects] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 integerValue]>[obj2 integerValue];
    }];

    
    NSMutableArray *mergedIntervals = [NSMutableArray array];
    NSInteger location = [[sortedArray firstObject] integerValue];;
    NSInteger previous = location;
    NSInteger length = 0;
    for(  int i=1;i<sortedArray.count;i++ ){
        NSNumber *e = [sortedArray objectAtIndex:i];
        if ( ([e integerValue]-previous) == 0 ) {
            continue;
        }else if( [e integerValue]-previous == 1 ){
            /* in a range */
            length += 1;
        }else{
            /* merge interval */
            NSArray *mergedInterval = @[ @(location), @(location+length) ];
            [mergedIntervals addObject:mergedInterval];
            
            /* start a new search */
            location = [e integerValue];
            length = 0;
        }
        
        /* merge the last item */
        if( i == sortedArray.count-1 ){
            NSArray *mergedInterval = @[ @(location), @(location+length) ];
            [mergedIntervals addObject:mergedInterval];
        }
        
        previous = [sortedArray[i] integerValue];
    }
    
    return [NSArray arrayWithArray:mergedIntervals];

}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        /* test case */
        NSArray *intervals1 = @[ @[@1, @3], @[@2, @6], @[@8, @10] , @[@15, @18] ];
        NSArray *intervals2 = @[ @[@1, @3], @[@4, @6], @[@8, @10] , @[@15, @18] ];
        NSArray *intervals3 = @[ @[@1, @10], @[@4, @6], @[@8, @9] ];
        NSArray *intervals4 = @[ @[@1, @10], @[@1, @9] ];
        NSArray *intervals5 = @[ @[@1, @10] ];
        NSArray *intervals6 = @[ @[@4, @6] , @[@15, @18], @[@8, @10] , @[@1, @3] ];
        
        /* test run */
        NSLog(@"1: %@" , merged_interval(intervals1));
        NSLog(@"2: %@" , merged_interval(intervals2));
        NSLog(@"3: %@" , merged_interval(intervals3));
        NSLog(@"4: %@" , merged_interval(intervals4));
        NSLog(@"5: %@" , merged_interval(intervals5));
        NSLog(@"6: %@" , merged_interval(intervals6));
        
    }
    return 0;
}
