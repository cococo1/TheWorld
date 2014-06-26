//
//  SettingsViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 4/14/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (nonatomic, strong) Action* lastAction;

@end

@implementation SettingsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
//        [self setup];
        // Custom initialization
    }
    return self;
}

-(void) awakeFromNib
{
    [super awakeFromNib];
//    [self setup];
}

-(void) actionFinished:(Action *)action
{
//    NSLog(@"Action stopping: %@",action.name);
    if ([self.lastAction.name isEqual:action.name])
    {
//        NSLog(@"this action was from here!");

        self.lastAction = nil;
        self.worldvc.myCurrentAction = nil;


        
        
        for (int i=0; i<[self.possibleActions count]+1; i++)
        {
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath1];
            cell.textLabel.enabled = !cell.textLabel.enabled;
            cell.userInteractionEnabled = !cell.userInteractionEnabled;
            cell. detailTextLabel.enabled = !cell.detailTextLabel.enabled;
        }
        
    }
    

}

-(void) setup
{
//    NSLog(@"setup");
//    self.somethingIsSelected = NO;
    self.worldvc = [[self.splitViewController viewControllers] objectAtIndex:1];
//    self.possibleActions = self.worldvc.myCountry.actions;
    self.possibleActions = [[NSMutableArray alloc]init];
    Action *action;
    for (int i =0; i<8; i++)
    {
        
        action = [self.worldvc.myCountry giveMeAnAction];
        if (![self.possibleActions containsObject:action])
        {
            self.possibleActions[i] = action;
        }
        else i--;
    }
    self.worldvc.delegate = self;
    


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    self.navigationItem.hidesBackButton = YES;
    self.title = self.worldvc.myCountry.name;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didReceiveMemoryWarning!!!");
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"need number of rows");
    return [self.possibleActions count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"cell row");
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];

    }
    
    if (!indexPath.row)
    {
        cell.textLabel.text = @"Stop current action";
        cell.textLabel.enabled = NO;
        cell.userInteractionEnabled = NO;
        cell.detailTextLabel.text = @"";
        
    }
    else
    {
    
        Action* action = self.possibleActions[indexPath.row-1];
        
        cell.textLabel.text = action.name;
//        [cell.textLabel sizeToFit];
        NSString* description;
        long duration = (long)action.duration;
        int year = YEAR;
        int month = MONTH;
        int week = WEEK;
        int day = DAY;
        int hour = HOUR;
        int minute = MINUTE;
        
        
        if (action.duration > 2*YEAR)
        {
            description = [NSString stringWithFormat:@"Will take about %li years", duration / year];
        }
        else if (action.duration > 10*MONTH)
        {
            description = @"Will take about a year";
        }
        else if (action.duration > 2*MONTH)
        {
            description = [NSString stringWithFormat:@"Will take about %li months", duration / month];
        }
        else if (action.duration > 4*WEEK)
        {
            description = @"Will take about a month";

        }
        else if (action.duration > 2*WEEK)
        {
            description = [NSString stringWithFormat:@"Will take about %li weeks", duration / week  ];

        }
        else if (action.duration > 6*DAY)
        {
            description = @"Will take about a week";

        }
        else if (action.duration > 2*DAY)
        {
            description = [NSString stringWithFormat:@"Will take about %li days", duration / day ];
        }
        else if (action.duration > 23*HOUR)
        {
            description = @"Will be done tomorrow";
        }
        else if (action.duration > 2*HOUR)
        {
            description = [NSString stringWithFormat:@"Will take about %li hours", duration / hour];
        }
        else if (action.duration > 50*MINUTE)
        {
            description = @"Will be done in an hour";
        }
        else if (action.duration > 2*MINUTE)
        {
            description = [NSString stringWithFormat:@"Will take about %li minutes", duration / minute];

        }
        else if (action.duration > 50)
        {
            description = @"Will be done in a minute";

        }
        else if (action.duration > 2)
        {
            description = [NSString stringWithFormat:@"Will take about %li seconds", duration ];

        }
        else description = @"Will be done immediately";
        
        
        cell.detailTextLabel.text = description;
        
        // Configure the cell...
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%@",[tableView cellForRowAtIndexPath:indexPath].textLabel.text);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
    if (indexPath.row)
    {

        
        Action* action1  = self.possibleActions[indexPath.row-1];
//        NSLog(@"Action starting: %@",action1.name);
        action1.delegate = self.worldvc;
        [action1 willStart];
        self.worldvc.myCurrentAction = action1;
        self.lastAction = action1;
//        NSLog(@"Before removal: %i",[self.possibleActions count]);
//        [self.possibleActions removeObjectAtIndex:indexPath.row-1];
//        NSLog(@"After removal (before insertion): %i",[self.possibleActions count]);

        
        Action* action = [self.worldvc.myCountry giveMeAnAction];
        
//        NSLog(@"Before insertion: %@",self.possibleActions);

        while ([self.possibleActions containsObject:action])
        {
            action = [self.worldvc.myCountry giveMeAnAction];
        }
//        NSLog(@"Action name: %@",action.name);

        self.possibleActions[indexPath.row-1] = action;
        
//        NSIndexPath* indexPath1 = [NSIndexPath indexPathForRow:[self.possibleActions count] inSection:0];

//        NSLog(@"Action: %@",action.name);
        
//        NSLog(@"After insertion: %i %@",[self.possibleActions count], self.possibleActions);
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];


        for (int i=0; i<[self.possibleActions count]+1; i++)
        {
            NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:i inSection:0];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath1];
            cell.textLabel.enabled = !cell.textLabel.enabled;
            cell.userInteractionEnabled = !cell.userInteractionEnabled;
            cell. detailTextLabel.enabled = !cell.detailTextLabel.enabled;
        }
        

    }
    else
    {
        [self.lastAction stop];
        
    }
    


    
    

    

    
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
