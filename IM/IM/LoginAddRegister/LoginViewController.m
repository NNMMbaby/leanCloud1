//
//  LoginViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

//控件
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt4PassWord;

//事件
- (IBAction)action4Login:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    




}

//- (void)selectKeys:(NSArray *)keys;



- (IBAction)action4Login:(id)sender {
    
    
    [AVUser logInWithUsernameInBackground:self.txt4UserName.text password:self.txt4PassWord.text block:^(AVUser *user, NSError *error) {
        if (user) {
            //Login success
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KEY_ISLOGINED];
            [[NSUserDefaults standardUserDefaults] setObject:self.txt4UserName.text forKey:KEY_USERNAME];
            [[NSUserDefaults standardUserDefaults] setObject:self.txt4PassWord.text forKey:KEY_PASSWORD];
            NSLog(@"Login success");

            //此页消失
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];

    
    
    
    
    /*
    AVQuery *query = [AVQuery queryWithClassName:@"Post"];
    [query getObjectInBackgroundWithId:@"56623d4a00b0d1dba289c518"
                                 block:^(AVObject *post, NSError *error){
             if (!error) {
                 // get 请求成功完成，结果存在 post 实例中
                 NSLog(@"The name was: %@", [post objectForKey:@"name"]);
                 
             } else {
                 // 请求失败，输出错误信息
                 NSLog(@"Error: %@ %@", error, [error userInfo]);
             }
      }];
 
    
    NSLog(@"action4Login");
    AVQuery *query = [AVQuery queryWithClassName:@"Register"];
    NSArray * array = @[@"objectid"];
    
    AVObject *reg = [query ]
    
    AVObject *post = [query getObjectWithId:@"56623d4a00b0d1dba289c518"];
    

    int timestamp = [[post objectForKey:@"pubTimestamp"] intValue];
    NSString *userName = [post objectForKey:@"name"];
    NSString *userPwd = [post objectForKey:@"pwd"];
    NSString *content = post[@"content"];


    NSString *objectId = post.objectId;
    NSDate *updatedAt = post.updatedAt;
    NSDate *createdAt = post.createdAt;
    
    if ([_txt4UserName.text isEqualToString:userName] && [_txt4PassWord.text isEqualToString:userPwd]) {
        NSLog(@"登陆成功");
    }else{
        NSLog(@"登陆失败");
    }
    
    [myObject refresh];// 刷新数据
*/
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
