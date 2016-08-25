//
//  ViewController.m
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height;

@interface ViewController ()<XLPhotoPickerDelegate>

@property (nonatomic, weak)XLPhotoPicker *photoPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    XLPhotoPicker *photoPicker = [[XLPhotoPicker alloc] initWithFrame:CGRectMake(0, 140, self.view.frame.size.width, 100)];
    photoPicker.backgroundColor = [UIColor grayColor];
    photoPicker.maxImageLimitCount = 12;
    photoPicker.animated = YES;
    photoPicker.displayType = self.type;
    photoPicker.pickerDelegate = self;
    if (self.type == XLPhotoPickerDisplayTypeMultiple) {
        photoPicker.maxRowCount = 5;
        photoPicker.photoSize = 70;
        self.title = @"多行";
    }else{
        self.title = @"单行";
    }
    
    self.photoPicker = photoPicker;
    [self.view addSubview:photoPicker];
    
    [photoPicker reloadData];
    
}

- (void)photoPicker:(XLPhotoPicker *)photoPicker didClickAddButton:(UIButton *)addButton{
    [photoPicker addImages:@[[UIImage imageNamed:@"placeholder_head"]]];
    [photoPicker reloadData];
}

- (void)photoPicker:(XLPhotoPicker *)photoPicker didPickerHeightChanged:(CGFloat)pickerHeight{
    self.photoPicker.frame = CGRectMake(0, 140, self.view.frame.size.width,pickerHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
