//
//  main.m
//  Move Zeroes
//
//  Created by Neo on 11/24/16.
//  Copyright © 2016 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>


void moveZero(NSMutableArray** inputArray){
    
    
    NSMutableIndexSet *zeroIndices = [NSMutableIndexSet indexSet];
    for( int i=0;i<[*inputArray count];i++ ){
        NSNumber *n = [*inputArray objectAtIndex:i];
        if( [n integerValue] == 0 ){
            [zeroIndices addIndex:i];
        }
    }

    [*inputArray removeObjectsAtIndexes:zeroIndices];
    
    for( int i=0;i<zeroIndices.count;i++){
        [*inputArray addObject:@(0)];
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        /* test case */
        NSMutableArray *testArray1 = [@[ @0, @1, @0, @3, @12 ] mutableCopy];
        NSMutableArray *testArray2 = [@[ @0, @0, @3, @12] mutableCopy];
        NSMutableArray *testArray3 = [@[ @3, @12, @0, @0 ] mutableCopy];
        NSMutableArray *testArray4 = [@[ @0, @0 ] mutableCopy];
        NSMutableArray *testArray5 = [@[ @1, @2 ] mutableCopy];
        NSMutableArray *testArray6 = [@[ @1, @0, @3, @0, @12 ] mutableCopy];
        
        moveZero(&testArray1);
        NSLog(@"test case 1: %@", testArray1 );
        moveZero(&testArray2);
        NSLog(@"test case 2: %@", testArray2 );
        moveZero(&testArray3);
        NSLog(@"test case 3: %@", testArray3 );
        moveZero(&testArray4);
        NSLog(@"test case 4: %@", testArray4 );
        moveZero(&testArray5);
        NSLog(@"test case 5: %@", testArray5 );
        moveZero(&testArray6);
        
    }
    return 0;
}
