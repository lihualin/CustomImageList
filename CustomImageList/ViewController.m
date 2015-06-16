//
//  ViewController.m
//  CustomImageList
//
//  Created by lihualin on 15/6/15.
//  Copyright (c) 2015年 lihualin. All rights reserved.
//

#import "ViewController.h"
#import "CustomImageList.h"
@interface ViewController ()
{
    NSArray * imgs;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CustomImageList * imgListView = [[[NSBundle mainBundle] loadNibNamed:@"CustomImageList" owner:self options:nil] objectAtIndex:0];
    imgs = @[@"0.jpg",@"1.jpg",@"10.jpg",@"15.jpg"];
    CustomImageList * imgListView = [[CustomImageList alloc]initWithFrame:CGRectMake(40, 200, 240, 50) withImages:imgs];
    [self.view addSubview:imgListView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
