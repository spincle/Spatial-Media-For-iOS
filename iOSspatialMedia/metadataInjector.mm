#import "metadataInjector.h"
@implementation metadataInjector

-(void)runPythonScript
{
    NSString *scriptPath = [self copyScriptResourcesIfNeeded];
    
    if (scriptPath) {
        NSString *script = [NSString stringWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
        if (script) {
            [[PythonInterpreter sharedInterpreter] run:script asFile:scriptPath];
        } else {
            NSLog(@"Could not load main.py (make sure its encoding is UTF-8)");
        }
    } else {
        NSLog(@"Could not find main.py");
    }
}

- (NSString *)copyScriptResourcesIfNeeded
{
    //Copy files from <Main Bundle>/Scripts to ~/Library/Application Support/PythonistaScript.
    //Files that are already there (and up-to-date) are skipped.
    
    //The script is not run directly from the main bundle because its directory wouldn't be writable then,
    //which would require changes in scripts that produce files.
    NSString *bundledScriptDirectory = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Script"];
    NSString *appSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    NSString *writableScriptDirectory = [appSupportDirectory stringByAppendingPathComponent:@"spatialmedia"];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createDirectoryAtPath:writableScriptDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
    
    NSArray *scriptResources = [fm contentsOfDirectoryAtPath:bundledScriptDirectory error:NULL];
    
    for (NSString *filename in scriptResources) {
        NSString *fullPath = [bundledScriptDirectory stringByAppendingPathComponent:filename];
        NSString *destPath = [writableScriptDirectory stringByAppendingPathComponent:filename];
        NSDate *srcModificationDate = [[fm attributesOfItemAtPath:fullPath error:NULL] fileModificationDate];
        NSDate *destModificationDate = [[fm attributesOfItemAtPath:destPath error:NULL] fileModificationDate];
        if (![destModificationDate isEqual:srcModificationDate]) {
            [fm removeItemAtPath:destPath error:NULL];
            [fm copyItemAtPath:fullPath toPath:destPath error:NULL];
        }
    }
    NSString *mainScriptFile = [writableScriptDirectory stringByAppendingPathComponent:@"main.py"];
    if (![fm fileExistsAtPath:mainScriptFile]) {
        //If there is no main.py, find the first *.py file...
        mainScriptFile = nil;
        for (NSString *filename in [fm contentsOfDirectoryAtPath:writableScriptDirectory error:NULL]) {
            if ([[[filename pathExtension] lowercaseString] isEqualToString:@"py"]) {
                mainScriptFile = [writableScriptDirectory stringByAppendingPathComponent:filename];
                break;
            }
        }
    }
    
    return mainScriptFile;
}

-(NSURL*) returnResultVideoPath
{
    NSString *appSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    NSString *writableScriptDirectory = [appSupportDirectory stringByAppendingPathComponent:@"spatialmedia"];
    NSString* resultPath=[writableScriptDirectory stringByAppendingPathComponent:@"resultvideo.mp4"];
    NSURL* resultURL=[NSURL fileURLWithPath:resultPath];
    return resultURL;
}

-(NSURL *) insertMetadataWithMovie:(NSURL*)inputPath
{
    
    NSString *appSupportDirectory = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
    NSString *writableScriptDirectory = [appSupportDirectory stringByAppendingPathComponent:@"spatialmedia"];
   
    NSString* processPath=[writableScriptDirectory stringByAppendingPathComponent:@"HDtest.mp4"];
    
    NSString* resultPath=[writableScriptDirectory stringByAppendingPathComponent:@"resultvideo.mp4"];
    NSString* backupPath=[writableScriptDirectory stringByAppendingPathComponent:@"resultvideo2.mp4"];
    
     NSFileManager* fileManager=[NSFileManager defaultManager];
//    if (![fileManager removeItemAtPath:resultPath error:NULL])
//    {
//        NSLog(@"remove error");
//    }
//    else
//    {
//        NSLog(@"resultPath remove succeed");
//    }
//   
//    if (![fileManager removeItemAtPath:processPath error:NULL])
//
//    {
//        NSLog(@"remove error");
//    }
//    else
//    {
//        NSLog(@"processPath remove succeed");
//    }
 
    if (![fileManager copyItemAtPath:[inputPath path] toPath:processPath error:NULL])
    {
        NSLog(@"copy not succeed");
    }
    
    [self runPythonScript];
    
//        NSOperationQueue *queue=[[NSOperationQueue alloc] init];
//        NSBlockOperation *blockOperation=[NSBlockOperation blockOperationWithBlock:^(void){
//                [self runPythonScript];
//        }];
//        
//        blockOperation.completionBlock=^(void){
//            [fileManager removeItemAtPath:[inputPath path] error:NULL];
//            [fileManager copyItemAtPath:resultPath toPath:[inputPath path] error:NULL];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"openSharePanel" object:nil];
//        };
//        [queue addOperation:blockOperation];

    
    double delayInSeconds = 4;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [fileManager copyItemAtPath:[inputPath path] toPath:backupPath error:nil];
        [fileManager removeItemAtPath:[inputPath path] error:NULL];
        NSError*err;
        
        if(! [fileManager copyItemAtPath:resultPath toPath:[inputPath path] error:&err])
        {
            NSLog(@"copy error %@",[err description]);
            [fileManager copyItemAtPath:backupPath toPath:[inputPath path] error:nil];
        }

        [fileManager removeItemAtPath:resultPath error:NULL];
        [fileManager removeItemAtPath:backupPath error:NULL];
        [fileManager removeItemAtPath:processPath error:NULL];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"openFBshare" object:nil];
    });

   return inputPath;
}

@end