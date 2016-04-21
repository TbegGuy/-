//
//  MapView.h
//  mapPushDown
//
//  Created by CYY033 on 16/4/21.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#define color(r,g,b)   [UIColor colorWithRed:(r/255.0) green:g/255.0 blue:(b/255.0) alpha:1.0]

@interface MapView : UIView
{
    CGPoint point;
    int     transfrom_y;
    int     begin_y;
}
@property (nonatomic, strong) UILabel *Up_lable;
@property (nonatomic, strong) UIView  *back_view;
@property (nonatomic, strong) UIImageView *bottomView;


@property (nonatomic, strong) UIView      *updown_view;
@property (nonatomic, strong) UIImageView *up_image;
@property (nonatomic, strong) UIImageView *down_image;
-(void)show;
- (void)setupMoving;
- (NSMutableAttributedString *)getAttrIbutedStrdistance:(NSString *)text1 state:(NSString *)text2;
- (NSMutableAttributedString *)getAttrIbutedStrinfo:(NSArray *)textType state:(NSArray *)contend;
@end
