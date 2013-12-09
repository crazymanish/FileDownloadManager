//
//  MROperationProtocol.h
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MROperation;
@protocol MROperationProtocol <NSObject>

@optional
//For Downloading-Progress
-(void)UrlOperation:(MROperation *)operation withProgress:(float)progress ofURLRequest:(NSURLRequest *)request;
//For URLConnection-Response
-(void)UrlOperation:(MROperation *)operation didReceiveResponse:(NSURLResponse *)response ofURLRequest:(NSURLRequest *)request;
//For finish Downloading
-(void)UrlOperation:(MROperation *)operation finishDownloadingOfURLRequest:(NSURLRequest *)request;
//For Failure Handler
-(void)UrlOperation:(MROperation *)operation didFailWithError:(NSError *)error ofURLRequest:(NSURLRequest *)request;
@end