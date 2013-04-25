//
//  ChimpKit.h
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ChimpKit;

@protocol ChimpKitDelegate <NSObject>

@optional
- (void)ckRequestSucceeded:(ChimpKit *)ckRequest;

@optional
- (void)ckRequestFailed:(NSError *)error;

@optional
- (void)ckRequestFailed:(ChimpKit *)ckRequest andError:(NSError *)error;

@end

@interface ChimpKit : NSOperation {
    id<ChimpKitDelegate> __unsafe_unretained delegate;
    SEL onSuccess;
    SEL onFailure;

    NSString *apiUrl;
    NSString *apiKey;

    id userInfo;

@private
    NSURLConnection *connection;
    NSMutableData *responseData;
}

@property (unsafe_unretained, readwrite) id<ChimpKitDelegate> delegate;
@property (nonatomic, strong) id userInfo;

@property (nonatomic, strong) NSString *apiUrl;
@property (nonatomic, strong) NSString *apiKey;

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, readonly) NSString *responseString;
@property (nonatomic, readonly) NSInteger responseStatusCode;
@property (nonatomic, readonly) NSError *error;

+ (void)setTimeout:(NSUInteger)tout;

-(id)initWithDelegate:(id)aDelegate andApiKey:(NSString *)key;
-(void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params;
- (void)cancel;

@end