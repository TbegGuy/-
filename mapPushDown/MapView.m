//
//  MapView.m
//  mapPushDown
//
//  Created by CYY033 on 16/4/21.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import "MapView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MapView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bottomView];
        [self addSubview:self.back_view];
        [_back_view addSubview:self.updown_view];
        [_updown_view addSubview:self.Up_lable];
        [_updown_view addSubview:self.up_image];
        [_updown_view addSubview:self.down_image];
        
        [self dwMakeBottomRoundCornerWithRadius:6];
        
        
    }
    
    return self;
}

- (UIView *)back_view{
    if (!_back_view) {
        _back_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
        _back_view.backgroundColor = [UIColor whiteColor];
        _back_view.userInteractionEnabled = YES;
        UIPanGestureRecognizer *moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector (moveAction:)];
        [moveRecognizer setCancelsTouchesInView:NO];
        [_back_view addGestureRecognizer:moveRecognizer];
    }
    return _back_view;
    
}
- (UIImageView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _bottomView.image = [UIImage imageNamed:@"4011862843057398391.jpg"];
    }
    return _bottomView;
}
- (UIView *)updown_view{
    if (!_updown_view) {
        _updown_view = [[UIView alloc] initWithFrame:CGRectMake(0,self.frame.size.height - 60 , self.frame.size.width, 60)];
        _updown_view.backgroundColor = color(242, 242, 242);
    }
    return _updown_view;
}
- (UILabel *)Up_lable{
    if (!_Up_lable) {
        _Up_lable = [[UILabel alloc] initWithFrame:CGRectMake(0,  15, self.frame.size.width, 20)];
        _Up_lable.text     = @"向上划动查看地图";
        _Up_lable.font     = [UIFont systemFontOfSize:13];
        _Up_lable.textColor  = UIColorFromRGB(0x333333);
        _Up_lable.textAlignment = 1;
        _Up_lable.numberOfLines = 2;
    }
    return _Up_lable;
}
- (UIImageView *)up_image{
    if (!_up_image) {
        _up_image = [[UIImageView alloc] initWithFrame:CGRectMake(_back_view.frame.size.width/2 - 14 , 6, 27, 9)];
        _up_image.image = [UIImage imageNamed:@"icon_arrowUp"];
    }
    return _up_image;
}
- (UIImageView *)down_image{
    if (!_down_image) {
        _down_image = [[UIImageView alloc] initWithFrame:CGRectMake(_back_view.frame.size.width/2 - 14 , CGRectGetMaxY(_Up_lable.frame) +5, 27, 9)];
        _down_image.image = [UIImage imageNamed:@"icon_arrowDown"];
        _down_image.hidden = YES;
    }
    return _down_image;
}







//手势
- (void)moveAction:(UIPanGestureRecognizer *)gr{
    if ([gr state] == UIGestureRecognizerStateBegan) {
        point = _back_view.frame.origin;
        transfrom_y = 0;
        begin_y     = 0;
    }
    if ([gr state] == UIGestureRecognizerStateChanged)
    {
        CGPoint translation = [gr translationInView:_back_view];
        transfrom_y = transfrom_y + translation.y;
        begin_y     = translation.y;
        CGRect rect = _back_view.frame;
        //        NSLog(@"%f he %f",rect.origin.y , translation.y);
        //        NSLog(@"%d",begin_y);
        if (rect.origin.y + translation.y >  -_back_view.frame.size.height  + 50 && rect.origin.y  +translation.y < 0) {
            _back_view.frame = CGRectMake(0, rect.origin.y  + translation.y, rect.size.width, rect.size.height);
            [gr setTranslation:CGPointZero inView:_back_view];
            
        }else if (rect.origin.y + translation.y <  -_back_view.frame.size.height  + 50 ){
            _back_view.frame = CGRectMake(0, -_back_view.frame.size.height  + 50 , rect.size.width, rect.size.height);
        }
        else if (rect.origin.y  +translation.y > 0){
            _back_view.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
        }
    }
    
    if ([gr state] == UIGestureRecognizerStateEnded) {
        NSLog(@"%f",point.y);
        if (point.y < -_back_view.frame.size.height/2) {
            if (transfrom_y > 0 && begin_y > 0) {
                [self setupMoving];
                NSLog(@"1");
            }else{
                [self setUpStopMoving];
                NSLog(@"2");
            }
        }else{
            if (transfrom_y < 0 && begin_y < 0 ) {
                [self setUpStopMoving];
                NSLog(@"3");
                
            }else{
                [self setupMoving];
                NSLog(@"4");
                
            }
        }
        
    }
    
}
- (void)setupMoving{
    [UIView animateWithDuration:0.3f animations:^{
        _Up_lable.text     = @"向上滑动查看地图";
        
        _up_image.hidden = NO;
        _down_image.hidden = YES;
        _back_view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    }];
    
    
}
- (void)setUpStopMoving{
    [UIView animateWithDuration:0.3f animations:^{
        _Up_lable.text     = @"向下滑动查看信息";
        
        _up_image.hidden = YES;
        _down_image.hidden = NO;
        _back_view.frame = CGRectMake(0, -_back_view.frame.size.height  + 50 , self.frame.size.width, self.frame.size.height);
    }];
    
    
}





//绘边
- (void)dwMakeBottomRoundCornerWithRadius:(CGFloat)radius
{
    CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height - 20);
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width - radius, size.height);
    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, M_PI/2, 0.0, YES);
    CGPathAddLineToPoint(path, NULL, size.width  , radius);
    CGPathAddArc(path, NULL, size.width - radius, radius, radius,0, M_PI, YES);
    CGPathAddLineToPoint(path, NULL, size.width -radius  , 0.0);
    CGPathAddLineToPoint(path, NULL, radius , 0.0);
    CGPathAddArc(path, NULL,  radius, radius, radius,0, M_PI, YES);
    CGPathAddLineToPoint(path, NULL, 0.0 , radius);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height - radius);
    CGPathAddArc(path, NULL, radius, size.height - radius, radius, M_PI, M_PI/2, YES);
    CGPathAddLineToPoint(path, NULL, size.width/2 - 10, size.height );
    CGPathAddLineToPoint(path, NULL, size.width/2, size.height+ 10 );
    CGPathAddLineToPoint(path, NULL, size.width/2 + 10, size.height );
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    self.layer.mask = shapeLayer;
}


-(void)show
{
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.08f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:nil];
    }];
}
//获得可变字符串
- (NSMutableAttributedString *)getAttrIbutedStrdistance:(NSString *)text1 state:(NSString *)text2{
    NSInteger len1 = [text1 length];
    NSInteger len2 = [text2 length];
    NSString *all_str = [NSString stringWithFormat:@"%@\n%@",text1,text2];
    NSMutableAttributedString * attributed_str = [[NSMutableAttributedString alloc]initWithString:all_str];
    [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:19] range:NSMakeRange(0, len1)];
    [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(len1+1, len2)];
    
    [attributed_str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xffffff) range:NSMakeRange(0, len1)];
    [attributed_str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xffffff) range:NSMakeRange(len1+1, len2)];
    NSLog(@"%@",attributed_str);
    return attributed_str;
}
//获得可变字符串
- (NSMutableAttributedString *)getAttrIbutedStrinfo:(NSArray *)textType state:(NSArray *)contend{
    NSString *str = @"";
    for (int i = 0; i < [textType count]; i++) {
        str = [NSString stringWithFormat:@"%@%@  %@\n",str,[textType objectAtIndex:i],[contend objectAtIndex:i]];
    }
    
    NSMutableAttributedString * attributed_str = [[NSMutableAttributedString alloc]initWithString:str];
    float  length = 0;
    for (int i = 0; i < [textType count]; i++) {
        NSString *leng_str = [textType objectAtIndex:i];
        length =   length +leng_str.length;
        
        [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(length - leng_str.length, leng_str.length)];
        [attributed_str addAttribute:NSForegroundColorAttributeName value:color(167, 167, 167) range:NSMakeRange(length - leng_str.length, leng_str.length)];
        
        
        NSString *leng_str2 = [NSString stringWithFormat:@"  %@\n",[contend objectAtIndex:i]];
        length = length + leng_str2.length;
        [attributed_str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(length - leng_str2.length, leng_str2.length)];
        [attributed_str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(length - leng_str2.length, leng_str2.length)];
        
    }
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    //设置行距
    [style setLineSpacing:10.0f];
    [attributed_str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attributed_str.length)];
    
    NSLog(@"%@",attributed_str);
    return attributed_str;
}

- (CGSize)getLableHeight:(float)cpmyemyWidth fontType:(UIFont *)font lable:(NSString *)textlable{
    NSDictionary *attritute = @{NSFontAttributeName:font};
    CGSize retSize = [textlable boundingRectWithSize:CGSizeMake(cpmyemyWidth, 800)
                                             options: (NSStringDrawingTruncatesLastVisibleLine
                                                       | NSStringDrawingUsesLineFragmentOrigin
                                                       | NSStringDrawingUsesFontLeading)
                                          attributes:attritute context:nil].size;
    
    return retSize;
}

@end
