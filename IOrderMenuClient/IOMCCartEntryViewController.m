//
//  IOMCCartEntryViewController.m
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

#import "IOMCCartEntryViewController.h"
#import "IOMCShoppingCartViewController.h"
#import "IOMCMenuViewController.h"
#import "IOMCMenuEntry.h"
#import "IOMCConnectionData.h"
@interface IOMCCartEntryViewController ()

@end

@implementation IOMCCartEntryViewController

@synthesize cartContents,editedCartEntry,row,image,countStepper,count,optionalExtras,longDescription,name,orderButton,removeButton,comestibles,scrollView,fromMenu,connection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

        // Custom initialization
    }
    return self;
}


- (id)initWithCartEntry:(IOMCShoppingCartEntry *)aCartEntry connection:(IOMCConnectionData *)aConnection row:(int)theRow nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    connection = aConnection;
    editedCartEntry = aCartEntry;
    cartContents = aConnection.cartContents;
    comestibles = aConnection.comestibles;
    // the row will be used to know which entry should be removed
    row = theRow;
    self = [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
    
}

- (id)initWithMenuEntry:(IOMCMenuEntry *)menuEntry connection:(IOMCConnectionData *)aConnection nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    IOMCShoppingCartEntry *newCartEntry = [[IOMCShoppingCartEntry alloc] init];
    newCartEntry.entry = menuEntry;
    newCartEntry.count = 0;
    int theRow = [cartContents count];
    self = [self initWithCartEntry:newCartEntry connection:aConnection row:theRow nibName:nibNameOrNil bundle:nibBundleOrNil];
    fromMenu=YES;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    if (editedCartEntry.entry.image == nil)
    { NSLog(@"there is no image"); }
    
    image.image = [UIImage imageWithData:editedCartEntry.entry.image];
    name.text = editedCartEntry.entry.name;
    longDescription.text = editedCartEntry.entry.longDescription;
    countStepper.value = (int)editedCartEntry.count;
    count.text = [NSString stringWithFormat:@"%g",countStepper.value];
    if (fromMenu)
    {
        [orderButton setEnabled:YES];
        [removeButton setEnabled:NO];
    }
    else
    {
        [orderButton setEnabled:NO];
        [removeButton setEnabled:YES];
    }
    
    if (editedCartEntry.optionalExtras != nil)
    {
        optionalExtras.text = editedCartEntry.optionalExtras;
    }
    else {
        editedCartEntry.optionalExtras = [NSMutableString stringWithFormat:@"%@", optionalExtras.text];
    }
    optionalExtras.delegate = self;
    optionalExtras.scrollEnabled = YES;
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Order" style:UIBarButtonItemStyleBordered target:self action:@selector(viewCart)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Leave to Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(viewMenu)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)textViewDidEndEditing:(UITextView *)textView
{
    editedCartEntry.optionalExtras = [NSMutableString stringWithFormat:@"%@",textView.text];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
       
        return NO;
    }

    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{

    [scrollView scrollRectToVisible:optionalExtras.frame animated:YES];
    if (fromMenu)
    {
        textView.text = @"";
        fromMenu = NO;
    }
    
}

- (void)viewCart
{
    IOMCShoppingCartViewController *cartView =[[IOMCShoppingCartViewController alloc] initWithConnection:connection style:UITableViewStylePlain];
    [self.navigationController pushViewController:cartView animated:YES];
}

- (void)viewMenu
{
    IOMCMenuViewController *menuView = [[IOMCMenuViewController alloc] initWithConnection:connection style:UITableViewStylePlain];
    [self.navigationController pushViewController:menuView animated:YES];

}

- (IBAction)orderDish:(id)sender {
    [orderButton setEnabled:NO];
    [removeButton setEnabled:YES];
    [cartContents addObject:editedCartEntry];
}

- (IBAction)removeDish:(id)sender {
    [orderButton setEnabled:YES];
    [removeButton setEnabled:NO];
    [cartContents removeObjectAtIndex:row];
    row =[cartContents count];
    
}

- (IBAction)changeCount:(id)sender {
    count.text = [NSString stringWithFormat:@"%g",countStepper.value];
    
    editedCartEntry.count = [[NSNumber numberWithDouble:countStepper.value] integerValue];
}
@end
