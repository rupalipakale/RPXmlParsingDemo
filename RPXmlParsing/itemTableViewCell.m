//
//  itemTableViewCell.m
//  RPXmlParsing
//
//  Created by Student P_07 on 16/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "itemTableViewCell.h"

@implementation itemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadData:(NSMutableDictionary *)dict
{
    [self setRoundImage];
    self.lblTitle.text=[dict valueForKey:@"title"];
    self.lblLink.text=[dict valueForKey:@"link"];
    NSString *urlToImage=[dict valueForKey:@"image"];
    [self getImage:urlToImage];
}

-(void)setRoundImage
{
    self.imgViewItem.layer.cornerRadius=self.imgViewItem.frame.size.width/2;
    self.imgViewItem.clipsToBounds=YES;
}

-(void)getImage:(NSString *)stringImage
{
    dispatch_queue_t thread=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    dispatch_async(thread, ^{
        
        NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:stringImage]];
        UIImage *urlImage=[UIImage imageWithData:imageData];
        if(urlImage)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imgViewItem.image=urlImage;
            });
        }
    });

}
@end
