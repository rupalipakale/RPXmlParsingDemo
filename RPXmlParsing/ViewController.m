//
//  ViewController.m
//  RPXmlParsing
//
//  Created by Student P_07 on 16/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ViewController.h"
#import "itemTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self showActivityIndicator];
    
    
    [self parseXml];
    [self loadDataonTable];
    
}

-(void)loadDataonTable
{
    if(itemArray.count>0)
    {
        self.title=@"Item list";
        dispatch_async(dispatch_get_main_queue(), ^{

        [_itemTableView reloadData];
        });
        
    }
    else
    {
        [self showAlertwithTitle:@"Error" andMsg:@""];
    }
    [_tableViewActivityIndicator stopAnimating];
}

-(void)parseXml
{
    NSString *strUrl=@"http://www.rediff.com/rss/sslide.xml";
    NSURL *url=[NSURL URLWithString:strUrl];
    
    NSXMLParser *parser=[[NSXMLParser alloc]initWithContentsOfURL:url];
    parser.delegate=self;
    [parser parse];
}

//NSXmlParser Delegetes
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    if([elementName isEqualToString:@"channel"])
    {
        itemArray=[[NSMutableArray alloc]init];
    }
    else if ([elementName isEqualToString:@"item"])
    {
        itemDictionary=[[NSMutableDictionary alloc]init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    if([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"link"] || [elementName isEqualToString:@"image"])
       {
        [itemDictionary setObject:mutString forKey:elementName];
       }
    else if ([elementName isEqualToString:@"item"])
    {
        [itemArray addObject:itemDictionary];
    }
    
    mutString=nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    mutString=[[NSMutableString alloc]initWithString:string];
}

-(void)showActivityIndicator
{
    self.tableViewActivityIndicator=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.tableViewActivityIndicator.color=[UIColor blueColor];
    self.tableViewActivityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
    self.tableViewActivityIndicator.center=self.view.center;
    [self.tableViewActivityIndicator setHidesWhenStopped:YES];
    [self.tableViewActivityIndicator startAnimating];
    [self.view addSubview:self.tableViewActivityIndicator];
}
-(void)showAlertwithTitle:(NSString *)title andMsg:(NSString *)message
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


//Tableview Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    itemTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    if(cell==nil)
    {
        cell=[[itemTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
    }
    
    [cell loadData:[itemArray objectAtIndex:indexPath.row]];
    
    return cell;
}
//Table view Delegate methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex=indexPath;
    [self performSegueWithIdentifier:@"PushToSecond" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"PushToSecond"])
    {
        DetailViewController *detailViewController=[segue destinationViewController];
        itemTableViewCell *cell=[_itemTableView cellForRowAtIndexPath:selectedIndex];
        detailViewController.stringTitle=cell.lblTitle.text;
        detailViewController.stringLink=cell.lblLink.text;
        detailViewController.detailImage=cell.imgViewItem.image;
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
