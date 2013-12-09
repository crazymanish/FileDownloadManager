//
//  NSFileManager+Helper.h
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Helper)

//Get Download Folder
-(NSString *)downloadFolderPath;

//Remove File for Path
-(BOOL)deleteFileAtPath:(NSString *)path;
@end