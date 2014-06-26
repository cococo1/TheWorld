//
//  Country.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 2/25/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "Country.h"
//#import "Score.h"
#import "defines.h"

@interface Country()


@end

@implementation Country

-(void) setAvgLifeSatisfaction:(Index *)avgLifeSatisfaction
{
    _avgLifeSatisfaction = avgLifeSatisfaction;
    _economy.importance *= avgLifeSatisfaction.value;
    _governance.importance *= avgLifeSatisfaction.value;
    _health.importance *= avgLifeSatisfaction.value;
    _education.importance *= avgLifeSatisfaction.value;
    _entrepreneurshipAndOpportunity.importance *= avgLifeSatisfaction.value;
    _safetyAndSecurity.importance *= avgLifeSatisfaction.value;
    _socialCapital.importance *= avgLifeSatisfaction.value;
    _personalFreedom.importance *= avgLifeSatisfaction.value;


}

-(id) initWithName:(NSString*) name
     onTimeline:(Timeline*) timeline
{
    self = [super init];
    if (self)
    {
        _timeline = timeline;
        _actions = [[NSMutableDictionary alloc]init];
        
        _name = [NSString stringWithString:name];
        _economy = [[Index alloc]initWithName:@"Economy" importance:1 initialValue:INITIAL_VALUE];
        _governance = [[Index alloc]initWithName:@"Governance" importance:1 initialValue:INITIAL_VALUE];
        _education = [[Index alloc]initWithName:@"Education" importance:1 initialValue:INITIAL_VALUE];
        _health = [[Index alloc]initWithName:@"Health" importance:1 initialValue:INITIAL_VALUE];
        _entrepreneurshipAndOpportunity = [[Index alloc]initWithName:@"Entrepreneurship & Opportunity" importance:1 initialValue:INITIAL_VALUE];
        _safetyAndSecurity = [[Index alloc]initWithName:@"Safety & Security" importance:1 initialValue:INITIAL_VALUE];
        _personalFreedom = [[Index alloc]initWithName:@"Personal Freedom" importance:1 initialValue:INITIAL_VALUE];
        _socialCapital = [[Index alloc]initWithName:@"Social Capital" importance:1 initialValue:INITIAL_VALUE];
        _avgLifeSatisfaction = [[Index alloc] initWithName:@"Average life satisfaction" importance:1 initialValue:INITIAL_VALUE];

        _score = [[Index alloc]initWithName:@"Score" importance:1 initialValue:INITIAL_VALUE];
        NSArray* objects = [NSArray arrayWithObjects:_economy, _governance, _entrepreneurshipAndOpportunity, _education, _safetyAndSecurity, _personalFreedom, _socialCapital, nil];
        NSArray* keys = [NSArray arrayWithObjects:_economy.name, _governance.name, _entrepreneurshipAndOpportunity.name, _education.name, _safetyAndSecurity.name, _personalFreedom.name, _socialCapital.name, nil];
        _score.subindices = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];

        
    }
    NSLog(@"%@ created.",name);
    return self;

}

-(id) init
{
    self = [self initWithName:@"Unnamed" onTimeline:nil];
    return self;
}

-(Action*) giveMeAnAction
{
    NSArray* allActions = [self.actions allValues];
    return allActions[arc4random_uniform([allActions count])];
}

-(void) addActions
{
//    NSLog(@"addActions");
    Action* buildRoads = [[Action alloc]initWithName:@"Build more roads"
                                           startTime:self.timeline.currentTime
                                            duration:3*MONTH onTimeline:self.timeline
                                     affectedIndices:@[self.economy.subindices[GROWTH]]
                                            strength:0.4
                                               place:self.place];
    self.actions[@"Build more roads"] = buildRoads;
    
    
    Action* closeSchools = [[Action alloc]initWithName:@"Close some schools"
                                             startTime:self.timeline.currentTime
                                              duration:WEEK onTimeline:self.timeline
                                       affectedIndices:@[self.education]
                                              strength:-0.4
                                                 place:self.place];
    self.actions[@"Close some schools"] = closeSchools;
    
    
    Action* changeName = [[Action alloc]initWithName:@"Rename capital into <Disneyland>"
                                           startTime:self.timeline.currentTime
                                            duration:WEEK onTimeline:self.timeline
                                     affectedIndices:@[self.socialCapital]
                                            strength:+0.2
                                               place:self.place];
    self.actions[changeName.name] = changeName;
    
    Action* increaseRetirementAge = [[Action alloc]initWithName:@"Increase retirement age"
                                                      startTime:self.timeline.currentTime
                                                       duration:MONTH
                                                     onTimeline:self.timeline
                                                affectedIndices:@[self.economy.subindices[@"Inflation"],
                                     self.economy.subindices[GROWTH],
                                     self.health.subindices[@"Life expectancy"]]
                                          dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys: @(-.5),INFLATION,@(.2), GROWTH, @(-.3), LIFE_EXPECTANCY, nil]
                                                          place:self.place];
    self.actions[increaseRetirementAge.name] = increaseRetirementAge;
    
    Action* riseSalariesInEducationSector = [[Action alloc]initWithName:@"Rise salaries in education sector"
                                                              startTime:self.timeline.currentTime
                                                               duration:6*MONTH
                                                             onTimeline:self.timeline
                                                        affectedIndices:@[self.education.subindices[GROWTH],self.economy.subindices[GDP], self.socialCapital.subindices[CHARITY]] dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(.2),GROWTH, @(-.1),GDP,@(0.2),CHARITY,nil] place:self.place];
    self.actions[riseSalariesInEducationSector.name] = riseSalariesInEducationSector;
    
    Action* makeGovernmentBetter = [[Action alloc]initWithName:@"Make government better"
                                                     startTime:self.timeline.currentTime
                                                      duration:5*YEAR
                                                    onTimeline:self.timeline
                                               affectedIndices:@[self.governance, self.governance.subindices[GROWTH]] strength:0.5
                                                         place:self.place];
    self.actions[makeGovernmentBetter.name] = makeGovernmentBetter;
    
    Action* investInInfrastructure = [[Action alloc]initWithName:@"Invest in infrastructure"
                                                       startTime:self.timeline.currentTime
                                                        duration:4*YEAR
                                                      onTimeline:self.timeline
                                                 affectedIndices:@[self.entrepreneurshipAndOpportunity.subindices[GROWTH],self.economy, self.entrepreneurshipAndOpportunity.subindices[GOOD_PLACE_TO_START_A_BUSINESS]]
                                           dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(.3),GROWTH,@(0.1), ECONOMY, @(.4),GOOD_PLACE_TO_START_A_BUSINESS, nil]
                                                           place:self.place];
    self.actions[investInInfrastructure.name] = investInInfrastructure;
    
    Action *plantMoreTrees = [[Action alloc]initWithName:@"Plant more trees"
                                               startTime:self.timeline.currentTime
                                                duration:9*MONTH
                                              onTimeline:self.timeline
                                         affectedIndices:@[self.governance.subindices[ENVIRONMENT], self.economy.subindices[GDP]]
                                   dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.6),ENVIRONMENT, @(-.1),GDP, nil]
                                                   place:self.place];
    self.actions[plantMoreTrees.name] = plantMoreTrees;
    
    Action *investInHealthcare = [[Action alloc]initWithName:@"Invest in healthcare"
                                                   startTime:self.timeline.currentTime
                                                    duration:2*YEAR
                                                  onTimeline:self.timeline
                                             affectedIndices:@[self.health, self.health.subindices[GROWTH], self.economy.subindices[GDP]]
                                                    dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(.7),HEALTH, @(.2),GROWTH, @(-.2),GDP, nil]
                                                       place:self.place];
    self.actions[investInHealthcare.name] = investInHealthcare;
    
    Action *putMoreLights = [[Action alloc]initWithName:@"Add more illuminations to streets at night"
                                                   startTime:self.timeline.currentTime
                                                    duration:3*WEEK
                                                  onTimeline:self.timeline
                                             affectedIndices:@[self.safetyAndSecurity, self.safetyAndSecurity.subindices[GROWTH], self.safetyAndSecurity.subindices[SAFE_WALKING_AT_NIGHT], self.economy.subindices[GDP]]
                                       dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(.2),SAFETY_AND_SECURITY, @(.2),GROWTH, @(-.2),SAFE_WALKING_AT_NIGHT, @(-0.1),GDP, nil]
                                                       place:self.place];
    self.actions[putMoreLights.name] = putMoreLights;

    Action *gayMarriage = [[Action alloc]initWithName:@"Legalize gay marriage"
                                              startTime:self.timeline.currentTime
                                               duration:5*MONTH
                                             onTimeline:self.timeline
                                        affectedIndices:@[self.personalFreedom, self.health.subindices[GROWTH], self.socialCapital.subindices[MARRIED], self.socialCapital.subindices[WORSHIP]]
                                  dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(.4),PERSONAL_FREEDOM, @(-.1),HEALTH, @(.2),MARRIED,@(-.3), WORSHIP, nil]
                                                  place:self.place];
    self.actions[gayMarriage.name] = gayMarriage;

    Action *giveMoneyForFree = [[Action alloc]initWithName:@"Give money for free every Sunday"
                                            startTime:self.timeline.currentTime
                                             duration:1*YEAR
                                           onTimeline:self.timeline
                                      affectedIndices:@[self.economy, self.economy.subindices[UNEMPLOYMENT], self.socialCapital, self.socialCapital.subindices[CHARITY]]
                                dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(-.4),ECONOMY, @(-.1),UNEMPLOYMENT, @(.6),SOCIAL_CAPITAL, @(.3), CHARITY, nil]
                                                place:self.place];
    self.actions[giveMoneyForFree.name] = giveMoneyForFree;
    
    Action *increaseExport = [[Action alloc]initWithName:@"Increase export"
                                                 startTime:self.timeline.currentTime
                                                  duration:2*YEAR
                                                onTimeline:self.timeline
                                           affectedIndices:@[self.economy.subindices[GDP]]
                                                strength:0.3
                                                   place:self.place];
    self.actions[increaseExport.name] = increaseExport;
    
    Action *createWorkplaces = [[Action alloc]initWithName:@"Create more workplaces"
                                               startTime:self.timeline.currentTime
                                                duration:1*YEAR
                                              onTimeline:self.timeline
                                         affectedIndices:@[self.economy, self.economy.subindices[UNEMPLOYMENT], self.entrepreneurshipAndOpportunity.subindices[GOOD_PLACE_TO_START_A_BUSINESS]]
                                               dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.1),ECONOMY, @(0.5),UNEMPLOYMENT, @(0.2),GOOD_PLACE_TO_START_A_BUSINESS, nil]
                                                     place:self.place];
    self.actions[createWorkplaces.name] = createWorkplaces;
    
    Action *bugetPlaces = [[Action alloc]initWithName:@"Offer more buget places at univesities"
                                                 startTime:self.timeline.currentTime
                                                  duration:9*MONTH
                                                onTimeline:self.timeline
                                           affectedIndices:@[self.education.subindices[OPPORTUNITY_TO_LEARN], self.education.subindices[SECONDARY_ENROLMENT_RATE], self.socialCapital.subindices[TRUST]]
                                     dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.6),OPPORTUNITY_TO_LEARN, @(0.4),SECONDARY_ENROLMENT_RATE, @(0.1),TRUST, nil]
                                                     place:self.place];
    self.actions[bugetPlaces.name] = bugetPlaces;
    
    Action *inviteProfessors = [[Action alloc]initWithName:@"Invite foreign professors at schools"
                                            startTime:self.timeline.currentTime
                                             duration:4*YEAR
                                           onTimeline:self.timeline
                                      affectedIndices:@[self.education.subindices[SATISFIED_WITH_QUALITY],self.socialCapital.subindices[VOLUNTEERED]]
                                dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),SATISFIED_WITH_QUALITY, @(0.1),VOLUNTEERED, nil]
                                                place:self.place];
    self.actions[inviteProfessors.name] = inviteProfessors;
    
    Action *corruptionComitee = [[Action alloc]initWithName:@"Create an independent corruption comitee"
                                                 startTime:self.timeline.currentTime
                                                  duration:2*YEAR
                                                onTimeline:self.timeline
                                           affectedIndices:@[self.governance.subindices[CORRUPTION],self.governance.subindices[SEPARATION_OF_POWERS]]
                                     dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.4),CORRUPTION, @(0.2),SEPARATION_OF_POWERS, nil]
                                                     place:self.place];
    self.actions[corruptionComitee.name] = corruptionComitee;
    
    Action *morePolice = [[Action alloc]initWithName:@"More police on streets"
                                                  startTime:self.timeline.currentTime
                                                   duration:WEEK
                                                 onTimeline:self.timeline
                                            affectedIndices:@[self.governance.subindices[STABILITY]]
                                                    strength:0.4
                                               place:self.place];
    self.actions[morePolice.name] = morePolice;
    
    Action *changeToLinux = [[Action alloc]initWithName:@"Change all computers in administration to Linux"
                                           startTime:self.timeline.currentTime
                                            duration:7*MONTH
                                          onTimeline:self.timeline
                                     affectedIndices:@[self.entrepreneurshipAndOpportunity.subindices[SECURE_INTERNET_SERVERS]]
                                            strength:0.4
                                               place:self.place];
    self.actions[changeToLinux.name] = changeToLinux;
    
    Action *nokiaFactory = [[Action alloc]initWithName:@"Open a Nokia factory"
                                                  startTime:self.timeline.currentTime
                                                   duration:5*YEAR
                                                 onTimeline:self.timeline
                                            affectedIndices:@[self.entrepreneurshipAndOpportunity.subindices[MOBILE_PHONES],self.economy.subindices[GDP]]
                                      dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.7),MOBILE_PHONES, @(0.2),GDP, nil]
                                                      place:self.place];
    self.actions[nokiaFactory.name] = nokiaFactory;
    
    Action *banSmoking = [[Action alloc]initWithName:@"Ban smoking in public places"
                                             startTime:self.timeline.currentTime
                                              duration:18*MONTH
                                            onTimeline:self.timeline
                                       affectedIndices:@[self.health.subindices[LIFE_EXPECTANCY],self.personalFreedom.subindices[FREEDOM_OF_CHOICE]]
                                 dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),LIFE_EXPECTANCY, @(-0.1),FREEDOM_OF_CHOICE, nil]
                                                 place:self.place];
    self.actions[banSmoking.name] = banSmoking;
    
    Action *payForChild = [[Action alloc]initWithName:@"Give money for second child"
                                           startTime:self.timeline.currentTime
                                            duration:13*MONTH
                                          onTimeline:self.timeline
                                     affectedIndices:@[self.health.subindices[INFANT_MORTALITY_RATE],self.socialCapital.subindices[HELP]]
                               dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.3),INFANT_MORTALITY_RATE, @(0.3),HELP, nil]
                                               place:self.place];
    self.actions[payForChild.name] = payForChild;
    
    Action *lowerPricesForWater = [[Action alloc]initWithName:@"Lower prices for water"
                                            startTime:self.timeline.currentTime
                                             duration:5*MONTH
                                           onTimeline:self.timeline
                                      affectedIndices:@[self.health.subindices[SANITATION],self.economy.subindices[GDP]]
                                dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),SANITATION, @(-.1),GDP, nil]
                                                place:self.place];
    self.actions[lowerPricesForWater.name] = lowerPricesForWater;
    
    Action *deathPenalty = [[Action alloc]initWithName:@"Introduce death penalty"
                                                    startTime:self.timeline.currentTime
                                                     duration:3*MONTH
                                                   onTimeline:self.timeline
                                              affectedIndices:@[self.safetyAndSecurity.subindices[ASSAULTED],self.personalFreedom.subindices[CIVIL_LIBERTIES]]
                                        dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),ASSAULTED, @(-.1),CIVIL_LIBERTIES, nil]
                                                        place:self.place];
    self.actions[deathPenalty.name] = deathPenalty;
    
    Action *stopConflicts = [[Action alloc]initWithName:@"Stop all national conflicts"
                                             startTime:self.timeline.currentTime
                                              duration:3*YEAR
                                            onTimeline:self.timeline
                                       affectedIndices:@[self.safetyAndSecurity.subindices[EMIGRATION],self.socialCapital.subindices[RELY_ON_FRIENDS_AND_FAMILY]]
                                 dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),EMIGRATION, @(.2),RELY_ON_FRIENDS_AND_FAMILY, nil]
                                                 place:self.place];
    self.actions[stopConflicts.name] = stopConflicts;

    Action *legalizeAbortion = [[Action alloc]initWithName:@"Legalize abortion"
                                              startTime:self.timeline.currentTime
                                               duration:11*MONTH
                                             onTimeline:self.timeline
                                        affectedIndices:@[self.personalFreedom.subindices[FREEDOM_OF_CHOICE]]
                                                  strength:0.4
                                                  place:self.place];
    self.actions[legalizeAbortion.name] = legalizeAbortion;
    
    Action *mosques = [[Action alloc]initWithName:@"Open more mosques"
                                                 startTime:self.timeline.currentTime
                                                  duration:36*MONTH
                                                onTimeline:self.timeline
                                           affectedIndices:@[self.personalFreedom.subindices[GOOD_PLACE_FOR_IMMIGRANTS], self.socialCapital.subindices[WORSHIP]]
                                              dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(0.5),GOOD_PLACE_FOR_IMMIGRANTS, @(.2),WORSHIP, nil]
                                                     place:self.place];
    self.actions[mosques.name] = mosques;
    
    Action *promoteVolunteering = [[Action alloc]initWithName:@"Promote volunteering"
                                        startTime:self.timeline.currentTime
                                         duration:4*MONTH
                                       onTimeline:self.timeline
                                  affectedIndices:@[self.socialCapital.subindices[VOLUNTEERED]]
                                                     strength:0.7
                                            place:self.place];
    self.actions[promoteVolunteering.name] = promoteVolunteering;

    
    

    
    
    
    
    
    
//    for (Index* i in [self.score.subindices allValues])
//    {
//        for (Index* j in [i.subindices allValues])
//        {
//            NSString* name = (NSString*)[(NSArray*)[i.subindices allKeysForObject:j] lastObject];
//            int p = arc4random() % 100;
//            NSTimeInterval duration;
//            if (p > 70)
//            {
//                duration = arc4random() % 5*DAY;
//
//            }
//            else if (p > 50)
//            {
//                duration = arc4random() % 5*MONTH;
//            }
//            else if (p > 20)
//            {
//                duration = arc4random() % YEAR;
//                
//            }
//            else if (p > 10)
//            {
//                duration = arc4random() % 3*YEAR;
//            }
//            else if (p > 5)
//            {
//                duration = arc4random() % 5*YEAR;
//            }
//            else
//            {
//                duration = arc4random() % DAY;
//            }
//            
//            
//            Action* increaseIndexAction = [[Action alloc]initWithName:[NSString stringWithFormat:@"Increase %@",name]
//                                                            startTime:self.timeline.currentTime
//                                                             duration:duration
//                                                           onTimeline:self.timeline
//                                                      affectedIndices:@[j]
//                                                             strength:0.6
//                                                                place:self.place];
//            self.actions[increaseIndexAction.name] = increaseIndexAction;
//            
//            p = arc4random() % 100;
//            if (p > 70)
//            {
//                duration = arc4random() % 5*DAY;
//                
//            }
//            else if (p > 50)
//            {
//                duration = arc4random() % 5*MONTH;
//            }
//            else if (p > 20)
//            {
//                duration = arc4random() % YEAR;
//                
//            }
//            else if (p > 10)
//            {
//                duration = arc4random() % 3*YEAR;
//            }
//            else if (p > 5)
//            {
//                duration = arc4random() % 5*YEAR;
//            }
//            else
//            {
//                duration = arc4random() % DAY;
//            }
//            Action* decreaseIndexAction = [[Action alloc]initWithName:[NSString stringWithFormat:@"Decrease %@",name]
//                                                            startTime:self.timeline.currentTime
//                                                             duration:duration
//                                                           onTimeline:self.timeline
//                                                      affectedIndices:@[j]
//                                                             strength:-0.6
//                                                                place:self.place];
//            self.actions[decreaseIndexAction.name] = decreaseIndexAction;
//            
//        }
//    }
    
    
    
    
    
}

#pragma mark SubjectProtocol implementation:
-(void)startAction:(Action*) action
{
//    NSLog(@"%@ started this action: %@",self, action);
    [action willStart];
}

-(void)stopAction:(Action*) action
{
//    NSLog(@"%@ stopped this action: %@",self, action);
}


-(NSString*) description
{
    return [NSString stringWithFormat:@"%@",self.name];
}

@end
