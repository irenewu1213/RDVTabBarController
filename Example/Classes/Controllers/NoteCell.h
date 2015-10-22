//
//  Header.h
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteCell;

@protocol NoteCellDelegate <NSObject>

@end

#import "NoteCellFrame.h"
@interface NoteCell : UITableViewCell
@property (nonatomic,strong) NoteCellFrame *cellFrame;
@property (nonatomic,assign) id<NoteCellDelegate> delegate;
@end
