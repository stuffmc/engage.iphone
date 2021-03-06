/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
 Copyright (c) 2010, Janrain, Inc.
 
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
	 list of conditions and the following disclaimer. 
 * Redistributions in binary form must reproduce the above copyright notice, 
	 this list of conditions and the following disclaimer in the documentation and/or
	 other materials provided with the distribution. 
 * Neither the name of the Janrain, Inc. nor the names of its
	 contributors may be used to endorse or promote products derived from this
	 software without specific prior written permission.
 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
 
 File:	 JRModalNavigationController.m 
 Author: Lilli Szafranski - lilli@janrain.com, lillialexis@gmail.com
 Date:	 Tuesday, June 1, 2010
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */


#import "JRModalNavigationController.h"

// TODO: Figure out why the -DDEBUG cflag isn't being set when Active Conf is set to debug
#define DEBUG
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

@implementation JRModalNavigationController

@synthesize navigationController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id)initWithRootViewController:(UIViewController*)controller
{
	if (controller == nil)
	{
		[self release];
		return nil;
	}
	
	if (self = [super init]) 
	{
        navigationController = [[UINavigationController alloc] 
                                initWithRootViewController:controller];    
        navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;        
    }
	        
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView  
{
	DLog(@"");

	UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	DLog(@"view retain count: %d", [view retainCount]);
    
    shouldUnloadSubviews = NO;
    
    [view setHidden:YES];
	[self setView:view];
    [view release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    DLog(@"");
    
    [super viewDidLoad];
    [self retain];
    
	DLog(@"view retain count: %d", [self.view retainCount]);
}


- (void)presentModalNavigationControllerForPublishingActivity
{
	DLog(@"");
	DLog(@"view retain count: %d", [self.view retainCount]);
    
	navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
	[self presentModalViewController:navigationController animated:YES];
}

- (void)presentModalNavigationControllerForAuthentication
{
	DLog(@"");
	navigationController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
	[self presentModalViewController:navigationController animated:YES];
}

- (void)restore:(BOOL)animated
{
	DLog(@"");
	[navigationController popToRootViewControllerAnimated:animated];
}

- (void)viewDidAppear:(BOOL)animated 
{
    DLog(@"");
    [super viewDidAppear:animated];

	DLog(@"view retain count: %d", [self.view retainCount]);
	if (shouldUnloadSubviews)
    {
        [self.view removeFromSuperview];
		[self release];
    }    
}

- (void)dismissModalNavigationController:(UIModalTransitionStyle)style
{
    DLog(@"");
	DLog(@"view retain count: %d", [self.view retainCount]);

    shouldUnloadSubviews = YES;
    navigationController.modalTransitionStyle = style;
    [self.view setHidden:NO];
    [self dismissModalViewControllerAnimated:YES];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewWillDisappear:(BOOL)animated
{
	DLog(@"");
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	DLog(@"");
    [super viewDidDisappear:animated];
}

- (void)viewDidUnload {
	DLog(@"");
    // Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc 
{
	DLog(@"");
    
	DLog(@"view retain count: %d", [self.view retainCount]);
    [navigationController release];

	[super dealloc];
}

@end
