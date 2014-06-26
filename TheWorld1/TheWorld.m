//
//  TheWorld.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/4/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "TheWorld.h"

@interface TheWorld()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray* countries;

@end

@implementation TheWorld


-(id) initWithName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        _timeline = [[Timeline alloc]initWithSpeed:0.1f];
        _name = name;
        _countries = [NSArray array];
    }
    NSLog(@"World created.");
    return self;
}

-(id) init
{
    self = [self initWithName:@"Earth"];
    return self;
}

-(NSString*) description
{
    return self.name;
}

-(void) addCountry:(Country*)country
{
    NSMutableArray *mutable = [self.countries mutableCopy];
    [mutable addObject:country];
    self.countries = mutable;
    NSLog(@"%@ added to the %@",country,self);
}

-(void) computeScore
{
    for (Country* country in self.countries)
    {
        NSLog(@"%@ = %f",country, country.score.value);
    }
    
}

@end
