//
//  RDV.m
//  RDVTabBarController
//
//  Created by IreneWu on 15/10/17.
//  Copyright (c) 2015年 Robert Dimitrov. All rights reserved.
//
#define kContentStartMargin 25
#import <Foundation/Foundation.h>
#import "NoteContentView.h"
#import "TaskDescription.h"

@implementation NoteContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backImageView=[[UIImageView alloc]init];
        self.backImageView.userInteractionEnabled=YES;
        [self addSubview:self.backImageView];
        
        self.contentLabel=[[UILabel alloc]init];
        self.contentLabel.numberOfLines=0;
        self.contentLabel.textAlignment=NSTextAlignmentLeft;
        self.contentLabel.font=[UIFont fontWithName:@"HelveticaNeue" size:13];
        [self addSubview:self.contentLabel];
        
        [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)]];
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.backImageView.frame=self.bounds;
    CGFloat contentLabelX=0;
    contentLabelX=kContentStartMargin*0.8;
    self.contentLabel.frame=CGRectMake(contentLabelX, -3, self.frame.size.width-kContentStartMargin-5, self.frame.size.height);
    
}


@end