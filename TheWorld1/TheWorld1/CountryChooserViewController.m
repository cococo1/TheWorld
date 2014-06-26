//
//  CountryChooserViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/8/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "CountryChooserViewController.h"
#import "WorldViewController.h"

@interface CountryChooserViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *countryPickerView;
@property (strong, nonatomic) NSArray* countries;
@property (weak, nonatomic) WorldViewController* worldvc;
@property (strong, nonatomic) NSString* myCountry;

@property (strong, nonatomic) Action* thatAction;
@end

@implementation CountryChooserViewController

- (IBAction)stopEarthquake:(UIButton *)sender
{
    [self.thatAction stop];
}

- (IBAction)earthquakeTouchUpInside:(UIButton *)sender
{
    Country* c1 = [self.worldvc.countriesDictionary objectForKey:@"Rep. Moldova"];
//    Country* c2 = [self.worldvc.countries objectAtIndex:1];
    NSArray* indices = @[c1.score];
    NSLog(@"moldova score: %f",c1.score.value);
//    NSDictionary *affects = [NSDictionary dictionaryWithObjectsAndKeys:@(-.2),c1.governance.name, @(.2), c1.education.name, nil];
    
    Action *earthquake = [[Action alloc]initWithName:@"Earthquake"
                                           startTime:self.worldvc.world.timeline.currentTime
                                            duration:WEEK
                                          onTimeline:self.worldvc.world.timeline
                                     affectedIndices:indices
                                            strength:1
                                               place:c1.place];
    earthquake.delegate = self.worldvc;
    UnknownForce* force = [[UnknownForce alloc]initWithName:@"God"];
    [force startAction:earthquake];
    self.thatAction = earthquake;
    
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    self.countries = [self.worldvc giveMeTheCountries];
    return [self.countries count];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    NSLog(@"title for row");
    return [self.countries objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
//    NSLog(@"row height");
    return ROW_HEIGHT;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
//    NSLog(@"row width");
    return self.view.bounds.size.width;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

//    NSLog(@"%i", row);
    NSString* countryName = [self.countries objectAtIndex:row];
    [self.worldvc showCountry:countryName];
//    NSLog(@"%@",countryName);
    self.myCountry = countryName;


    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"start"])
    {
        int row = [self.countryPickerView selectedRowInComponent:0];
        self.myCountry = [self.countries objectAtIndex:row];
//        NSLog(@"my : %@",self.myCountry);
        [self.worldvc showWorld];
        self.worldvc.myCountry = [self.worldvc.countriesDictionary objectForKey:self.myCountry];
//        NSLog(@"My country!!!: %@", self.worldvc.myCountry);
    }
}

    


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.worldvc = [[self.splitViewController viewControllers] objectAtIndex:1];
    self.countryPickerView.delegate = self;
    
    int row = [self.countryPickerView selectedRowInComponent:0];
    NSString* countryName = [self.countries objectAtIndex:row];
    [self.worldvc showCountry:countryName];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning %@",self);
//    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCountryPickerView:nil];
    [super viewDidUnload];
}
@end
