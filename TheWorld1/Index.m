//
//  Index.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/26/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "Index.h"


static NSMutableArray* economyIndices = nil;
static NSMutableArray* governanceIndices = nil;
static NSMutableArray* educationIndices = nil;
static NSMutableArray* healthIndices = nil;
static NSMutableArray* entrepreneurshipIndices = nil;
static NSMutableArray* safetyIndices = nil;
static NSMutableArray* personalFreedomIndices = nil;
static NSMutableArray* socialCapitalIndices = nil;

static NSMutableArray* scoreIndices = nil;






@interface Index()
{
    NSMutableArray *similarIndices;
 
}




@end

@implementation Index

@synthesize rank = _rank;
@synthesize value = _value;


-(void) setValue:(double)value
{
    _value = value;
}


+(void) initialize
{
    if (!economyIndices) economyIndices = [NSMutableArray array];
    if (!governanceIndices) governanceIndices = [NSMutableArray array];
    if (!educationIndices) educationIndices = [NSMutableArray array];
    if (!healthIndices) healthIndices = [NSMutableArray array];
    if (!entrepreneurshipIndices) entrepreneurshipIndices = [NSMutableArray array];
    if (!safetyIndices) safetyIndices = [NSMutableArray array];
    if (!personalFreedomIndices) personalFreedomIndices = [NSMutableArray array];
    if (!socialCapitalIndices) socialCapitalIndices = [NSMutableArray array];

    
    if (!scoreIndices) scoreIndices = [NSMutableArray array];

}

//@synthesize value = _value;

-(void) setImportance:(double)importance
{
    if (importance < 0.1) importance = 0.1;
    else if (importance > 1) importance = 1;
    _importance = importance;
}



-(double) value
{

    if (self.subindices)
    {
        int numberOfSubindices = [[self.subindices allValues] count];
        if (numberOfSubindices)
        {
            double result = 0.0f;
            //        NSLog(@"here: %@",[self.subindices class]);
            for (Index* index in [self.subindices allValues])
            {
                result = result + index.value * index.importance;
//                NSLog(@"%@ %f %f",index.name, index.value, index.importance);

            }
//            NSLog(@"%i",[[self.subindices allValues] count]);
            _value = result/numberOfSubindices;
//            NSLog(@"number of subindices: %i",numberOfSubindices);
            if (_value != _value)
            {
                while (1) {
                    NSLog(@"we've got a nan!!!");
                    sleep(1000);
                }
            }
            _value *= self.importance;
        }
    }
    return _value;
}

-(void) setRank:(NSUInteger)rank
{
//    if (rank > VALUE_MAX) rank = VALUE_MAX;
    _rank = rank;
}

-(void) orderSimilarRanks
{
    similarIndices = [NSMutableArray arrayWithArray:[similarIndices sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
     {
         Index *first = (Index*)obj1;
         Index *second = (Index*)obj2;
         return first.value < second.value;
     }]];
//    self.rank = [similarIndices indexOfObject:self]+1;
}

-(NSUInteger) rank
{
    [self orderSimilarRanks];
    _rank = [similarIndices indexOfObject:self]+1;
    return _rank;
}

-(id) initWithName:(NSString*)name
        importance:(double) importance
      initialValue:(double) value
{
    self = [super init];
    if (self)
    {
        _subindices = [[NSMutableDictionary alloc]init];
        _positive = YES;
        if ([name isEqualToString:@"Economy"])
        {
//            NSLog(@"we got to init");

            [economyIndices addObject:self];
            similarIndices = economyIndices;
        }
        else if ([name isEqualToString:@"Governance"])
        {
            [governanceIndices addObject:self];
            similarIndices = governanceIndices;
        }
        else if ([name isEqualToString:@"Entrepreneurship & Opportunity"])
        {
            [entrepreneurshipIndices addObject:self];
            similarIndices = entrepreneurshipIndices;
        }
        else if ([name isEqualToString:@"Safety & Security"])
        {
            [safetyIndices addObject:self];
            similarIndices = safetyIndices;
        }
        else if ([name isEqualToString:@"Education"])
        {
            [educationIndices addObject:self];
            similarIndices = educationIndices;
        }
        else if ([name isEqualToString:@"Personal Freedom"])
        {
            [personalFreedomIndices addObject:self];
            similarIndices = personalFreedomIndices;
        }
        else if ([name isEqualToString:@"Social Capital"])
        {
            [socialCapitalIndices addObject:self];
            similarIndices = socialCapitalIndices;
        }
        else if ([name isEqualToString:@"Health"])
        {
            [healthIndices addObject:self];
            similarIndices = healthIndices;
        }
        else if ([name isEqualToString:@"Score"])
        {
            [scoreIndices addObject:self];
            similarIndices = scoreIndices;
        }
        _name = name;
        
        if (importance < 0) importance = 0;
        else if (importance > 1) importance = 1;
        _importance = importance;
        
        _value = value;
        
        _rank = 0;
        
    }
    return self;
}

-(id) init
{
    self = [self initWithName:@"Unnamed" importance:0.0f initialValue:1.0f];
    return self;
}

-(NSString*) description
{
    return self.name;
}

@end
