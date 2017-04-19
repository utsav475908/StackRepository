// *************************************************************************************************
// # MARK: Imports


#import "AppDelegate.h"
#import "iBPMDataProviderManager.h"
#import "iBPMServerDataProvider.h"
#import "iBPMAuthenticationManager.h"
#import "iBPMConnection.h"
#import "iBPMDataProviderInterface.h"
#import "iBPMDataProvider+PostProcessor.h"
#import "iBPMOperationQueueUtils.h"
#import <UserNotifications/UserNotifications.h>
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <UserNotifications/UNNotificationServiceExtension.h>


// *************************************************************************************************
// # MARK: Macros

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


// *************************************************************************************************
// # MARK: Private Interfaces


@interface AppDelegate () <UNUserNotificationCenterDelegate, UIApplicationDelegate>

@end


// *************************************************************************************************
// # MARK: Implementation


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// Registering for Notifications
    
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound |
                                                 UNAuthorizationOptionAlert |
                                                 UNAuthorizationOptionBadge)
                              completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if( !error )
             {
                 [[UIApplication sharedApplication] registerForRemoteNotifications];
                 NSLog( @"Successful Authorization" );
             }
             else
             {
                 NSLog( @"Unsuccessful Authorization" );
                 NSLog( @"Error : %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"Recovery Suggestions : %@ - %@", error.localizedRecoveryOptions,
                       error.localizedRecoverySuggestion );
             }
         }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"NotificationStatusActive"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"NotificationIdentifier"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Remote notification registered successfully");
    
    NSString *token = [NSString stringWithFormat:@"%@",deviceToken];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    NSLog(@"Device Token : %@",token);
    
    ///Persist the Device Token for further use.
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"DeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error while registering for remote notification: %@",error.localizedDescription);
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"Notification : %@",userInfo);
    NSString *identifier = [userInfo valueForKey:@"Identifier"];
    NSLog(@"Identifier: %@",identifier);
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"NotificationStatusActive"];
    [[NSUserDefaults standardUserDefaults] setValue:identifier forKey:@"NotificationIdentifier"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([identifier isEqualToString:@"status"]) {
        NSString *sr_id = [userInfo valueForKey:@"sr_id"];
        NSString *domain = [userInfo valueForKey:@"Domain"];
        NSLog(@"SR_ID: %@, Domain: %@",sr_id,domain);
        [[NSUserDefaults standardUserDefaults] setValue:sr_id forKey:@"SR_ID"];
        [[NSUserDefaults standardUserDefaults] setValue:domain forKey:@"domain"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (void)didReceiveNotification:(UNNotification *)notification {
    NSLog(@"Badge Number of application before : %ld",[UIApplication sharedApplication].applicationIconBadgeNumber);
    NSLog(@"Badge Number of notification: %d",notification.request.content.badge.intValue);
    [[UIApplication sharedApplication]
     setApplicationIconBadgeNumber:[UIApplication sharedApplication].applicationIconBadgeNumber+
     notification.request.content.badge.intValue];
    NSLog(@"Badge Number of application after : %ld",[UIApplication sharedApplication].applicationIconBadgeNumber);
}


@end
