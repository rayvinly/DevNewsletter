//
//  AppDelegate.m
//  DevNewsMac
//
//  Created by Raymond Law on 4/8/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#import <DevNews Mac/DevNews.h>
#import "SubscribeWindowController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) SubscribeWindowController *subscribeWindowController;

@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)easySubscribe:(id)sender
{
    NSLog(@"Easy Subscribe");

    // Create the DevNews singleton object
    DevNews *devNews = [DevNews sharedDevNews];

    // Ask DevNews to handle the rest of the signup process
    [devNews subscribeToList:nil];
}

- (IBAction)customSubscribe:(id)sender
{
    NSLog(@"Custom Subscribe");

    self.subscribeWindowController = [[SubscribeWindowController alloc] initWithWindowNibName:@"SubscribeWindowController"];
    [self.subscribeWindowController showWindow:nil];
}

@end
