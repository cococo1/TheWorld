//
//  SubjectProtocol.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/3/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@protocol SubjectProtocol <NSObject>

-(void)startAction:(Action*) action;
-(void)stopAction:(Action*) action;

@end
