//
//  main.m
//  Practice_DP
//
//  Created by Neo on 1/21/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LargeNumber.h"

/* dynamic programming (with hash table) */
NSInteger numberOfDicesCombinationToNumberWithHash( NSMutableDictionary *hashTable, NSInteger n ){
    
    if( n == 1 ){
        return 1;
    }
    
    NSInteger count = 0;
    
    /* divide */
    for (NSInteger i=1; i<n; i++) {
    
        
        NSInteger j = n-i;
        
        NSString *hashKeyForPair = [NSString stringWithFormat:@"%ld_%ld", i , j ];
        if( [hashTable objectForKey:hashKeyForPair] != nil ){
            count += [[hashTable objectForKey:hashKeyForPair] integerValue];
        }else{
            NSInteger c = numberOfDicesCombinationToNumberWithHash(hashTable, j);
            count += c;
            [hashTable setObject:@(c) forKey:hashKeyForPair];
        }
    }
    
    /* if n is one of 1,2,3,4,5,6 */
    if( n <= 6 ){
        count += 1;
    }
    
    return count;
}

LargeNumber* numberOfDicesCombinationToNumberWithLargeNumber( NSMutableDictionary *hashTable, NSInteger n ){
    
    if( n == 1 ){
        return [LargeNumber numberWithInt:1];
    }
    
    LargeNumber *count = [LargeNumber numberWithInt:0];
    
    /* divide */
    for (NSInteger i=1; i<MIN(7, n); i++) {
        for (NSInteger j=i; j<n; j++) {
            NSLog(@"operating %ld %ld", i, j);
        }
        
        NSInteger j = n-i;

        NSString *hashKeyForPair = [NSString stringWithFormat:@"%ld_%ld", i , j ];
        if( [hashTable objectForKey:hashKeyForPair] != nil ){
            LargeNumber *cachedNumber = [hashTable objectForKey:hashKeyForPair];
            count = [count add:cachedNumber];
            
        }else{
            LargeNumber *c = numberOfDicesCombinationToNumberWithLargeNumber(hashTable, j);
            count = [count add:c];;
            [hashTable setObject:c forKey:hashKeyForPair];
        }
    }
    
    /* if n is one of 1,2,3,4,5,6 */
    if( n <= 6 ){
        count = [count add:[LargeNumber numberWithInt:1]];
    }

    return count;
}

/* dynamic programming */
LargeNumber* numberOfDicesCombinationToNumber(int n){
    
    NSMutableDictionary *hashTable = [NSMutableDictionary dictionary];
    NSMutableArray *summingArray = [NSMutableArray array];

    for( int j=1;j<n;j++ ){
        
        LargeNumber *accumulatedCount = [summingArray sumOfElements];
        
        for( int i=1;i<MIN(n-j+1,7);i++ ){
            LargeNumber *count = [accumulatedCount copy];
            
            NSString *hashKey = [NSString stringWithFormat:@"%d_%d", i, j ];
            if( j <= 6 ){
                count = [count add:[LargeNumber numberWithInt:1]];
            }
            
            if( i+j == n ){
                [hashTable setObject:count forKey:hashKey];
            }
            
            if( i == 1 ){
                [summingArray addObject:count];
            }
        }
   
    }

    LargeNumber *result = [hashTable.allValues sumOfElements];
    if( n <= 6 ){
        result = [result add:[LargeNumber numberWithInt:1]];
    }
    
    return result;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int targetDice = 610;
        LargeNumber *count = numberOfDicesCombinationToNumber(targetDice);
        NSLog(@"total count needed %@" , count );
    }
    return 0;
}
