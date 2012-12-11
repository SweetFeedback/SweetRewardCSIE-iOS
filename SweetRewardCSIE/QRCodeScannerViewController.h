//
//  QRCodeScannerViewController.h
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/12.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"

@interface QRCodeScannerViewController : UIViewController <ZXingDelegate> /*{
    IBOutlet UITextView *resultsView;
    NSString *resultsToDisplay;
}*/

@property (weak, nonatomic) IBOutlet UITextField *resultText;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


- (IBAction)scanPressed:(UIButton *)sender;


@end
