//
//  DevNewsSubscribeWindowController.m
//  DevNews
//
//  Created by Raymond Law on 4/8/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#import "DevNews.h"
#import "DevNewsSubscribeWindowController.h"

@interface DevNewsSubscribeWindowController ()

@property (weak) IBOutlet NSTextField *firstNameTextField;
@property (weak) IBOutlet NSTextField *lastNameTextField;
@property (weak) IBOutlet NSTextField *emailTextField;

@end


@implementation DevNewsSubscribeWindowController

#pragma mark - Object lifecycle

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }

    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark - User taps cancel button

- (IBAction)cancel:(id)sender
{
    [self.window performClose:sender];
}

#pragma mark - User taps sign up button

- (IBAction)subscribe:(id)sender
{
    // Get the details from the user
    NSString *firstName = self.firstNameTextField.stringValue;
    NSString *lastName = self.lastNameTextField.stringValue;
    NSString *email = self.emailTextField.stringValue;

    // Dismiss the keyboard
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];

    // Create the DevNews singleton object
    DevNews *devNews = [DevNews sharedDevNews];

    // Ask DevNews to subscribe the user to our newsletter
    [devNews subscribeToList:nil withEmail:email firstName:firstName lastName:lastName success:^{
    } failure:^{
    }];
}

@end
