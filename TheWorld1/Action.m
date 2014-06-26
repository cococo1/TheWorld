//
//  Action.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/26/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "Action.h"
#import "Index.h"
//#import "Timeline.h"

@interface Action()

@property (nonatomic, strong) NSDictionary* dictionaryOfStrengths;
@end

@implementation Action

-(void) setStartTime:(NSDate *)startTime
{
    _startTime = startTime;
    _endTime = [NSDate dateWithTimeInterval:self.duration sinceDate:startTime];
}

-(void) setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    _endTime = [NSDate dateWithTimeInterval:_duration sinceDate:self.startTime];

}

-(id)initWithName:(NSString*)name
        startTime:(NSDate*)startTime
         duration:(NSTimeInterval)duration
       onTimeline:(Timeline*)timeline
  affectedIndices:(NSArray*)affectedIndices
dictionaryOfStrengths:(NSDictionary*)strengths
            place:(CGPoint)place
{
    _dictionaryOfStrengths = strengths;
    
    return [self initWithName:name
                    startTime:startTime
                     duration:duration
                   onTimeline:timeline
              affectedIndices:affectedIndices
                     strength:0.0
                        place:place];
}

-(id)initWithName:(NSString*)name
        startTime:(NSDate*)startTime
         duration:(NSTimeInterval)duration
         onTimeline:(Timeline*) timeline
  affectedIndices:(NSArray*)affectedIndices
         strength:(double)strength
            place:(CGPoint)place 
{
    self = [super init];
    if (self)
    {
        _name = [NSString stringWithString:name];
        _startTime = startTime;
        _endTime = [NSDate dateWithTimeInterval:duration sinceDate:startTime];
        _duration = duration;
        _happens = NO;
        _timeline = timeline;
        _affectedIndices = affectedIndices;
        _strength = strength;
        _place = place;
    }
    return self;
}

-(id) init
{
    [NSException raise:@"Call designated initializer instead" format:nil];
    return nil;
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@",self.name];
}

-(void)willStart
{
    if ([[self.startTime laterDate:self.timeline.currentTime] isEqualToDate:self.timeline.currentTime])
    {
        self.startTime = self.timeline.currentTime;
    }
    
    [self.timeline addAction:self];
    NSLog(@"%@ will start soon.",self);

}

-(void)start
{
    self.happens = YES;
//    NSLog(@"%@ started.",self);
}

-(void) affectIndex:(Index*)index
       realDuration:(NSTimeInterval)realDuration
   supposedDuration:(NSTimeInterval)supposedDuration
           strength:(float)power
{
//    NSLog(@"index:%@",index);
    NSNumber* pow = [self.dictionaryOfStrengths valueForKey:index.name];
    if (pow)
    {
        power = [pow floatValue];
    }
    
    if ([index.subindices.allValues count])
    {
        NSArray* subindices = [index.subindices allValues];
        for (Index* i in subindices)
        {
            [self affectIndex:i
                 realDuration:realDuration
             supposedDuration:supposedDuration
             strength:power];
        }
    }
    else
    {
        index.value += ( fabs(index.value) * power * (realDuration/supposedDuration));
//        NSLog(@"supposed duration %f",supposedDuration);
        if (index.value != index.value)
        {
            while (1) {
                NSLog(@"we've got a nan!!!");
                sleep(1000);
            }
        }
//        NSLog(@"Index.name: %@, value:%f", index.name, index.value);

    }
    
}

-(void)stop
{
    NSDate* realEndTime = [self.timeline currentTime];
//    NSLog(@"%@ stopped.",self);
    self.happens = NO;
    NSTimeInterval supposedDuration = [self.endTime timeIntervalSinceDate:self.startTime];
    if (supposedDuration < 2)
    {
        supposedDuration = 1;
    }
    NSTimeInterval realDuration = [realEndTime timeIntervalSinceDate:self.startTime];
    if (realDuration > supposedDuration) realDuration = supposedDuration;
    if (realDuration < supposedDuration)
    {
        NSLog(@"%@ was shorter than predicted",self.name);
    }
    for (Index* index in self.affectedIndices)
    {
        [self affectIndex:index
             realDuration:realDuration
         supposedDuration:supposedDuration
                 strength:self.strength];
    }
    
    [self.delegate actionFinished:self];
    [self.timeline deleteAction:self];

}


@end
