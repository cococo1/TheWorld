//
//  WorldViewController.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/3/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheWorld.h"
#import "CountryViewController.h"
//#import "CountryChooserViewController.h"

#define COUNTRY_POPOVER_CONTENT_WIDTH 300
#define COUNTRY_POPOVER_CONTENT_HEIGHT 400
#define MAXIMUM_SCROLL_VIEW_ZOOM_SCALE 5.0f
#define MINIMUM_SCROLL_VIEW_ZOOM_SCALE 0.1f

@protocol WorldViewControllerProtocol <NSObject>

-(void) actionFinished:(Action*)action;

@end


@interface WorldViewController : UIViewController <UIScrollViewDelegate,TimelineDelegate, ActionDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@property (nonatomic, strong) NSMutableDictionary* countriesDictionary;
@property (nonatomic, strong) TheWorld* world; //our model
@property (nonatomic, weak) Country* myCountry;
@property (nonatomic, weak) id<WorldViewControllerProtocol>delegate;
@property (nonatomic, strong) Action* myCurrentAction;


-(NSArray*) giveMeTheCountries; //NSStrings* of names
-(void) showCountry:(NSString*)country;
-(void) showWorld;
@end
