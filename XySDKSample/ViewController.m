//
//  ViewController.m
//  XySDKSample
//
//  Created by Erich Ocean on 2/19/19.
//  Copyright © 2019 Xy Group Ltd. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString *deviceId = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).deviceId;
   [self.deviceIdLabel setText: deviceId];
}


@end
