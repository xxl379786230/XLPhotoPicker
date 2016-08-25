//
//  XLPhoto.m
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import "XLPhoto.h"
#import "XLConst.h"

@interface XLPhoto ()

@property (nonatomic, strong)UIButton *deleteButton;
@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation XLPhoto
#pragma mark - init
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - private method
- (void)commonInit{
    _imageViewCornerRadius = kXLPhotoImageViewCornerRadius;
    _cancelButtonImage = [UIImage imageNamed:@"cha"];
    
    [self addSubview:self.imageView];
    [self addSubview:self.deleteButton];
}

- (void)setUpFrame{
    self.imageView.frame = CGRectMake(kXLPhotoMargin, kXLPhotoMargin, self.frame.size.width - kXLPhotoMargin * 2, self.frame.size.height - kXLPhotoMargin * 2);
    
    CGPoint deleteCenter = CGPointMake(CGRectGetMaxX(self.imageView.frame), CGRectGetMinY(self.imageView.frame));
    self.deleteButton.frame = CGRectMake(0, 0, self.frame.size.width * kXLPhotoImageDeleteButtonSizeScale, self.frame.size.height * kXLPhotoImageDeleteButtonSizeScale);
    self.deleteButton.center = deleteCenter;
}

#pragma mark - Event Response
- (void)deleteAction:(id)sender{
    if (self.photoClickBlock) {
        self.photoClickBlock(self);
    }
}


#pragma mark - Setter and Getter
- (void)setImage:(UIImage *)image{
    _image = image;
    
    //设置frame，
    [self setUpFrame];
    self.imageView.image = image;
}

- (void)setImageViewCornerRadius:(CGFloat)imageViewCornerRadius{
    _imageViewCornerRadius = imageViewCornerRadius;
    self.imageView.layer.cornerRadius = imageViewCornerRadius;
}

- (void)setCancelButtonImage:(UIImage *)cancelButtonImage{
    _cancelButtonImage = cancelButtonImage;
    [self.deleteButton setImage:_cancelButtonImage forState:UIControlStateNormal];
    [self.deleteButton setImage:_cancelButtonImage forState:UIControlStateHighlighted];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.layer.cornerRadius = _imageViewCornerRadius;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:_cancelButtonImage forState:UIControlStateNormal];
        [_deleteButton setImage:_cancelButtonImage forState:UIControlStateHighlighted];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
