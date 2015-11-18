//
//  MHCollectionController.m
//  MH漫画控
//
//  Created by mis on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHCollectionController.h"
#import "MHDetaiViewController.h"
#import "MHCollectionCell.h"
#import "RESideMenu.h"

@interface MHCollectionController ()<SWTableViewCellDelegate>

@property(nonatomic,strong)NSString *collectionPath;

@property(nonatomic,strong)NSMutableArray *collectionArr;

@end

@implementation MHCollectionController
- (NSString *)collectionPath {
    if (!_collectionPath) {
        _collectionPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _collectionPath = [_collectionPath stringByAppendingPathComponent:@"collection.plist"];
       // DDLogVerbose(@"收藏plist的路径是:%@",_collectionPath);
    }
    return _collectionPath;
}
- (NSMutableArray *)collectionArr {
    [self collectionPath];
    if(!_collectionArr) {
        _collectionArr = [NSMutableArray arrayWithContentsOfFile:_collectionPath];
    }
    return _collectionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置导航栏
    [self setNavBar];
    
    self.tableView.tableFooterView = [UIView new];
    //  [self.tableView registerClass:[MHCollectionCell class] forCellReuseIdentifier:@"cell"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _collectionArr = [NSMutableArray arrayWithContentsOfFile:_collectionPath];

    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
- (void)setNavBar {
    self.title = @"收藏列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_back_hov"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}
- (void)back {
  [self.sideMenuViewController presentLeftMenuViewController];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.collectionArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[MHCollectionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
    cell.dic = self.collectionArr[indexPath.row];
     
    cell.delegate = self;
    
    
    return cell;
}
//检测右侧划出的按钮哪个被点击
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
//    DDLogVerbose(@"indexPath:%ld",indexPath.row);
    
    [self.collectionArr removeObjectAtIndex:indexPath.row];
 
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    [self.collectionArr writeToFile:self.collectionPath atomically:YES];
    
   
}
//同一时间只能划出一个带按钮的
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MHDetaiViewController *detailVC = [MHDetaiViewController new];
    
    detailVC.ID = [self.collectionArr[indexPath.row][@"id"] integerValue];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
