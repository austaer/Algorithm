//
//  main.m
//  Remove Invalid Parentheses
//
//  Created by Neo on 11/26/16.
//  Copyright © 2016 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isValidParentheses(NSString* inputStr){
    
    
    
    return NO;
}


NSInteger longestValidParenthese(NSString* inputStr){
    
    NSMutableArray *stack = [NSMutableArray array];
    NSInteger leng = 0;
    
    for (int i=0; i<inputStr.length; i++) {
        
        NSString *subChar = [inputStr substringWithRange:NSMakeRange(i, 1)];
        if( ![subChar isEqualToString:@")"] ){
            [stack addObject:subChar];
        }else{
            BOOL validP = NO;
            /* pop out valid parentheses from stack */
            for (NSInteger j=stack.count-1; j>=0; j--) {
                NSString *top = [stack[j] copy];
                leng+=1;
                [stack removeLastObject];
                if ([top isEqualToString:@"("]) {
                    validP = YES;

                    /* count for ")" */
                    leng+=1;
                    break;
                }
            }
            
        }
    }

    return leng;
}

NSArray* removeParentheses(NSString* inputStr){
    
    
    NSMutableArray *stack = [NSMutableArray array];
    /* forward */
    for (int i=0; i<inputStr.length; i++) {
        
        
        
    }
    
    /* backward */
    
    
    return @[];
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        
        
        /* test case */
        NSString *case1 = @"()())fff)()";
        NSString *case2 = @"(a)())()";
        NSString *case3 = @")(";
        
        NSLog(@"case 1: %@" , removeParentheses(case1));
        NSLog(@"case leng 1: %d" , (int)longestValidParenthese(case1));
        NSLog(@"case 2: %@" , removeParentheses(case2));
        NSLog(@"case 3: %@" , removeParentheses(case3));
        
        
    }
    return 0;
}
