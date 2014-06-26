//
//  Action.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/26/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "Foundation/Foundation.h"
#import "Timeline.h"

@protocol ActionDelegate <NSObject>

-(void) actionFinished:(Action*)action;

@end

@interface Action : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, weak) Timeline* timeline;
@property (nonatomic, strong) NSDate *startTime;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, strong, readonly) NSDate *endTime;
@property (nonatomic, getter = isHappenning) BOOL happens;
@property (nonatomic, strong) NSArray *affectedIndices;
@property (nonatomic) double strength; // between -1 and 1. *100 = percent of change.
@property (nonatomic, weak) id<ActionDelegate> delegate;
@property (nonatomic) CGPoint place;

-(id)initWithName:(NSString*)name
        startTime:(NSDate*)startTime
         duration:(NSTimeInterval)duration
       onTimeline:(Timeline*)timeline
  affectedIndices:(NSArray*)affectedIndices //TO DO HERE: NSDictionary - each index has a specific affect
         strength:(double)strength
            place:(CGPoint)place;

-(id)initWithName:(NSString*)name
        startTime:(NSDate*)startTime
         duration:(NSTimeInterval)duration
       onTimeline:(Timeline*)timeline
  affectedIndices:(NSArray*)affectedIndices
         dictionaryOfStrengths:(NSDictionary*)strengths
            place:(CGPoint)place;

-(void)willStart;
-(void)stop;
//Called only by timeline TODO here !!
-(void)start;
@end
