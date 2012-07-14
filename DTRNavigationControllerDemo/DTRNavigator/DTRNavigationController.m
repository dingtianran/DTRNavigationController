//
//  DTRNavigationController.m
//  DTRNavigator
//
//  Created by dingtr on 12-7-14.
//  Copyright (c) 2012年 dingtr. All rights reserved.
//

#import "DTRNavigationController.h"

#define ANIMATION_DURATION 1.0
#define ANIMATION_DELAY 0

@interface DTRNavigationController (Private)

- (UIViewController *)currentViewController;
- (UIViewController *)previousViewController;
- (void)setNavigatorIfNeeded:(UIViewController *)viewController;

@end

@implementation DTRNavigationController
@synthesize viewControllers = _viewControllers;

- (id) initWithRootViewController:(UIViewController*)rootViewController {
    if (self = [super init]) {
        self.viewControllers = [NSMutableArray arrayWithObject:rootViewController];
        [self setNavigatorIfNeeded:rootViewController];
        [self.view addSubview:rootViewController.view];
        
    }
    return self;
    
}

- (void) dealloc {
    [_viewControllers release];
    [super dealloc];
}

- (void) loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    _blackMask = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    _blackMask.backgroundColor = [UIColor blackColor];
    _blackMask.alpha = 0.0;
    [self.view insertSubview:_blackMask atIndex:0];
    
}


- (void) pushViewController:(UIViewController *)viewController {
    viewController.view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
    // Add the new view to our view hierarchy so that it displays on screen.
    // black mask is a transparent uiview to make the behind view looks dim(alpha 0.0 -> 0.5)
    _blackMask.alpha = 0.0;
    [self.view bringSubviewToFront:_blackMask];
    [self.view addSubview:viewController.view];
    
    [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DELAY options:UIViewAnimationCurveEaseInOut animations:^{
        CGAffineTransform transf = CGAffineTransformIdentity;
        [self currentViewController].view.transform = CGAffineTransformScale(transf, 0.8, 0.8);
        viewController.view.frame = self.view.bounds;
        _blackMask.alpha = 0.5;
    }   completion:^(BOOL finished) {
        if (finished) {
            // Connect DTRNavigationController to viewController if needed
            [self setNavigatorIfNeeded:viewController];
            
            // Add the new controller to our viewController stack
            [self.viewControllers addObject:viewController];
            
        }
    }];
}

- (void) popViewController {
    if (self.viewControllers.count < 2) {
        return;
    }
    _blackMask.alpha = 0.5;
    [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DELAY options:UIViewAnimationCurveEaseInOut animations:^{
        [self currentViewController].view.frame = CGRectOffset(self.view.bounds, self.view.bounds.size.width, 0);
        CGAffineTransform transf = CGAffineTransformIdentity;
        [self previousViewController].view.transform = CGAffineTransformScale(transf, 1.0, 1.0);
        [self previousViewController].view.frame = self.view.bounds;
        _blackMask.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view bringSubviewToFront:[self previousViewController].view];
            // Remove current view controller from viewController stack
            [self.viewControllers removeLastObject];
        }
    }];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Private implementation

- (void)setNavigatorIfNeeded:(UIViewController *)viewController {
    if ([viewController respondsToSelector:@selector(setNavigator:)]) {
        [viewController performSelector:@selector(setNavigator:) withObject:self];
    }
}

- (UIViewController *)currentViewController {
    UIViewController *result = nil;
    if ([self.viewControllers count]>0) {
        result = [self.viewControllers lastObject];
    }
    return result;
}

- (UIViewController *)previousViewController {
    UIViewController *result = nil;
    if ([self.viewControllers count]>1) {
        result = [self.viewControllers objectAtIndex:self.viewControllers.count - 2];
    }
    return result;
}


@end
