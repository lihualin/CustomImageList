//
//  CustomImageList.h
//  CustomImageList
//
//  Created by lihualin on 15/6/15.
//  Copyright (c) 2015年 lihualin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageList : UIView
{
    CGRect defalutRect;
    UILabel * titleLabel;
    
}
@property (nonatomic , retain) NSArray * imagesList;
-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images;

@end
