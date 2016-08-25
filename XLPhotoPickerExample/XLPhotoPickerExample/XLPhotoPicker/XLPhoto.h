//
//  XLPhoto.h
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLPhoto;
typedef void(^XLPhotoClickBlock)(XLPhoto *photo);

@interface XLPhoto : UIControl

/** 圆角度数（默认为5） */
@property (nonatomic, assign)CGFloat imageViewCornerRadius;
/** 取消按钮图片 */
@property (nonatomic, strong)UIImage *cancelButtonImage;
/** 主图片 */
@property (nonatomic, strong)UIImage *image;

@property (nonatomic, copy)XLPhotoClickBlock photoClickBlock;

@end
