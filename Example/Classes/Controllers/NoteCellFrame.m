//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//

#define kIconMarginX 5
#define kIconMarginY 5

#import "NoteCellFrame.h"

@implementation NoteCellFrame

-(void)setNoteMessage:(TaskDescription *)noteMessage
{
    _noteMessage=noteMessage;
    
    CGSize winSize=[UIScreen mainScreen].bounds.size;
    CGFloat iconX=kIconMarginX;
    CGFloat iconY=kIconMarginY;
    CGFloat iconWidth=40;
    CGFloat iconHeight=40;
    
    
    self.iconRect=CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    CGFloat contentX=CGRectGetMaxX(self.iconRect)+kIconMarginX;
    CGFloat contentY=iconY;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:13]};
    CGSize contentSize=[noteMessage.description boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    
    self.noteViewRect=CGRectMake(contentX, contentY, contentSize.width+35, contentSize.height+30);
    
    self.cellHeight=MAX(CGRectGetMaxY(self.iconRect), CGRectGetMaxY(self.noteViewRect))+kIconMarginX;
}
@end
