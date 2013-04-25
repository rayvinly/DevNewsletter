//
//  SubscriptionAlertView.h
//  ChimpKit2
//
//  Created by Amro Mousa on 4/6/11.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChimpKit.h"
//#define kSubscriptionAlertViewHeight 230
#define kSubscriptionAlertViewTextFieldHeight 30
#define kSubscriptionAlertViewTextFieldYPadding 5

@class ChimpKit;

@interface SubscribeAlertView : UIAlertView <UITextFieldDelegate, UIAlertViewDelegate, ChimpKitDelegate> {
    UITextField *textField;
    ChimpKit *chimpKit;
    NSString *listId;
}

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic) BOOL doubleOptIn;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
             apiKey:(NSString *)apiKey
             listId:(NSString *)aListId
  cancelButtonTitle:(NSString *)cancelButtonTitle
subscribeButtonTitle:(NSString *)subscribeButtonTitle;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
             apiKey:(NSString *)apiKey
             listId:(NSString *)aListId
  cancelButtonTitle:(NSString *)cancelButtonTitle
subscribeButtonTitle:(NSString *)subscribeButtonTitle
        doubleOptIn:(BOOL)doubleOptIn;
@end
