//
//  XLPhotoPicker.h
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,XLPhotoPickerDisplayType){
    XLPhotoPickerDisplayTypeSingle,     //单行显示
    XLPhotoPickerDisplayTypeMultiple    //多行显示
};

@class XLPhotoPicker,XLPhoto;
@protocol XLPhotoPickerDelegate <NSObject>

@optional
- (void)photoPicker:(XLPhotoPicker *)photoPicker didPickerHeightChanged:(CGFloat)pickerHeight;
- (void)photoPicker:(XLPhotoPicker *)photoPicker didClickAddButton:(UIButton *)addButton;
- (void)photoPicker:(XLPhotoPicker *)photoPicker didSelectPhoto:(XLPhoto *)photo;

@end

@interface XLPhotoPicker : UIScrollView
/** 显示方式（默认多行显示） */
@property (nonatomic, assign)XLPhotoPickerDisplayType displayType;
/** 是否动画 */
@property (nonatomic, assign)BOOL animated;
/** 最大图片张数限制(默认为9张) */
@property (nonatomic, assign)NSInteger maxImageLimitCount;
/** 每行最多显示的张数（默认3张） */
@property (nonatomic, assign)NSInteger maxRowCount;
/** 行间距 （默认0）*/
@property (nonatomic, assign)CGFloat rowMargin;
/** (0,0)元素距离左边的距离（默认10） */
@property (nonatomic, assign)CGFloat rowMarginX;
/** 列间距 （默认0）*/
@property (nonatomic, assign)CGFloat columnMargin;
/** (0,0)元素距离顶部的距离（默认是10） */
@property (nonatomic, assign)CGFloat columnMarginY;
/** 每个元素的size，如果不设置，默认会根据当前屏幕宽度自动计算宽和高 */
@property (nonatomic, assign)CGFloat photoSize;
/** 添加按钮的图片 */
@property (nonatomic, strong)UIImage *addButtonImage;

@property (nonatomic, weak)id<XLPhotoPickerDelegate> pickerDelegate;

#pragma mark - public
- (void)addImages:(NSArray *)images;

- (void)reloadData;

- (NSArray *)photos;
@end
