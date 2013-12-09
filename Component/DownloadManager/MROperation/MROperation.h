//
//  MROperation.h
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MROperationProtocol.h"

@interface MROperation : NSOperation<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

/**
 The request used by the operation's connection.
 */
@property (nonatomic, strong) NSMutableURLRequest *request;

/**
 The output stream that is used to write data received until the request is finished.
 */
@property (nonatomic, strong) NSOutputStream *outputStream;

/**
 Set UrlConnection
 */
@property (nonatomic, strong) NSURLConnection *connection;

/**
 Set SWSOperation Delegate
 */
@property(nonatomic,weak) id<MROperationProtocol> delegate;

/**
 @param urlRequest The request object to be used by the operation connection.
 */
-(id)initWithRequest:(NSMutableURLRequest *)urlRequest targetPath:(NSString*)path withDelegate:(id)delegate;
@end