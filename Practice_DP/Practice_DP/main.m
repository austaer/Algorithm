//
//  main.m
//  Practice_DP
//
//  Created by Neo on 1/21/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LargeNumber.h"

/* Use hash table to cache */
NSInteger numberOfDicesCombinationToNumberWithHash(NSMutableDictionary *hashTable, NSInteger n ){
    
    if( n == 1 ){
        return 1;
    }
    
    NSInteger count = 0;

    for (NSInteger i=1; i<MIN(n,7); i++) {
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

/* dynamic programming */
LargeNumber* numberOfDicesCombinationToNumber(int n){
    
    /* save temp count for the next step, e.g save 2_1: 1 and 1_2: 2, so we are able to calculate x_3 = 3 by add count of 2_1 and 1_2 */
    NSMutableDictionary *hashTable = [NSMutableDictionary dictionary];

    for( int j=1;j<n;j++ ){

        for( int i=1;i<MIN(n-j+1,7);i++ ){

            /* current i,j pair */
            NSString *hashKeyForCurrentStep = [NSString stringWithFormat:@"%d", j ];
            LargeNumber *countForCurrentStep = [hashTable objectForKey:hashKeyForCurrentStep];
            
            /* for the following calculation */
            NSString *hashKeyForNextStep = [NSString stringWithFormat:@"%d", (i+j) ];
            LargeNumber *countForNextStep = [hashTable objectForKey:hashKeyForNextStep]==nil?[LargeNumber numberWithInt:0]:[hashTable objectForKey:hashKeyForNextStep];
            
            /* special case for dice */
            if( j<= 6 ){
                countForNextStep = [countForNextStep add:[LargeNumber numberWithInt:1]];
            }
            
            countForNextStep = [countForNextStep add:countForCurrentStep];
            [hashTable setObject:countForNextStep forKey:hashKeyForNextStep];
            
        }
   
    }
    LargeNumber *result = [hashTable objectForKey:[NSString stringWithFormat:@"%d", (n) ]];
    
    /* special case for dice */
    if( n <= 6 ){
        result = [result add:[LargeNumber numberWithInt:1]];
    }
    return result;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int targetDice = 50;
        LargeNumber *count = numberOfDicesCombinationToNumber(targetDice);
        NSLog(@"total count needed %@" , count );
        
        NSMutableDictionary *hashTable = [NSMutableDictionary dictionary];
        NSInteger count2 = numberOfDicesCombinationToNumberWithHash( hashTable, targetDice );
        NSLog(@"correct answer %ld" , count2 );
    }
    return 0;
}
