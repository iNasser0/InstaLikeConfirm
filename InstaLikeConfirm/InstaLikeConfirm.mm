#line 1 "/Users/iNasser/Desktop/InstaLikeConfirm/InstaLikeConfirm/InstaLikeConfirm.xm"
#import <UIKit/UIKit.h>
#define SETTINGSFILENEW "com.inasser.ilc"

@interface IGDate : NSObject
-(double)timeIntervalSinceNow;
@end

@interface IGStorableObject : NSObject
@end

@interface IGPost : IGStorableObject {
        IGDate *_takenAt;
}
@property(readonly) BOOL hasLiked;
@property(readonly) IGDate *takenAt;

@end

@interface IGFeedItem : IGPost

@end



#include <logos/logos.h>
#include <substrate.h>
@class IGFeedItem; 
static void (*_logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$)(IGFeedItem*, SEL, BOOL, id, BOOL, id, id); static void _logos_method$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(IGFeedItem*, SEL, BOOL, id, BOOL, id, id); 

#line 25 "/Users/iNasser/Desktop/InstaLikeConfirm/InstaLikeConfirm/InstaLikeConfirm.xm"

static void _logos_method$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(IGFeedItem* self, SEL _cmd, BOOL like, id user, BOOL dt, id ui, id cp) {

    
    NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.inasser.ilc.plist"];
    BOOL enabled2;
    int after2;
        if (preferences != nil) {
              enabled2 = [preferences[@"enabled"] boolValue];
              after2 = [preferences[@"after"] intValue];
        }
        else {
               enabled2 = YES;
              after2 = 3;
         }

    if (!enabled2) {
        _logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(self, _cmd, like, user, dt, ui, cp);
        return;
    }
    else if (enabled2) {
   
        int time;
        
          switch (after2) {
                case 0:
                    time = 0; 
                    break;
                case 1:
                    time = 5; 
                    break;
                case 2:
                    time = 10; 
                    break;
                case 3:
                     time = 24; 
                     break;
                case 4:
                     time = 5 * 24; 
                     break;
                case 5:
                     time = 10 * 24; 
                     break;
                case 6:
                    time = 30 * 24; 
                     break;
       }

    
IGDate *date = self.takenAt;
double nowDate = -[date timeIntervalSinceNow];

if (nowDate >= time * 60 * 60) {
    
    if (self.hasLiked == NO ) {
      
       
  UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  window.backgroundColor = [UIColor clearColor];
  UIViewController *viewCon = [[UIViewController alloc] init];
  viewCon.view.backgroundColor = [UIColor clearColor];
  window.rootViewController = viewCon;
        
        
     UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirm"
                                                   message:@"Are you sure you want to like this post?"
                                                preferredStyle:UIAlertControllerStyleAlert];

     UIAlertAction* yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                  
                                                                    _logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(self, _cmd, like, user, dt, ui, cp);
                                                                    window.hidden = YES;
                                                                    [window release];

                                           }];


     UIAlertAction* no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                              window.hidden = YES;
                                                            [window release];


                                           }];

     [alert addAction:yes];
     [alert addAction:no];
     [window makeKeyAndVisible];
     [viewCon presentViewController:alert animated:YES completion:nil];

  }
  
    else {
    _logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(self, _cmd, like, user, dt, ui, cp);
   }
}
else {
    _logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$(self, _cmd, like, user, dt, ui, cp);
}
    }
}


static void prefschanged() {
    
    
    
 
    





}

static __attribute__((constructor)) void _logosLocalCtor_fcb669a7() {
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)prefschanged,
                                    CFSTR("com.inasser.ilc/prefschanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    prefschanged();

}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$IGFeedItem = objc_getClass("IGFeedItem"); MSHookMessageEx(_logos_class$_ungrouped$IGFeedItem, @selector(performLike:withUser:userDidDoubleTap:userInfo:completion:), (IMP)&_logos_method$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$, (IMP*)&_logos_orig$_ungrouped$IGFeedItem$performLike$withUser$userDidDoubleTap$userInfo$completion$);} }
#line 154 "/Users/iNasser/Desktop/InstaLikeConfirm/InstaLikeConfirm/InstaLikeConfirm.xm"
