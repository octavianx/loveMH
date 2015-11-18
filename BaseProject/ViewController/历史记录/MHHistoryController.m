//
//  MHHistoryController.m
//  MH漫画控
//
//  Created by mis on 15/11/5.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHHistoryController.h"
#import "MHHistoryCell.h"
#import "MHDetaiViewController.h"
#import "RESideMenu.h"
@interface MHHistoryController ()<SWTableViewCellDelegate>
@property(nonatomic,strong)NSString *historyPath;

@property(nonatomic,strong)NSMutableArray *historyArr;
@end

@implementation MHHistoryController
-(NSString *)historyPath {
    if (!_historyPath) {
        _historyPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.plist"];
    }
    return _historyPath;
}
- (NSMutableArray *)historyArr {
    if (!_historyArr) {
        _historyArr = [NSMutableArray arrayWithContentsOfFile:self.historyPath];
    }
    return _historyArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置导航栏
    [self setNavBar];

    
    self.tableView.tableFooterView = [UIView new];
    
   // [self.tableView registerClass:[MHHistoryCell class] forCellReuseIdentifier:@"cell"];
}
- (void)setNavBar {
    self.title = @"历史记录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_back_hov"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}
- (void)back {
  [self.sideMenuViewController presentLeftMenuViewController];
}
- (void)viewWillAppear:(BOOL)animated {
    _historyArr = [NSMutableArray arrayWithContentsOfFile:self.historyPath];
    [self.tableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.historyArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[MHHistoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    cell.delegate = self;
    cell.dic = self.historyArr[indexPath.row];
    
    return cell;
}
#pragma mark --- SWCellDelegate
//同一时间只能有一个删除按钮
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    if (index == 0) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        [self.historyArr removeObjectAtIndex:indexPath.row];
        [self.historyArr writeToFile:self.historyPath atomically:YES];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MHDetaiViewController *detailVC = [MHDetaiViewController new];
    detailVC.ID = [self.historyArr[indexPath.row][@"id"] integerValue];
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
