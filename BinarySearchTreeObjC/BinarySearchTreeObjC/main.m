//
//  main.m
//  BinarySearchTreeObjC
//
//  Created by Peter Molnar on 07/11/2015.
//  Copyright © 2015 Peter Molnar. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Read the first line from stdin
        int testArrayLength;
        int sumOfArray;
        scanf("%d", &testArrayLength);
        
        // Read the ints from the stdin
        int sumArray[testArrayLength];
        for(int i = 0; i<testArrayLength; i++){
            int n;
            scanf("%d",&n);
            sumArray[i]=n;
        }
        sumOfArray = 0;
        for(int j = 0; j<testArrayLength; j++){
            sumOfArray = addTwoNumbers(sumOfArray,sumArray[j]);
        }
        printf("%d\n", sumOfArray);
        
    }
    return 0;
}
