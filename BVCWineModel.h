//
//  BVCWineModel.h
//  Baccus
//
//  Created by Bhavish Chandnani on 12/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

#define NO_RATING -1

@interface BVCWineModel : NSObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *wineCompanyWeb;
@property (strong, nonatomic) NSString *notes;
@property (strong, nonatomic) NSString *origin;
@property (nonatomic) int rating;		// 0 - 5
@property (strong, nonatomic) NSArray *grapes;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *wineCompanyName;
@property (strong, nonatomic) UIImage *photo;


//Class methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin:(NSString *) anOrigin
			grapes: (NSArray *) arrayOfGrapes
	wineCompanyWeb: (NSURL *) aURL
			 notes: (NSString *) aNotes
			rating: (int) aRating
			 photoURL: (NSURL *) photoURL;

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin: (NSString *)anOrigin;


// Initializers

//Designated

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin:(NSString *) anOrigin
			grapes: (NSArray *) arrayOfGrapes
	wineCompanyWeb: (NSURL *) aURL
			 notes: (NSString *) aNotes
			rating: (int) aRating
			 photoURL: (NSURL *) photoURL;

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin: (NSString *)anOrigin;

// Inicializador a partir de diccionario JSON
-(id) initWithDictionary: (NSDictionary *) dict;

@end
