//
//  ChatViewController.m
//  XMPPDemo
//
//  Created by YuanRong on 15/7/30.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *chatTextField;
@property (weak, nonatomic) IBOutlet UITableView *chatTableView;
@property (copy, nonatomic) NSString *chatWithUser;
@property (strong, nonatomic) NSMutableArray *messages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
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
    
    NSMutableDictionary *dict = [self.messages objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict objectForKey:@"msg"];
    cell.detailTextLabel.text = [dict objectForKey:@"sender"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (IBAction)sendMessage:(id)sender {
}

@end
