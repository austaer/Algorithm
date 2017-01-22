//
//  main.m
//  Practice_Tree
//
//  Created by Neo on 1/18/17.
//  Copyright © 2017 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) Node *lNode;
@property (nonatomic, strong) Node *rNode;
@property (nonatomic, strong) id data;

+ (Node*)aNodeWithData:(id)data;

@end

@implementation Node

- (instancetype)init{
    self = [super init];
    if(self){
        self.lNode = nil;
        self.rNode = nil;
        self.data = nil;
    }
    return self;
}

+ (Node *)aNodeWithData:(id)data{
    Node *aNode = [[Node alloc] init];
    aNode.data = data;
    return aNode;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@", self.data ];
}

- (id)copy{
    Node *node = [Node aNodeWithData:[self.data copy]];
    node.lNode = [self.lNode copy];
    node.rNode = [self.rNode copy];
    return node;
}

@end

Node* createARandomTreeWithLevels(NSInteger n){
    if( n == 0 ){
        return nil;
    }else{
        
        Node *root = [Node aNodeWithData:@( arc4random() % 16 )];
        root.lNode = createARandomTreeWithLevels(n-1);
        root.rNode = createARandomTreeWithLevels(n-1);
        
        return root;
    }
}


Node *createATreeWithBFSArrayRepresentation(NSArray *treeArray){
    
    Node* root = [Node aNodeWithData:[treeArray[0] copy]];
    
    for( NSNumber *num in treeArray ){
        
        
        
        
    }
    
    if( treeArray.count == 0 ){
        return nil;
    }
    
    int firstDigit = [[treeArray firstObject] intValue];
    if( firstDigit == 0 ){
        return nil;
    }
    
    return nil;
}

void printTheNodeofTreesInLevel( NSArray *tree, int level ){
    if( level == 0 ){
        NSLog(@"%@", [tree firstObject] );
        return;
    }
    int firstIndexOfLevelInArray = pow(2, level)-1;
    int nextIndexOfLevelInArray = pow(2, level+1);
    NSLog(@"%@", [tree subarrayWithRange:NSMakeRange(firstIndexOfLevelInArray, nextIndexOfLevelInArray-firstIndexOfLevelInArray-1)] );
    for (int i=firstIndexOfLevelInArray; i< nextIndexOfLevelInArray; i++ ) {
        
    }
    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *tree = @[@(1),@(1),@(0),@(1),@(0),@(1),@(1),@(0),@(1), @(0), @(0), @(1), @(1), @(0), @(1)];
        Node *root = createATreeWithBFSArrayRepresentation(tree);
        NSLog(@"root %@", root );
        printTheNodeofTreesInLevel(tree, 3);

    }
    return 0;
}
