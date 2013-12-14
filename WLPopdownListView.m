//
//  PopdownListView.m
//  TestGDB
//
//  Created by linger on 06/12/13.
//  Copyright (c) 2013年 linger. All rights reserved.
//

#import "WLPopdownListView.h"

#define CALLBACK_ONE_PARAMETER(DELEGATE, SEL, X) if (DELEGATE && [DELEGATE respondsToSelector:@selector(SEL)]) [DELEGATE performSelector:@selector(SEL) withObject:X]

@interface WLPopdownListView()<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation WLPopdownListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self initWithView];
}

#pragma mark TableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndex = indexPath.row;
    CALLBACK_ONE_PARAMETER(self.delegate, didSelectPopDownIndex:, self);
    if (self.autoHideAfterSelect)
    {
        [self tapGuestureClick:nil];
    }
}

#pragma mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifierCell = @"ListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifierCell];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierCell] autorelease];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight)];
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.tag = 100;
        textLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:textLabel];
        [textLabel release];
    }
    
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:100];
    textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
	return cell;
}

#pragma mark PrivateFunc

- (void)initWithView
{
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self addSubview:bgView];
    [bgView release];
    
    UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGuestureClick:)];
    [tapGuesture setNumberOfTapsRequired:1];
    [tapGuesture setNumberOfTouchesRequired:1];
    [bgView addGestureRecognizer:tapGuesture];
    [tapGuesture release];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (self.cellHeight*self.dataSource.count > self.frame.size.height - 20.f)
    {
        self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20.f);
    }
    else
    {
        self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cellHeight*self.dataSource.count);
    }
    [self addSubview:self.tableView];
    [self.tableView release];
    [self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.selectIndex inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop
     ];
}

- (void)showPopdownListView:(UIView *)view
{
    [view addSubview:self];
    self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -44.f);
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, 44.f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -44.f);
    }];
}

- (void)tapGuestureClick:(UIGestureRecognizer *)gestureReg
{
    [UIView animateWithDuration:0.35 animations:^{
        self.frame = CGRectMake(0, -[UIScreen mainScreen].bounds.size.height , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -44.f);
    } completion:^(BOOL finish)
    {
        [self removeFromSuperview];
    }];
}

- (void)hidePopdownListView
{
    [self tapGuestureClick:nil];
}

@end
