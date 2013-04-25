//
//  ChimpKit2AppDelegate.m
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import "ChimpKit2AppDelegate.h"
#import "ChimpKit2ViewController.h"

@implementation ChimpKit2AppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    //We can set ChimpKit's timeout globally
    [ChimpKit setTimeout:15];
    
    ChimpKit *ck = [[ChimpKit alloc] initWithDelegate:self 
                                            andApiKey:@"<YOUR_API_KEY>"];

    // This call would fetch lists
    [ck callApiMethod:@"lists" withParams:nil];

    // Build the params dictionary (please see documentation at http://apidocs.mailchimp.com/1.3 )
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"<YOUR_LIST_ID>" forKey:@"id"];
    [params setValue:@"someemail@example.com" forKey:@"email_address"];
    [params setValue:@"true" forKey:@"double_optin"];
    [params setValue:@"true" forKey:@"update_existing"];

    NSMutableDictionary *mergeVars = [NSMutableDictionary dictionary];
    [mergeVars setValue:@"First" forKey:@"FNAME"];
    [mergeVars setValue:@"Last" forKey:@"LNAME"];
    [params setValue:mergeVars forKey:@"merge_vars"];

    [ck callApiMethod:@"listSubscribe" withParams:params];

    return YES;
}

- (void)ckRequestSucceeded:(ChimpKit *)ckRequest {
    NSLog(@"HTTP Status Code: %d", [ckRequest responseStatusCode]);
    NSLog(@"Response String: %@", [ckRequest responseString]);
}

- (void)ckRequestFailed:(ChimpKit *)ckRequest andError:(NSError *)error {
    NSLog(@"Response Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}




@end
