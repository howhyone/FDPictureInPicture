//
//  HKView.m
//  RACProject
//
//  Created by fd-macmini on 2021/10/20.
//

#import "HKView.h"



@implementation HKView


- (IBAction)clickBtn:(UIButton *)sender {
    
    [self handleClickBtnWithStr:@"hhhhha"];
}

-(void)handleClickBtnWithStr:(NSString *)str {
    
}

- (RACSubject *)clickBtnSinggnal {
    if (!_clickBtnSinggnal) {
        _clickBtnSinggnal = [RACSubject subject];
    }
    return _clickBtnSinggnal;
}

@end
