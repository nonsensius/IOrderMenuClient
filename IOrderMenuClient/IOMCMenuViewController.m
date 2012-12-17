//
//  IOMCMenuViewController.m
//  IOrderMenuClient
//
/*
 Copyright (c) 2012, Benjamin Pawlowsky
 All rights reserved.
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 •	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 •	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
//

#import "IOMCMenuViewController.h"
#import "IOMCMenuEntry.h"
#import "IOMCImageCell.h"
#import "IOMCCartEntryViewController.h"
#import "IOMCShoppingCartViewController.h"
#import "IOMCConnectionData.h"

@interface IOMCMenuViewController ()

@end

@implementation IOMCMenuViewController

@synthesize comestibles, connection, cartContents, cartEntryView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[self navigationItem] setTitle:@"Menu"];
        self.tableView.delegate = self;

        [self.tableView setAllowsSelection:YES];

        ((UITableViewController *)self).tableView.rowHeight =120;
        
        [self.tableView setAllowsSelectionDuringEditing:YES];


    }
    return self;
}


- (id)initWithConnection:(IOMCConnectionData *)aConnection style:(UITableViewStyle)style
{
    connection = aConnection;

    comestibles = connection.comestibles;
    if (connection.cartContents == nil)
    {
        connection.cartContents = [[NSMutableArray alloc] init];
    }
    self = [self initWithStyle:style];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Order" style:UIBarButtonItemStyleBordered target:self action:@selector(viewCart)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewCart
{
    IOMCShoppingCartViewController *cartView =[[IOMCShoppingCartViewController alloc] initWithConnection:connection style:UITableViewStylePlain];
    [self.navigationController pushViewController:cartView animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Structuce of a line is first the name and shortdescription and then an small image of the dish
    // or beverage and its price
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 // number of things in the Menu
    return [comestibles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    IOMCMenuEntry *m = [comestibles objectAtIndex:[indexPath row]];
    

            IOMCImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (imageCell ==nil){
             imageCell = [[IOMCImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
        }
        
        //in the second section there should be the image Placed for the MenuEntry and the price
        [imageCell setUserInteractionEnabled:YES];
        imageCell.dishImage.image = [UIImage imageWithData:m.image];
        [imageCell.secondLabel setText:[NSString stringWithFormat: @"Price: %@ €", [m.price stringValue]]];
        [[imageCell textLabel] setText: m.name];
        [[imageCell detailTextLabel] setText:m.shortDescription];
        [imageCell setUserInteractionEnabled:YES];
        return imageCell;
    
    
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
    IOMCMenuEntry *theEntry =[comestibles objectAtIndex:indexPath.row];
    
    cartEntryView =[[IOMCCartEntryViewController alloc] initWithMenuEntry:theEntry connection:connection nibName:nil bundle:nil];

    [self.navigationController pushViewController:cartEntryView animated:YES];
  
    
    


}

@end
