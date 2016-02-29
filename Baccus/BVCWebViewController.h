//
//  BVCWebViewController.h
//  Baccus
//
//  Created by Bhavish Chandnani on 14/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BVCWineModel.h"

@interface BVCWebViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) BVCWineModel *model;

@property (weak, nonatomic) IBOutlet UIWebView *browser;


-(id) initWithModel: (BVCWineModel *) model;

@end
