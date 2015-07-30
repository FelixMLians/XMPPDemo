//
//  AppDelegate.h
//  XMPPDemo
//
//  Created by YuanRong on 15/7/30.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPP.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    XMPPStream *_xmppStream;
    NSString *password;
    BOOL isOpen;   // xmppStream 是否开着
}

@property (strong, nonatomic) XMPPStream *xmppStream;

@property (strong, nonatomic) UIWindow *window;

- (BOOL)connect;
- (void)disconnect;

- (void)setupStream;
- (void)goOnline;
- (void)goOffline;

@end

