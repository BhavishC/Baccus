//
//  BVCWineryTableViewController.h
//  Baccus
//
//  Created by Bhavish Chandnani on 15/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVCWineryModel.h"

#define RED_WINE_SECTION 0
#define WHITE_WINE_SECTION 1
#define OTHER_WINE_SECTION 2

#define NEW_WINE_NOTIFICATION_NAME @"newWine"
#define WINE_KEY @"wine"

#define LAST_WINE_SELECTED @"lastWine"
#define SECTION_KEY @"section"
#define ROW_KEY @"row"

@class BVCWineryTableViewController;


@protocol BVCWineryTableViewControllerDelegate <NSObject>

-(void) wineryTableViewController: (BVCWineryTableViewController *) wineryVC didSelectWine: (BVCWineModel *) aWine;

@end

@interface BVCWineryTableViewController : UITableViewController <BVCWineryTableViewControllerDelegate>

@property (strong, nonatomic) BVCWineryModel *model;
@property (weak, nonatomic) id<BVCWineryTableViewControllerDelegate> delegate;

-(id) initWithModel: (BVCWineryModel *) aModel
			  style: (UITableViewStyle) style;

-(BVCWineModel *) lastSelectedWine;
@end


