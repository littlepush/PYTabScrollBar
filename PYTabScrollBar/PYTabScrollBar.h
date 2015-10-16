//
//  PYTabScrollBar.h
//  PYTabScrollBar
//
//  Created by Push Chen on 9/14/15.
//  Copyright (c) 2015 PushLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// The delegate for tab scroll bar.
@protocol PYTabScrollBarDelegate;

@interface PYTabScrollBar : UIView

/*!
 @brief the delegate object
 */
@property (nonatomic, assign)   id<PYTabScrollBarDelegate>  delegate;

/*!
 @brief all tab views in the container.
 */
@property (nonatomic, readonly) NSArray             *tabs;

/*!
 @brief current selected tab view.
 */
@property (nonatomic, readonly) UIView              *selectedTab;

/*!
 @brief The max available width while the container has enough space to display
 the full size tab item.
 */
@property (nonatomic, assign)   CGFloat             maxTabWidth;

/*!
 @brief The min width to display a full tab item.
 */
@property (nonatomic, assign)   CGFloat             minTabWidth;

/*!
 @brief the left side customized view
 */
@property (nonatomic, strong)   UIView              *leftView;

/*!
 @brief the right side customized view
 */
@property (nonatomic, strong)   UIView              *rightView;

/*!
 @brief create a new tab view with the content.
 */
- (void)appendTabViewWithContent:(id)content;

@end

@protocol PYTabScrollBarDelegate <NSObject>

@required

/*!
 @brief Create a new tabbar with specified content
 */
- (id)tabScrollBar:(PYTabScrollBar *)tabScrollBar createNewTabWithContent:(id)content;

@end
