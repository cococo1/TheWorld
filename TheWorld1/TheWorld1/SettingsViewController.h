//
//  SettingsViewController.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/14/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldViewController.h"

@interface SettingsViewController : UITableViewController <WorldViewControllerProtocol>

//@property (nonatomic) BOOL somethingIsSelected;
//@property (nonatomic) int numberOfRows;
@property (nonatomic, strong) NSMutableArray* possibleActions;
@property (nonatomic, weak) WorldViewController* worldvc;

@end
