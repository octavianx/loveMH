//
//  MHDetaiViewController.m
//  MH漫画控
//
//  Created by mis on 15/10/27.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHDetaiViewController.h"
#import "MHDetaiHeaderView.h"
#import "MHDetailViewModel.h"
#import "MHScreenshotView.h"
#import "MHDetailDescView.h"
#import "MHMarksView.h"
#import "MHRecommendViewModel.h"
#import "MHRecommendCell.h"
#import "MHGirlHeader.h"
#import "UMSocial.h"
#import "MHContentViewModel.h"
#import "MHContentController.h"
#import "MHContentModel.h"

@interface MHDetaiViewController ()<MHScreenshotViewChickDelegate>
/**
 *  headerVM
 */
@property(nonatomic,strong)MHDetailViewModel *HeaderVM;


/**
 *  RecommendVM 最底下的相关推荐部分
 */
@property(nonatomic,strong)MHRecommendViewModel *recommendVM;

@property(nonatomic)CGRect descRect;

@property (nonatomic) CGFloat height;


/**
 *  存放历史记录的plist路径
 */
@property(nonatomic,strong)NSString *historyPath;

/**
 *  从plist读取历史记录的数组
 */
@property(nonatomic,strong)NSMutableArray *historyArr;

/**
 *  剧集的VM
 */
@property (nonatomic,strong)MHContentViewModel *contentVM;
/**
 *  剧集tableView
 */
@property (nonatomic,strong)UITableView *jujiTableView;



@end

@implementation MHDetaiViewController
- (UITableView *)jujiTableView {
    if (!_jujiTableView) {
        _jujiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 225, 375, 380) style:UITableViewStylePlain];
        [self.view addSubview:_jujiTableView];
        _jujiTableView.dataSource = self;
        _jujiTableView.delegate = self;
        _jujiTableView.hidden = YES;
        [_jujiTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Jcell"];
        self.jujiTableView.tableFooterView = [UIView new];
    }
    return _jujiTableView;
}
- (MHContentViewModel *)contentVM {
    
    if (!_contentVM) {
        _contentVM = [MHContentViewModel new];
        
    }
    return _contentVM;
}
- (MHRecommendViewModel *)recommendVM {
    
    if (!_recommendVM) {
        _recommendVM = [MHRecommendViewModel new];
    }
    return _recommendVM;
}
- (MHDetailViewModel *)HeaderVM {
    
    if (!_HeaderVM) {
        _HeaderVM = [MHDetailViewModel new];
    }
    return _HeaderVM;
}
- (NSString *)historyPath {
    
    if (!_historyPath) {
        _historyPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.plist"];
        DDLogVerbose(@"历史记录文件的Plist路径 ：%@",self.historyPath);
    }
    return _historyPath;
}
- (NSMutableArray *)historyArr {
    
    if (!_historyArr) {
        _historyArr = [NSMutableArray arrayWithContentsOfFile:self.historyPath];
        if (_historyArr == nil) {
            _historyArr = [NSMutableArray new];
        }
    }
    return _historyArr;
}
//去除左边的分界线
kRemoveCellSeparator

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.tableView.allowsSelection = NO;
  //self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //设置导航栏
    [self setNavBar];
    
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MHGirlHeader headerWithRefreshingBlock:^{
        
        [self.HeaderVM getdataWith:self.ID CompeltionHandel:^(NSError *error) {
          
            if (self.HeaderVM.object.resources.count == 0) {
//                [self showErrorMsg:@"暂无资源"];
//                [self.tableView.header endRefreshing];
                [self.HeaderVM getOtherObjectWith:self.ID CompeltionHandel:^(NSError *error) {
                    [self getDescRect];
                    //刷新数据
                    [self.tableView reloadData];
                    //添加历史记录
                    [self addHistory];
                    
                    [self.tableView.mj_header endRefreshing];
             
                }];
            }else {
                
                //获取中间文字部分的高度
                [self getDescRect];
                //添加历史记录
                [self addHistory];
                //刷新数据
                [self.tableView reloadData];
                
                [self.tableView.mj_header endRefreshing];
            }
        
        
                
          
            
        }];
        [self.recommendVM getRecommendWithID:self.ID CompletionHandle:^(NSError *error) {
            [self.contentVM getContentdataWithName:@"迷你无头" completionHandle:^(NSError *error) {
                
                [self.tableView reloadData];
            }];
        }];
        
     
    }];

    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[MHRecommendCell class] forCellReuseIdentifier:@"Rcell"];

    
}
#pragma mark --- 代理的点击事件
-(void)jujiBtnClick:(MHScreenshotView *)controller withHiden:(BOOL)ishiden {
      DDLogVerbose(@"代理执行了");
    self.jujiTableView.hidden = ishiden;
    [self.tableView setScrollEnabled:ishiden];
    
    [self.jujiTableView reloadData];
}
//- (void)MHScreentableView:(UITableViewCell *)cell didSelectAtIndexPath:(NSIndexPath *)indexPath {
//    DDLogVerbose(@"%ld",indexPath.row);
//    MHChapterlistModel *model = self.contentVM.dataArr[indexPath.row];
//
//    MHContentController *vc = [MHContentController new];
//    vc.name = @"黑色五叶草";
//    vc.ID = model.ID;
//    [self presentViewController:vc animated:YES completion:nil];
//}

#pragma mark ---加入历史记录
- (void)addHistory {
    //如果history的plist文件不存在，则创建
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:self.historyPath]) {
        [fileManager createFileAtPath:self.historyPath contents:nil attributes:nil];
    }
    
    //创建history字典
    NSMutableDictionary  *dic = [NSMutableDictionary new];
    MHDetailObjectModel *object = self.HeaderVM.object;
    [dic setValue:object.comic_id.stringValue forKey:@"id"];
    [dic setValue:object.comic_name forKey:@"name"];
    [dic setValue:object.comic_cover forKey:@"cover"];
    [dic setValue:object.comic_author forKey:@"author"];
    //如果已经存在历史列表中，则移动到第一位，否则则在历史记录中添加该记录
    NSInteger index = -1;
    for (NSDictionary *history in self.historyArr) {
        if ([history[@"id"] isEqualToString:object.comic_id.stringValue]) {
            index = [self.historyArr indexOfObject:history];
            break;
        }
    }
    if (index != -1) {
        
        [self.historyArr removeObjectAtIndex:index];
    }

    [self.historyArr insertObject:dic atIndex:0];
    
    //写入historyPlist文件中
    [self.historyArr writeToFile:self.historyPath atomically:YES];

}
#pragma mark --- 获取文字的高度
- (void)getDescRect {
    MHDetailObjectModel *model = self.HeaderVM.object;
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.text = model.desc;
    CGRect rectOfText = CGRectMake(0, 0, kWindowW-10, 999);
    self.descRect = [label textRectForBounds:rectOfText limitedToNumberOfLines:0];

    
}
#pragma mark ------设置导航栏以及点击事件响应
- (void)setNavBar {
    self.title = @"漫画详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_back_hov"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbutton_share_hov"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"bg_clear"]];
    
}
//设置状态栏的显示 状态0位深色 1为亮色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return 1;
}
#pragma mark --- 分享模块
- (void)share {
    NSLog(@"分享");
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"563ca68be0f55af80100249b"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                       delegate:nil];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView  == self.tableView) {
        return 4;
    }else  {
         return self.contentVM.rowNum;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UITableViewCell  *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
 

    if (tableView == self.jujiTableView) {
        UITableViewCell *jcell = [tableView dequeueReusableCellWithIdentifier:@"Jcell"];
        jcell.textLabel.text = [self.contentVM titleForRow:indexPath.row];;
        return jcell;
    }
    if (tableView == self.tableView) {
     
        if (indexPath.row == 0) {
            MHScreenshotView *view = [MHScreenshotView screenView];
            view.screenshot = self.HeaderVM.screenhot;
            view.delegte = self;
            view.chapters = self.contentVM.dataArr;
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            return  cell;
            
        }else if(indexPath.row == 1) {
            MHDetailObjectModel *model = self.HeaderVM.object;
            MHDetailDescView *descView = [MHDetailDescView DetailDesc];
            descView.DescLB.text = model.desc;
            self.descRect = descView.DescLB.frame;
            [cell.contentView addSubview:descView];
            [descView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            return cell;
        }else if(indexPath.row == 2) {
            NSArray *marks = self.HeaderVM.marks;
            MHMarksView *maskView = [[MHMarksView alloc]initWithFrame:CGRectMake(0, 0, kWindowW, 60)];
            
            maskView.marks = marks;
            [cell.contentView addSubview:maskView];
            
            return cell;
        }else {
            MHRecommendCell *ReCell = [tableView dequeueReusableCellWithIdentifier:@"Rcell"];
            if (ReCell == nil) {
                ReCell = [[MHRecommendCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Rcell"];
            }
            ReCell.recommends = self.recommendVM.dataArr;
            return ReCell;
        }
    }

    return cell;
}

#pragma mark --- tableView的HeaderView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == self.jujiTableView) {
        return 0;
    }
    return 170;
}
#pragma mark ----设置tableView的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MHDetaiHeaderView *headerView = [MHDetaiHeaderView headerView];
    
    headerView.object = self.HeaderVM.object;
    
    return  headerView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        switch (indexPath.row) {
           case 0: {
                //图片不存在
                if (self.HeaderVM.screenhot.count == 0) {
                    return 70;
                }
                return 220;
            }
                
            case 1: {  if (self.height > self.descRect.size.height) {
                    return self.height + 70;
                }else {
                    self.height = self.descRect.size.height;
                    return self.height + 70 ;
                }
                
            }
                
            case 2:  {  if (self.HeaderVM.marks.count == 0) {
                    return 0;
                }
                    return 50;
            }
                
            case 3: return 180;
                
        }

    } else {
        
        return 44;
    }
    return 100;
}
#pragma mark --- jujiTableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.jujiTableView) {
        [self.jujiTableView deselectRowAtIndexPath:indexPath animated:YES];
        MHContentController *vc = [MHContentController new];
        vc.ID = [self.contentVM idForRow:indexPath.row];
        vc.name = @"迷你无头";
        //self.tableView.tableHeaderView.hidden = YES;
        [self.navigationController pushViewController:vc animated:YES];
        DDLogVerbose(@"%ld",indexPath.row);
    }
}
#pragma mark --- 在退出界面后，取消网络请求
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.HeaderVM.dataTask cancel];
    [self.recommendVM.dataTask cancel];
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
