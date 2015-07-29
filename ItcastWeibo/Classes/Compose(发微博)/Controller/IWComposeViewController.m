//
//  IWComposeViewController.m
//  ItcastWeibo
//
//  Created by yz on 14/11/15.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWComposeViewController.h"
#import "IWTextView.h"
#import "IWComposeToolBar.h"
#import "IWComposePhotosView.h"

#import "AFNetworking.h"

#import "IWAccount.h"
#import "IWAccountTool.h"

#import "MBProgressHUD+MJ.h"

#import "IWComposeTool.h"

@interface IWComposeViewController ()<UITextViewDelegate,IWComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, weak) IWTextView *textView;
@property (nonatomic, weak) UIButton *composeBtn;
@property (nonatomic, weak) IWComposeToolBar *toolBar;
@property (nonatomic, weak) IWComposePhotosView *photosView;
@end

@implementation IWComposeViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setUpNaVBar];
    
    // 添加textView
    [self setUpTextView];
    
    // 监听文本内容改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:_textView];

    // 添加工具条
    [self setUpToolBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 添加相册
    [self setUpPhotosView];
    
}
- (void)keyboardWillHide:(NSNotification *)notifacation
{
    _toolBar.transform = CGAffineTransformIdentity;
}
- (void)keyboardWillShow:(NSNotification *)notifacation
{
    CGRect keyboardF = [notifacation.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);

}
- (void)textChange
{
    
    _textView.hidePlaceHolder = _textView.text.length != 0;
    _composeBtn.enabled =  _textView.text.length != 0;
}

- (void)setUpToolBar
{
    IWComposeToolBar *toolBar = [[IWComposeToolBar alloc] init];
    _toolBar = toolBar;
    toolBar.delegate = self;
    CGFloat toolBarW = self.view.width;
    CGFloat toolBarH = 35;
    CGFloat toolBarY = self.view.height - toolBarH;
    toolBar.frame = CGRectMake(0, toolBarY, toolBarW, toolBarH);
   
    [self.view addSubview:toolBar];
}

- (void)toolBar:(IWComposeToolBar *)toolBar didClickType:(IWComposeToolBarButtonType)type
{
    switch (type) {
        case IWComposeToolBarButtonTypeCamera:// 进入相册
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:picker animated:YES completion:nil];
            }
            break;
        case IWComposeToolBarButtonTypeMention:
            
            break;
        case IWComposeToolBarButtonTypeTrend:
            
            break;
        case IWComposeToolBarButtonTypeEmoticon:
            
            break;
        case IWComposeToolBarButtonTypeKeyboard:
            
            break;
        default:
            break;
    }

}
// 选中一个照片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [_photosView addImage:image];
    
    _composeBtn.enabled = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setUpPhotosView
{
    IWComposePhotosView *photosView = [[IWComposePhotosView alloc] initWithFrame:_textView.bounds];
    photosView.y = 70;
    _photosView = photosView;
    [_textView addSubview:photosView];
}

- (void)setUpTextView
{
    IWTextView *textView = [[IWTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    textView.placeHolder = @"分享新鲜事...";

    [self.view addSubview:textView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)setUpNaVBar
{
    UIBarButtonItem *cancleItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancle)];
    
    self.navigationItem.leftBarButtonItem = cancleItem;
    
    UIButton *composeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [composeBtn setTitle:@"发送" forState:UIControlStateNormal];
    _composeBtn = composeBtn;
    [composeBtn sizeToFit];
    [composeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [composeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [composeBtn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *composeItem = [[UIBarButtonItem alloc] initWithCustomView:composeBtn];
    composeBtn.enabled = NO;
    
    self.navigationItem.rightBarButtonItem = composeItem;

}

- (void)compose
{
    
    if (_photosView.images.count) { // 有图片
        [self composeImage];
    }else{ // 没有图片
        [self composeWithoutImage];
    }
}

- (void)composeImage
{
    [MBProgressHUD showMessage:@"正在发送。。。"];
    UIImage *image = [_photosView.images firstObject];
    NSString *status = _textView.text.length?_textView.text:@"分享图片";
    
    [IWComposeTool composeWithImage:image status:status success:^{
        [MBProgressHUD hideHUD];
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"%@",error.description);
    }];
    
  }
- (void)composeWithoutImage
{
    [IWComposeTool composeWithSatausText:_textView.text success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        
    }];
}

- (void)cancle
{

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
