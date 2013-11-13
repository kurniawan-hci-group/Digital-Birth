//
//  DBTooltipView.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 10/26/13.
//
//

#import <UIKit/UIKit.h>

@interface DBTooltipView : UIView

@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSString* tag;

-(void)show;
-(void)hide;

@end
