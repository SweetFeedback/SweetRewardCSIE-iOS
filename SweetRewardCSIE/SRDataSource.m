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
NSString * const SRUserToken = @"token";

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
        _isLogin = NO;
    }

    
    return self;
}

- (BOOL)createOrLoginUserAccountByAccount:(NSString *)account andPassword:(NSString *)password {
    NSString *token = [self.userDefaults valueForKey:SRUserToken];
    
    if(token != nil) {
        return YES;
    }
    NSLog(@"GO");
    
    //NSString *path = @"~blt/sweetreward/php/mobile/createNewUser.php";
    NSString *path = @"~blt/sweetreward/php/mobile/createNewUser.php";
    NSString *requestString = [NSString stringWithFormat:@"%@/%@?account=%@&password=%@", SRAPIdomain, path, account, password];
    NSURL *jsonURL = [NSURL URLWithString:requestString];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"jsonstring %@", jsonString);
    /*
    // maybe the user account already exists, so try login
    if(jsonString == nil) {
        path = @"~blt/sweetreward/php/mobile/verifyUser.php";
        requestString = [NSString stringWithFormat:@"%@/%@?account=%@&password=%@", SRAPIdomain, path, account, password];
        jsonURL = [NSURL URLWithString:requestString];
        
        jsonString = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
        
        NSLog(@"try to verify user");
        if(jsonString == nil);
            return NO;
    }*/
    
    NSDictionary *result = [jsonString objectFromJSONString];
    NSLog(@"%@", result);
    token = result[@"token"];
    
    [self.userDefaults setValue:token forKey:@"token"];
    [self.userDefaults synchronize];
    
    self.isLogin = YES;
    
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

- (BOOL)logoutUserAccount {
    NSLog(@"logout");
    self.isLogin = NO;
    return YES;
}

- (BOOL)submitWindowByWindowID:(NSInteger)windowID andAction:(NSInteger)action{
    NSString *token = [self.userDefaults valueForKey:@"token"];
    
    NSString *path = @"~blt/sweetreward/php/userActionTrigger.php";
    NSString *requestString = [NSString stringWithFormat:@"%@/%@?window_id=%d&token=%@&action=%d", SRAPIdomain, path, windowID, token, action];
    //NSLog(@"%@", requestString);
    NSURL *jsonURL = [NSURL URLWithString:requestString];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfURL:jsonURL encoding:NSUTF8StringEncoding error:nil];
    
    //NSLog(@"%@", jsonString);
    
    NSDictionary *result = [jsonString objectFromJSONString];
    //NSLog(@"window result: %@", result);
    if(result == nil) {
        return YES;
    } else {
        return NO;
    }
    return YES;
}

@end
