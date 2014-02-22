//
//  FFViewController.m
//  FFⅩⅣiConCreator
//
//  Created by 山本洸希 on 2014/02/22.
//  Copyright (c) 2014年 keito5656. All rights reserved.
//

#import "FFViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface FFViewController ()

@end

@implementation FFViewController

- (UIImage *)createImage:(UIImage *)image_b
{
    UIGraphicsBeginImageContext(CGSizeMake(128, 128));
    NSString *fileName = [NSString stringWithFormat:@"ffxiv_twf%d.png",_company];

    UIImage *image_a = [UIImage imageNamed:fileName];

    [image_b drawInRect:CGRectMake(0, 0, 128, 128)];
    [image_a drawInRect:CGRectMake(0, 0, 128, 128)];
    UIImage *image_c = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image_c;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger count = arc4random_uniform(25);
    NSString *fileName = [NSString stringWithFormat:@"ffxiv_twi%d.png",count];
    UIImage *image_b = [UIImage imageNamed:fileName];

    
    UIImage *image_c;
    image_c = [self createImage:image_b];
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:100];
    imageView.image = image_c;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    if (indexPath.row == 0) {
        UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
        return cell;
    }
   
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *filename = [NSString stringWithFormat:@"ffxiv_twi%d.png", indexPath.row];
    UIImage *image = [UIImage imageNamed:filename];
    UIImageView *imageView = (UIImageView*)[cell viewWithTag:100];
    imageView.image = image;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 26;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:^{
            
        }];
    }
    
    
    NSString *filename = [NSString stringWithFormat:@"ffxiv_twi%d.png", indexPath.row];
    UIImage *image = [UIImage imageNamed:filename];
    UIImage *createdImage = [self createImage:image];
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:100];
    imageView.image = createdImage;
}


- (IBAction)save:(id)sender {
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:100];

    [self saveImageToPhotosAlbum:imageView.image];
}

- (void)saveImageToPhotosAlbum:(UIImage*)_image {
    
    BOOL isPhotoAccessEnable = [self isPhotoAccessEnableWithIsShowAlert:YES];
    
    /////// フォトアルバムに保存 ///////
    if (isPhotoAccessEnable) {
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library writeImageToSavedPhotosAlbum:_image.CGImage
                                  orientation:(ALAssetOrientation)_image.imageOrientation
                              completionBlock:
         ^(NSURL *assetURL, NSError *error){
             NSLog(@"URL:%@", assetURL);
             NSLog(@"error:%@", error);
             
             ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
             
             if (status == ALAuthorizationStatusDenied) {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@"エラー"
                                           message:@"写真へのアクセスが許可されていません。\n設定 > 一般 > 機能制限で許可してください。"
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                 [alertView show];
             } else {
                 UIAlertView *alertView = [[UIAlertView alloc]
                                           initWithTitle:@""
                                           message:@"フォトアルバムへ保存しました。"
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                 [alertView show];
             }
         }];        
    }
}

- (BOOL)isPhotoAccessEnableWithIsShowAlert:(BOOL)_isShowAlert {
    // このアプリの写真への認証状態を取得する
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    BOOL isAuthorization = NO;
    
    switch (status) {
        case ALAuthorizationStatusAuthorized: // 写真へのアクセスが許可されている
            isAuthorization = YES;
            break;
        case ALAuthorizationStatusNotDetermined: // 写真へのアクセスを許可するか選択されていない
            isAuthorization = YES; // 許可されるかわからないがYESにしておく
            break;
        case ALAuthorizationStatusRestricted: // 設定 > 一般 > 機能制限で利用が制限されている
        {
            isAuthorization = NO;
            if (_isShowAlert) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"エラー"
                                          message:@"写真へのアクセスが許可されていません。\n設定 > 一般 > 機能制限で許可してください。"
                                          delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
            
        case ALAuthorizationStatusDenied: // 設定 > プライバシー > 写真で利用が制限されている
        {
            isAuthorization = NO;
            if (_isShowAlert) {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"エラー"
                                          message:@"写真へのアクセスが許可されていません。\n設定 > プライバシー > 写真で許可してください。"
                                          delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
            
        default:
            break;
    }
    return isAuthorization;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    UIImage *createdImage = [self createImage:image];
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:100];
    imageView.image = createdImage;
    
}


@end
