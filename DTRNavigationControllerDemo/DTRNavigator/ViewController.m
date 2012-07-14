//
//  ViewController.m
//  DTRNavigator
//
//  Created by dingtr on 12-7-14.
//  Copyright (c) 2012年 dingtr. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize navigator = _navigator;

- (void) dealloc {
    [super dealloc];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pushButtonPressed:(id)sender {
    [self.navigator pushViewController:[[[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]] autorelease]];
    
}

- (IBAction)popButtonPressed:(id)sender {
    [self.navigator popViewController];
    
}

@end
