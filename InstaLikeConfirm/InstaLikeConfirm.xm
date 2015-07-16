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



%hook IGFeedItem
-(void)performLike:(BOOL)like withUser:(id)user userDidDoubleTap:(BOOL)dt userInfo:(id)ui completion:(id)cp {

    
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
        %orig;
        return;
    }
    else {
   
        int time;
        
          switch (after2) {
                case 0:
                    time = 0; // Always
                    break;
                case 1:
                    time = 5; // 5 Hours
                    break;
                case 2:
                    time = 10; // 10 Hours
                    break;
                case 3:
                     time = 24; // 1 Day
                     break;
                case 4:
                     time = 5 * 24; // 5 Days
                     break;
                case 5:
                     time = 10 * 24; // 10 Days
                     break;
                case 6:
                    time = 30 * 24; // 1 Month
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
                                                  
                                                                    %orig;
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
    %orig;
   }
}
else {
    %orig;
}
    }
}
%end

static void prefschanged() {
    
    
    // For the first time, this did not work with me :( and had to replace it with the old method
 
    /*CFPreferencesAppSynchronize(CFSTR(SETTINGSFILENEW));
    
    enabled= !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW)) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW))) boolValue];
    
    after = !CFPreferencesCopyAppValue(CFSTR("after"), CFSTR(SETTINGSFILENEW)) ? 3 : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("after"), CFSTR(SETTINGSFILENEW))) intValue];
    */
}

%ctor {
    //Non sense
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)prefschanged,
                                    CFSTR("com.inasser.ilc/prefschanged"),
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);

    prefschanged();

}