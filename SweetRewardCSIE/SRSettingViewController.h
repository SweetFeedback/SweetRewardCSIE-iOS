//
//  SRSettingViewController.h
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/13.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
- (IBAction)submitPressed:(UIButton *)sender;

@end
