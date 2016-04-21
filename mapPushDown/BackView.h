//
//  BackView.h
//  mapPushDown
//
//  Created by CYY033 on 16/4/21.
//  Copyright © 2016年 LYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapView.h"



@interface BackView : UIView{
    int timer;
    NSDate *newDate;
}

@property (nonatomic, strong)MapView *lycNewOrderView;
@property (nonatomic, strong)UIButton        *timeAction_btn;
@property (nonatomic, strong)UIButton        *ignore_btn;
@property(nonatomic  , strong) NSTimer *connectTimer;

@end
