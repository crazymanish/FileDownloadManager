//
//  MROperation.m
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


#import "MROperation.h"
#import "NSFileManager+Helper.h"

@interface MROperation (){
    NSString *downloadingFilePath;
}
@property (nonatomic)long long dataLengthOfConnection;
@property (nonatomic)long long totalBytesRead;
@end

@implementation MROperation
@synthesize outputStream=_outputStream;
#pragma mark - Custom Init
#pragma mark -------------------------------------
-(id)initWithRequest:(NSMutableURLRequest *)urlRequest targetPath:(NSString*)path withDelegate:(id)delegate{
    self = [super init];
    if (!self) {
		return nil;
    }
    self.request = urlRequest;
    self.delegate= delegate;
    downloadingFilePath=path;
    
    //Remove Downloading File
    [self removeDownloadingFile];
    
    //OutPut-Stream
    _outputStream = [NSOutputStream outputStreamToFileAtPath:path append:YES];
    
    // If the output stream can't be created, instantly destroy the object. [SELF]
    if (!_outputStream){
        //Call-Failure Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(UrlOperation:didFailWithError:ofURLRequest:)]) {
            [self.delegate UrlOperation:self didFailWithError:nil ofURLRequest:_request];
        }
        
        return nil;
    }
    
    return self;
}

#pragma mark - NSURLConnectionDataDelegate
#pragma mark -------------------------------------
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //Length Of Data
    _dataLengthOfConnection = [response expectedContentLength];
    
    //Open outPut stream
    [_outputStream open];
    
    //Call DID_RECEIVE_RESPONSE delegate Now
    if (self.delegate && [self.delegate respondsToSelector:@selector(UrlOperation:didReceiveResponse:ofURLRequest:)]) {
        [self.delegate UrlOperation:self didReceiveResponse:response ofURLRequest:_request];
    }
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data{
    //Length
    NSUInteger length = [data length];
    
    //Write-Data
    if ([self.outputStream hasSpaceAvailable]) {
        const uint8_t *dataBuffer = (uint8_t *) [data bytes];
        [self.outputStream write:&dataBuffer[0] maxLength:length];
    }
    
    //Total Bytes read
    _totalBytesRead += length;
    
    //Progress
    float progress=((float)_totalBytesRead/(float)_dataLengthOfConnection);
    
    //Call PROGRESS Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(UrlOperation:withProgress:ofURLRequest:)]) {
        [self.delegate UrlOperation:self withProgress:progress ofURLRequest:_request];
    }
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
    [self.outputStream close];
    _connection = nil;
    
    //Call FINISH delegate now
    if (self.delegate && [self.delegate respondsToSelector:@selector(UrlOperation:finishDownloadingOfURLRequest:)]) {
        [self.delegate UrlOperation:self finishDownloadingOfURLRequest:_request];
    }
}

#pragma mark - NSURLConnectionDelegate
#pragma mark -------------------------------------
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self.outputStream close];
    self.connection = nil;
    
    //Remove Downloading File
    [self removeDownloadingFile];
    
    //Call-Failure Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(UrlOperation:didFailWithError:ofURLRequest:)]) {
        [self.delegate UrlOperation:self didFailWithError:error ofURLRequest:_request];
    }
}

#pragma mark - Override Start Function  @Manish
#pragma mark -------------------------------------
- (void)start{
    _connection = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:NO];
    [_connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_connection start];
}

#pragma mark - Override Cancel Function  @Manish
#pragma mark -------------------------------------
- (void)cancel{
    //Cancel NSURLConnection
    [_connection cancel];
    _connection = nil;
    
    //Remove Downloading File
    [self removeDownloadingFile];
    
    //Call Super's Cancel Now
    [super cancel];
}

#pragma mark - Output stream
#pragma mark -------------------------------------
- (NSOutputStream *)outputStream {
    if (!_outputStream) {
        _outputStream = [NSOutputStream outputStreamToMemory];
    }
    
    return _outputStream;
}

- (void)setOutputStream:(NSOutputStream *)output_Stream {
    if (_outputStream != output_Stream) {
        [self willChangeValueForKey:@"outputStream"];
        if (_outputStream) {
            [_outputStream close];
        }
        _outputStream = output_Stream;
        [self didChangeValueForKey:@"outputStream"];
    }
}

#pragma mark - Remove DOWNLOADING File
#pragma mark -------------------------------------
-(BOOL)removeDownloadingFile{
    return [[NSFileManager defaultManager] deleteFileAtPath:downloadingFilePath];
}

#pragma mark - dealloc
#pragma mark -------------------------------------
- (void)dealloc {
    if (_outputStream) {
        [_outputStream close];
        _outputStream = nil;
    }
    
    if (_connection) {
        [_connection cancel];
        _connection=nil;
    }
    
    if (_request) {
        _request=nil;
    }
}
@end