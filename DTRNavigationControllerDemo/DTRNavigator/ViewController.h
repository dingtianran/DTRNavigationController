//
//  ViewController.h
//  DTRNavigator
//
//  Created by dingtr on 12-7-14.
//  Copyright (c) 2012年 dingtr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTRNavigationController.h"

@interface ViewController : UIViewController <DTRNavigationControllerDelegate>

- (IBAction)pushButtonPressed:(id)sender;

- (IBAction)popButtonPressed:(id)sender;

@end
