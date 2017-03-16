//
//  itemTableViewCell.h
//  RPXmlParsing
//
//  Created by Student P_07 on 16/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface itemTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblLink;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewItem;
-(void)loadData:(NSMutableDictionary *)dict;
@end
