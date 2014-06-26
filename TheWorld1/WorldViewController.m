//
//  WorldViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/3/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "WorldViewController.h"
#import "MessageViewController.h"
#import "defines.h"
#import "NewsTableViewController.h"

@interface WorldViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary* mapsDictionary;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIImageView* worldMap;

@property (nonatomic, strong) UIPopoverController* popover;
@property (nonatomic, strong) CountryViewController* countryDataViewController;
@property (nonatomic, strong) MessageViewController* messagevc;

@property (nonatomic, strong) UIPopoverController* newsFeedPopover;
@property (nonatomic, strong) NewsTableViewController* newsvc;






@end

@implementation WorldViewController

//Economy:
float gdpAvg = 14774.7;
float inflationAvg = 5.1;
float unemploymentAvg = 11.0;
float growthRateAvg = 2.7;

//Entrepreneurship & Opportunity:
float goodPlaceToStartABusinessAvg = 70.0;
float secureInternetServersAvg = 126.20;
float mobilePhonesAvg = 98.7;

//Governance:
float separationOfPowersAvg = 15.8;
float stabilityAvg = 29;
float corruptAvg = 66.7;
float preserveEnvironmentAvg = 54.2;

//Education:
float opportunityToLearnAvg = 70.4;
float satisfiedWithQualityAvg = 66.6;
float secondaryEnrolmentRateAvg = 77.5;

//Health:
float lifeExpectancyAvg = 69.6;
float infantMortalityRateAvg = 30;
float sanitationAvg = 73.2;

//Safety & security:
float assaultedAvg = 7.4;
float emigrationAvg = 5.4;
float safeWalkingAloneAtNightAvg = 61.9;

//Personal freedom:
float civilLibertiesAvg = 4.8;
float freedomOfChoiceAvg = 73.4;
float goodPlaceImmigrantsAvg = 65.0;

//Social capital:
float marriedAvg = 51.0;
float worshipAvg = 49.2;
float trustAvg = 24.1;
float volunteeredAvg = 19.1;
float helpStrangerAvg = 45.7;
float charityAvg = 28;
float relyOnFamilyAvg = 80.6;

-(void) setPopover:(UIPopoverController *)popover
{
    if (_popover.isPopoverVisible)
    {
        [_popover dismissPopoverAnimated:YES];
    }
    _popover = popover;
}

-(void) setNewsFeedPopover:(UIPopoverController *)newsFeedPopover
{
    if (_newsFeedPopover.isPopoverVisible)
    {
        [_newsFeedPopover dismissPopoverAnimated:YES];
    }
    _newsFeedPopover = newsFeedPopover;
}

//-(BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    if ([identifier isEqualToString:@"news feed"])
//    {
//        if (self.newsFeedPopover)
//        {
//            return NO;
//        }
//    }
//    return YES;
//
//}
//
//-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"news feed"])
//    {
//        self.newsFeedPopover = segue.destinationViewController;
//    }
//}

- (IBAction)newsPressed:(UIBarButtonItem *)sender
{
    NSLog(@"news pressed");
    self.newsFeedPopover = [[UIPopoverController alloc]initWithContentViewController:self.newsvc];
//    self.popover.passthroughViews = @[self.splitViewController.view];
    [self.newsFeedPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
     
//     presentPopoverFromRect:sender. inView:self.worldMap permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
-(void) showWorld
{
//    [self.scrollView zoomToRect:self.worldMap.frame animated:YES];
    [self.scrollView setZoomScale:self.scrollView.frame.size.height/self.worldMap.image.size.height animated:YES];
}

-(MessageViewController*) messagevc
{
    if (!_messagevc)
    {
        _messagevc = [[MessageViewController alloc]init];
        _messagevc.label.text = @"None";
    }
    return _messagevc;
}

-(void) actionFinished:(Action *)action
{
    BOOL growthAction = YES;
    NSLog(@"action finished: %@",action.name);

    [self.delegate actionFinished:action];
    NSArray* countries = [self.countriesDictionary allValues];
    Country* country;
    
    for (country in countries)
    {
        if ((country.place.x == action.place.x) &&
            (country.place.y == action.place.y))
        {
//            NSLog(@"Action finished in %@",country.name);
            break;
        }
    }
    

    
//    Country* country = self.countriesDictionary[@"Rep. Moldova"];
//    NSLog(@"moldova score: %f",country.score.value);
//    
    if ([action.name isEqualToString:@"Economic growth"])
    {
        float a = country.score.rank;
        a += 1;
        [self startEconomicGrowthForCountry:country];
        NSLog(@"%@ economy: %f",country.name, country.economy.value);
    }
    else if ([action.name isEqualToString:@"Entrepreneurship growth"])
    {
//        NSLog(@"%@ Entrepreneurship: %f",country.name, country.entrepreneurshipAndOpportunity.value);
        [self startEntrepreneurshipGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Governance growth"])
    {
//        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startGovernanceGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Education growth"])
    {
        //        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startEducationGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Health growth"])
    {
        //        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startHealthGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Safety growth"])
    {
        //        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startSafetyGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Freedom growth"])
    {
        //        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startFreedomGrowthForCountry:country];
    }
    else if ([action.name isEqualToString:@"Social growth"])
    {
        //        NSLog(@"%@ governance: %f",country.name, country.governance.value);
        [self startSocialGrowthForCountry:country];
    }
    else
    {
        growthAction = NO;
        NSString* newsTime = [NSString stringWithFormat:@"%@",self.world.timeline.currentTime];
        NSArray* news = [NSArray arrayWithObjects:action.name, newsTime, country.name, nil];
        [self.newsvc addNews:news];
        
        self.messagevc.label.text = [NSString stringWithFormat:@"Here just happened a %@",[action description] ];
        [self.messagevc setupSize];
        CGRect rectForPopover = CGRectMake(action.place.x - 50, action.place.y - 50, 100, 100);
        self.popover = [[UIPopoverController alloc]initWithContentViewController:self.messagevc];
        self.popover.passthroughViews = @[self.splitViewController.view];
        [self.popover presentPopoverFromRect:rectForPopover inView:self.worldMap permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
    int p = arc4random() % 8;
    if (growthAction && (p>=7))
    {
        NSString* newsTime = [NSString stringWithFormat:@"%@",self.world.timeline.currentTime];
        NSArray* news = [NSArray arrayWithObjects:action.name, newsTime, country.name, nil];
        [self.newsvc addNews:news];
    }


}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.popover dismissPopoverAnimated:YES];

}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    [self.popover dismissPopoverAnimated:YES];
}

-(void) showCountry:(NSString*)country
{
    UIImageView *mapView = [self.mapsDictionary objectForKey:country];
    [self.scrollView zoomToRect:mapView.frame animated:YES];
}

-(NSArray*) giveMeTheCountries
{
    return [self.countriesDictionary allKeys];
}

-(void) setup
{
    _newsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"news feed"];
    NSArray* news = [NSArray arrayWithObjects:@"Timeline created.",@"",@"", nil];
    [_newsvc addNews:news];
    _myCountry = nil;
    _world = [[TheWorld alloc]init];
    news = [NSArray arrayWithObjects:@"Earth created.",@"",@"", nil];
    [_newsvc addNews:news];
    _world.timeline.delegate = self;
    _mapsDictionary = [[NSMutableDictionary alloc]init];
    _countriesDictionary = [[NSMutableDictionary alloc]init];
    _dateFormatter = [[NSDateFormatter alloc]init];
    _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    _dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _worldMap = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map3.jpg"]];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        [self setup];
    }
    return self;
}

-(void) awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}


- (IBAction)timeSpeedChanged:(UISegmentedControl *)sender
{
    sender.momentary = NO;
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            self.world.timeline.speed = 0.1;
            break;
        case 1:
            self.world.timeline.speed = 0.1*DAY+0.1;
            break;
        case 2:
            self.world.timeline.speed = 0.1*WEEK+0.1;
            break;
        case 3:
            self.world.timeline.speed = 0.1*MONTH+0.1;
            break;
        case 4:
            self.world.timeline.speed = 0.1*YEAR+0.1;
            break;
        default:
            break;
    }

}

#pragma mark ScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.worldMap;
}

-(void) tap1:(UIGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {

        self.popover = [[UIPopoverController alloc]initWithContentViewController:self.countryDataViewController];
        [self.popover setPopoverContentSize:CGSizeMake(COUNTRY_POPOVER_CONTENT_WIDTH, COUNTRY_POPOVER_CONTENT_HEIGHT) animated:YES];
        NSArray* keysArray = [self.mapsDictionary allKeysForObject:gesture.view];
        NSString *countryName = [keysArray lastObject];
        id country = [self.countriesDictionary objectForKey:countryName];
        self.countryDataViewController.country = country;
        [self.popover presentPopoverFromRect:gesture.view.bounds inView:gesture.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

#pragma mark TimelineDelegate

-(void) timeChanged:(NSDate *)time
{
    NSString* t = [self.dateFormatter stringFromDate:time];
    self.timeLabel.text = t;
    if (self.myCurrentAction)
    {
        NSTimeInterval howMuchCompleted = [self.world.timeline.currentTime timeIntervalSinceDate:self.myCurrentAction.startTime];
//        NSLog(@"how much %f, duration: %f",howMuchCompleted,self.myCurrentAction.duration);

        [self.progressBar setProgress:howMuchCompleted/self.myCurrentAction.duration animated:YES];
    }
    else
    {
        [self.progressBar setProgress:0 animated:YES];
    }

}

-(void) pan:(UIGestureRecognizer*) gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded)
    {
        gesture.view.center = [gesture locationInView:self.worldMap];
        NSLog(@"%f %f",gesture.view.center.x, gesture.view.center.y);
    }
}

-(void) addCountry:(Country*)country
{
    [self.world addCountry:country];
    [country addActions];

    NSLog(@"%@ score is %f",country.name, country.score.value);
    
    NSString* imageName = [NSString stringWithFormat:@"%@.png",country.name];
     UIImageView* mapImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    mapImageView.userInteractionEnabled = YES;
    mapImageView.multipleTouchEnabled = YES;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1:)];
    [mapImageView addGestureRecognizer:tap];
    
//    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
//    [mapImageView addGestureRecognizer:pan];
    
    mapImageView.center = country.place;
    [self.worldMap addSubview:mapImageView];
    [self.mapsDictionary setObject:mapImageView forKey:country.name];
    [self.countriesDictionary setObject:country forKey:country.name];    
}


-(Country*) createUSA
{
    Country *country = [[Country alloc]initWithName:@"United States Of America" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.712];
// Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:47153/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/1.6];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/9.6];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:0.05/growthRateAvg];
    
// Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:69.1/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:1561.9/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:105.9/mobilePhonesAvg];
    country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.07];
    
//Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:32/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:201/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/67];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:60.80/preserveEnvironmentAvg];
    country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:-0.02];

    
//Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:82.3/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:65.3/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:96/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.18];

    
//Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:78.2/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/6.5];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:100/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.32];
    
//Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/1.5];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/1.1];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:75.7/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.35];

    
//Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:7/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:86.3/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:83.5/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:-0.15];

    
//Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:50.1/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:46.6/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:37.1/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:42.1/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:71.9/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:56.8/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:92.2/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.46];
    //TODO HERE!!!!
    
    country.place = CGPointMake(1870.506104, 1143.087036);
    
    return country;
}

-(Country*) createFrance
{
    Country *country = [[Country alloc]initWithName:@"France"onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.696];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:34123.2/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/1.5];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/9.3];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:0.10/growthRateAvg];
    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:76.1/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:355.6/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:105/mobilePhonesAvg];
        country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.57];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:32/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:41/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/53.8];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:60.10/preserveEnvironmentAvg];
    country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:0.16];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:86/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:76.8/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:112.6/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:-0.13];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:81.4/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/3.4];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:100/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.44];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/4.9];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/1.8];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:67/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.16];
    
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:7/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:90.3/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:77.1/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.64];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:47.3/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:21.3/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:19.9/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:29.3/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:44.1/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:28.7/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:92.1/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.03];

    
    //TODO HERE!!!!
    
    country.place = CGPointMake(4033.65, 931.37);
    
    return country;
}

-(Country*) createRussia
{
    Country *country = [[Country alloc]initWithName:@"Russian Federation" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.539];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:19891.4/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/6.9];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/7.5];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:3.80/growthRateAvg];
    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:76/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:27.20/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:179.3/mobilePhonesAvg];
        country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:1.27];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:6/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:10/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/80.5];
        country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:28.60/preserveEnvironmentAvg];
        country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:-0.04];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:45.8/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:55.9/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:88.6/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.62];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:68.8/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/9.1];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:70/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.44];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/2.8];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/5.7];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:44/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.54];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:3/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:62.6/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:58.1/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:-0.65];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:52.9/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:11.7/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:24.7/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:17.4/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:30/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:7.2/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:88.3/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.09];

    //TODO HERE!!!!
    
    country.place = CGPointMake(6291.569824, 643.252197);
    
    return country;
}

-(Country*) createAfghanistan
{ 
    Country *country = [[Country alloc]initWithName:@"Afghanistan" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.383];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:1207.3/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/0.9];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/35];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:7.80/growthRateAvg];
    
    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:43.2/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:0.6/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:54.3/mobilePhonesAvg];
    country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.0];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:4.9/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:0/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/65.9];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:37.30/preserveEnvironmentAvg];
    country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:0.0];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:43.3/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:52.6/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:45.5/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.0];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:48.3/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/103];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:37/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.0];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/14.7];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/7.2];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:30.6/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.0];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:2/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:49.6/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:43.6/goodPlaceImmigrantsAvg];
country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.0];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:67.2/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:68.2/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:27.6/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:21.7/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:51.2/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:33.5/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:52.1/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:0.0];

    //TODO HERE!!!!
    
    country.place = CGPointMake(5466.720703, 1212.987305);
    
    return country;
}

-(Country*) createGermany
{
    Country *country = [[Country alloc]initWithName:@"Germany" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.665];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:37402.3/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/1.1];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/7.1];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:1.50/growthRateAvg];
    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:69.5/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:1025.6/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:132.3/mobilePhonesAvg];
        country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.65];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:32/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:20/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/59];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:70.50/preserveEnvironmentAvg];
        country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:0.04];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:78/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:76.9/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:102.6/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.37];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:80/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/3.4];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:100/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.55];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/3.6];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/2.6];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:81.5/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.28];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:7/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:89.6/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:83.9/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.94];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:53.6/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:32.8/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:31.6/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:24.2/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:48.5/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:43.1/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:95.1/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.25];

    //TODO HERE!!!!
    
    country.place = CGPointMake(4229.284668, 828.495117);
    
    return country;
}

-(Country*) createMoldova
{
    Country *country = [[Country alloc]initWithName:@"Rep. Moldova" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.579];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:3109.84/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/7.40];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/6.40];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:3.50/growthRateAvg];

    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:75.90/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:19.80/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:104.80/mobilePhonesAvg];
        country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:1.15];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:12.00/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:19.00/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/83.90];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:21.90/preserveEnvironmentAvg];
    country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:-0.06];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:55.70/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:63.10/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:88.00/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.6];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:68.90/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/16.30];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:85.00/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.5];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/3.50];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/7.50];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:52.50/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.45];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:5.00/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:62.80/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:50.20/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.56];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:58.20/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:26.40/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:31.6/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:24.2/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:41.80/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:19.70/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:86.90/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.41];

    //TODO HERE!!!!
    
    country.place = CGPointMake(4628.356934, 923.899353);
    
    return country;
}

-(Country*) createJapan
{
    Country *country = [[Country alloc]initWithName:@"Japan" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.626];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:33732.90/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/0.7];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/5.00];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:0.2/growthRateAvg];

    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:38.90/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:743.30/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:102.70/mobilePhonesAvg];
            country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.53];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:32.00/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:58.00/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/65.80];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:48.90/preserveEnvironmentAvg];
        country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:0.21];

    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:88.10/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:70.10/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:101.50/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:0.16];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:82.90/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/2.40];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:100.00/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.4];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/1.40];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/1.80];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:70.50/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:-0.13];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:6.00/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:81.40/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:65.30/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.53];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:65.30/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:32.20/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:33.90/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:21.30/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:24.70/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:32.80/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:91.70/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:0.34];

    //TODO HERE!!!!
    
    country.place = CGPointMake(6985.484375, 1196.877686);
    
    return country;
}

-(Country*) createUK
{
    Country *country = [[Country alloc]initWithName:@"United Kingdom" onTimeline:self.world.timeline];
    country.avgLifeSatisfaction = [[Index alloc]initWithName:@"Average life satisfaction" importance:1 initialValue:0.691];
    // Economy:
    country.economy.subindices[@"GDP"] = [[Index alloc]initWithName:@"GDP" importance:0.8 initialValue:35686.20/gdpAvg];
    country.economy.subindices[@"Inflation"] = [[Index alloc]initWithName:@"Inflation" importance:.2 initialValue:inflationAvg/3.30];
    country.economy.subindices[@"Unemployment"] = [[Index alloc]initWithName:@"Unemployment" importance:0.1 initialValue:unemploymentAvg/7.80];
    country.economy.subindices[GROWTH] = [[Index alloc]initWithName:@"GDP growth rate" importance:0.4 initialValue:0.05/growthRateAvg];

    
    // Entrepreneurship:
    country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"] = [[Index alloc]initWithName:@"Good place to start a business" importance:0.5 initialValue:67.30/goodPlaceToStartABusinessAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"]  = [[Index alloc]initWithName:@"Secure internet servers" importance:0.1 initialValue:1594.30/secureInternetServersAvg];
    country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"] = [[Index alloc] initWithName:@"Mobile phones" importance:0.2 initialValue:130.80/mobilePhonesAvg];
        country.entrepreneurshipAndOpportunity.subindices[GROWTH] = [[Index alloc] initWithName:@"Entrepreneurship & Opportunity growth rate" importance:0.0 initialValue:0.46];
    
    //Governance:
    country.governance.subindices[@"Separation of powers"] = [[Index alloc] initWithName:@"Separation of powers" importance:0.5 initialValue:32.00/separationOfPowersAvg];
    country.governance.subindices[@"Stability"] = [[Index alloc]initWithName:@"Stability" importance:0.4 initialValue:130.00/stabilityAvg];
    country.governance.subindices[@"Corruption"] = [[Index alloc]initWithName:@"Corruption" importance:0.3 initialValue:corruptAvg/36.30];
    country.governance.subindices[@"Environment"] = [[Index alloc]initWithName:@"Preserve environment" importance:0.3 initialValue:74.10/preserveEnvironmentAvg];
    country.governance.subindices[GROWTH] = [[Index alloc] initWithName:@"Governance index growth rate" importance:0.0 initialValue:0.26];
    
    //Education:
    country.education.subindices[@"Opportunity to learn"] = [[Index alloc]initWithName:@"Opportunity to learn" importance:0.6 initialValue:89.70/opportunityToLearnAvg];
    country.education.subindices[@"Satisfied with quality"] = [[Index alloc]initWithName:@"Satisfied with quality" importance:0.4 initialValue:86.20/satisfiedWithQualityAvg];
    country.education.subindices[@"Secondary enrolment rate"] = [[Index alloc]initWithName:@"Secondary enrolment rate" importance:0.1 initialValue:101.80/secondaryEnrolmentRateAvg];
    country.education.subindices[GROWTH] = [[Index alloc] initWithName:@"Education index growth rate" importance:0.0 initialValue:-0.22];
    
    //Health:
    country.health.subindices[@"Life expectancy"] = [[Index alloc]initWithName:@"Life expectancy" importance:0.7 initialValue:80.40/lifeExpectancyAvg];
    country.health.subindices[@"Infant mortality rate"] = [[Index alloc]initWithName:@"Infant mortality rate" importance:0.2 initialValue:infantMortalityRateAvg/4.60];
    country.health.subindices[@"Sanitation"] = [[Index alloc]initWithName:@"Sanitation" importance:0.3 initialValue:100.00/sanitationAvg];
    country.health.subindices[GROWTH] = [[Index alloc] initWithName:@"Health index growth rate" importance:0.0 initialValue:0.6];
    
    //Safety and security:
    country.safetyAndSecurity.subindices[@"Assaulted" ] = [[Index alloc]initWithName:@"Assaulted" importance:0.5 initialValue:assaultedAvg/1.90];
    country.safetyAndSecurity.subindices[@"Emigration"] = [[Index alloc]initWithName:@"Emigration" importance:0.2 initialValue:emigrationAvg/2.10];
    country.safetyAndSecurity.subindices[@"Safe walking at night"] = [[Index alloc]initWithName:@"Safe walking at night" importance:0.1 initialValue:71.50/safeWalkingAloneAtNightAvg];
    country.safetyAndSecurity.subindices[GROWTH] = [[Index alloc] initWithName:@"Safety index growth rate" importance:0.0 initialValue:0.68];
    
    //Personal freedom:
    country.personalFreedom.subindices[@"Civil liberties"] = [[Index alloc]initWithName:@"Civil liberties" importance:0.5 initialValue:7.00/civilLibertiesAvg];
    country.personalFreedom.subindices[@"Freedom of choice"] = [[Index alloc]initWithName:@"Freedom of choice" importance:0.3 initialValue:90.40/freedomOfChoiceAvg];
    country.personalFreedom.subindices[@"Good place for immigrants"] = [[Index alloc] initWithName:@"Good place for immigrants" importance:0.2 initialValue:82.10/goodPlaceImmigrantsAvg];
    country.personalFreedom.subindices[GROWTH] = [[Index alloc] initWithName:@"Freedom index growth rate" importance:0.0 initialValue:0.95];

    
    //Social capital:
    country.socialCapital.subindices[@"Married"] = [[Index alloc]initWithName:@"Married" importance:0.1 initialValue:45.20/marriedAvg];
    country.socialCapital.subindices[@"Worship"] = [[Index alloc]initWithName:@"Worship" importance:0.1 initialValue:18.20/worshipAvg];
    country.socialCapital.subindices[@"Trust"] = [[Index alloc]initWithName:@"Trust" importance:0.2 initialValue:35.80/trustAvg];
    country.socialCapital.subindices[@"Volunteered"] = [[Index alloc]initWithName:@"Have you volunteered your time in past month?" importance:0.4 initialValue:25.90/volunteeredAvg];
    country.socialCapital.subindices[@"Help"] = [[Index alloc]initWithName:@"Have you helped a stranger in past month?" importance:0.4 initialValue:55.20/helpStrangerAvg];
    country.socialCapital.subindices[@"Charity"] = [[Index alloc]initWithName:@"Donated money to charity in past month?" importance:0.4 initialValue:70.20/charityAvg];
    country.socialCapital.subindices[@"Rely"] = [[Index alloc]initWithName:@"Can you rely on friends and family?" importance:0.5 initialValue:95.60/relyOnFamilyAvg];
    country.socialCapital.subindices[GROWTH] = [[Index alloc] initWithName:@"Social capital index growth rate" importance:0.0 initialValue:-0.23];

    //TODO HERE!!!!
    
    country.place = CGPointMake(3946.718994, 756.478088);
    
    return country;
}

-(void) createCountries
{
//    NSInteger france[8] = {22, 21, 18, 19, 9, 31, 16, 40};
//    NSInteger spain[8] = {40, 26, 26, 10, 21, 29, 18, 34};
    Country* usa = [self createUSA];
    [self addCountry:usa];
    NSArray* news = [NSArray arrayWithObjects:@"USA created.",@"",usa.name, nil];
    [_newsvc addNews:news];
//
    Country* france = [self createFrance];
    [self addCountry:france];
    news = [NSArray arrayWithObjects:@"France created.",@"",france.name, nil];
    [_newsvc addNews:news];
    
    Country* russia = [self createRussia];
    [self addCountry:russia];
    news = [NSArray arrayWithObjects:@"Russia created.",@"",russia.name, nil];
    [_newsvc addNews:news];
    
    Country* japan = [self createJapan];
    [self addCountry:japan];
    news = [NSArray arrayWithObjects:@"Japan created.",@"",japan.name, nil];
    [_newsvc addNews:news];
    
    Country *afghanistan = [self createAfghanistan];
    [self addCountry:afghanistan];
    news = [NSArray arrayWithObjects:@"Afghanistan created.",@"",afghanistan.name, nil];
    [_newsvc addNews:news];
    
    Country* uk = [self createUK];
    [self addCountry:uk];
    news = [NSArray arrayWithObjects:@"UK created.",@"",uk.name, nil];
    [_newsvc addNews:news];
    
    Country *moldova = [self createMoldova];
    [self addCountry:moldova];
    news = [NSArray arrayWithObjects:@"Moldova created.",@"",moldova.name, nil];
    [_newsvc addNews:news];
    

    
    Country *germany = [self createGermany];
    [self addCountry:germany];
    news = [NSArray arrayWithObjects:@"Germany created.",@"",germany.name, nil];
    [_newsvc addNews:news];
    

    
//    NSLog(@"Af: %f",afghanistan.governance.value);
//    NSLog(@"fr : %f",france.socialCapital.value);

    
//

    
    
    
    
    
    

}

-(void) doubleTap:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        [self.scrollView setZoomScale:self.scrollView.zoomScale*2 animated:YES];
    }
}

-(void) doubleDoubleTap:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        [self.scrollView setZoomScale:self.scrollView.zoomScale/2 animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                         bundle:nil];
    self.countryDataViewController = (CountryViewController*)[storyboard instantiateViewControllerWithIdentifier:@"countryView"];
 
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.worldMap.image.size;
    self.scrollView.maximumZoomScale = MAXIMUM_SCROLL_VIEW_ZOOM_SCALE;
    self.scrollView.minimumZoomScale = self.scrollView.frame.size.width/self.worldMap.image.size.width;

    [self.scrollView addSubview:self.worldMap];
    

    self.scrollView.userInteractionEnabled = YES;
    self.worldMap.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer* doubleDoubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleDoubleTap:)];
    doubleDoubleTap.numberOfTapsRequired = 2;
    doubleDoubleTap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:doubleDoubleTap];

}

-(void) startEconomicGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;

    NSArray* economicGrowthIndices = @[
                                       country.economy.subindices[@"GDP"]
                                       ];
    Index* growth = country.economy.subindices[GROWTH];
    float growthValue = (growth.value * growthRateAvg)/100;
//    NSLog(@"Growth: %f",growthValue);
    Action* economicGrowth = [[Action alloc] initWithName:@"Economic growth"
                                                startTime:self.world.timeline.currentTime
                                                 duration:period
                                               onTimeline:self.world.timeline
                                          affectedIndices:economicGrowthIndices
                                                 strength:growthValue
                                                    place:country.place];
    economicGrowth.delegate = self;
    [country startAction:economicGrowth];
}

-(void) startEntrepreneurshipGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;

    NSArray* growthIndices = @[
                                       country.entrepreneurshipAndOpportunity.subindices[@"Good place to start a business"],
                                       country.entrepreneurshipAndOpportunity.subindices[@"Secure internet servers"],
                                       country.entrepreneurshipAndOpportunity.subindices[@"Mobile phones"]
                                       ];
    Index* growth = country.entrepreneurshipAndOpportunity.subindices[GROWTH];
    float growthValue = growth.value/10;
//    NSLog(@"Growth: %f",growthValue);
    Action* entrepreneurshipGrowth = [[Action alloc] initWithName:@"Entrepreneurship growth"
                                                startTime:self.world.timeline.currentTime
                                                 duration:period
                                               onTimeline:self.world.timeline
                                          affectedIndices:growthIndices
                                                 strength:growthValue
                                                    place:country.place];
    entrepreneurshipGrowth.delegate = self;
    [country startAction:entrepreneurshipGrowth];
}

-(void) startGovernanceGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;

    
    NSArray* growthIndices = @[
                               country.governance.subindices[@"Separation of powers"],
                               country.governance.subindices[@"Stability"],
                               country.governance.subindices[@"Corruption"],
                               country.governance.subindices[@"Environment"]
                               ];
    Index* growth = country.governance.subindices[GROWTH];
    float growthValue = growth.value/10;
//    NSLog(@"Growth: %f",growthValue);
    Action* governanceGrowth = [[Action alloc] initWithName:@"Governance growth"
                                                        startTime:self.world.timeline.currentTime
                                                         duration:period
                                                       onTimeline:self.world.timeline
                                                  affectedIndices:growthIndices
                                                         strength:growthValue
                                                            place:country.place];
    governanceGrowth.delegate = self;
    [country startAction:governanceGrowth];
}

-(void) startEducationGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;
    
    NSArray* growthIndices = @[
                               country.education.subindices[@"Opportunity to learn"],
                               country.education.subindices[@"Satisfied with quality"],
                               country.education.subindices[@"Secondary enrolment rate"]
                               ];
    Index* growth = country.education.subindices[GROWTH];
    float growthValue = growth.value/10;
//    NSLog(@"Growth: %f",growthValue);
    Action* educationGrowth = [[Action alloc] initWithName:@"Education growth"
                                                  startTime:self.world.timeline.currentTime
                                                   duration:period
                                                 onTimeline:self.world.timeline
                                            affectedIndices:growthIndices
                                                   strength:growthValue
                                                      place:country.place];
    educationGrowth.delegate = self;
    [country startAction:educationGrowth];
}

-(void) startHealthGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;
    
    NSArray* growthIndices = @[
                               country.health.subindices[@"Life expectancy"],
                               country.health.subindices[@"Infant mortality rate"],
                               country.health.subindices[@"Sanitation"]
                               ];
    Index* growth = country.health.subindices[GROWTH];
    float growthValue = growth.value/10;
    //    NSLog(@"Growth: %f",growthValue);
    Action* healthGrowth = [[Action alloc] initWithName:@"Health growth"
                                                 startTime:self.world.timeline.currentTime
                                                  duration:period
                                                onTimeline:self.world.timeline
                                           affectedIndices:growthIndices
                                                  strength:growthValue
                                                     place:country.place];
    healthGrowth.delegate = self;
    [country startAction:healthGrowth];
}

-(void) startSafetyGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;
    
    NSArray* growthIndices = @[
                               country.safetyAndSecurity.subindices[@"Assaulted" ],
                               country.safetyAndSecurity.subindices[@"Emigration"],
                               country.safetyAndSecurity.subindices[@"Safe walking at night"]
                               ];
    Index* growth = country.safetyAndSecurity.subindices[GROWTH];
    float growthValue = growth.value/10;
    //    NSLog(@"Growth: %f",growthValue);
    Action* safetyGrowth = [[Action alloc] initWithName:@"Safety growth"
                                              startTime:self.world.timeline.currentTime
                                               duration:period
                                             onTimeline:self.world.timeline
                                        affectedIndices:growthIndices
                                               strength:growthValue
                                                  place:country.place];
    safetyGrowth.delegate = self;
    [country startAction:safetyGrowth];
 }

-(void) startFreedomGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;
    
    NSArray* growthIndices = @[
                               country.personalFreedom.subindices[@"Civil liberties" ],
                               country.personalFreedom.subindices[@"Freedom of choice"],
                               country.personalFreedom.subindices[@"Good place for immigrants"]
                               ];
    Index* growth = country.personalFreedom.subindices[GROWTH];
    float growthValue = growth.value/10;
    //    NSLog(@"Growth: %f",growthValue);
    Action* freedomGrowth = [[Action alloc] initWithName:@"Freedom growth"
                                              startTime:self.world.timeline.currentTime
                                               duration:period
                                             onTimeline:self.world.timeline
                                        affectedIndices:growthIndices
                                               strength:growthValue
                                                  place:country.place];
    freedomGrowth.delegate = self;
    [country startAction:freedomGrowth];
}

-(void) startSocialGrowthForCountry:(Country*)country
{
    long period = YEAR;
    
    period = period + arc4random() % period;
    
    NSArray* growthIndices = @[
                               country.socialCapital.subindices[@"Married" ],
                               country.socialCapital.subindices[@"Worship"],
                               country.socialCapital.subindices[@"Trust"],
                                country.socialCapital.subindices[@"Volunteered"],
                              country.socialCapital.subindices[@"Help"],
                               country.socialCapital.subindices[@"Charity"],
                              country.socialCapital.subindices[@"Rely"]
                               ];
    Index* growth = country.socialCapital.subindices[GROWTH];
    float growthValue = growth.value/10;
    //    NSLog(@"Growth: %f",growthValue);
    Action* socialGrowth = [[Action alloc] initWithName:@"Social growth"
                                               startTime:self.world.timeline.currentTime
                                                duration:period
                                              onTimeline:self.world.timeline
                                         affectedIndices:growthIndices
                                                strength:growthValue
                                                   place:country.place];
    socialGrowth.delegate = self;
    [country startAction:socialGrowth];
}





-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createCountries];
    
    [self.scrollView zoomToRect:self.worldMap.frame animated:YES];
    
    NSArray* countries = [self.countriesDictionary allValues];

    
    Country* japan = [self.countriesDictionary objectForKey:@"Japan"];
    
    Action *earthquake = [[Action alloc]initWithName:@"Earthquake"
                                           startTime:[NSDate dateWithTimeInterval:10*YEAR sinceDate:self.world.timeline.currentTime ]
                                            duration:2*MINUTE
                                          onTimeline:self.world.timeline
                                     affectedIndices:@[japan.economy, japan.health, japan.entrepreneurshipAndOpportunity]
                               dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(-.5),ECONOMY, @(-.1),HEALTH, @(-.1),ENTREPRENEURSHIP_AND_OPPORTUNITY, nil]
                                               place:japan.place];
    earthquake.delegate = self;
    [earthquake willStart];
    
    Country* afghanistan = [self.countriesDictionary objectForKey:@"Afghanistan"];
    
    Action *earthquake1 = [[Action alloc]initWithName:@"Earthquake"
                                            startTime:[NSDate dateWithTimeInterval:MONTH sinceDate:self.world.timeline.currentTime ]
                                             duration:2*MINUTE
                                           onTimeline:self.world.timeline
                                      affectedIndices:@[afghanistan.economy, afghanistan.health]
                                dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(-.2),ECONOMY, @(-.2),HEALTH, nil]
                                                place:afghanistan.place];
    earthquake1.delegate = self;
    [earthquake1 willStart];
    
    Country* russia = [self.countriesDictionary objectForKey:@"Russian Federation"];
    
    Action *olympiad = [[Action alloc]initWithName:@"Olympiad"
                                            startTime:[NSDate dateWithTimeInterval:7*MONTH sinceDate:self.world.timeline.currentTime ]
                                             duration:2*MONTH
                                           onTimeline:self.world.timeline
                                      affectedIndices:@[russia.economy, russia.entrepreneurshipAndOpportunity, russia.socialCapital]
                                dictionaryOfStrengths:[NSDictionary dictionaryWithObjectsAndKeys:@(+.2),ECONOMY, @(.2),ENTREPRENEURSHIP_AND_OPPORTUNITY, @(.6), SOCIAL_CAPITAL, nil]
                                                place:russia.place];
    olympiad.delegate = self;
    [olympiad willStart];
    
    
    for (Country* country in countries)
    {
        [self startEconomicGrowthForCountry:country];
        [self startEntrepreneurshipGrowthForCountry:country];
        [self startGovernanceGrowthForCountry:country];
        [self startEducationGrowthForCountry:country];
        [self startHealthGrowthForCountry:country];
        [self startSafetyGrowthForCountry:country];
        [self startFreedomGrowthForCountry:country];
        [self startSocialGrowthForCountry:country];
        
        
    }


//    Country* c1 = [self.countriesDictionary objectForKey:@"Rep. Moldova"];
//    Country* c2 = [countries objectAtIndex:1];
//    NSArray* indices = @[c1.score];
//    NSLog(@"moldova score: %f",c1.score.value);
//    
//    Action *earthquake = [[Action alloc]initWithName:@"Earthquake" startTime:[NSDate date] duration:MINUTE onTimeline:self.world.timeline affectedIndices:indices strength:-0.2 place:c1.place];
//    earthquake.delegate = self;
//    
//    [c2 startAction:earthquake];
//    
//    Action *olimp = [[Action alloc]initWithName:@"Olimpic games asdasd a"
//                                      startTime:[NSDate dateWithTimeInterval:MONTH
//                                                                   sinceDate: self.world.timeline.currentTime]
//                                       duration:HOUR
//                                     onTimeline:self.world.timeline
//                                affectedIndices:nil//c1.score.subindices
//                                       strength:+0.01
//                                          place:c1.place];
//    olimp.delegate = self;
//    [c1 startAction:olimp];

    [self showWorld];
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning!!!");
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)viewDidUnload {
    [self setProgressBar:nil];
    [super viewDidUnload];
}
@end
