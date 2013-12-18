//
//  MRDownloadManager.m
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


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