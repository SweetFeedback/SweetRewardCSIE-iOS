//
//  SRDataSource.h
//  SweetRewardCSIE
//
//  Created by Che-Wei Liang on 12/12/13.
//  Copyright (c) 2012年 agents. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRDataSource : NSObject

@property(strong, nonatomic) NSUserDefaults *userDefaults;
@property(weak, nonatomic) NSString *userToken;

+ (SRDataSource *)sharedSRDataSource;
- (BOOL)submitUserAccountByAccount:(NSString *)account andPassword:(NSString *)password;
- (BOOL)submitWindowByWindowID:(NSInteger)windowID;


@end
