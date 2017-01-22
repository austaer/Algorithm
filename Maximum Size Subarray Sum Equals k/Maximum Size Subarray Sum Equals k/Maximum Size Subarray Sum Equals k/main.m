//
//  main.m
//  Maximum Size Subarray Sum Equals k
//
//  Created by Neo on 11/26/16.
//  Copyright © 2016 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>


NSInteger maxSizeOfSubArrayWithSumK( NSArray *nums, NSInteger k){
    
    NSUInteger leng = nums.count;
    NSInteger maxLeng = 0;
    for (int i=0; i<leng; i++) {
        for (int j=i; j<leng; j++) {
            
            NSArray *subArray = [nums subarrayWithRange:NSMakeRange(i, j-i+1)];
            NSNumber *sum = (NSNumber*)[subArray valueForKeyPath:@"@sum.self"];
            if( [sum integerValue] == k ){
                if(subArray.count>maxLeng){
                    maxLeng = subArray.count;
                }
            }
        }
    }
    
    return maxLeng;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        /* test case */
        NSInteger k = 3;
        NSArray* testArray1 = @[ @1, @(-1), @5, @(-2), @3];
        NSLog(@"case 1: %lu" , maxSizeOfSubArrayWithSumK(testArray1, k));
        
        k = 3;
        NSArray* testArray2 = @[ @1, @(-1), @(3), @(-2), @2];
        NSLog(@"case 2: %lu" , maxSizeOfSubArrayWithSumK(testArray2, k));
        
        k = 1;
        NSArray* testArray3 = @[ @(1), @(-1), @(2), @(-2)];
        NSLog(@"case 3: %lu" , maxSizeOfSubArrayWithSumK(testArray3, k));
        
        k = 1;
        NSArray* testArray4 = @[ @(-1), @1];
        NSLog(@"case 4: %lu" , maxSizeOfSubArrayWithSumK(testArray4, k));
        
        k = -26;
        NSArray* testArray5 = @[ @19, @(-1), @(-25), @(-2), @3];
        NSLog(@"case 5: %lu" , maxSizeOfSubArrayWithSumK(testArray5, k));
        
        k = -1;
        NSArray* testArray6 = @[ @(-1), @(-1), @(-5), @(-2), @(-3)];
        NSLog(@"case 6: %lu" , maxSizeOfSubArrayWithSumK(testArray6, k));
        
    }
    return 0;
}
