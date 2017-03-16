//
//  DetailViewController.h
//  RPXmlParsing
//
//  Created by Student P_07 on 16/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *labelLink;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic)  NSString *stringLink;
@property (strong, nonatomic) NSString *stringTitle;
@property (strong, nonatomic) UIImage *detailImage;

@end
