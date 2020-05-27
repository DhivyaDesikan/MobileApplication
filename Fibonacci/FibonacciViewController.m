//
//  FibonacciViewController.m
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import "FibonacciViewController.h"
#import "FibonacciHelper.h"
#import "CacheController.h"

@interface FibonacciViewController ()
{
    FibonacciHelper * fibonacciHelper;
    
}

@end

@implementation FibonacciViewController

@synthesize filteredArray;
@synthesize fetchedArray;
@synthesize listView;
@synthesize  searchBar;
int searchIndex = 0;
BOOL isFiltered;
const int MAXVALUE = 2500;
int key = 0;
int ui_count;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fibonacciHelper = [[FibonacciHelper alloc]init];
    filteredArray = [NSMutableArray new];
    fetchedArray = [NSMutableArray new];
    listView.dataSource = self;
    listView.delegate = self;
    self.searchBar.delegate = self;
    ui_count = [[[NSBundle mainBundle]objectForInfoDictionaryKey:@"UI_COUNT"]intValue];

    if(![fibonacciHelper getFibboSeriesforKey:key])
      fetchedArray =  [fibonacciHelper fetchFibonacci:key];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([fetchedArray count] == 0)
        fetchedArray =  [fibonacciHelper fetchFibonacci:key];
}


-(void) refreshTable
{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listView reloadData];
        });
       
}

/* TableView Delegate Methods */

/* WillDisplayCell Delegate Method - Cache loaded to UI on table scroll */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowTrigger = ui_count/2;
    if((indexPath.row + rowTrigger)% ui_count == 0)
    {
           if([fetchedArray count] <= indexPath.row + rowTrigger)
           {
               int start_index = (int)indexPath.row+ rowTrigger;
               NSMutableArray *tempArray =   [fibonacciHelper fetchFibonacci:start_index];
               [fetchedArray addObjectsFromArray:tempArray];
               [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0];
           }
       }
}
    
/*CellForRowAtIndexPath*/
    
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *displayText;
    if(isFiltered)
    {
        displayText = [NSString stringWithFormat:@"%@", [filteredArray objectAtIndex:0]];
    }
    else
    {
        displayText = [NSString stringWithFormat:@"%ld. %@", indexPath.row,[fetchedArray objectAtIndex:indexPath.row]];
    }
    cell.textLabel.text = displayText;
    return cell;
}

/* NumberofRows In Tableview Delegate Method*/
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(isFiltered)
        return [filteredArray count];
    else
    {
        if([[CacheController sharedCache]getUserInputValue] >0)
            return  [[CacheController sharedCache]getUserInputValue];
        else
            return [fetchedArray count];
    }
    
}

/*SearchBar Delegate Methods*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [filteredArray removeAllObjects];
    if (searchText.length == 0)
    {
        isFiltered = false;
        [self.searchBar endEditing:YES];
    }
    else
    {
        isFiltered = true;
        searchIndex = [searchText intValue];
        if(searchIndex <= MAXVALUE && searchIndex < [fetchedArray count])
        {
            NSString *searchResult = [fetchedArray objectAtIndex:searchIndex];
            [filteredArray addObject:searchResult];
        }
    }
    [self.listView reloadData];
}
@end
