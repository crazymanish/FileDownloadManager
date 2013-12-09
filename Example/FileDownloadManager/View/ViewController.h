//
//  ViewController.h
//  FileDownloadManager
//
//  Created by Manish Rathi on 09/12/13.
//  Copyright (c) 2013 Manish Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

/**
  Downloading Files
 */
@property (weak, nonatomic) IBOutlet UILabel *lblDownloading;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewDownload;
@end
