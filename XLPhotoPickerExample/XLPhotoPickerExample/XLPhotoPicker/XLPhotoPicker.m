//
//  XLPhotoPicker.m
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/24.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import "XLPhotoPicker.h"
#import "XLPhoto.h"
#import "XLConst.h"

@interface XLPhotoPicker ()

@property (nonatomic, strong)UIButton *addButton;

/** 所有选择的图片 */
@property (nonatomic, strong)NSMutableArray *totalPhotos;


@property (nonatomic, assign)CGFloat contentWidthCache;
@end

@implementation XLPhotoPicker
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

#pragma mark - Public Method
- (void)reloadData{
    //移除所有子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //判断是否是多行显示
    if (_displayType == XLPhotoPickerDisplayTypeMultiple) {
        //多行显示
        [self multipleLoadData];
    }else{
        //单行显示
        [self singleLoadData];
    }
}

- (CGFloat)photoPickerHeight{
    if (_displayType == XLPhotoPickerDisplayTypeMultiple) {
        CGFloat photoH;
        NSInteger maxRowCountTmp = _maxRowCount;
        if (_photoSize > 0) {
            photoH = _photoSize;
            //判断每行是否能显示最大个数
            NSInteger possibleCount = (self.frame.size.width - _rowMarginX * 2 + _rowMargin) / (_rowMargin + _photoSize);
            maxRowCountTmp = possibleCount >= _maxRowCount ? _maxRowCount : possibleCount;
        }else{
            photoH = (self.frame.size.width - (_maxRowCount - 1) * _rowMargin - _rowMarginX * 2) / _maxRowCount;
        }
        if (self.totalPhotos.count < maxRowCountTmp) {
            return photoH + _columnMarginY * 2;
        }else{
            NSInteger count = self.totalPhotos.count;
            NSInteger rows;
            if (self.totalPhotos.count < _maxImageLimitCount) {
                count = count + 1;
            }
            rows = count % maxRowCountTmp == 0 ? count / maxRowCountTmp : count / maxRowCountTmp + 1;
            return rows * photoH + _columnMargin * (rows - 1) + _columnMarginY * 2;
        }
    }else{
        return self.frame.size.height;
    }
}

- (void)addImages:(NSArray *)images{
    [self.totalPhotos addObjectsFromArray:images];
}

#pragma mark - private method
- (void)commonInit{
    _displayType = XLPhotoPickerDisplayTypeMultiple;
    _maxImageLimitCount = kXLPhotoPickerMaxImageLimitCount;
    _maxRowCount = kXLPhotoPickerMaxRowCount;
    _rowMargin = kXLPhotoPickerZero;
    _rowMarginX = kXLPhotoPickerRowMargin;
    _columnMargin = kXLPhotoPickerZero;
    _columnMarginY = kXLPhotoPickerColumnMargin;
    _addButtonImage = [UIImage imageNamed:@"tupian"];
    _animated = NO;
    _photoSize = kXLPhotoPickerZero;
}

#pragma mark -SingleLoadData
- (void)singleLoadData{
    CGFloat photoW;
    CGFloat photoH;
    CGFloat maxWidth;
    
    //判断是否手动设置了size
    if (_photoSize > 0) {
        photoW = _photoSize;
        photoH = _photoSize;
    }else{
        //计算当前显示的视图高度
        photoH = self.frame.size.height - _columnMarginY * 2;
        photoW = photoH;
    }
    for (int i = 0; i < self.totalPhotos.count; i++) {
        
        CGFloat photoX = _rowMarginX + i * (_rowMargin + photoW);
        CGFloat photoY = _columnMarginY;
        
        XLPhoto *photo = [[XLPhoto alloc] initWithFrame:CGRectMake(photoX, photoY, photoW, photoH)];
        photo.tag = i;
        photo.image = self.totalPhotos[i];
        [photo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:photo];
        
        __weak typeof(self) weakSelf = self;
        photo.photoClickBlock = ^(XLPhoto *photo){
            if (weakSelf.animated) {
                //缩小动画
                [UIView animateWithDuration:kXLPhotoPickerDismissAnimatedDuration animations:^{
                    photo.transform = CGAffineTransformMakeScale(kXLPhotoPickerDismissAnimatedScaled, kXLPhotoPickerDismissAnimatedScaled);
                } completion:^(BOOL finished) {
                    if (finished) {
                        [weakSelf.totalPhotos removeObjectAtIndex:photo.tag];
                        [weakSelf reloadData];
                    }
                }];
            }else{
                [weakSelf.totalPhotos removeObjectAtIndex:photo.tag];
                [weakSelf reloadData];
            }
        };
    }
    //判断是否超过最大图片数量
    if (self.totalPhotos.count < _maxImageLimitCount) {
        
        CGFloat buttonX = _rowMarginX + self.totalPhotos.count * (_rowMargin + photoW);
        CGFloat buttonY = _columnMarginY;
        
        [self addSubview:self.addButton];
        self.addButton.frame = CGRectMake(buttonX + _rowMarginX, buttonY + kXLPhotoMargin, photoW - kXLPhotoMargin * 2, photoH - kXLPhotoMargin * 2);
        
        maxWidth = _rowMarginX * 2 + (self.totalPhotos.count + 1) * photoH + self.totalPhotos.count * _rowMargin;
    }else{
        maxWidth = _rowMarginX * 2 + self.totalPhotos.count * photoH + self.totalPhotos.count * _rowMargin;
    }
    //计算ScrollView的偏移量
    self.contentSize = CGSizeMake(maxWidth, self.frame.size.height);
    if (maxWidth > self.frame.size.width) {
        CGFloat offsetX = maxWidth - self.frame.size.width;
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

#pragma mark -MultipleLoadData
- (void)multipleLoadData{
    //计算当前视图的宽和高
    CGFloat photoW;
    CGFloat photoH;
    NSInteger maxRowCountTmp = _maxRowCount;
    //判断是否手动设置了size
    if (_photoSize > 0) {
        photoW = _photoSize;
        photoH = _photoSize;
        //判断每行是否能显示最大个数
        NSInteger possibleCount = (self.frame.size.width - _rowMarginX * 2 + _rowMargin) / (_rowMargin + _photoSize);
        maxRowCountTmp = possibleCount >= _maxRowCount ? _maxRowCount : possibleCount;
    }else{
        //计算当前视图的宽和高
        photoW = (self.frame.size.width - (_maxRowCount - 1) * _rowMargin - 2 * _rowMarginX) / _maxRowCount;
        photoH = photoW;
    }
    //添加子视图
    for (int i = 0; i < self.totalPhotos.count; i++) {
        NSInteger rowIndex = i / maxRowCountTmp;
        NSInteger columnIndex = i % maxRowCountTmp;
        
        CGFloat photoX = _rowMarginX + columnIndex * (_rowMargin + photoW);
        CGFloat photoY = rowIndex * (_columnMargin + photoH) + _columnMarginY;
        XLPhoto *photo = [[XLPhoto alloc] initWithFrame:CGRectMake(photoX, photoY, photoW, photoH)];
        photo.tag = i;
        photo.image = self.totalPhotos[i];
        [photo addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:photo];
        
        __weak typeof(self) weakSelf = self;
        photo.photoClickBlock = ^(XLPhoto *photo){
            if (weakSelf.animated) {
                //缩小动画
                [UIView animateWithDuration:kXLPhotoPickerDismissAnimatedDuration animations:^{
                    photo.transform = CGAffineTransformMakeScale(kXLPhotoPickerDismissAnimatedScaled, kXLPhotoPickerDismissAnimatedScaled);
                } completion:^(BOOL finished) {
                    if (finished) {
                        [weakSelf.totalPhotos removeObjectAtIndex:photo.tag];
                        [weakSelf reloadData];
                    }
                }];
            }else{
                [weakSelf.totalPhotos removeObjectAtIndex:photo.tag];
                [weakSelf reloadData];
            }
        };
    }
    
    //判断是否超过最大图片数量
    if (self.totalPhotos.count < _maxImageLimitCount) {
        NSInteger rowIndex = self.totalPhotos.count / maxRowCountTmp;
        NSInteger columnIndex = self.totalPhotos.count % maxRowCountTmp;
        
        CGFloat buttonX = _rowMarginX + columnIndex * (_rowMargin + photoW);
        CGFloat buttonY = rowIndex * (_columnMargin + photoH) + _columnMarginY;
        
        [self addSubview:self.addButton];
        self.addButton.frame = CGRectMake(buttonX + _rowMarginX, buttonY + kXLPhotoMargin, photoW - kXLPhotoMargin * 2, photoH - kXLPhotoMargin * 2);
    }
    
    if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(photoPicker:didPickerHeightChanged:)]) {
        [self.pickerDelegate photoPicker:self didPickerHeightChanged:[self photoPickerHeight]];
    }
}

#pragma mark - Event Response
- (void)buttonAction:(id)sender{
    if (sender == self.addButton) {
        if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(photoPicker:didClickAddButton:)]) {
            [self.pickerDelegate photoPicker:self didClickAddButton:sender];
        }
    }else{
        if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(photoPicker:didSelectPhoto:)]) {
            [self.pickerDelegate photoPicker:self didSelectPhoto:sender];
        }
    }
}

#pragma mark - Setter and Getter
- (NSArray *)photos{
    return [self.totalPhotos copy];
}

- (NSMutableArray *)totalPhotos{
    if (!_totalPhotos) {
        _totalPhotos = [NSMutableArray array];
    }
    return _totalPhotos;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:_addButtonImage forState:UIControlStateNormal];
        [_addButton setImage:_addButtonImage forState:UIControlStateHighlighted];
        [_addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

@end
