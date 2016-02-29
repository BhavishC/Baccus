//
//  BVCWineryModel.h
//  Baccus
//
//  Created by Bhavish Chandnani on 15/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BVCWineModel.h"

#define RED_WINE_KEY @"Tinto"
#define WHITE_WINE_KEY @"Blanco"

@interface BVCWineryModel : NSObject

@property (readonly, nonatomic) int redWinesCount;
@property (readonly, nonatomic) int whiteWinesCount;
@property (readonly, nonatomic) int otherWinesCount;


-(BVCWineModel *) redWineAtIndex: (int) index;
-(BVCWineModel *) whiteWineAtIndex: (int) index;
-(BVCWineModel *) otherWineAtIndex: (int) index;


@end
