//
//  PYTabScrollBar.h
//  PYTabScrollBar
//
//  Created by Push Chen on 9/14/15.
//  Copyright (c) 2015 PushLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PYTabScrollBar : UIView

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

@end
