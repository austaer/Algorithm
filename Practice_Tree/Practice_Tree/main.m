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

Node *createATreeWithBFSArrayRepresentation(NSArray *treeArray){
    
    Node* root = [Node aNodeWithData:[treeArray[0] copy]];
    
    int flag = 0;
    Node *currentNode;
    NSMutableArray *queue = [NSMutableArray array];
    [queue addObject:root];
    
    for (int i=1; i<treeArray.count; i++) {
        int data = [treeArray[i] intValue];
        
        if( flag == 0 ){
            currentNode = [queue firstObject];
            [queue removeObjectAtIndex:0];
        }
        
        if( data != 0 ){
            Node *nodeToBeInsert = [Node aNodeWithData:@(data)];
            if( flag == 0 ){
                currentNode.lNode =  nodeToBeInsert;
            }else{
                currentNode.rNode =  nodeToBeInsert;
            }
            [queue addObject:nodeToBeInsert];
        }
        
        if( flag == 0 ){
            flag = 1;
        }else{
            flag = 0;
        }

    }
    
    return root;
}

/* use a queue to implement the breadth first search */
void printTheNodeOfNodeRepresentedTree( Node *tree ){
    
    NSMutableArray *queue = [NSMutableArray array];
    
    /* flag the left node (0) or the right node (1) */
    int flag = 0;
    Node *currentNode = tree;
    
    [queue addObject:tree];
    
    NSLog(@"%@" , tree );
    
    while ( queue.count != 0 ) {
        /* dequeue the parent */
        if( flag == 0 ){
            currentNode = [queue firstObject];
            [queue removeObjectAtIndex:0];
            
        }
    
        if( flag == 0 ){
            /* save node for later access */
            if( currentNode.lNode != nil ){
                [queue addObject:currentNode.lNode];
            }
            flag = 1;
            NSLog(@"%@", currentNode.lNode );
            
        }else{
            /* save node for later access */
            if( currentNode.rNode != nil ){
                [queue addObject:currentNode.rNode];
            }
            flag = 0;
            NSLog(@"%@", currentNode.rNode );
        }
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /* this is a breadth first representation of a binary tree */
        NSArray *tree = @[@(2),@(4),@(3),@(1),@(0),@(5),@(8),@(3),@(1), @(0), @(0), @(3), @(9), @(0), @(7)];
        
        Node *root = createATreeWithBFSArrayRepresentation(tree);
        
        printTheNodeOfNodeRepresentedTree( root );
        
    }
    return 0;
}
