//
//  MetadataInjector.m
//  Spincle BetaVR
//
//  Created by Tom Tong on 11/3/2017.
//  Copyright © 2016 Spincle Inc. All rights reserved.

#import "MetadataInjector.h"
#import "metadata_utils.h"

@implementation MetadataInjector

+(void)injectMetadataWithInputURL:(NSURL*)inputUrl withOutputURL:(NSURL*)outputUrl withSem:(dispatch_semaphore_t)sem
{
    std::string inputPath = std::string([[inputUrl path] UTF8String]);
    
    [[NSFileManager defaultManager] removeItemAtPath:[outputUrl path] error:nil];
    std::string outputPath = std::string([[outputUrl path] UTF8String]);
    
    SpatialMedia::Parser parser;
    parser.getInFile() = inputPath;
    parser.getOutFile() = outputPath;
    
    Utils utils;
    if ( parser.getInject ( ) )  {
        Metadata md;
        std::string &strVideoXML = utils.generate_spherical_xml ( parser.getStereoMode ( ), parser.getCrop ( ) );
        md.setVideoXML ( strVideoXML );
        utils.inject_metadata ( parser.getInFile ( ), parser.getOutFile ( ), &md );
        if (sem!=nil){
            dispatch_semaphore_signal(sem);
        }
    }
}
@end

