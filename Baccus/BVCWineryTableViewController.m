//
//  BVCWineryTableViewController.m
//  Baccus
//
//  Created by Bhavish Chandnani on 15/2/16.
//  Copyright © 2016 T-systems. All rights reserved.
//

#import "BVCWineryTableViewController.h"
#import "BVCWineViewController.h"

@interface BVCWineryTableViewController (){
    UIColor *wineColor;
    UIColor *wineColorWithAlpha;
    UIColor* lightYellowColor;
    UIColor* lightYellowColorWithAlpha;
    
}
   

@end

@implementation BVCWineryTableViewController


-(id) initWithModel: (BVCWineryModel *) aModel
			  style: (UITableViewStyle) style{
	self= [super initWithStyle:style];
	
	if (self) {
		_model =aModel;
		self.title =@"Baccus";
        
        wineColor= [UIColor colorWithRed:120.0/255.0
                                            green:10.0/255.0
                                             blue:10.0/255.0
                                            alpha:1];
        
        wineColorWithAlpha= [UIColor colorWithRed:140.0/255.0
                                             green:15.0/255.0
                                              blue:15.0/255.0
                                             alpha:1];
        lightYellowColor= [UIColor colorWithRed:255.0/255.0
                                          green:250.0/255.0
                                           blue:160.0/255.0
                                          alpha:1];
        lightYellowColorWithAlpha= [UIColor colorWithRed:245.0/255.0
                                    green:240.0/255.0
                                    blue:210.0/255.0
                                          alpha:1];
 
        
		
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	
	self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.5
																			  green:0
																			   blue:0.13
																			  alpha:1];
    self.tableView.backgroundColor = lightYellowColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case RED_WINE_SECTION:
			return @"Vinos Tintos";
			break;
		case WHITE_WINE_SECTION:
			return @"Vinos blancos";
			break;
		case OTHER_WINE_SECTION:
			return @"Otros vinos";
			break;
			
		default:
			return 0;
			break;
	}

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
// return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
// return the number of rows
	switch (section) {
		case RED_WINE_SECTION:
				return self.model.redWinesCount;
			break;
		case WHITE_WINE_SECTION:
				return self.model.whiteWinesCount;
			break;
		case OTHER_WINE_SECTION:
				return self.model.otherWinesCount;
			break;
			
		default:
			return 0;
			break;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (!cell){
		// Crear a mano la celda
		cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
	//Averiguar de que modelo nos estan hablando
    BVCWineModel *wine =[self wineAtIndexPath:indexPath];
	
	// Sincronizar celda (vista) y modelo (objeto vino)
	//cell.imageView.image = wine.photoURL;

  
	cell.textLabel.text = wine.name;
	cell.detailTextLabel.text = wine.wineCompanyName;
    [cell.imageView setImage:wine.photo];
    
    [self customizeCell:cell];
	
	//Devolver la celda
    return cell;
}

-(void) customizeCell: (UITableViewCell *) cell {
    
    cell.backgroundColor =wineColorWithAlpha;
    
    cell.textLabel.font = [UIFont fontWithName:@"Cochin-Bold" size:14];
    cell.textLabel.textColor=lightYellowColor;
    cell.detailTextLabel.font = [UIFont fontWithName:@"Cochin" size:14];
    cell.detailTextLabel.textColor=lightYellowColor;
    
    
}


-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        castView.contentView.backgroundColor = lightYellowColor;
        [castView.textLabel setTextColor:wineColor];
        castView.textLabel.font = [UIFont fontWithName:@"Cochin-Bold" size:18];
    }
}

#pragma mark - Table view delegate

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	//Suponemos que estamos en un Navigation Controller
	
	//Averiguamos de que vino se trata
    BVCWineModel *wine = [self wineAtIndexPath:indexPath];
    
	[self.delegate wineryTableViewController:self didSelectWine:wine];
	
	//Notification
	NSNotification *n = [NSNotification notificationWithName:NEW_WINE_NOTIFICATION_NAME
													  object:self
													userInfo:@{WINE_KEY:wine}];
	
	[[NSNotificationCenter defaultCenter] postNotification:n];
    
    [tableView beginUpdates];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self changeCellStyleToSelected:cell];
    [tableView endUpdates];
    
    NSIndexPath *prevIndexPath= [self lastSelectedWineIndexPath];
    
    if (!(prevIndexPath.section==indexPath.section && prevIndexPath.row == indexPath.row)) {
        UITableViewCell *prevCell = [tableView cellForRowAtIndexPath:prevIndexPath];
        [self changeCellStyleToUnselected:prevCell];
    }
    
    //Guardar el último vino selectionado
    [self saveLastSelectedWineAtSection:indexPath.section
                                    row:indexPath.row];
    
}

-(void) changeCellStyleToSelected: (UITableViewCell *) cell{
    cell.backgroundColor =lightYellowColorWithAlpha;
    
    cell.textLabel.textColor=wineColor;
    cell.detailTextLabel.textColor=wineColor;
}

-(void) changeCellStyleToUnselected: (UITableViewCell *) cell{
    
    cell.backgroundColor =wineColorWithAlpha;
    
    cell.textLabel.textColor=lightYellowColor;
    cell.detailTextLabel.textColor=lightYellowColor;
}


#pragma mark - Utils
-(BVCWineModel *) wineAtIndexPath: (NSIndexPath *) indexPath{
    BVCWineModel *wine =nil;
    switch (indexPath.section) {
        case RED_WINE_SECTION:
            wine = [self.model redWineAtIndex:indexPath.row];
            break;
        case WHITE_WINE_SECTION:
            wine = [self.model whiteWineAtIndex:indexPath.row];
            break;
        case OTHER_WINE_SECTION:
            wine = [self.model otherWineAtIndex:indexPath.row];
            break;
            
        default:
            
            break;
    }
    return wine;
}

#pragma mark - NSUserDefaults

-(void) saveLastSelectedWineAtSection:(NSUInteger) section row:(NSUInteger) row{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@{SECTION_KEY : @(section), ROW_KEY : @(row)}
                 forKey:LAST_WINE_SELECTED];
    //Sincronizamos por si acaso
    [defaults synchronize];
}

-(NSDictionary *) setDefaults{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    //Definimos el primer vino tinto como el vino por defecto
    NSDictionary *defaultWineCoords = @{SECTION_KEY : @(RED_WINE_SECTION), ROW_KEY : @0};
    
    //lo asignamos
    [defaults setObject:defaultWineCoords forKey:LAST_WINE_SELECTED];
    
    //guardamos
    [defaults synchronize];
    
    return defaultWineCoords;
    
}

-(BVCWineModel *) lastSelectedWine {
    
    NSIndexPath *indexPath= [self lastSelectedWineIndexPath];
    
    return [self wineAtIndexPath:indexPath];
}

-(NSIndexPath *) lastSelectedWineIndexPath {
    NSIndexPath *indexPath = nil;
    NSDictionary *coords = nil;
    
    coords= [[NSUserDefaults standardUserDefaults] objectForKey:LAST_WINE_SELECTED];
    
    if (!coords){
        //No hay nada bajo la clave LAST_WINE_SELECTED ponemos el valor por defecto (el primero de los tintos)
        coords =[self setDefaults];
    }
    
    indexPath = [NSIndexPath indexPathForRow:[[coords objectForKey:ROW_KEY] integerValue]
                                   inSection:[[coords objectForKey:SECTION_KEY]integerValue]];
    return indexPath;
}

#pragma mark - BVCWineryTableViewControllerDelegate

-(void)wineryTableViewController:(BVCWineryTableViewController *)wineryVC
                   didSelectWine:(BVCWineModel *)aWine{
    //Creamos el controllador
    BVCWineViewController *wineVC = [[BVCWineViewController alloc] initWithModel:aWine];
    
    //Hacemos el push
    [self.navigationController pushViewController:wineVC animated:YES];
}


@end
