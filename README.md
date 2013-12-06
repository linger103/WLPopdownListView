WLPopdownListView

You Can Use it easy!

    WLPopdownListView *popListView = [[WLPopdownListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width),[UIScreen mainScreen].bounds.size.height)];
    popListView.dataSource = [NSArray arrayWithObjects:@"All", @"sectionOne", @"sectionTwo",nil];
    popListView.cellHeight = 50.f;
    popListView.selectIndex = [_requestBalanceType intValue];
    popListView.delegate = self;
    popListView.autoHideAfterSelect = YES;
    [popListView showPopdownListView:self.view];
    [popListView release];
    
    
    PopdownListViewDelegate
    - (void)didSelectPopDownIndex:(WLPopdownListView *)popDownListView
    {
     WLLog("%@", popDownListView.selectIndex);
}

===================================================================
