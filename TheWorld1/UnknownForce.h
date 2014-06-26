//
//  UnknownForce.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/16/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubjectProtocol.h"
#import "Action.h"

@interface UnknownForce : NSObject <SubjectProtocol>

-(id) initWithName:(NSString*) name;

@property (nonatomic, strong) NSString* name;

@end
