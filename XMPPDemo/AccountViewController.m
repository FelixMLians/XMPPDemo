//
//  AccountViewController.m
//  XMPPDemo
//
//  Created by YuanRong on 15/7/30.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"
#import "ChatDelegate.h"
#import "AppDelegate.h"
#import "ChatViewController.h"

@interface AccountViewController ()<UITableViewDataSource, UITableViewDelegate, ChatDelegate>

@property (weak, nonatomic) IBOutlet UITableView *accountTableView;

@property (strong, nonatomic) NSMutableArray *onlineUsers;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accountTableView.delegate = self;
    self.accountTableView.dataSource = self;
    
    self.onlineUsers = [[NSMutableArray alloc] init];
    
    AppDelegate *del = [self appDelegate];
    del.chatDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *login = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    if (login) {
        if ([[self appDelegate] connect]) {
//            NSLog(@"show buddy list %@", self.onlineUsers);
        }
    }
    else {
        
    }
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.onlineUsers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"userCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.onlineUsers objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *chatUserName = (NSString *)[self.onlineUsers objectAtIndex:indexPath.row];
    ChatViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatVC"];
    vc.chatWithUser = chatUserName;
    [self.navigationController pushViewController:vc animated:YES];}

- (IBAction)accountClick:(UIBarButtonItem *)sender {
    UINavigationController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginNavVC"];
    [self presentViewController:vc animated:YES completion:NULL];
}

#pragma mark - ChatDelegate

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
    return [[self appDelegate] xmppStream];
}

- (void)newBuddyOnline:(NSString *)buddyName {
//    NSLog(@"%@",buddyName);
    
    if (![self.onlineUsers containsObject:buddyName]) {
        [self.onlineUsers addObject:buddyName];
        [self.accountTableView reloadData];
    }
}

- (void)buddyWentOffline:(NSString *)buddyName {
    [self.onlineUsers removeObject:buddyName];
    [self.accountTableView reloadData];
}

@end
