#import "FlutterflappytoastPlugin.h"
#import "UIView+Toast.h"

@implementation FlutterflappytoastPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutterflappytoast"
                                     binaryMessenger:[registrar messenger]];
    FlutterflappytoastPlugin* instance = [[FlutterflappytoastPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if([@"showToast" isEqualToString:call.method]){
        //获取显示吐司的字符串
        NSString* toast=(NSString*)call.arguments[@"toast"];
        NSString* gravity=(NSString*)call.arguments[@"gravity"];
        //获取顶部的contoller
        UIViewController *topController = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
        //显示吐司
        // immediately hides all toast views in self.view
        [topController.view hideAllToasts];
        
        // create a new style
        CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
        // this is just one of many style options
        style.messageColor = [UIColor whiteColor];
        //设置提示的大小
        
        if (@available(iOS 8.2, *)) {
            style.titleFont=[UIFont systemFontOfSize:10 weight:UIFontWeightThin];
        } else {
            style.titleFont=[UIFont systemFontOfSize:10];
        }
        //设置圆角
        style.cornerRadius=16;
        //透明度
        style.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        style.horizontalPadding=12;
        style.verticalPadding=6;
        // present the toast with the new style
        
        if([gravity integerValue]==0){
            
            [topController.view makeToast:toast
                                 duration:2.0
                                 position:CSToastPositionBottom
                                    style:style];
        }else if([gravity integerValue]==1){
            
            [topController.view makeToast:toast
                                 duration:2.0
                                 position:CSToastPositionCenter
                                    style:style];
        }else if([gravity integerValue]==2){
            
            [topController.view makeToast:toast
                                 duration:2.0
                                 position:CSToastPositionTop
                                    style:style];
        }
        //显示吐司
        result(@"true");
    } else {
        result(FlutterMethodNotImplemented);
    }
}


//这里是获取整个应用的顶部Controller;
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
