//
//  ChimpKit2ViewController.m
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import "ChimpKit2ViewController.h"
#import "SubscribeAlertView.h"
#import "CKAuthViewController.h"
@implementation ChimpKit2ViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SubscribeAlertView *alert = [[SubscribeAlertView alloc] initWithTitle:@"Subscribe" 
                                                                  message:@"Enter your email address to subscribe to our mailing list." 
                                                                   apiKey:@"<YOUR API KEY>" 
                                                                   listId:@"<LIST ID>" 
                                                        cancelButtonTitle:@"Cancel"
                                                     subscribeButtonTitle:@"Subscribe"];
//    [alert show];
    
    
    //Authenticating via OAuth2

    if (!shownAuthView) {
        shownAuthView = YES;

        //You don't have to use a navigation controller, but we'll put a cancel button on it for you if you do
        CKAuthViewController *authViewController = [[CKAuthViewController alloc] initWithClientId:@"<YOUR_CLIENT_ID>" andClientSecret:@"<YOUR_CLIENT_SECRET>"];
        authViewController.delegate = self;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:authViewController];
//        [self presentModalViewController:navigationController animated:YES];
    }
}

- (void)ckAuthSucceededWithApiKey:(NSString *)apiKey {
    NSLog(@"Auth success - api key is: %@", apiKey);
}

- (void)ckAuthFailedWithError:(NSError *)error {
    NSLog(@"Auth failed - error is: %@", error);
}

- (void)ckAuthUserDismissedView {
    NSLog(@"User dismissed view");
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
