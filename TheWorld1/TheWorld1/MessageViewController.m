//
//  MessageViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/8/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()


@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UILabel*) label
{
    if (!_label)
    {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _label;
}

-(void)loadView
{
    NSLog(@"asa");
    self.view = [[UIView alloc]initWithFrame:CGRectZero];
}

-(void) setupSize
{
    [self.label sizeToFit];
    self.view.frame = CGRectMake(0, 0, self.label.frame.size.width+20, self.label.frame.size.height+20);
    //Position it at the center
    self.label.center = self.view.center;
    
    self.contentSizeForViewInPopover = self.view.frame.size;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    [self setupSize];
}

-(void) viewWillAppear:(BOOL)animated
{
//    NSLog(@"asda");
    [super viewWillAppear:animated];


}

- (void)didReceiveMemoryWarning
{
    NSLog(@"memory warning %@",self);
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
