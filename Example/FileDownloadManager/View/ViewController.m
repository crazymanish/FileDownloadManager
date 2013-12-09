//
//  ViewController.m
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import "ViewController.h"
#import "MRDownloadManager.h"
#import "NSFileManager+Helper.h"
#import "MROperation.h"
@interface ViewController ()<MROperationProtocol>

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self startFileDownload];
}

#pragma mark - Start Downloading Here
#pragma mark -------------------------------------
-(void)startFileDownload{
    _lblDownloading.text=@"File Downloading";
    [_progressViewDownload setHidden:NO];
    
    NSURL *fileUrl=[NSURL URLWithString:@"https://github.com/RestKit/RestKit/archive/development.zip"];
    NSString *fileName=[fileUrl lastPathComponent];
    NSString *localPath=[[[NSFileManager defaultManager] downloadFolderPath] stringByAppendingPathComponent:fileName];
    NSLog(@"Target Path=%@",localPath);
    
    [[MRDownloadManager instance] downloadFileWithUrl:fileUrl targetPath:localPath withDelegate:self];
}

#pragma mark - MROperation Delegate
#pragma mark -------------------------------------
-(void)UrlOperation:(MROperation *)operation withProgress:(float)progress ofURLRequest:(NSURLRequest *)request{
    NSLog(@"Downloading Progress=%.1f",progress*100);
    __block ViewController * __weak weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.lblDownloading.text=[NSString stringWithFormat:@"Downloading =%.1f%%",progress*100];
        [weakSelf.progressViewDownload setProgress:progress animated:YES];
    });
}

-(void)UrlOperation:(MROperation *)operation finishDownloadingOfURLRequest:(NSURLRequest *)request{
    NSLog(@"Downloading Complete");
    __block ViewController * __weak weakSelf=self;
    dispatch_async(dispatch_get_main_queue(), ^{
       weakSelf.lblDownloading.text=@"Downloading Complete";
        [weakSelf.progressViewDownload setHidden:YES];
    });
    
}
@end