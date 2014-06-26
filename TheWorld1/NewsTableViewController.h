//
//  NewsTableViewController.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/17/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewController : UITableViewController

@property (nonatomic) int numberOfRows;
-(void) addNews:(NSArray*)news;

@end
