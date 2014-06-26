//
//  TheWorld.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/4/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Timeline.h"
#import "Country.h"
#import "Action.h"

@interface TheWorld : NSObject

//It is unique for the world:
@property (nonatomic, strong, readonly) Timeline* timeline;

-(id) initWithName:(NSString*)name;
-(void) addCountry:(Country*)country;
-(void) computeScore;


@end
