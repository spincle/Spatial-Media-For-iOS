//
//  ViewController.m
//  iOSspatialMedia
//
//  Created by Tom Tong on 4/12/2016.
//  Copyright © 2016 Spincle Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSURL* videoUrl;
- (void)viewDidLoad {
    [super viewDidLoad];

    videoUrl = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"mp4"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* resultPath=[documentsDirectory stringByAppendingPathComponent:@"resultvideo.mp4"];
   
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    [MetadataInjector injectMetadataWithInputURL:videoUrl withOutputURL:[NSURL fileURLWithPath:resultPath] withSem:sem];
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    [self saveVideoToPhotosWithURL:[NSURL fileURLWithPath:resultPath]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveVideoToPhotosWithURL:(NSURL*)url
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
        PHObjectPlaceholder* placeholder = [createAssetRequest placeholderForCreatedAsset];
        
    } completionHandler:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"%@", error);
        }
        else
        {
        }
    }];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:NO];
}
@end
