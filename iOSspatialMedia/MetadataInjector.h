//
//  MetadataInjector.h
//  Spincle BetaVR
//
//  Created by Tom Tong on 11/3/2017.
//  Copyright © 2016 Spincle Inc. All rights reserved.


#import <Foundation/Foundation.h>

@interface MetadataInjector : NSObject
+(void)injectMetadataWithInputURL:(NSURL*)inputUrl withOutputURL:(NSURL*)outputUrl withSem:(dispatch_semaphore_t)sem;
@end
