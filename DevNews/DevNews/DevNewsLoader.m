//
//  DevNewsLoader.m
//  DevNews
//
//  Created by Raymond Law on 4/8/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#import "DevNews.h"
#import "DevNewsLoader.h"

@implementation DevNewsLoader

+ (void)load
{
#if TARGET_OS_IPHONE
    [[NSNotificationCenter defaultCenter] addObserver:[self class] selector:@selector(applicationDidBecomeActive:) name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
#elif !TARGET_OS_IPHONE
    [[NSNotificationCenter defaultCenter] addObserver:[self class] selector:@selector(applicationDidBecomeActive:) name:@"NSApplicationDidFinishLaunchingNotification" object:nil];
#endif
}

+ (void)applicationDidBecomeActive:(NSNotification *)notification
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"DevNews" ofType:@"plist"];
    NSDictionary *configs = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *apiKey;
    NSString *listID;

#if TARGET_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
    NSDictionary *configurations = [configs valueForKey:@"Simulator"];

    // API Key
    if ([configurations objectForKey:@"API Key"]) {
        apiKey = [configurations valueForKey:@"API Key"];
    }

    // List ID
    if ([configurations objectForKey:@"List ID"]) {
        listID = [configurations valueForKey:@"List ID"];
    }
#else
    NSDictionary *configurations = [configs valueForKey:@"Device"];

    // API Key
    if ([configurations objectForKey:@"API Key"]) {
        apiKey = [configurations valueForKey:@"API Key"];
    }

    // List ID
    if ([configurations objectForKey:@"List ID"]) {
        listID = [configurations valueForKey:@"List ID"];
    }
#endif
#elif !TARGET_OS_IPHONE
    NSDictionary *configurations = [configs valueForKey:@"Mac"];

    // API Key
    if ([configurations objectForKey:@"API Key"]) {
        apiKey = [configurations valueForKey:@"API Key"];
    }

    // List ID
    if ([configurations objectForKey:@"List ID"]) {
        listID = [configurations valueForKey:@"List ID"];
    }
#endif

    if (apiKey) {
        [DevNews devNewsWithAPIKey:apiKey listID:listID];
        NSLog(@"DevNews is configured with the MailChimp API key %@ and list ID %@", apiKey, listID);
    } else {
        NSLog(@"Please specify the MailChimp API key in DevNews.plist first");
    }
}

@end
