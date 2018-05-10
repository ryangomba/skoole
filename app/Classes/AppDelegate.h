@class MainViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    MainViewController *mainViewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end