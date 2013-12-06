//
//  PopdownListView.h
//  TestGDB
//
//  Created by linger on 06/12/13.
//  Copyright (c) 2013年 linger. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLPopdownListView;

@protocol WLPopdownListViewDelegate <NSObject>

- (void)didSelectPopDownIndex:(WLPopdownListView *)popDownListView;

@end

@interface WLPopdownListView : UIView

@property (nonatomic, assign) id <WLPopdownListViewDelegate> delegate;
@property (nonatomic, assign) NSUInteger selectIndex;   //default 0
@property (nonatomic, retain) NSArray *dataSource;  //default empty
@property (nonatomic, assign) float cellHeight; //default 44.f
@property (nonatomic, assign) BOOL autoHideAfterSelect; //default NO

- (void)showPopdownListView:(UIView *)view;
- (void)hidePopdownListView;

@end
