//
//  RootViewController.m
//  XLPhotoPickerExample
//
//  Created by Argo Zhang on 16/8/25.
//  Copyright © 2016年 Argo Zhang. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片选择";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"单行";
    }else{
        cell.textLabel.text = @"多行";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ViewController *vc = [[ViewController alloc] init];
    if (indexPath.row == 0) {
        vc.type = XLPhotoPickerDisplayTypeSingle;
    }else{
        vc.type = XLPhotoPickerDisplayTypeMultiple;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
