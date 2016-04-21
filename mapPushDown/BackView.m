//
//  BackView.m
//  mapPushDown
//
//  Created by CYY033 on 16/4/21.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "BackView.h"
#define colorH(r,g,b,h)   [UIColor colorWithRed:(r/255.0) green:g/255.0 blue:(b/255.0) alpha:h]
#define GCD_DELAY_AFTER(time, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC), dispatch_get_main_queue(), block)

@implementation BackView


- (instancetype)initWithFrame:(CGRect)frame{
    
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = colorH(1, 1, 1, 0.7);
        [self addSubview:self.lycNewOrderView];
        [self addSubview:self.timeAction_btn];
        [self addSubview:self.ignore_btn];
        [self timeAction];
    }
    return self;
}

- (MapView *)lycNewOrderView{
    if (!_lycNewOrderView) {
        
        NSInteger top = 84;
        _lycNewOrderView  = [[MapView alloc] initWithFrame:CGRectMake(15, top , self.frame.size.width - 30, 400)];

        
        
    }
    return _lycNewOrderView;
}
- (UIButton *)timeAction_btn{
    if (!_timeAction_btn) {
        _timeAction_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeAction_btn.frame = CGRectMake(self.frame.size.width/2-40, CGRectGetMaxY(_lycNewOrderView.frame) , 80, 80);
        _timeAction_btn.titleLabel.numberOfLines = 0;
        [_timeAction_btn setBackgroundColor:color(253, 96, 30)];
        _timeAction_btn.tag = 100;
        [self radiusView:_timeAction_btn radius:40];
        [_timeAction_btn setAttributedTitle:[self getAttrIbutedStr:@"抢 单\n90秒" font:19] forState:0];
        
    }
    return _timeAction_btn;
}
- (UIButton *)ignore_btn{
    if (!_ignore_btn) {
        _ignore_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _ignore_btn.frame = CGRectMake(self.frame.size.width - 70, CGRectGetMaxY(_lycNewOrderView.frame) + 20 , 50, 50);
        _ignore_btn.titleLabel.numberOfLines = 0;
        [_ignore_btn setBackgroundColor:colorH(10, 10, 10, 0.7)];
        NSMutableAttributedString * attributed_str = [[NSMutableAttributedString alloc]initWithString:@"忽略\n此单"];
        [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributed_str.length)];
        [attributed_str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attributed_str.length)];
        [_ignore_btn setAttributedTitle:attributed_str forState:0];
        [self radiusView:_ignore_btn radius:25];
    }
    return _ignore_btn;
}
//获得可变字符串
- (NSMutableAttributedString *)getAttrIbutedStr:(NSString *)all_str font:(float)font{
    NSMutableAttributedString * attributed_str = [[NSMutableAttributedString alloc]initWithString:all_str];
    [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, all_str.length)];
    
    [attributed_str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, all_str.length)];
    NSLog(@"%@",attributed_str);
    return attributed_str;
}

//画圆角
- (void)radiusView:(UIView *)view radius:(float)radius{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = radius;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [[UIColor clearColor] CGColor];
}
#pragma mark 倒计时
- (void)timeAction{
    timer = 90;
    ;
    

    [self.connectTimer invalidate];
    self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFireMethod) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
    [self.connectTimer fire];
}

- (void)timerFireMethod
{
    NSString *length = [NSString stringWithFormat:@"抢 单\n%d秒",timer];
    if (timer <= 0)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        _timeAction_btn.userInteractionEnabled = YES;
        [self removeFromSuperview];
    }else{
        timer = --timer ;
        [_timeAction_btn setAttributedTitle:[self getAttrIbutedStr:length font:19] forState:0];
        
    }
    if (timer% 10 == 0) {
    }
}
- (int)intervalSinceNow: (NSString *) theDate
{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSTimeInterval cha=now-late;
    return (int)cha;
}




// 继续执行任务
- (void)GoOnTask{
    _timeAction_btn.userInteractionEnabled = YES;
    
    [self removeFromSuperview];
}
- (void)IgnoreThisSingle{
    
    _timeAction_btn.userInteractionEnabled = YES;
    [self removeFromSuperview];
}









- (CGSize)getLableHeight:(float)cpmyemyWidth lable:(NSAttributedString *)textlable{
    CGSize retSize = [textlable boundingRectWithSize:CGSizeMake(cpmyemyWidth, 800) options:(NSStringDrawingTruncatesLastVisibleLine
                                                                                            | NSStringDrawingUsesLineFragmentOrigin
                                                                                            | NSStringDrawingUsesFontLeading)  context:nil].size;
    return retSize;
}








@end
