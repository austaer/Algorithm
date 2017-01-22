//
//  LargeNumber.m
//  Practice_DP
//
//  Created by Neo on 1/21/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import "LargeNumber.h"

@implementation NSArray (LargeNumber)

- (LargeNumber *)sumOfElements{
    LargeNumber *sum = [LargeNumber numberWithInt:0];
    for(LargeNumber *num in self){
        sum = [sum add:num];
    }
    return sum;
}

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

- (id)copy{
    return [[LargeNumber alloc] initWithNumericArray:self.numericArray];
}

- (NSString *)description{
    return [self.numericArray componentsJoinedByString:@""];
}
@end
