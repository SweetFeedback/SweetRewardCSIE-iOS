//
//  SRDataSource.h
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/13.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const SRUserToken;

@interface SRDataSource : NSObject

@property(strong, nonatomic) NSUserDefaults *userDefaults;
@property(nonatomic) BOOL isLogin;

+ (SRDataSource *)sharedSRDataSource;
- (BOOL)createOrLoginUserAccountByAccount:(NSString *)account andPassword:(NSString *)password;
- (BOOL)logoutUserAccount;
- (BOOL)submitWindowByWindowID:(NSInteger)windowID;


@end
