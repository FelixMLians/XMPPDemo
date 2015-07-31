//
//  ChatViewController.m
//  XMPPDemo
//
//  Created by YuanRong on 15/7/30.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import "ChatViewController.h"
#import "AppDelegate.h"
#import "MessageDelegate.h"

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, MessageDelegate>

@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;

@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.rowHeight = 100;
    self.chatTableView.tableFooterView = [[UIView alloc] init];
    
    self.messages = [[NSMutableArray alloc] init];
    
    AppDelegate *del = [self appDelegate];
    del.messageDelegate = self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.messages count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"msgCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.messages.count > indexPath.row) {
    [dict setDictionary:[self.messages objectAtIndex:indexPath.row]];
    }
    
    cell.textLabel.text = [dict objectForKey:@"msg"];
    cell.detailTextLabel.text = [dict objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (IBAction)sendMessage:(id)sender {
    NSString *message = self.chatTextField.text;
    if (message.length > 0) {
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:message];
        
        NSXMLElement *mes = [NSXMLElement elementWithName:@"message"];
        [mes addAttributeWithName:@"type" stringValue:@"chat"];
        [mes addAttributeWithName:@"to" stringValue:self.chatWithUser];
        [mes addAttributeWithName:@"from" stringValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"userid"]];
        //组合
        [mes addChild:body];
        
        [[self xmppStream] sendElement:mes];
        
        self.chatTextField.text = @"";
        [self.chatTextField resignFirstResponder];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:message forKey:@"msg"];
        [dict setObject:@"you" forKey:@"sender"];
        
        [self.messages addObject:dict];
        [self.chatTableView reloadData];
    }
}

#pragma mark - 

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (XMPPStream *)xmppStream {
    return [[self appDelegate] xmppStream];
}

- (void)newMessageReceived:(NSDictionary *)messageContent {
    
    [self.messages addObject:messageContent];
    NSLog(@"messages：%@",self.messages);
    [self.chatTableView reloadData];
}
@end
