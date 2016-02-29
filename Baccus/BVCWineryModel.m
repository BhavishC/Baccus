 //
//  BVCWineryModel.m
//  Baccus
//
//  Created by Bhavish Chandnani on 15/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "BVCWineryModel.h"

@interface BVCWineryModel ()

@property(strong,nonatomic) NSMutableArray *redWines;
@property(strong,nonatomic) NSMutableArray *whiteWines;
@property(strong,nonatomic) NSMutableArray *otherWines;

@end

@implementation BVCWineryModel

#pragma mark - Properties
-(int) redWinesCount{
	return [self.redWines count];
}

-(int) whiteWinesCount{
	return [self.whiteWines count];
}

-(int) otherWinesCount{
	return [self.otherWines count];
}

-(id) init{
	self=[super init];
	
	if (self){
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://golang.bz/baccus/wines.json"]];
        NSURLSession *session = [NSURLSession sharedSession];
        
        [[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            if (data){
                NSArray *JSONObjects = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:kNilOptions
                                                                         error:&error];
                if (JSONObjects) {
                    for (NSDictionary *dict in JSONObjects) {
                        BVCWineModel *wine = [[BVCWineModel alloc] initWithDictionary:dict];
                        
                        //añadir el vino al tipo que corresponde
                        if ([wine.type isEqualToString:RED_WINE_KEY]) {
                            if (!self.redWines) {
                                self.redWines = [NSMutableArray arrayWithObject:wine];
                            } else {
                                [self.redWines addObject:wine];
                            }
                        } else if ([wine.type isEqualToString:WHITE_WINE_KEY]){
                            if (!self.whiteWines) {
                                self.whiteWines = [NSMutableArray arrayWithObject:wine];
                            } else {
                                [self.whiteWines addObject:wine];
                            }

                        } else {
                            if (wine.name) {
                                if (!self.otherWines) {
                                    self.otherWines = [NSMutableArray arrayWithObject:wine];
                                } else {
                                    [self.otherWines addObject:wine];
                                }
                            }
                        }
                        
                    }
                }
            }else{
                NSLog(@"Error al parsear JSON: %@", error.localizedDescription);
            }
        }]resume];
        
		
    }else{
        NSLog(@"Error al descargar datos del servidor.");
    }
	return self;
}




-(BVCWineModel *) redWineAtIndex: (int) index{
	return [self.redWines objectAtIndex:index];
}
-(BVCWineModel *) whiteWineAtIndex: (int) index{
	
	return [self.whiteWines objectAtIndex:index];
}
-(BVCWineModel *) otherWineAtIndex: (int) index{
	
	return [self.otherWines objectAtIndex:index];
}

@end
