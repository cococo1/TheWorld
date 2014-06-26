//
//  UnknownForce.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/16/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "UnknownForce.h"

@implementation UnknownForce

-(id) initWithName:(NSString*) name
{
    if (self = [super init])
    {
        _name = name;
    }
    return self;
}

-(NSString*) description
{
    return self.name;
}

-(id)init
{
    return  [self initWithName:@"Unknown force"];
}
#pragma mark SubjectProtocol implementation:
-(void)startAction:(Action*) action
{
    [action willStart];
    NSLog(@"%@ started this action: %@",self, action);
}

-(void)stopAction:(Action*) action
{
    [action stop];
    NSLog(@"%@ stopped this action: %@",self, action);
    
}

@end

