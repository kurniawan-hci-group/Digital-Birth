//
//  DBCopingDisplay.h
//  Digital-Birth
//
//  Created by Sandy Achmiz on 10/26/13.
//
//

#import <UIKit/UIKit.h>

@interface DBCopingDisplay : UIView

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIImage* backgroundImage;

@property float visibleAlpha;

@property (nonatomic) bool flipHorizontal;
@property (nonatomic) bool flipVertical;

@property bool autoFadeOut;
@property float fadeOutDelay;
@property float fadeOutDuration;

-(void)show;
//-(void)showForDuration:(NSTimeInterval)duration;
-(void)hide;
-(void)fadeOut;
-(void)fadeOutWithDuration:(NSTimeInterval)duration;
-(void)pulse:(NSInteger)times;

@end
