//
//  ChimpKit2ViewController.h
//  ChimpKit2
//
//  Created by Amro Mousa on 11/19/10.
//  Copyright 2011 MailChimp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKAuthViewController.h"

@interface ChimpKit2ViewController : UIViewController <CKAuthViewControllerDelegate> {
    BOOL shownAuthView;
}

@end

