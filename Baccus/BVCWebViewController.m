//
//  BVCWebViewController.m
//  Baccus
//
//  Created by Bhavish Chandnani on 14/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "BVCWebViewController.h"
#import "BVCWineryTableViewController.h"

@interface BVCWebViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation BVCWebViewController

-(id) initWithModel: (BVCWineModel *) model
{
	self =[super initWithNibName:nil bundle:nil];
	
	if(self){
		_model=model;
		self.title=@"Web";
	}
	return self;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	[self displayURL: self.model.wineCompanyWeb];
	
	//Alta en notificacion
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self
               selector:@selector(wineDidChange :)
                   name:NEW_WINE_NOTIFICATION_NAME object:nil];
}

#pragma mark - Notification selector

-(void) wineDidChange: (NSNotification *) notification{
	NSDictionary *dict = [notification userInfo];
	BVCWineModel *newWine = [dict objectForKey:WINE_KEY];
	
	//Actualiza modelo
	self.model =  newWine;
	
	[self displayURL:self.model.wineCompanyWeb];
	
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	//Baja en notificacion
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Utils

-(void) displayURL: (NSURL *) aURL{
	
	self.activityView.hidden=NO;
	[self.activityView startAnimating];
	
	[self.browser loadRequest:[NSURLRequest requestWithURL:aURL]];
	self.browser.delegate=self;
}


#pragma mark - UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[self.activityView stopAnimating];
	self.activityView.hidden=YES;
}

@end
