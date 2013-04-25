//
//  ChimpKit.m
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import "ChimpKit.h"

static NSUInteger timeout = 10;

@interface ChimpKit()
- (NSMutableData *)encodeRequestParams:(NSDictionary *)params;
- (NSString *)encodeString:(NSString *)unencodedString;

- (void)notifyDelegateOfSuccess;
- (void)notifyDelegateOfError:(NSError *)error;
- (void)cleanup;
@end


@implementation ChimpKit

@synthesize apiUrl = _apiUrl;
@synthesize apiKey = _apiKey;
@synthesize delegate = _delegate;
@synthesize connection = _connection;
@synthesize responseData = _responseData;
@synthesize userInfo = _userInfo;
@synthesize responseString = _responseString;
@synthesize responseStatusCode = _responseStatusCode;
@synthesize error = _error;

+ (void)setTimeout:(NSUInteger)tout {
    timeout = tout;
}

#pragma mark - Initialization

- (void)setApiKey:(NSString*)key {
    _apiKey = key;
    if (_apiKey) {
        //Parse out the datacenter and template it into the URL.
        NSArray *apiKeyParts = [_apiKey componentsSeparatedByString:@"-"];
        if ([apiKeyParts count] > 1) {
            self.apiUrl = [NSString stringWithFormat:@"https://%@.api.mailchimp.com/1.3/?method=", [apiKeyParts objectAtIndex:1]];
        }
    }
}

- (id)initWithDelegate:(id)aDelegate andApiKey:(NSString *)key {
	self = [super init];
	if (self != nil) {
        self.apiUrl  = @"https://api.mailchimp.com/1.3/?method=";
        [self setApiKey:key];
        self.delegate = aDelegate;
        self.responseData = [NSMutableData data];
	}
	return self;
}

#pragma mark - Setup

- (NSMutableData *)encodeRequestParams:(NSDictionary *)params {
    NSMutableDictionary *postBodyParams = [NSMutableDictionary dictionary];
    if (self.apiKey) {
        [postBodyParams setValue:self.apiKey forKey:@"apikey"];
    }

    if (params) {
        [postBodyParams setValuesForKeysWithDictionary:params];
    }

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:postBodyParams options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *encodedParamsAsJson = [self encodeString:jsonString];
    NSMutableData *postData = [NSMutableData dataWithData:[encodedParamsAsJson dataUsingEncoding:NSUTF8StringEncoding]];
    return postData;
}

- (void)callApiMethod:(NSString *)method withParams:(NSDictionary *)params {
    [self cancel];

    NSString *urlString = [NSString stringWithFormat:@"%@%@", self.apiUrl, method];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
	[request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:timeout];

    NSMutableData *postData = [self encodeRequestParams:params];
    [request setHTTPBody:postData];

    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

#pragma mark - NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseStatusCode = [((NSHTTPURLResponse *)response) statusCode];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self notifyDelegateOfSuccess];
    [self cleanup];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self notifyDelegateOfError:error];
    [self cleanup];
}

#pragma mark - Helpers

- (void)notifyDelegateOfSuccess {
    _responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(ckRequestSucceeded:)]) {
        [self.delegate performSelector:@selector(ckRequestSucceeded:) withObject:self];
    }
}

- (void)notifyDelegateOfError:(NSError *)error {
    _error = error;

    if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(ckRequestFailed:andError:)]) {
        [self.delegate performSelector:@selector(ckRequestFailed:andError:) withObject:self withObject:error];
    } else if ((self.delegate != nil) && [self.delegate respondsToSelector:@selector(ckRequestFailed:)]) {
        [self.delegate performSelector:@selector(ckRequestFailed:) withObject:error];
    }
}

- (NSString *)encodeString:(NSString *)unencodedString {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                                                  (__bridge CFStringRef)unencodedString, 
                                                                                  NULL, 
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]", 
                                                                                  kCFStringEncodingUTF8));
    return encodedString;
}

#pragma mark - Tear down

- (void)cancel {
    if (self.connection) {
        [self.connection cancel];
    }

    [self cleanup];
}

- (void)cleanup {
    self.connection = nil;
    [self.responseData setLength:0];
}

- (void)dealloc {
    [self cleanup];
    self.apiKey = nil;
}

@end
