# spatialMediaForIOS
objective-c template for inserting spatial media metadata into video with iPhone app

#### Facebook has released a new function to play 360° video in its app.

![screenshot](./Screenshot/360Facebook.png)

#### Youtube App also has a 360° video channel.

![screenshot](./Screenshot/360Youtube.png)

But your 360 video file needs to have metadata inserted for these platforms to treat them with 360 player
You could do that in iPhone app now with this project.

### This project uses the port from the python scripts provided by google to C++ by Varol Okan Thank him for his hard work.
The repo is listed here. https://github.com/VarolOkan/spatial-media

The method used
```  objc
+(void)injectMetadataWithInputURL:(NSURL*)inputUrl withOutputURL:(NSURL*)outputUrl withSem:(dispatch_semaphore_t)sem
```








