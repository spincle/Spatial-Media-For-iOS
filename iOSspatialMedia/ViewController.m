//
//  ViewController.m
//  iOSspatialMedia
//
//  Created by Tom Tong on 4/12/2016.
//  Copyright © 2016 Tom Tong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
NSURL* videoUrl;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(callbackAfterMetadataInserted:)
                                                 name:@"callbackAfterMetadataInserted" object:nil];
    videoUrl = [[NSBundle mainBundle] URLForResource:@"sample" withExtension:@"mp4"];
    metadataInjector* _metadataInjector=[[metadataInjector alloc] init];
    videoUrl = [_metadataInjector insertMetadataWithMovie:videoUrl];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callbackAfterMetadataInserted:(NSNotification *)note
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest* createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:videoUrl];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"callbackAfterMetadataInserted" object:nil];
}
@end
