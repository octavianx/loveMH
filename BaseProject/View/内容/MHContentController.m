//
//  MHContentController.m
//  MH漫画控
//
//  Created by mis on 15/11/10.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MHContentController.h"
#import "MHContentNetManager.h"
#import "MWPhotoBrowser.h"
#import "MHContentImgaeViewModel.h"
@interface MHContentController ()<MWPhotoBrowserDelegate>
@property(nonatomic,strong)NSArray *imagesURl;
@property(nonatomic,strong)MHContentImgaeViewModel *contentVM;

@end

@implementation MHContentController
- (MHContentImgaeViewModel *)contentVM {
    if (!_contentVM) {
        _contentVM = [MHContentImgaeViewModel new];
    }
    return _contentVM;
}
- (NSArray *)imagesURl {
    if (!_imagesURl) {
        
        _imagesURl = [NSArray new];
        
    }
    return _imagesURl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"左滑"]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.contentVM getDataWith:_name chpate_id:_ID completionHandle:^(NSError *error) {
        //创建图片展示页面，Github排名最高的图片展示类控件
        MWPhotoBrowser *photoB = [[MWPhotoBrowser alloc] initWithDelegate:self];
        photoB.zoomPhotosToFill = NO;

//        //   图片展示页面不应该是当前页推出的，而应该是取代当前页面在导航控制器中的位置。
  //      NSMutableArray *naviVCs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
   //     删除掉最后一个控制器，即当前的白色控制器
     //       [naviVCs removeLastObject];
      
      //      [naviVCs addObject:photoB];
        //        //把新的控制器数组赋值给导航控制器
      //  self.navigationController.viewControllers = naviVCs;
        [self.navigationController pushViewController:photoB animated:NO];

    }];
    

}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return self.contentVM.rowNum ;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    MWPhoto *photo = [MWPhoto photoWithURL:[self.contentVM urlForRow:index]];
    
    return photo;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
