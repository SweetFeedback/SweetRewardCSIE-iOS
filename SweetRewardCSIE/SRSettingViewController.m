//
//  SRSettingViewController.m
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/13.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import "SRSettingViewController.h"
#import "SRDataSource.h"
#import "SRTextViewCell.h"
#import "SRSettingTextViewCell.h"

@interface SRSettingViewController ()



@end

@implementation SRSettingViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.account = @"sweetreward";
    self.password = @"test";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    // Configure the cell...
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(row == 0) {
        SRSettingTextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
        if(!textCell){
            textCell = [[[NSBundle mainBundle] loadNibNamed:@"SRTextViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        textCell.label.text = @"Account";
        textCell.textField.text = @"sweetreward";
        textCell.textField.delegate = self;
        self.account = textCell.textField.text;        
        [textCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //textCell.textView.delegate = self;

        cell = textCell;
    } else if(row == 1) {
        SRSettingTextViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:@"TextCell"];
        if(!textCell){
            textCell = [[[NSBundle mainBundle] loadNibNamed:@"SRTextViewCell" owner:self options:nil] objectAtIndex:0];
        }
        
        textCell.label.text = @"Password";
        textCell.textField.text = @"test";
        textCell.textField.delegate = self;
        self.password = textCell.textField.text;
        [textCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        //textCell.textView.delegate = self;
        
        cell = textCell;
    } else if(row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonCell"];
        
        if([SRDataSource sharedSRDataSource].isLogin) {
            cell.textLabel.text = @"Logout";
        } else {
            cell.textLabel.text = @"Create / Login";
        }
    } else {
        NSAssert(NO, @"table cell out of bound");
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([SRDataSource sharedSRDataSource].isLogin) {
        return NO;
    }
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if(row == 2) {
        if([SRDataSource sharedSRDataSource].isLogin) {
            [[SRDataSource sharedSRDataSource] logoutUserAccount];
        } else {
            NSString *account = self.account;
            NSString *password = self.password;
            [[SRDataSource sharedSRDataSource] createOrLoginUserAccountByAccount:account andPassword:password];
        }
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}

@end
