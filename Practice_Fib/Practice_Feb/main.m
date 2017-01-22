//
//  main.m
//  Practice_fib
//
//  Created by Neo on 1/17/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LargeNumber : NSObject

@property (nonatomic, strong) NSArray *numericArray;

+ (LargeNumber*)numberWithInt:(NSInteger)n;
- (instancetype)initWithNumericArray:(NSArray*)numericArray;
- (instancetype)initWithInt:(NSInteger)n;
- (NSUInteger)length;
- (LargeNumber*)add:(LargeNumber*)n;
- (BOOL)isEqualToNumber:(NSInteger)num;
- (NSInteger)toInteger;
- (NSInteger)numberAtDigit:(NSUInteger)digit;

@end

@implementation LargeNumber

+ (LargeNumber *)numberWithInt:(NSInteger)n{
    return [[LargeNumber alloc] initWithInt:n];
}

- (instancetype)initWithNumericArray:(NSArray *)numericArray{
    self = [super init];
    if( self ){
        self.numericArray = [NSArray arrayWithArray:numericArray];
    }
    return self;
}

- (instancetype)initWithInt:(NSInteger)n{
    if( n == 0 ){
        return  [self initWithNumericArray:@[@0]];
    }
    NSMutableArray *aNewArray = [NSMutableArray array];
    NSUInteger digitLen = (int)log10(n) + 1;
    
    for (NSUInteger i=0; i<digitLen; i++) {
        NSUInteger humanDigit = digitLen - i;
        int d = (n % (int)pow(10,humanDigit)) / (int)pow(10, humanDigit-1);
        [aNewArray addObject:@(d)];
    }
    return [self initWithNumericArray:aNewArray];
}

- (NSInteger)toInteger{
    return [[self.numericArray componentsJoinedByString:@""] integerValue];
}

- (BOOL)isEqualToNumber:(NSInteger)num{
    return [self toInteger] == num;
}

- (NSUInteger)length{
    return self.numericArray.count;
}

- (NSInteger)numberAtDigit:(NSUInteger)digit{
    if( digit >= self.length ){
        return 0;
    }
    return [[self.numericArray objectAtIndex:self.length-digit-1] integerValue];
}

- (LargeNumber*)add:(LargeNumber *)n{
    
    NSInteger carryNum = 0;
    
    NSMutableArray *resultArray = [NSMutableArray array];
    NSUInteger maxLength = MAX(n.length, self.length);
    
    for (NSUInteger i=0; i<maxLength; i++) {
        
        NSInteger d1 = [self numberAtDigit:i];
        NSInteger d2 = [n numberAtDigit:i];
        
        NSInteger sum = d1 + d2 + carryNum;
        NSNumber *currentDigit = @( (sum)%10 ) ;
        carryNum = (sum)/10;
        
        [resultArray addObject:currentDigit];
    }
    if( carryNum != 0 ){
        [resultArray addObject:@(carryNum)];
    }
    
    /* reverse the array */
    NSMutableArray *reversedArray = [NSMutableArray array];
    for (NSNumber *n in [resultArray reverseObjectEnumerator]) {
        [reversedArray addObject:n];
    }
    
    return [[LargeNumber alloc] initWithNumericArray:reversedArray];
}

- (NSString *)description{
    return [self.numericArray componentsJoinedByString:@""];
}

@end


NSInteger fibRecursive(n){
    if( n == 0 ){
        return 0;
    }else if( n == 1 ){
        return 1;
    }else{
        return fibRecursive( n-1 ) + fibRecursive(  n-2 );
    }
}

LargeNumber* fibIteration( LargeNumber* n ){
    
    if( [n isEqualToNumber:0] ){
        return [LargeNumber numberWithInt:0];
    }else if ( [n isEqualToNumber:1] ){
        return [LargeNumber numberWithInt:1];
    }
    
    NSMutableArray<LargeNumber*> *tempArray = [NSMutableArray arrayWithCapacity:3];
    tempArray[0] = [LargeNumber numberWithInt:0];
    tempArray[1] = [LargeNumber numberWithInt:1];
    
    for (int i=2; i<=[n toInteger]; i++) {
        LargeNumber *sum = [tempArray[(i-1)%3] add:tempArray[(i-2)%3]];
        tempArray[i%3] = sum;
    
    }
    
    return tempArray[[n toInteger]%3];
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        /* simple test large number */
        LargeNumber *testN1 = [[LargeNumber alloc] initWithInt:999000];
        LargeNumber *testN2 = [[LargeNumber alloc] initWithInt:111999];
        LargeNumber *sum = [testN1 add:testN2];
        NSLog(@"sum is %@", sum );
        NSLog(@"fib %@", fibIteration([LargeNumber numberWithInt:8181]));
        
    }
    return 0;
}
