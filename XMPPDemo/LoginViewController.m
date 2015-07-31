//
//  LoginViewController.m
//  XMPPDemo
//
//  Created by YuanRong on 15/7/30.
//  Copyright (c) 2015年 深圳市源镕科技有限公司. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *serverTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.serverTextField.text = @"yuanrongdeimac.local";
}

- (IBAction)login:(id)sender {
    if ([self validateWithUser:self.userTextField.text andPass:self.passwordTextField.text andServer:self.serverTextField.text]) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.userTextField.text forKey:@"userid"];
        [defaults setObject:self.passwordTextField.text forKey:@"pass"];
        [defaults setObject:self.serverTextField.text forKey:@"server"];
        //保存
        [defaults synchronize];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入用户名，密码和服务器" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL)validateWithUser:(NSString *)userText andPass:(NSString *)passText andServer:(NSString *)serverText{
    
    if (userText.length > 0 && passText.length > 0 && serverText.length > 0) {
        return YES;
    }
    
    return NO;
}

@end
