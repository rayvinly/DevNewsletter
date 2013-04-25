//
//  DevNews.m
//  DevNewsiOS
//
//  Created by Raymond Law on 4/5/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#if TARGET_OS_IPHONE
#import "MBProgressHUD.h"
#elif !TARGET_OS_IPHONE
#import "DevNewsSubscribeWindowController.h"
#endif
#import "ChimpKit.h"
#import "DevNews.h"

static DevNews *sharedDevNews = nil;

@interface DevNews () <ChimpKitDelegate>

#if TARGET_OS_IPHONE
@property (strong, nonatomic) UIViewController *presentingViewController;
#elif !TARGET_OS_IPHONE
@property (strong, nonatomic) DevNewsSubscribeWindowController *devNewsSubscribeWindowController;
#endif
@property (strong, nonatomic) void (^success)(void);
@property (strong, nonatomic) void (^failure)(void);

@end


@implementation DevNews

#pragma mark - Object lifecycle

+ (id)sharedDevNews
{
    if (sharedDevNews == nil) {
        NSAssert(false, @"You have to call devNewsWithAPIKey: first.");
    }
    return sharedDevNews;
}

+ (id)devNewsWithAPIKey:(NSString *)apiKey listID:(NSString *)listID
{
    if (sharedDevNews == nil) {
        sharedDevNews = [[DevNews alloc] initWithAPIKey:apiKey listID:listID];
    }
    return sharedDevNews;
}

- (id)initWithAPIKey:(NSString *)apiKey listID:(NSString *)listID
{
    if (self = [super init]) {
        _apiKey = apiKey;
        _listID = listID;
    }
    return self;
}

#pragma mark - Subscribe to list

/** Easy Subscribe - Use DevNews' included UI for the subscribe process **/
#if TARGET_OS_IPHONE

- (void)subscribeToList:(NSString *)listID withPresentingViewController:(UIViewController *)presentingViewController
{
    // Get DevNews' storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DevNews_iPhone" bundle:nil];

    // Get the initial view controller in the storyboard
    UINavigationController *navigationController = [storyboard instantiateInitialViewController];

    // Show this view controller
    [presentingViewController presentViewController:navigationController animated:YES completion:nil];
}

#elif !TARGET_OS_IPHONE

- (void)subscribeToList:(NSString *)listID
{
    // Use DevNews' included subscribe window
    self.devNewsSubscribeWindowController = [[DevNewsSubscribeWindowController alloc] initWithWindowNibName:@"DevNewsSubscribeWindowController"];
    [self.devNewsSubscribeWindowController showWindow:nil];
}

#endif

/** Custom Subscribe - The target app needs to provide its own UI to collect email, first and last name and supply these to DevNews **/
- (void)subscribeToList:(NSString *)listID withEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName success:(void (^)(void))success failure:(void (^)(void))failure
{
    if (!listID) {
        listID = [[DevNews sharedDevNews] listID];
    }
    // Build the params for the listSubscribe API call. Ref: http://apidocs.mailchimp.com/api/1.3/listsubscribe.func.php
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:listID forKey:@"id"];
    [params setValue:email forKey:@"email_address"];
    [params setValue:@"true" forKey:@"double_optin"];
    [params setValue:@"true" forKey:@"update_existing"];

    NSMutableDictionary *mergeVars = [NSMutableDictionary dictionary];
    [mergeVars setValue:firstName forKey:@"FNAME"];
    [mergeVars setValue:lastName forKey:@"LNAME"];
    [params setValue:mergeVars forKey:@"merge_vars"];

    // Ask ChimpKit2 to call the listSubscribe API call to subscribe the user to our newsletter
    ChimpKit *chimpKit = [[ChimpKit alloc] initWithDelegate:self andApiKey:self.apiKey];
    [chimpKit callApiMethod:@"listSubscribe" withParams:params];

    // We have to save the success and failure blocks so we can call it when the API call finishes
    self.success = success;
    self.failure = failure;
}

#pragma mark - ChimpKitDelegate

- (void)ckRequestSucceeded:(ChimpKit *)ckRequest
{
    NSLog(@"HTTP Status Code: %ld", (long)[ckRequest responseStatusCode]);
    NSLog(@"Response String: %@", [ckRequest responseString]);

    // If we saved a success block before, call it now
    if (self.success) {
        self.success();
        self.success = nil;
    }
}

- (void)ckRequestFailed:(ChimpKit *)ckRequest andError:(NSError *)error
{
    NSLog(@"HTTP Status Code: %ld", (long)[ckRequest responseStatusCode]);
    NSLog(@"Response String: %@", [ckRequest responseString]);
    NSLog(@"Response Error: %@", error);

    // If we saved a failure block before, call it now
    if (self.failure) {
        self.failure();
        self.failure = nil;
    }
}

- (void)ckRequestFailed:(NSError *)error
{
    NSLog(@"Response Error: %@", error);

    // If we saved a failure block before, call it now
    if (self.failure) {
        self.failure();
        self.failure = nil;
    }
}

@end
