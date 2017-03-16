//
//  ViewController.h
//  RPXmlParsing
//
//  Created by Student P_07 on 16/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *itemArray;
    NSMutableDictionary *itemDictionary;
    NSMutableString *mutString;
    NSIndexPath *selectedIndex;
}
@property (strong,nonatomic)UIActivityIndicatorView *tableViewActivityIndicator;
@property (strong, nonatomic) IBOutlet UITableView *itemTableView;

@end

