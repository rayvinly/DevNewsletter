//
//  DevNews.h
//  DevNewsiOS
//
//  Created by Raymond Law on 4/5/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

@interface DevNews : NSObject

@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *listID;
@property (strong, nonatomic) NSString *headline;

/*** Creation methods ***/

+ (id)sharedDevNews;
+ (id)devNewsWithAPIKey:(NSString *)apiKey listID:(NSString *)listID;
- (id)initWithAPIKey:(NSString *)apiKey listID:(NSString *)listID;

/*** Subscribe methods ***/

#if TARGET_OS_IPHONE

- (void)subscribeToList:(NSString *)listID withPresentingViewController:(UIViewController *)viewController;

#elif !TARGET_OS_IPHONE

- (void)subscribeToList:(NSString *)listID;

#endif

- (void)subscribeToList:(NSString *)listID withEmail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName success:(void (^)(void))success failure:(void (^)(void))failure;

@end
