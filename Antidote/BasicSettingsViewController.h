//
//  BasicSettingsViewController.h
//  Antidote
//
//  Created by Dmitry Vorobyov on 31.01.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tableStructure;

- (instancetype)initWithTitle:(NSString *)title
                   tableStyle:(UITableViewStyle)tableStyle
               tableStructure:(NSArray *)tableStructure;

- (NSIndexPath *)indexPathForCellType:(NSInteger)type;
- (NSInteger)cellTypeForIndexPath:(NSIndexPath *)indexPath;

#pragma mark -  Methods to override

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)configureTableView;
- (void)registerCellsForTableView;

@end
