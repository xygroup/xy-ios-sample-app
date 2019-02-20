//
//  XyClient.h
//  XySDK
//
//  Created by Erich Ocean on 2/18/19.
//  Copyright © 2019 Xy Group Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const XyBluetoothIsEnabledNotification;
FOUNDATION_EXPORT NSString *const XyBluetoothIsDisabledNotification;

@interface XyClient : NSObject

+ (instancetype) clientWithDeviceId: (NSString *) deviceId;

// Disable the default initializer.
- (instancetype) init NS_UNAVAILABLE;

- (instancetype) initWithDeviceId: (NSString *) deviceId;

- (void) startBluetoothDiscovery;
- (void) stopBluetoothDiscovery;
- (void) restartBluetoothDiscovery;

// Although you can send anything in your jsonDictionary, please co-ordinate with
// Xy Group on the schema. :)
- (BOOL) addDeviceEvent: (NSDictionary *) jsonDictionary;

@end
