//
//  BVCWineModel.m
//  Baccus
//
//  Created by Bhavish Chandnani on 12/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "BVCWineModel.h"

@implementation BVCWineModel

@synthesize photo = _photo;

#pragma mark - Properties

-(UIImage *) photo{
    //Carga de imagen a partir de URL, se debería hacer en segundo plano
    if (!_photo) {
        _photo =[UIImage imageWithData:[NSData dataWithContentsOfURL:self.photoURL]];
    }
    return _photo;
}

# pragma mark - Class Methods

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin:(NSString *) anOrigin
			grapes: (NSArray *) arrayOfGrapes
	wineCompanyWeb: (NSURL *) aURL
			 notes: (NSString *) aNotes
			rating: (int) aRating
			 photoURL: (NSURL *) aPhotoURL{
	return [[self alloc] initWithName:aName
					  wineCompanyName:aWineCompanyName
								 type:aType
							   origin:anOrigin
							   grapes:arrayOfGrapes
					   wineCompanyWeb:aURL
								notes:aNotes
							   rating:aRating
								photoURL:aPhotoURL];
}

+(id) wineWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin: (NSString *)anOrigin{
	return [[self alloc] initWithName:aName wineCompanyName:aWineCompanyName type:aType origin:anOrigin];
	
}

# pragma mark - Init
-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin:(NSString *) anOrigin
			grapes: (NSArray *) arrayOfGrapes
	wineCompanyWeb: (NSURL *) aURL
			 notes: (NSString *) aNotes
			rating: (int) aRating
			 photoURL: (NSURL *) aPhotoURL{
	self =[super init];
	
	if (self) {
		// Asignamos los parámetros a las variables de instancia
		_name =aName;
		_wineCompanyName=aWineCompanyName;
		_type=aType;
		_origin=anOrigin;
		_grapes=arrayOfGrapes;
		_wineCompanyWeb=aURL;
		_notes=aNotes;
		_rating=aRating;
		_photoURL=aPhotoURL;
	}
	
	return self;
}

-(id) initWithName: (NSString *) aName
   wineCompanyName: (NSString *) aWineCompanyName
			  type: (NSString *) aType
			origin: (NSString *)anOrigin {
	self = [self initWithName:aName
			  wineCompanyName:aWineCompanyName
						 type:aType origin:anOrigin
					   grapes:nil
			   wineCompanyWeb:nil
						notes:nil
					   rating:NO_RATING
						photoURL:nil];

	return self;
}

#pragma mark - JSON
-(id) initWithDictionary: (NSDictionary *) dict{
    return [self initWithName:[dict objectForKey:@"name"]
              wineCompanyName:[dict objectForKey:@"company"]
                         type:[dict objectForKey:@"type"]
                       origin:[dict objectForKey:@"origin"]
                       grapes: [self extractGrapesFromJSONArray:[dict objectForKey:@"grapes"]]
               wineCompanyWeb:[NSURL URLWithString:[dict objectForKey:@"wine_web"]]
                        notes:[dict objectForKey:@"notes"]
                       rating:[[dict objectForKey:@"rating"]integerValue]
                     photoURL:[NSURL URLWithString:[dict objectForKey:@"picture"]]];
}

-(NSDictionary *) proxyForJSON{
    return @{@"name"            :   self.name,
             @"company"         :   self.wineCompanyName,
             @"wine_web"        :   [self.wineCompanyWeb path],
             @"type"            :   self.type,
             @"origin"          :   self.origin,
             @"grapes"          :   self.grapes,
             @"notes"           :   self.notes,
             @"rating"          :   @(self.rating),
             @"picture"         :   [self.photoURL path]};
}

#pragma mark - Utils

-(NSArray *) extractGrapesFromJSONArray: (NSArray *) JSONArray{
    
    NSMutableArray *grapes = [NSMutableArray arrayWithCapacity:[JSONArray count]];
    
    for (NSDictionary *dic in JSONArray) {
        [grapes addObject:[dic objectForKey:@"grape"]];
    }
    
    return grapes;
}

-(NSArray *) packGrapesIntoJSONArray {
    
    NSMutableArray *jsonArray = [NSMutableArray arrayWithCapacity:[self.grapes count]];
    
    for (NSString *grape in self.grapes) {
        [jsonArray addObject:@{@"grape": grape}];
    }
    return jsonArray;
}
@end