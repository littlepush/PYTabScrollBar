//
//  PYTabScrollBar.m
//  PYTabScrollBar
//
//  Created by Push Chen on 9/14/15.
//  Copyright (c) 2015 PushLab. All rights reserved.
//

#import "PYTabScrollBar.h"

@interface PYTabScrollBar () <UIGestureRecognizerDelegate>
{
    UIView                          *_tabContainer;
    UIPanGestureRecognizer          *_panGesture;
    
    NSMutableArray                  *_tabPool;
    NSInteger                       _selectedIndex;
    
    // Left and right view
    UIView                          *_leftView;
    UIView                          *_rightView;
}

@end

@implementation PYTabScrollBar

@synthesize tabs = _tabPool;
@dynamic selectedTab;
- (UIView *)selectedTab
{
    @synchronized(self) {
        if ( _tabPool.count <= _selectedIndex ) return nil;
        return _tabPool[_selectedIndex];
    }
}

@synthesize leftView = _leftView;
- (void)setLeftView:(UIView *)leftView
{
    [self willChangeValueForKey:@"leftView"];
    
    if ( _leftView != nil && _leftView.superview != nil ) {
        [_leftView removeFromSuperview];
    }
    
    _leftView = leftView;
    [self addSubview:_leftView];
    [_leftView setCenter:CGPointMake(_leftView.bounds.size.width / 2,
                                     self.bounds.size.height / 2)];
    
    // Re-layout the tab container
    [self setNeedsLayout];
    
    [self didChangeValueForKey:@"leftView"];
}

@synthesize rightView = _rightView;
- (void)setRightView:(UIView *)rightView
{
    [self willChangeValueForKey:@"rightView"];
    
    if ( _rightView != nil && _rightView.superview != nil ) {
        [_rightView removeFromSuperview];
    }
    
    _rightView = rightView;
    [self addSubview:_rightView];
    [_rightView setCenter:CGPointMake(_rightView.bounds.size.width / 2,
                                      self.bounds.size.height / 2)];
    
    [self setNeedsLayout];
    
    [self didChangeValueForKey:@"rightView"];
}

- (void)_initialize_tabbar
{
    // Data Initial
    self.maxTabWidth = 200.f;
    self.minTabWidth = 80.f;
    _leftView = nil;
    _rightView = nil;
    _selectedIndex = 0;
    _tabPool = [NSMutableArray array];
    
    // Create the container
    _tabContainer = [[UIView alloc] init];
    [self addSubview:_tabContainer];
    
    // Add the main gesture
    _panGesture = [[UIPanGestureRecognizer alloc]
                   initWithTarget:self
                   action:@selector(_action_pangesture_handler:)];
    _panGesture.delegate = self;
    [_tabContainer addGestureRecognizer:_panGesture];
}

- (void)_process_ScrollAllTabsWithDeltaDistance:(CGFloat)distance animationTime:(CGFloat)duration
{
    
}

- (void)_action_pangesture_handler:(UIPanGestureRecognizer *)panGesture
{
    // Calculate the speed and move
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Stop current animation first
    
    // Save the begin point.
    return YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Set the tab container's frame
    CGFloat _tabHeight = self.bounds.size.height;
    CGFloat _tabContainerWidth = self.bounds.size.width;
    _tabContainerWidth -= ( _leftView ? _leftView.bounds.size.width : 0 );
    _tabContainerWidth -= ( _rightView ? _rightView.bounds.size.width : 0 );
    CGRect _tabContainerFrame = CGRectMake((_leftView ? _leftView.bounds.size.width : 0),
                                           0, _tabContainerWidth, _tabHeight);
    [_tabContainer setFrame:_tabContainerFrame];
    
    // Re-layout all opened tabs
    CGFloat _avgWidth = MAX(MIN(_tabContainerWidth / _tabPool.count, _maxTabWidth), _minTabWidth);
    for ( NSInteger _idx = 0; _idx < _tabPool.count; ++_idx ) {
        [_tabPool[_idx] setFrame:CGRectMake(_idx * _avgWidth, 0, _avgWidth, _tabHeight)];
    }
}

- (id)init
{
    self = [super init];
    if ( self ) {
        [self _initialize_tabbar];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        [self _initialize_tabbar];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    if ( _leftView ) {
        [_leftView setCenter:CGPointMake(_leftView.bounds.size.width / 2,
                                         self.bounds.size.height / 2)];
    }
    if ( _rightView ) {
        [_rightView setCenter:CGPointMake(_rightView.bounds.size.width / 2,
                                          self.bounds.size.height / 2)];
    }
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if ( _leftView ) {
        [_leftView setCenter:CGPointMake(_leftView.bounds.size.width / 2,
                                         self.bounds.size.height / 2)];
    }
    if ( _rightView ) {
        [_rightView setCenter:CGPointMake(_rightView.bounds.size.width / 2,
                                          self.bounds.size.height / 2)];
    }
    [self setNeedsLayout];
}

- (void)appendTabViewWithContent:(id)content
{
    if ( self.delegate &&
        [self.delegate respondsToSelector:@selector(tabScrollBar:createNewTabWithContent:)] ) {
        UIView *_tabView = [self.delegate tabScrollBar:self createNewTabWithContent:content];
        if ( _tabView == nil ) return;
        [_tabPool addObject:_tabView];
        [_tabContainer addSubview:_tabView];
        [self setNeedsLayout];
    }
}

@end
