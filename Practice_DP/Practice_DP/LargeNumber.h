//
//  LargeNumber.h
//  Practice_DP
//
//  Created by Neo on 1/21/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LargeNumber;

@interface NSArray (LargeNumber)

- (LargeNumber*)sumOfElements;

@end

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
