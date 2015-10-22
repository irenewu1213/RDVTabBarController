//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//


#import "NoteCell.h"
#import "NoteContentView.h"
@interface NoteCell()<NoteContentViewDelegate>
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) NoteContentView *noteView;
@property (nonatomic,strong) NoteContentView *currentNoteView;
@property (nonatomic,strong) NSString *contentStr;
@end

@implementation NoteCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.icon=[[UIImageView alloc]init];
        [self.contentView addSubview:self.icon];
        self.noteView =[[NoteContentView alloc]initWithFrame:CGRectZero];
        self.noteView.delegate=self;
        [self.contentView addSubview:self.noteView];
    }
    return self;
}
-(void)setCellFrame:(NoteCellFrame *)cellFrame
{
    
    _cellFrame=cellFrame;
    
//    ChartMessage *chartMessage=cellFrame.chartMessage;
    TaskDescription *taskMessage = cellFrame.noteMessage;
    self.icon.frame=cellFrame.iconRect;
//    self.icon.image=[UIImage imageNamed:chatMessage.icon];
    self.icon.image=[UIImage imageNamed:@"second_normal.png"];
    self.noteView.taskDescription=taskMessage;
    self.noteView.frame=cellFrame.noteViewRect;
    [self setBackGroundImageViewImage:self.noteView];
    
    self.noteView.contentLabel.text=taskMessage.taskAll;
    
}
-(void)setBackGroundImageViewImage:(NoteContentView *)noteView{
    UIImage *normal=nil ;
    normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
    noteView.backImageView.image=normal;
}


@end