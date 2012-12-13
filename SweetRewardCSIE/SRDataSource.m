//
//  SRDataSource.m
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/13.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import "SRDataSource.h"
#import "AFNetworking.h"
#import "JSONKit.h"

NSString * const SRAPIdomain = @"http://disa.csie.ntu.edu.tw";

@implementation SRDataSource

+ (SRDataSource *)sharedSRDataSource {
    static dispatch_once_t once;
    static SRDataSource *sharedDataSource;
    dispatch_once(&once, ^ {
        sharedDataSource = [[self alloc] init];
    });
    return sharedDataSource;
}

- (id)init {
    if(self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }

    
    return self;
}

- (BOOL)submitUserAccountByAccount:(NSString *)account andPassword:(NSString *)password {
    NSString *token = [self.userDefaults valueForKey:@"token"];
    if(token != nil) {
        return YES;
    }
    
    //NSString *path = @"~blt/sweetreward/php/mobile/createNewUser.php";
    NSString *path = @"~blt/sweetreward/php/mobile/verifyUser.php";
    NSString *requestString = [NSString stringWithFormat:@"%@/%@?account=%@&password=%@", SRAPIdomain, path, account, password];
    NSURL *jsonURL = [NSURL URLWithString:requestString];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    if(jsonString == nil) {
        return NO;
    }
    
    NSDictionary *result = [jsonString objectFromJSONString];
    token = result[@"token"];
    
    [self.userDefaults setValue:token forKey:@"token"];
    [self.userDefaults synchronize];
    
#warning fix this
    /*
     [[AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:jsonURL]
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
     NSLog(@"%@", JSON);
     NSLog(@"%@", JSON[@"token"]);
     } failure:nil] start];
     */
    

    
    return YES;
}

- (BOOL) submitWindowByWindowID:(NSInteger)windowID {
    NSString *token = [self.userDefaults valueForKey:@"token"];
    
    NSString *path = @"~blt/sweetreward/php/userActionTrigger.php";
    NSString *requestString = [NSString stringWithFormat:@"%@/%@?window_id=%d&token=%@", SRAPIdomain, path, windowID, token];
    NSLog(@"%@", requestString);
    NSURL *jsonURL = [NSURL URLWithString:requestString];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"%@", jsonString);
    
    NSDictionary *result = [jsonString objectFromJSONString];
    NSLog(@"window result: %@", result);

    return YES;
}

@end
