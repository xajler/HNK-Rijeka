#import "MIUnderlayNavigationBar.h"

@interface MIUnderlayNavigationBar ()
{
	UIView* _underlayView;
}

- (UIView*) underlayView;

@end

@implementation MIUnderlayNavigationBar

- (void) didAddSubview:(UIView *)subview
{
	[super didAddSubview:subview];
    
	if(subview != _underlayView)
	{
		UIView* underlayView = self.underlayView;
		[underlayView removeFromSuperview];
		[self insertSubview:underlayView atIndex:1];
	}
}

- (UIView*) underlayView
{
	if(_underlayView == nil)
	{
		const CGFloat statusBarHeight = 20;    //  Make this dynamic in your own code...
		const CGSize selfSize = self.frame.size;
        
		_underlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, selfSize.width, selfSize.height + statusBarHeight)];
		[_underlayView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_underlayView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.34f blue:0.62f alpha:1.0f]];
		[_underlayView setAlpha:0.36f];
		[_underlayView setUserInteractionEnabled:NO];
	}
    
	return _underlayView;
}

@end
