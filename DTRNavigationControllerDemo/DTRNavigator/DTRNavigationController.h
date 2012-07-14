//
//  DTRNavigationController.h
//  DTRNavigator
//
//  Created by dingtr on 12-7-14.
//  Copyright (c) 2012年 dingtr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTRNavigationController : UIViewController {
    NSMutableArray *_viewControllers;
    UIView *_blackMask;
    
}

@property(nonatomic, retain) NSMutableArray *viewControllers;

- (id) initWithRootViewController:(UIViewController*)rootViewController;
- (void) pushViewController:(UIViewController *)viewController;
- (void) popViewController;

@end

@protocol DTRNavigationControllerDelegate <NSObject>

@optional

@property (nonatomic, assign) DTRNavigationController *navigator;

- (UIViewController *) viewControllerToPush;

@end