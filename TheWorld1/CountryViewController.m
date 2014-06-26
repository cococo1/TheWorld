//
//  CountryViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/16/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *governanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationLabel;

@property (weak, nonatomic) IBOutlet UILabel *entrepreneurshipLabel;
@property (weak, nonatomic) IBOutlet UILabel *safetyLabel;
@property (weak, nonatomic) IBOutlet UILabel *personalFreedomLabel;

@property (weak, nonatomic) IBOutlet UILabel *healthLabel;
@property (weak, nonatomic) IBOutlet UILabel *socialCapitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *overallRankLabel;


@property (weak, nonatomic) IBOutlet UILabel *economyLabel;
@property (nonatomic,strong) UIImageView* mapImageView;

@end

@implementation CountryViewController


-(void) viewDidLoad
{
    [super viewDidLoad];

}

-(void) awakeFromNib
{
    [super awakeFromNib];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.countryNameLabel.text = self.country.name;
    self.economyLabel.text = [NSString stringWithFormat:@"%i", self.country.economy.rank];
//    NSLog(@"%@ %f %f",self.country.economy.name, self.country.economy.value ,self.country.economy.importance);

    self.governanceLabel.text = [NSString stringWithFormat:@"%i", self.country.governance.rank];
//    NSLog(@"%@ %f %f",self.country.governance.name, self.country.governance.value ,self.country.governance.importance);

    self.educationLabel.text = [NSString stringWithFormat:@"%i", self.country.education.rank];
//    NSLog(@"%@ %f %f",self.country.education.name, self.country.education.value ,self.country.education.importance);

    self.healthLabel.text = [NSString stringWithFormat:@"%i", self.country.health.rank];
//    NSLog(@"%@ %f %f",self.country.health.name, self.country.health.value ,self.country.health.importance);

    self.entrepreneurshipLabel.text = [NSString stringWithFormat:@"%i", self.country.entrepreneurshipAndOpportunity.rank];
//    NSLog(@"%@ %f %f",self.country.entrepreneurshipAndOpportunity.name, self.country.entrepreneurshipAndOpportunity.value ,self.country.entrepreneurshipAndOpportunity.importance);

    self.safetyLabel.text = [NSString stringWithFormat:@"%i", self.country.safetyAndSecurity.rank];
//    NSLog(@"%@ %f %f",self.country.safetyAndSecurity.name, self.country.safetyAndSecurity.value ,self.country.safetyAndSecurity.importance);

    self.personalFreedomLabel.text = [NSString stringWithFormat:@"%i", self.country.personalFreedom.rank];
//    NSLog(@"%@ %f %f",self.country.personalFreedom.name, self.country.personalFreedom.value ,self.country.personalFreedom.importance);

    self.socialCapitalLabel.text = [NSString stringWithFormat:@"%i", self.country.socialCapital.rank];
//    NSLog(@"%@ %f %f",self.country.socialCapital.name, self.country.socialCapital.value ,self.country.socialCapital.importance);

    self.overallRankLabel.text = [NSString stringWithFormat:@"%i",self.country.score.rank];
    NSLog(@"%@ %f %f",self.country.name, self.country.score.value, self.country.avgLifeSatisfaction.value);


}

- (void)viewDidUnload {
    [self setCountryNameLabel:nil];
    [self setEconomyLabel:nil];
    [self setGovernanceLabel:nil];
    [self setEducationLabel:nil];
    [self setHealthLabel:nil];
    [self setEntrepreneurshipLabel:nil];
    [self setSafetyLabel:nil];
    [self setPersonalFreedomLabel:nil];
    [self setSocialCapitalLabel:nil];
    [self setOverallRankLabel:nil];
    [super viewDidUnload];
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"This is a view controller for %@",self.country.name ];
}

@end
