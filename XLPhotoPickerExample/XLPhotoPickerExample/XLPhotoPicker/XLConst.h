//
//  XLConst.h
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - XLPhoto
extern NSInteger const kXLPhotoImageViewCornerRadius;
extern float const kXLPhotoImageDeleteButtonSizeScale;
extern NSInteger const kXLPhotoMargin;

#pragma mark - XLPhotoPicker
extern NSInteger const kXLPhotoPickerMaxImageLimitCount;
extern NSInteger const kXLPhotoPickerMaxRowCount;
extern NSInteger const kXLPhotoPickerRowMargin;
extern NSInteger const kXLPhotoPickerColumnMargin;

extern NSTimeInterval const kXLPhotoPickerDismissAnimatedDuration;
extern CGFloat const kXLPhotoPickerDismissAnimatedScaled;
extern NSInteger const kXLPhotoPickerZero;

@interface XLConst : NSObject
@end
