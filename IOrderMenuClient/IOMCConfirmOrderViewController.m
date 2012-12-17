//
//  IOMCConfirmOrderViewController.m
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

#import "IOMCConfirmOrderViewController.h"
#import "IOMCShoppingCartViewController.h"
#import "IOMCShoppingCartEntry.h"
@interface IOMCConfirmOrderViewController ()

@end

@implementation IOMCConfirmOrderViewController
@synthesize comestibles,cartContents,tablePicker,orderTextView,tables,table,connection;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithConnection:(IOMCConnectionData *)aConnection nibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    connection = aConnection;
    comestibles = connection.comestibles;
    cartContents = connection.cartContents;
    tables = connection.tables;
    table =connection.table;
    
    self =[self initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

-(void)showOrder
{
    int i=0;
    NSString *orderString= @"Your Order: ";
    NSString *orderPart;
    float count;
    float price;
    float sum = 0.0;
    for (i = 0; i < cartContents.count ; i++)
    {
        
        orderPart = [NSString stringWithFormat:@"%d %@",((IOMCShoppingCartEntry *)[cartContents objectAtIndex:i]).count,((IOMCShoppingCartEntry *)[cartContents objectAtIndex:i ]).entry.name ];
        count =(float)((IOMCShoppingCartEntry *)[cartContents objectAtIndex:i ]).count;
        price =[((IOMCShoppingCartEntry *)[cartContents objectAtIndex:i ]).entry.price floatValue];
        sum = sum + count * price;
        orderString = [NSString stringWithFormat:@"%@ %@ ,",orderString, orderPart];
        
    }
    
    NSString *toTable;
    if (table==nil)
    {
        toTable = @"nowhere";
    }
    else
    {
        toTable = table;
    }
    NSNumberFormatter *sumFormatter = [[NSNumberFormatter alloc] init];
    [sumFormatter setCurrencySymbol:@"€"];
    [sumFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *sumFormatted= [[NSNumber alloc] initWithFloat:sum];
    orderString =[NSString stringWithFormat: @" %@ for %@ total to %@." ,orderString,[sumFormatter stringFromNumber:sumFormatted] ,toTable];
    orderTextView.text = orderString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Order" style:UIBarButtonItemStyleBordered target:self action:@selector(viewCart)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Order !" style:UIBarButtonItemStyleBordered target:self action:@selector(sendOrder)];
    [self showOrder];
    // Do any additional setup after loading the view from its nib.
}

-(void)sendOrder
{
    // to be implemented with the network code
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    
    return tables.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [tables objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    connection.table = [tables objectAtIndex:row];
    table =connection.table;
    [self showOrder];
}


@end
