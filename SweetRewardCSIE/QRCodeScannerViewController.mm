//
//  QRCodeScannerViewController.m
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/12.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import "QRCodeScannerViewController.h"

#import "QRCodeReader.h"

@interface QRCodeScannerViewController ()

@end

@implementation QRCodeScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark ZXingDelegateMethods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    //self->resultsToDisplay = result;
    if (self.isViewLoaded) {
        self.resultText.text = result;
        //[resultsView setText:resultsToDisplay];
        //[resultsView setNeedsDisplay];
        NSURL *url = [NSURL URLWithString:result];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    [self dismissModalViewControllerAnimated:NO];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    //self->resultsView = nil;
}

#pragma mark - scan button

- (IBAction)scanPressed:(UIButton *)sender {
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    
    [self presentModalViewController:widController animated:YES];
}


@end