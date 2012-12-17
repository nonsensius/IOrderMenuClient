//
//  RootViewController.m
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

#import "IOMCRootViewController.h"
#import "IOMCMenuEntry.h"
#import "IOMCMenuViewController.h"

@interface IOMCRootViewController ()

@end

@implementation IOMCRootViewController

@synthesize menuView,connection,copyrightNotice;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

                [[self navigationItem] setTitle:@"I Order Menu Client"];
        NSString *copyright = @"Copyright (c) 2012, Benjamin Pawlowsky\n        All rights reserved.\n        Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:\n        •	Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.\n        •	Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following\n disclaimer in the documentation and/or other materials provided with the distribution.\n        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE." ;
        
        copyrightNotice = [[UIAlertView alloc] initWithTitle:@"Copyright Notice" message: copyright delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];

        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];


    [copyrightNotice show];
    IOMCMenuEntry *entry1 = [[IOMCMenuEntry alloc] init];
    
    entry1.name = [NSString stringWithFormat: @"Omlett"];
    
    entry1.longDescription =[NSString stringWithFormat: @"Omlett mit Kaese ueberbacken, serviert mit Bratkartoffeln und Buttergemuese"];
    
    entry1.shortDescription=[NSString stringWithFormat: @"Omlett,Bratkartoffeln,Buttergemuese"];
    
    entry1.price = [NSNumber numberWithFloat:(float)2.99];

    entry1.image =[NSData dataWithContentsOfFile:[NSString stringWithFormat: @"%@/OMLett.jpg",[[NSBundle mainBundle] resourcePath]]];


    NSArray *comestibles = [[NSArray alloc] initWithObjects:entry1, nil];
    NSString *table1= @"table1";
    NSString *table2= @"table2";
    NSArray *tables = [[NSArray alloc] initWithObjects:table1, table2, nil];
    
    connection = [[IOMCConnectionData alloc] init];
    connection.comestibles = comestibles;
    connection.tables = tables;
    
    menuView = [[IOMCMenuViewController alloc] initWithConnection:connection style:UITableViewStylePlain];
    
    [self.navigationController pushViewController:menuView animated:YES];
    [menuView.tableView setDelegate:menuView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end



