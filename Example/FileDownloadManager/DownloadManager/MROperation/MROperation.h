//
//  MROperation.h
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