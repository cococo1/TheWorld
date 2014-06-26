//
//  Country.h
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/25/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Event.h"
#import "Action.h"
#import "SubjectProtocol.h"
#import "Index.h"

typedef enum
{
    ActionTypeRandom = 0,
    ActionTypeEconimic = 1
}ActionType;



@interface Country : NSObject <SubjectProtocol>

@property (nonatomic, weak) Timeline* timeline;

@property (nonatomic, readonly) Index* score;
@property (nonatomic, strong, readonly) NSString* name;
@property (nonatomic) CGPoint place;

@property (nonatomic, strong) Index *economy;
@property (nonatomic, strong) Index *governance;
@property (nonatomic, strong) Index *health;
@property (nonatomic, strong) Index *education;
@property (nonatomic, strong) Index *entrepreneurshipAndOpportunity;
@property (nonatomic, strong) Index *safetyAndSecurity;
@property (nonatomic, strong) Index *personalFreedom;
@property (nonatomic, strong) Index *socialCapital;
@property (nonatomic, strong) Index *avgLifeSatisfaction;

@property (nonatomic, strong) NSMutableDictionary* actions;





-(id) initWithName:(NSString*)name
        onTimeline:(Timeline*) timeline;
-(void) addActions;
-(Action*) giveMeAnAction;


@end
