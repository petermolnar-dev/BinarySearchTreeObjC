//
//  main.m
//  BinarySearchTreeObjC
//
//  Created by Peter Molnar on 07/11/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - PMONode

@interface PMONode : NSObject
@property (strong, nonatomic) id value;
@property (strong, nonatomic) PMONode *left;
@property (strong, nonatomic) PMONode *right;

-(instancetype)initWithValue:(id)value;
@end

@implementation PMONode
-(instancetype)init
{
    self  = [super init];

    return self;
}


-(instancetype)initWithValue:(id)value;
{
    self = [super init];
    
    if (self) {
        [self setValue:value];
        [self setLeft:nil];
        [self setRight:nil];
    }
    
    return self;
}
@end


#pragma mark - BSTree
@interface BSTree : NSObject
+(PMONode *)insertNode:(PMONode *)root withValue:(id)value;
+(id)maxValue:(PMONode *)root;
+(id)minValue:(PMONode *)root;
+(int)height:(PMONode *)root;
+(void)preOrder:(PMONode *)root;
+(int)treeSize:(PMONode *)root;
@end

@implementation BSTree

+(PMONode *)insertNode:(PMONode *)root withValue:(id)value
{
    PMONode *newNode= [[PMONode alloc] initWithValue:value];
    
    if (!root) {
        root = newNode;
    }
    
    if (value < root.value) {
        root.left = [BSTree insertNode:root.left withValue:value];
    } else if (value > root.value) {
        root.right = [BSTree insertNode:root.right withValue:value];
    }
    
    return root;
    
}

+(int)height:(PMONode *)root
{
    if (!root) {
        return 0;
    } else {
        int leftHeight = [BSTree height:root.left];
        int rightHeight = [BSTree height:root.right];
        
        if (leftHeight > rightHeight) {
            return leftHeight;
        } else {
            return rightHeight;
        }
        
    }
}

+(id)maxValue:(PMONode *)root
{
    PMONode *currentNode = root;
    
    if (!root) return 0;
        
    while (currentNode.right != nil) {
        currentNode = currentNode.right;
    }
    
    return currentNode.value;
}

+(id)minValue:(PMONode *)root
{
    PMONode *currentNode = root;
    
    if (!root) return 0;
    
    while (currentNode.left != nil) {
        currentNode = currentNode.left;
    }
    
    return currentNode.value;
}


+(void)preOrder:(PMONode *)root
{
    if (!root) return;
    
    NSLog(@"%@",root.value);
    [BSTree preOrder:root.left];
    [BSTree preOrder:root.right];
}

+(int)treeSize:(PMONode *)root
{
    int counter = 1;
    
    if (!root) {
        return 0;
    } else {
        counter += [BSTree treeSize:root.left];
        counter += [BSTree treeSize:root.right];
        return counter;
    }

}

@end


#pragma mark - C interface
typedef struct node {
    int value;
    struct node *left;
    struct node *right;
    
} node;

// Helper function creating a new node
node* newNode(int value)
{
    node *newNode = (node *)malloc(sizeof(node));
    newNode->value = value;
    newNode->left = NULL;
    newNode->right = NULL;
    
    return newNode;
}

int treesize(node * root)
{
    int counter = 1;
    
    if (root==NULL) {
     return 0;
    } else {
        counter += treesize(root->left);
        counter += treesize(root->right);
        
        return counter;
    }
}

node * insert(node * root, int value)
{
    // If the tree is empty or this is the corner case return the new leaf
    if (root == NULL) return newNode(value);
    
    // Otherwise go along on the tree for the proper position
    if (value < root->value) {
        root->left = insert(root->left,value);
    } else if (value > root->value) {
        root->right = insert(root->right,value);
    }
    
    return root;
}

#pragma mark - Main function
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Read the first line from stdin
       int sumOfElements;
        PMONode *root;
        scanf("%d", &sumOfElements);
        
        // Read the ints from the stdin

        for(int i = 0; i<sumOfElements; i++){
            int n;
            scanf("%d",&n);
            root = [BSTree insertNode:root withValue:[NSNumber numberWithInt:n]];
        }
        
        // Print it out preordr traversal
        [BSTree preOrder:root];
        
    }
    return 0;
}
