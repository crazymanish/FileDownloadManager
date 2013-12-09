//
//  NSFileManager+Helper.m
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import "NSFileManager+Helper.h"

@implementation NSFileManager (Helper)

-(NSString *)downloadFolderPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *cacheFolderPath = [documentsDirectory stringByAppendingPathComponent:@"downloads"];
    if (![self fileExistsAtPath:cacheFolderPath]){
        [self createDirectoryAtPath:cacheFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cacheFolderPath;
}

-(BOOL)deleteFileAtPath:(NSString *)path{
    return [self removeItemAtPath:path error:nil];
}
@end