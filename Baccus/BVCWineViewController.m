//
//  BVCWineViewController.m
//  Baccus
//
//  Created by Bhavish Chandnani on 14/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "BVCWineViewController.h"
#import "BVCWebViewController.h"
#import "BVCWineryTableViewController.h"

@interface BVCWineViewController ()

@end

@implementation BVCWineViewController

-(id) initWithModel: (BVCWineModel *) aModel{
	self =[super initWithNibName:nil bundle:nil];
	
	if (self) {
		_model =aModel;
		self.title=aModel.name;
        
    }
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"pergamino.jpg"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
}


//Sincronización etnre modelo y vista
-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[self syncModelWithView];
	self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5 green:0 blue:0.13 alpha:1];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:255.0/255.0
                                                                          green:250.0/255.0
                                                                           blue:160.0/255.0
                                                                          alpha:1]];
    
}

-(void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)displayWeb:(id)sender{
	//Crear un web view controller
	BVCWebViewController *webVC = [[BVCWebViewController alloc] initWithModel:self.model];
	
	//Hacemos un push
	[self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Utils

-(void) syncModelWithView{
	self.nameLabel.text=self.model.name;
	self.wineryNameLabel.text=self.model.wineCompanyName;
	self.typeLabel.text=self.model.type;
	self.originLabel.text=self.model.origin;
	self.notesLabel.text=self.model.notes;
	self.photoView.image=self.model.photo;
	self.grapesLabel.text= [self arrayToString:self.model.grapes];
	[self displayRating:self.model.rating];
	
	[self.notesLabel setNumberOfLines:0];
	
}

-(NSString *) arrayToString: (NSArray *) array{
	NSString *string = nil;
	if (array.count==1) {
		string=[@"100% " stringByAppendingString:[[array lastObject] stringByAppendingString:@"."]];
	}else{
		[[array componentsJoinedByString:@", "]	 stringByAppendingString:@"."];
	}
	return string;
}

-(void) displayRating:(int) aRating{
	[self clearRatings];
	UIImage *glass =[UIImage imageNamed:@"splitView_score_glass"];
	for (int i=0; i<aRating; i++) {
		[[self.ratingViews objectAtIndex:i] setImage:glass];
	}
}

-(void) clearRatings{
	for (UIImageView *img in self.ratingViews) {
		img.image=nil;
	}
}

#pragma mark - UISplitViewControllerDelegate

-(void) splitViewController:(UISplitViewController *)svc
	willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
	
	if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
		self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
	} else {
		self.navigationItem.rightBarButtonItem=nil;
	}
}

#pragma mark - WineryTableViewControllerDelegate

-(void) wineryTableViewController: (BVCWineryTableViewController *) wineryVC didSelectWine: (BVCWineModel *) aWine{
	self.model = aWine;
	self.title = aWine.name;
	[self syncModelWithView];
}


@end
