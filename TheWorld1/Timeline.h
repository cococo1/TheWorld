//
//  Timeline.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/3/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Action.h"

#define TIMER_INTERVAL 0.1f
#define MINUTE 60
#define HOUR 60 * MINUTE
#define DAY 24 * HOUR
#define WEEK 7 * DAY
#define MONTH 30 * DAY
#define YEAR 365 * DAY



@class Action;

@protocol TimelineDelegate <NSObject>

-(void)timeChanged:(NSDate*)time;

@end

@interface Timeline : NSObject

@property (nonatomic, strong) NSDate* currentTime;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic) double speed;
@property (nonatomic,weak) id<TimelineDelegate> delegate;
-(id)initWithSpeed:(double)speed;
-(void) addAction:(Action*) action;
-(void) deleteAction:(Action*) action;



@end
