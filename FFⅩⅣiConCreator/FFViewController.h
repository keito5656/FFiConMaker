//
//  FFViewController.h
//  FFⅩⅣiConCreator
//
//  Created by 山本洸希 on 2014/02/22.
//  Copyright (c) 2014年 keito5656. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SOUJACompanyType = 1,
    KOKKACompanyType,
    FUMETSUCompanyType,
}CompanyType;

@interface FFViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic)CompanyType company;
- (IBAction)save:(id)sender;
@end
