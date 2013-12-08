WLPopdownListView

<br/>
<img src="https://github.com/linger103/WLPopdownListView/raw/master/screenshot.png" alt="Image" title="ScreenShot" width="200" height="300" />

You can use it easy!

    WLPopdownListView *popListView = [[WLPopdownListView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width),[UIScreen mainScreen].bounds.size.height)];
    popListView.dataSource = [NSArray arrayWithObjects:@"全部", @"支出", @"收入",nil];
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
