//
//  ChimpKit2AppDelegate.h
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChimpKit.h"

@class ChimpKit2ViewController;

@interface ChimpKit2AppDelegate : NSObject <UIApplicationDelegate, ChimpKitDelegate> {
    UIWindow *window;
    ChimpKit2ViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet ChimpKit2ViewController *viewController;

@end

