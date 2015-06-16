//
//  CustomImageList.m
//  CustomImageList
//
//  Created by lihualin on 15/6/15.
//  Copyright (c) 2015年 lihualin. All rights reserved.
//

#import "CustomImageList.h"
#define  window [UIApplication sharedApplication].keyWindow
#define  imgViewWidth [UIScreen mainScreen].bounds.size.width
#define  imgViewHeight [UIScreen mainScreen].bounds.size.height

@implementation CustomImageList
@synthesize imagesList;
-(instancetype)initWithFrame:(CGRect)frame withImages:(NSArray *)images
{
    self = [super init];
    if (self) {
        self.frame = frame;
        imagesList = images;
        defalutRect= frame;
        [self createImagesView:images];
    }
    return self;
}

-(void)createImagesView :(NSArray *)imgs
{
    for (int i = 0; i < imgs.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[imgs objectAtIndex:i]]];
        imageView.frame = CGRectMake((defalutRect.size.height+10)*i, 0, defalutRect.size.height, defalutRect.size.height);
        imageView.tag = 10+i;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImg:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
  
}

//放大图片
-(void)enlargeImg:(id)tap
{
    self.frame = CGRectMake(0, 0, imgViewWidth, window.frame.size.height);
    self.backgroundColor = [UIColor blackColor];
    UIImageView * selectedImgView = (UIImageView *)[tap view];
    
    if (titleLabel == nil) {
        titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 20, imgViewWidth, 20)];
        titleLabel.text = [NSString stringWithFormat:@"%d/%d",selectedImgView.tag-10+1,imagesList.count];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
    }
    [self addSubview:titleLabel];
    
    for (int i = 0; i < imagesList.count; i++) {
        UIImageView * imgView= (UIImageView *)[self viewWithTag:10+i];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = NO;
        imgView.frame = CGRectMake(imgViewWidth*i-(selectedImgView.tag-10)*imgViewWidth, titleLabel.frame.size.height+titleLabel.frame.origin.y+10, imgViewWidth, imgViewHeight-30*2);
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ReductionSmallImg:)];
        [imgView addGestureRecognizer:tap];
    
         UISwipeGestureRecognizer * swipeLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [imgView addGestureRecognizer:swipeLeft];
        UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
        [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [imgView addGestureRecognizer:swipeRight];
        
    }
    
}
//滑动事件
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe
{
    UIImageView * selectedImgView = (UIImageView *)[swipe view];
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        //左滑
        if (selectedImgView.tag - 10 == imagesList.count-1) {
            return;
        }
        titleLabel.text = [NSString stringWithFormat:@"%d/%d",selectedImgView.tag-10+2,imagesList.count];
        for (int i = 0; i < imagesList.count; i++) {
            UIImageView * imgView= (UIImageView *)[self viewWithTag:10+i];
           imgView.frame = CGRectMake(imgView.frame.origin.x-imgViewWidth, imgView.frame.origin.y, imgViewWidth, imgView.frame.size.height);
        }
    }else{
        //右滑
        if (selectedImgView.tag - 10 == 0) {
            return;
        }
         titleLabel.text = [NSString stringWithFormat:@"%d/%d",selectedImgView.tag-10,imagesList.count];
        for (int i = 0; i < imagesList.count; i++) {
            UIImageView * imgView= (UIImageView *)[self viewWithTag:10+i];
            imgView.frame = CGRectMake(imgView.frame.origin.x+imgViewWidth, imgView.frame.origin.y, imgViewWidth, imgView.frame.size.height);
        }
    }
}

//还原图片
-(void)ReductionSmallImg:(id)tap
{
    self.frame = defalutRect;
    self.backgroundColor = [UIColor clearColor];
    [titleLabel removeFromSuperview];
    titleLabel = nil;
    for (int i = 0; i < imagesList.count; i++) {
        UIImageView * imgView= (UIImageView *)[self viewWithTag:10+i];
        imgView.frame = CGRectMake((defalutRect.size.height+10)*i, 0, defalutRect.size.height, defalutRect.size.height);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(enlargeImg:)];
        [imgView addGestureRecognizer:tap];
    }
}
@end
