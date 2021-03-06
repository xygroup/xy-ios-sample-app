//
//  AppDelegate.m
//  XySDKSample
//
//  Created by Erich Ocean on 2/19/19.
//  Copyright © 2019 Xy Group Ltd. All rights reserved.
//

#import "AppDelegate.h"

#import <XySDK/XySDK.h>

@interface AppDelegate ()

@property (nonatomic, strong) XyClient *xyClient;

@end

NSString *XySDK_DEVICE_ID = @"XySDKDeviceId";

@implementation AppDelegate

// DeviceIDs must be 20 bytes long, with characters [a-zA-Z0-9] only, and unique to each device.
- (void) establishDeviceId {
    NSString *deviceId = [[NSUserDefaults standardUserDefaults] valueForKey: XySDK_DEVICE_ID];

    if (deviceId == nil) {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        deviceId = [[uuid stringByReplacingOccurrencesOfString: @"-" withString: @""] substringToIndex: 20];
        [[NSUserDefaults standardUserDefaults] setValue: deviceId forKey: XySDK_DEVICE_ID];
    }

    self.deviceId = deviceId;
}

- (void) xyBluetoothIsEnabledNotification: (NSNotification *) note {
    NSLog(@"XyBluetoothIsEnabledNotification");
}

- (void) xyBluetoothIsDisabledNotification: (NSNotification *) note {
    NSLog(@"XyBluetoothIsDisabledNotification");
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [self establishDeviceId];

    self.xyClient = [XyClient clientWithDeviceId: self.deviceId];

    if (self.xyClient == nil) {
        NSLog(@"Failed to initialize XyClient; check logs for more info.");
    }

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(xyBluetoothIsEnabledNotification:)
                                                 name: XyBluetoothIsEnabledNotification
                                               object: nil];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(xyBluetoothIsDisabledNotification:)
                                                 name: XyBluetoothIsDisabledNotification
                                               object: nil];

    [self.xyClient startBluetoothDiscovery];





    // How to add a custom event.
    // NOTE: Dictionary provided must be a JSON-serializable dictionary.
    BOOL success = [self.xyClient addDeviceEvent: @{ @"foo": @"bar" }];
    NSLog(@"Added device event? %@", success ? @"YES" : @"NO");

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    [self.xyClient stopBluetoothDiscovery];
}


@end
