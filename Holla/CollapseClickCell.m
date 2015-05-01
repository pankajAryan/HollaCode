//
//  CollapseClickCell.m
//  CollapseClick
//
//  Created by Ben Gordon on 2/28/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "CollapseClickCell.h"

@implementation CollapseClickCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title index:(int)index content:(UIView *)content
{
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CollapseClickCell" owner:nil options:nil];
    CollapseClickCell *cell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0, 0, 320, kCCHeaderHeight)];
    cell = [views objectAtIndex:0];
    
    // Initialization Here
    cell.TitleLabel.text = title;
    cell.index = index;
    cell.TitleButton.tag = index;
    cell.ContentView.frame = CGRectMake(cell.ContentView.frame.origin.x, cell.ContentView.frame.origin.y, cell.ContentView.frame.size.width, content.frame.size.height);
    
    if (index == 0) {
        [cell.titleImageView setImage:[UIImage imageNamed:@"Sunday.png"]];
    }
    else if (index == 1)
        [cell.titleImageView setImage:[UIImage imageNamed:@"Sat.png"]];
    else if (index == 2)
        [cell.titleImageView setImage:[UIImage imageNamed:@"fri.png"]];
    else if (index == 3)
        [cell.titleImageView setImage:[UIImage imageNamed:@"thurs.png"]];
    else if (index == 4)
        [cell.titleImageView setImage:[UIImage imageNamed:@"wed.png"]];
    else if (index == 5)
        [cell.titleImageView setImage:[UIImage imageNamed:@"tues.png"]];
    else if (index == 6)
        [cell.titleImageView setImage:[UIImage imageNamed:@"fri.png"]];

    
    
    [cell.ContentView addSubview:content];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
