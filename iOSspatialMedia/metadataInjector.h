//
//  metadataInjector.h
//  Spincle BetaVR
//
//  Created by Tom Tong on 4/5/2016.
//
#import <UIKit/UIKit.h>

@interface metadataInjector : NSObject
-(NSURL *) insertMetadataWithMovie:(NSURL*)inputPath;

@end

@interface PythonInterpreter : NSObject

+ (id)sharedInterpreter;
- (void)run:(NSString *)script asFile:(NSString *)scriptPath;

@end
