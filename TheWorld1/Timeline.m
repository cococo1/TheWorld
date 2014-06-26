//
//  Timeline.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/3/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "Timeline.h"
#import "Action.h"

@interface Timeline()

@property (nonatomic,strong) NSMutableArray* actions;

@end

@implementation Timeline

-(id)initWithSpeed:(double)speed
{
    self = [super init];
    if (self)
    {
        _currentTime = [NSDate date];
        _timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL
                                                  target:self
                                                selector:@selector(tic)
                                                userInfo:nil
                                                 repeats:YES];
        _actions = [NSMutableArray array];
        _speed = speed;
    }
    NSLog(@"Timeline created.");
    return self;
}

-(id) init
{
    self = [self initWithSpeed:0.1f];
    return self;
}

-(void) tic
{
    self.currentTime = [NSDate dateWithTimeInterval:self.speed
                                          sinceDate:self.currentTime];
    
    [self.delegate timeChanged:self.currentTime];
label:
//    NSLog(@"number of actions: %i",[self.actions count]);
    for (Action* action in self.actions)
    {
//        if ([action.name isEqualToString:@"Economic growth"])
//        {
////            NSLog(@"start time: %@, is happenning: %i",action.startTime, action.isHappenning);
//        }
        if ([[action.startTime laterDate:self.currentTime] isEqualToDate:self.currentTime] && !action.isHappenning )
        {
            [action start];
        }
        
        if ([[action.endTime laterDate:self.currentTime] isEqualToDate:self.currentTime])
        {
//            NSLog(@"action to remove: %@ %@",action.name, action.startTime);
            [action stop];
            [self deleteAction:action];
            goto label;
        }
    }
}

-(void) deleteAction:(Action*) action
{
//    NSLog(@"delete action: %@",action.name);
    [self.actions removeObject:action];

}

-(void) addAction:(Action*)action
{
//    NSLog(@"number of actions on timeline: %i",[self.actions count]);
    [self.actions addObject:action];
//    NSLog(@"number of actions on timeline: %i",[self.actions count]);
//    NSLog(@"action: %@",action.name);

}

-(NSString*) description
{
    return @"This is a timeline";
}


@end
