//
//  HKView.h
//  RACProject
//
//  Created by fd-macmini on 2021/10/20.
//

#import <UIKit/UIKit.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface HKView : UIView

@property (nonatomic, strong) RACSubject *clickBtnSinggnal;

@end

NS_ASSUME_NONNULL_END
