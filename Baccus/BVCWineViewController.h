//
//  BVCWineViewController.h
//  Baccus
//
//  Created by Bhavish Chandnani on 14/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVCWineModel.h"
#import "BVCWineryTableViewController.h"

@interface BVCWineViewController : UIViewController <UISplitViewControllerDelegate, BVCWineryTableViewControllerDelegate>

@property (strong, nonatomic) BVCWineModel *model;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wineryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *grapesLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *ratingViews;

-(id) initWithModel: (BVCWineModel *) aModel;

-(IBAction)displayWeb:(id)sender;

@end
