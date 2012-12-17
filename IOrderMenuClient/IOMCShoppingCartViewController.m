//
//  IOMCShoppingCartViewController.m
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

#import "IOMCShoppingCartViewController.h"
#import "IOMCShoppingCartEntry.h"
#import "IOMCImageCell.h"
#import "IOMCCartEntryViewController.h"
#import "IOMCMenuViewController.h"
#import "IOMCConfirmOrderViewController.h"
#import "IOMCConnectionData.h"

@interface IOMCShoppingCartViewController ()

@end

@implementation IOMCShoppingCartViewController

@synthesize cartContents,comestibles,connection;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[self navigationItem] setTitle:@"Your Order:"];
        ((UITableViewController *)self).tableView.rowHeight =120;
    }
    return self;
}

- (id) initWithConnection:(IOMCConnectionData *)aConnection style:(UITableViewStyle)style
{
    connection =aConnection;
    cartContents = connection.cartContents;
    comestibles = connection.comestibles;
    self = [self initWithStyle:style];
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Leave to Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(viewMenu)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Confirm Order" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmOrder)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



-(void)confirmOrder
{
    IOMCConfirmOrderViewController *menuView = [[IOMCConfirmOrderViewController alloc] initWithConnection:connection nibName:nil bundle:nil];
    [self.navigationController pushViewController:menuView animated:YES];
}

-(void)viewMenu
{
    IOMCMenuViewController *menuView = [[IOMCMenuViewController alloc] initWithConnection:connection style:UITableViewStylePlain];
    [self.navigationController pushViewController:menuView animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cartContents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    IOMCShoppingCartEntry *e = [cartContents objectAtIndex:[indexPath row]];
    
   
        IOMCImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (imageCell ==nil){
            imageCell = [[IOMCImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        //in the second section there should be the image Placed for the MenuEntry and the count.
        
        imageCell.dishImage.image = [UIImage imageWithData:e.entry.image];
        [imageCell.secondLabel setText: [NSString stringWithFormat: @"count: %i",e.count]];
        [imageCell.textLabel setText: e.entry.name];
        [imageCell.detailTextLabel setText:e.optionalExtras];
        
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
    
    IOMCCartEntryViewController *cartView = [[IOMCCartEntryViewController alloc] initWithCartEntry:[cartContents objectAtIndex:indexPath.row] connection:connection row:indexPath.row nibName:nil bundle:nil];
    [self.navigationController pushViewController:cartView animated:YES];
}

@end
