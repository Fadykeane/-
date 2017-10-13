//
//  SendMsgToWeChatVC.h
//  
//
//  Created by tusm on 16/1/4.
//
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@protocol sendMsgToWeChatViewDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendTextContent;
- (void) sendImageContent;
- (void) sendLinkContent;
- (void) sendMusicContent;
- (void) sendVideoContent;
- (void) sendAppContent;
- (void) sendNonGifContent;
- (void) sendGifContent;
- (void) sendFileContent;
@end


@interface SendMsgToWeChatVC : UIViewController<UITextViewDelegate>

{
    enum WXScene _scene;
}
@property (nonatomic,strong)id<sendMsgToWeChatViewDelegate,NSObject>delegate;

@end
