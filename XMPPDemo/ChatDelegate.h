//
//  ChatDelegate.h
//  XMPPDemo
//
//  Created by YuanRong on 15/7/31.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ChatDelegate <NSObject>

- (void)newBuddyOnline:(NSString *)buddyName;
- (void)buddyWentOffline:(NSString *)buddyName;
- (void)didDisconnect;

@end
