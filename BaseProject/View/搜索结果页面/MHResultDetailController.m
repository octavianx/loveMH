//
//  MHResultDetailController.m
//  MH漫画控
//
//  Created by mis on 15/11/3.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHResultDetailController.h"
#import "MHResultDetailViewModel.h"
#import "MHResultDetailCell.h"
#import "MHDetaiViewController.h"
@interface MHResultDetailController ()

@property (nonatomic,strong)MHResultDetailViewModel *resultDetaiVM;
@end

@implementation MHResultDetailController
- (MHResultDetailViewModel *)resultDetaiVM {
    if (!_resultDetaiVM) {
        _resultDetaiVM = [MHResultDetailViewModel new];
    }
    return _resultDetaiVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航栏
    [self configNav];
    [self.resultDetaiVM getResultsDataWithName:self.name completionHandle:^(NSError *error) {
        [self.tableView reloadData];
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"MHResultDetailCell" bundle:nil] forCellReuseIdentifier:@"Rcell"];
}
#pragma mark --- 配置导航栏
- (void)configNav {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_back_hov"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resultDetaiVM.rowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHResultDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Rcell" forIndexPath:indexPath];
    [cell.CoverImage setImageWithURL:[self.resultDetaiVM coverIconForRow:indexPath.row]];
    cell.nameLB.text = [self.resultDetaiVM nameForRow:indexPath.row];
    cell.authorLB.text = [self.resultDetaiVM authorForRow:indexPath.row];
    [cell.rightBtn setTitle:[self.resultDetaiVM buttonTitleForRow:indexPath.row] forState:UIControlStateNormal];
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MHDetaiViewController *detailVC = [[MHDetaiViewController alloc]init];
    detailVC.ID = [self.resultDetaiVM comicIDForRow:indexPath.row];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detailVC];
//    [self presentViewController:nav animated:YES completion:nil];
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
