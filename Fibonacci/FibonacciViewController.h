//
//  FibonacciViewController.h
//  Fibonacci
//
//  Created by Dhivya on 5/25/20.
//  Copyright © 2020 Dhivya. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FibonacciViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,weak)IBOutlet UITableView *listView;
@property(nonatomic,weak)IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain)NSMutableArray *filteredArray;
@property(nonatomic,retain)NSMutableArray *fetchedArray;

@end

NS_ASSUME_NONNULL_END
