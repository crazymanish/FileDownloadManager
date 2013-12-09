//
//  MRDownloadManager.m
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import "MRDownloadManager.h"
#import "MROperation.h"
@implementation MRDownloadManager
static MRDownloadManager *sharedInstance = nil;

#pragma mark - Singleton Instance
+ (id)instance{
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        //Download Queue
        _downloadQueue=[[NSOperationQueue alloc] init];
    }
    return self;
}

//Download File Now
-(void)downloadFileWithUrl:(NSURL*)url targetPath:(NSString*)path withDelegate:(id)delegate{
    
    //Download Operation
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    urlRequest.timeoutInterval=0;
    MROperation *operation=[[MROperation alloc] initWithRequest:urlRequest targetPath:path withDelegate:delegate];
    
    //add operation into Queue
    [self.downloadQueue addOperation:operation];
}

#pragma mark - Cancel Operation
-(void)removeOperationFromQueue:(MROperation *)operation{
    //Make sure, Our operation should removed from Queue
    for (MROperation* op in self.downloadQueue.operations) {
        if ([operation isEqual:op]) {
            [operation cancel];
            return;
        }
    }
}

-(void)removeAllOperations{
    //Make sure, Our operation should removed from Queue
    for (MROperation* op in self.downloadQueue.operations) {
        [op cancel];
        return;
    }
}
@end