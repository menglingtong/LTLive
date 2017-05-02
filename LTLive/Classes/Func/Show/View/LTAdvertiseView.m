//
//  LTAdvertiseView.m
//  LTLive
//
//  Created by 孟令通 on 2017/5/2.
//  Copyright © 2017年 LryMlt. All rights reserved.
//

#import "LTAdvertiseView.h"

#import "LTShowHandler.h"

#import "LTAdvertise.h"

#import "LTCatch.h"

static NSUInteger showtime = 3;

@interface LTAdvertiseView ()

@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation LTAdvertiseView

+ (instancetype)loadAdvertiseView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LTAdvertiseView" owner:self options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    // 展示广告
    [self showAd];
    
    // 下载广告
    [self downLoadAd];
    
    // 倒计时
    [self startTimer];
}

- (void)showAd
{
    NSString *fileName = [LTCatch getAdvertise];
    
    UIImage *lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:fileName];
    
    
    if (lastCacheImage) {
        
        self.backImage.image = lastCacheImage;
    }
    else
    {
        self.backImage.hidden = YES;
    }
}

- (void)downLoadAd
{
    // 获取最新广告数据
    [LTShowHandler executeGetAdvertiseTaskWithSuccess:^(id obj) {
        
        LTAdvertise *advertise = obj;
        
        NSURL *imageUrl = [NSURL URLWithString:advertise.image];
        
        /**
         * By default, when a URL fail to be downloaded, the URL is blacklisted so the library won't keep trying.
         * This flag disable this blacklisting.
         */
//        SDWebImageRetryFailed = 1 << 0,
        
        /**
         * By default, image downloads are started during UI interactions, this flags disable this feature,
         * leading to delayed download on UIScrollView deceleration for instance.
         */
//        SDWebImageLowPriority = 1 << 1,
        
        /**
         * This flag disables on-disk caching
         */
//        SDWebImageCacheMemoryOnly = 1 << 2,
        
        /**
         * This flag enables progressive download, the image is displayed progressively during download as a browser would do.
         * By default, the image is only displayed once completely downloaded.
         */
//        SDWebImageProgressiveDownload = 1 << 3,
        
        /**
         * Even if the image is cached, respect the HTTP response cache control, and refresh the image from remote location if needed.
         * The disk caching will be handled by NSURLCache instead of SDWebImage leading to slight performance degradation.
         * This option helps deal with images changing behind the same request URL, e.g. Facebook graph api profile pics.
         * If a cached image is refreshed, the completion block is called once with the cached image and again with the final image.
         *
         * Use this flag only if you can't make your URLs static with embedded cache busting parameter.
         */
//        SDWebImageRefreshCached = 1 << 4,
        
        /**
         * In iOS 4+, continue the download of the image if the app goes to background. This is achieved by asking the system for
         * extra time in background to let the request finish. If the background task expires the operation will be cancelled.
         */
//        SDWebImageContinueInBackground = 1 << 5,
        
        /**
         * Handles cookies stored in NSHTTPCookieStore by setting
         * NSMutableURLRequest.HTTPShouldHandleCookies = YES;
         */
//        SDWebImageHandleCookies = 1 << 6,
        
        /**
         * Enable to allow untrusted SSL certificates.
         * Useful for testing purposes. Use with caution in production.
         */
//        SDWebImageAllowInvalidSSLCertificates = 1 << 7,
        
        /**
         * By default, images are loaded in the order in which they were queued. This flag moves them to
         * the front of the queue.
         */
//        SDWebImageHighPriority = 1 << 8,
        
        /**
         * By default, placeholder images are loaded while the image is loading. This flag will delay the loading
         * of the placeholder image until after the image has finished loading.
         */
//        SDWebImageDelayPlaceholder = 1 << 9,
        
        /**
         * We usually don't call transformDownloadedImage delegate method on animated images,
         * as most transformation code would mangle it.
         * Use this flag to transform them anyway.
         */
//        SDWebImageTransformAnimatedImage = 1 << 10,
        
        /**
         * By default, image is added to the imageView after download. But in some cases, we want to
         * have the hand before setting the image (apply a filter or add it with cross-fade animation for instance)
         * Use this flag if you want to manually set the image in the completion when success
         */
        // 下载完成后不自动给imageView赋值
//        SDWebImageAvoidAutoSetImage = 1 << 11
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageUrl options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            NSLog(@"下载成功");
            
            [LTCatch setAdvertise:advertise.image];
            
        }];
        
        
        
    } failed:^(id obj) {
        
        NSLog(@"%@", obj);
    }];
}

- (void)startTimer
{
    __block NSUInteger timeout = showtime + 1;
    
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        
        
        if (timeout <= 0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
            });
            
        }
        else
        {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.timeLabel.text = [NSString stringWithFormat:@"跳过%zd", timeout];
            });
            
            timeout--;
            
        }
        
    });
    dispatch_resume(_timer);
    
}

- (void)dismiss
{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
