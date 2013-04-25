//
//  ViewController.m
//  DevNewsiOS
//
//  Created by Raymond Law on 4/4/13.
//  Copyright (c) 2013 Raymond Law. All rights reserved.
//

#import <DevNews iOS/DevNews.h>
#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User taps easy subscribe button

- (IBAction)easySubscribe:(id)sender
{
    // Create the DevNews singleton object
    DevNews *devNews = [DevNews sharedDevNews];

    // Set a custom headline in the signup form
    devNews.headline = @"Want my free goodies? Subscribe";

    // Ask DevNews to handle the rest of the signup process
    [devNews subscribeToList:nil withPresentingViewController:self];
}

@end
