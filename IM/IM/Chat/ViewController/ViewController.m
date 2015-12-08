//
//  ViewController.m
//  IM
//
//  Created by 李艳楠 on 15/12/4.
//  Copyright © 2015年 南南南. All rights reserved.
//

#import "ViewController.h"
#import "UserChatCell.h"
#import "UUChatCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITextView *txt4Chat;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *img4Background;
@property (weak, nonatomic) IBOutlet UIView *view4Chat;
- (IBAction)action4SendChat:(UIButton *)sender;

@property (nonatomic, strong) NSMutableArray *chatArray;

@end

@implementation ViewController

// lazyload
- (NSMutableArray *)chatArray{
    if (!_chatArray) {
        _chatArray = [NSMutableArray array];
    }
    return _chatArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
// 隐藏分割线 和垂直滚轴
    self.tableView.separatorStyle = NO;
    self.tableView.showsVerticalScrollIndicator = NO;

    [self.tableView registerNib:[UINib nibWithNibName:@"UserChatCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"UUChatCell" bundle:nil] forCellReuseIdentifier:@"UUCell"];
}
#pragma mark --sendChat

- (IBAction)action4SendChat:(UIButton *)sender {

    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",_txt4Chat.text];
    // 用户拼接添加
    [string appendString:@"user"];
    NSLog(@"%@",string);
    
    AVUser *user = [AVUser currentUser];
    [self.chatArray addObject:string];
    [user addObject:_chatArray forKey:@"ChatArray"];
    
    NSLog(@"用户发送:%ld",_chatArray.count);
    
    [self.tableView reloadData];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addUUAnswer) userInfo:nil repeats:NO];
    
    
}
// 自动回复事件
- (void)addUUAnswer{
   // _CellState = NO;
    NSMutableString *string = [NSMutableString stringWithString:@"小U已经收到了哦~"];
    [string appendString:@"UUUU"];
    [_chatArray addObject:string];
    NSLog(@"自动回复后:%ld",_chatArray.count);
    [self.tableView reloadData];
    
    [_timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- TableViewDelegate, TableViewDataSource
// section count
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 自适应高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *string = _chatArray[indexPath.row];
    
    return [self TextHight:string] +10;
}
// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _chatArray.count;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableString *string = [NSMutableString stringWithString:_chatArray[indexPath.row]];
    NSInteger length = [string length];

    if ([[string substringWithRange:NSMakeRange(length - 4, 4)] isEqualToString:@"user"]) {
        [string deleteCharactersInRange:NSMakeRange(length-4, 4)];
        NSLog(@"%@",string);
        // UserCell
        UserChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.lab4UserChat.frame = CGRectMake(5, 5, kWidth * 0.8, [self TextHight:string]);
        cell.lab4UserChat.text = string;
        cell.selectionStyle = NO;
        
        // 聊天始终显示底部
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatArray.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        
        
        return cell;
    }else{
        [string deleteCharactersInRange:NSMakeRange(length-4, 4)];
        NSLog(@"%@",string);
        // UUCell
        UUChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UUCell"];
        
        // 聊天始终显示底部
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_chatArray.count - 1 inSection:0] atScrollPosition:(UITableViewScrollPositionBottom) animated:YES];
        cell.backgroundColor = [UIColor clearColor];
        cell.lab4Chat.frame = CGRectMake(5, 5, kWidth * 0.8, [self TextHight:string]);
        cell.lab4Chat.text = string;
        cell.selectionStyle = NO;
        
        
        return cell;
        
    }
}

// 计算fram.Height
- (CGFloat)TextHight:(NSString *)textString{
    CGRect rect = [textString boundingRectWithSize:CGSizeMake(kWidth *0.8, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    
    return rect.size.height;
}


@end
