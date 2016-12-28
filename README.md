# spatialMediaForIOS
objective-c template for inserting spatial media metadata into video with iPhone app

#### Facebook has released a new function to play 360° video in its app.

![screenshot](./Screenshot/360Facebook.png)

#### Youtube App also has a 360° video channel.

![screenshot](./Screenshot/360Youtube.png)

But your 360 video file needs to have metadata inserted for these platforms to treat them with 360 player
You could do that in iPhone app now with this project.

### Lightweighted PythonistaKit framework is used in this project for running the Spatial Media python script in iOS
The framework github is listed here. https://github.com/omz/PythonistaAppTemplate/tree/master/PythonistaAppTemplate/PythonistaKit.framework

The method used
```  objc
-(NSURL *) insertMetadataWithMovie:(NSURL*)inputPath;
```

The callback method
```  objc
-(void)callbackAfterMetadataInserted:(NSNotification *)note
```  

### my contact email tomtomtongtong@gmail.com






