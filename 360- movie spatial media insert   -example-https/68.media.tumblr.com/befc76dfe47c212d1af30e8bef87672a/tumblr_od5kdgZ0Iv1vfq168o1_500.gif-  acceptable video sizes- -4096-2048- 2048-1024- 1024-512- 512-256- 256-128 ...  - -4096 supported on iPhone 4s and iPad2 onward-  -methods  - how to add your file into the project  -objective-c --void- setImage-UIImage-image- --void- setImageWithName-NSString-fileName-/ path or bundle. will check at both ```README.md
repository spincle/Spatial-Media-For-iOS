# spatialMediaForIOS
objective-c template for inserting spatial media metadata into video with iPhone app

![example](https://68.media.tumblr.com/befc76dfe47c212d1af30e8bef87672a/tumblr_od5kdgZ0Iv1vfq168o1_500.gif)

acceptable video sizes: (4096×2048), 2048×1024, 1024×512, 512×256, 256×128 ...

* (4096 supported on iPhone 4s and iPad2 onward)

#methods

### how to add your file into the project

```objective-c
-(void) setImage:(UIImage*)image;
-(void) setImageWithName:(NSString*)fileName;  // path or bundle. will check at both
```





