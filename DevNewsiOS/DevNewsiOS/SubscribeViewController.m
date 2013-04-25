//
//  SubscribeViewController.m
//  DevNewsiOS
//
//  Created by Raymond Law on 4/4/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#import <DevNews iOS/DevNews.h>
#import <DevNews iOS/MBProgressHUD.h>
#import "SubscribeViewController.h"

@interface SubscribeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end


@implementation SubscribeViewController

#pragma mark - Object lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User taps cancel button

- (IBAction)cancel:(id)sender
{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - User taps sign up button

- (IBAction)subscribe:(id)sender
{
    // Get the details from the user
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;
    NSString *email = self.emailTextField.text;

    // Dismiss the keyboard
    [self.firstNameTextField resignFirstResponder];
    [self.lastNameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];

    // Show the spinner
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    // Create the DevNews singleton object
    DevNews *devNews = [DevNews sharedDevNews];

    // Ask DevNews to subscribe the user to our newsletter
    [devNews subscribeToList:nil withEmail:email firstName:firstName lastName:lastName success:^{

        // Hide the spinner
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // Dismiss the navigation controller that started the subscribe process
        [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];

    } failure:^{

        // Hide the spinner
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // Ask the user to try again
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"There was a problem." message:@"Please try again." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }];
}

@end
