# XLPhotoPicker
用于图片选择的小控件，可分为单行选择和多行选择！

# 属性和方法
* 所有属性：
        <br>显示方式（默认多行显示)\<br>
        <br>XLPhotoPickerDisplayType displayType;\<br>
        <br> 是否动画 \<br>
        <br>BOOL animated;\<br>
        <br> 最大图片张数限制(默认为9张) \<br>
        <br>NSInteger maxImageLimitCount\<br>
        <br> 每行最多显示的张数（默认3张） \<br>
        <br>NSInteger maxRowCount;\<br>
        <br> 行间距 （默认0）\<br>
        <br>CGFloat rowMargin\<br>
        <br> (0,0)元素距离左边的距离（默认10） \<br>
        <br>CGFloat rowMarginX;\<br>
        <br> 列间距 （默认0）\<br>
        <br>CGFloat columnMargin;\<br>
        <br> (0,0)元素距离顶部的距离（默认是10） \<br>
        <br>CGFloat columnMarginY\<br>
        <br> 每个元素的size，如果不设置，默认会根据当前屏幕宽度自动计算宽和高 \<br>
        <br>CGFloat photoSize\<br>
        <br> 添加按钮的图片 \<br>
        <br>UIImage *addButtonImage;\<br>
* Delegate:
        <br> 返回当前视图的高度 \<br>
        <br>- (void)photoPicker:(XLPhotoPicker *)photoPicker didPickerHeightChanged:(CGFloat)pickerHeight;\<br>
        <br> 点击添加按钮回调 \<br>
        <br>- (void)photoPicker:(XLPhotoPicker *)photoPicker didClickAddButton:(UIButton *)addButton;\<br>
        <br> 单个图片点击事件 \<br>
        <br>- (void)photoPicker:(XLPhotoPicker *)photoPicker didSelectPhoto:(XLPhoto *)photo;\<br>

# 用法
    具体用法，看demo即可，非常简单的例子。