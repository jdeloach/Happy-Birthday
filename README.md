Happy Birthday (at Midnight) - A Facebook App
=================================================

I for one am way too lazy to actually stay up till 12, or more likely, I forget what I am doing at by the time it reaches 12 I am playing a video game or something, not focused on their birthday and miss the 12:00 A.M. magic moment. This app solves that problem. It runs on the Google App Engine as I am soo cheap to pay for hosting. It's simple and the time that I posted it to GitHub it has been about 50 hours since I had the idea. It's very rough, and probably won't get much more development. Unless it goes well on Facebook.

### Bugs, And Such
Yeah, it probably has about 1500 bugs, that's fine. If you want to fix one, go for it. Fork it, Push it, I'll merge it and we'll have a pretty little project.

### Config.java
Of course it is not included because it contains sensitive information. The low down of what you need is a `net.jtmcgee.project.happybirthday.utils.Config` class.
Within you'll need 4 `public final static String` variables named SECRETKEY, APPID, REDIRECTURI, and APIKEY, all those would come from Facebook.
Finally you need a `public static String ACCESS_TOKEN(HttpServletRequest request)` method. Within you basically retrieve the session and retrieve the value of `access_token`


[Find it on Facebook](http://apps.facebook.com/happymidnightbday)
[@jtmcgee](http://twitter.com/jtmcgee)
[jordandeloach.com](http://jordandeloach.com)
[jtmcgee.net projects](http://project.jtmcgee.net)
[jtmcgee.net](http://jtmcgee.net)
