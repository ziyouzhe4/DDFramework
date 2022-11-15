//
//  DDVoiceManager.h
//  测试demo
//
//  Created by majianjie on 2022/6/29.
//  Copyright © 2022 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDVoiceManager : NSObject

+(DDVoiceManager *)shareInstance;
-(void)startWithText:(NSString *)language;


@end

NS_ASSUME_NONNULL_END
