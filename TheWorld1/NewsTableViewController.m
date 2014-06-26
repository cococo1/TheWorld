//
//  NewsTableViewController.m
//  TheWorld1
//
//  Created by Maxim Chetrusca on 6/17/13.
//  Copyright (c) 2013 Maxim Chetrusca. All rights reserved.
//

#import "NewsTableViewController.h"

@interface NewsTableViewController ()

@property (nonatomic, strong) NSMutableArray* newsFeed;

@end

@implementation NewsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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

-(void) setup
{
    _newsFeed = [[NSMutableArray alloc]init];
}

-(void) addNews:(NSArray*)news
{
//    NSLog(@"add news, %@",self.newsFeed);
    [self.newsFeed insertObject:news atIndex:0];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.numberOfRows++;

    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];

    NSLog(@"%i",[self.newsFeed count]);

//    [self.tableView reloadData];

}

-(void) refresh
{
    [self.refreshControl beginRefreshing];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh)
             forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"did receive memory warning!!!, %@",self);
    //[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
        
    }
    
//    NSLog(@"%@ %i",(NSString*)self.newsFeed[indexPath.row], [self.newsFeed count]);
    cell.textLabel.text = (NSString*)self.newsFeed[indexPath.row][0];
    cell.detailTextLabel.text = (NSString*)self.newsFeed[indexPath.row][1];
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",(NSString*)self.newsFeed[indexPath.row][2]]];
//    image.size = CGSizeMake(30, 30/image.size.width*image.size.height);
    cell.imageView.image = [UIImage imageWithCGImage:image.CGImage scale:image.size.width/30 orientation:image.imageOrientation];
//    NSLog(@"%@",self.newsFeed[indexPath.row][3]);
//    BOOL bold = [(NSNumber*)self.newsFeed[indexPath.row][3] boolValue];
//    if (bold)
//    {
//        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
//    }
//    cell.imageView.transform = CGAffineTransformMakeScale(<#CGFloat sx#>, <#CGFloat sy#>)
    
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
