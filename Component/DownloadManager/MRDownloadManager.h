//
//  MRDownloadManager.h
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRDownloadManager : NSObject

//Download-Queue
@property (nonatomic, strong) NSOperationQueue *downloadQueue;

//SingleTon Instance
+ (id)instance;

//Download File
-(void)downloadFileWithUrl:(NSURL*)url targetPath:(NSString*)path withDelegate:(id)delegate;
@end