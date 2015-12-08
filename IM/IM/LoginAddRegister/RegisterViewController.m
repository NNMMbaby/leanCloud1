//
//  RegisterViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt4PassWord;

- (IBAction)action4Register:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)action4Register:(id)sender {
    NSLog(@"action4Register");
    AVUser *user = [AVUser user];
    user.username = _txt4UserName.text;
    user.password = _txt4PassWord.text;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //Register success
            NSLog(@"Register success");
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_ISLOGINED];
            [[NSUserDefaults standardUserDefaults] setObject:self.txt4UserName.text forKey:KEY_USERNAME];
            [[NSUserDefaults standardUserDefaults] setObject:self.txt4PassWord.text forKey:KEY_PASSWORD];
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    

    
    
    
    
    
    
    
    
//    
//    AVObject *registerObject = [AVObject objectWithClassName:@"Register"];
//    [registerObject setObject:_txt4UserName.text forKey:@"name"];
//    [registerObject setObject:_txt4PassWord.text forKey:@"pwd"];
//    // 保存到leanCloud
//    [registerObject save];
//    // 后台保存
//    [registerObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            NSLog(@"保存成功");
//            
//            //保存ID？
//            NSString *string = [registerObject objectForKey:@"objectid"];
//            NSLog(@"string:%@",string);
//        } else {
//            NSLog(@"保存 post 时出错：%@",error);
//        }
//    }];
//    
//
//    
//    AVObject *post = [AVObject objectWithClassName:@"Post"];
//    [post setObject:@"每个 Objective-C 程序员必备的 8 个开发工具" forKey:@"content"];
//    [post setObject:@"LeanCloud官方客服" forKey:@"pubUser"];
//    [post setObject:[NSNumber numberWithInt:1435541999] forKey:@"pubTimestamp"];
//    [post save];
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
