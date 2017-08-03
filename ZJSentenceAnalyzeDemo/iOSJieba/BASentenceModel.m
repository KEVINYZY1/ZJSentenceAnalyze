
//
//  BASentenceModel.m
//  BulletAnalyzer
//
//  Created by 张骏 on 17/6/22.
//  Copyright © 2017年 Zj. All rights reserved.
//

#import "BASentenceModel.h"

@implementation BASentenceModel

+ (BASentenceModel *)sentenceWithText:(NSString *)text words:(NSArray *)wordsArray{
    BASentenceModel *sentenceModel = [BASentenceModel new];
    sentenceModel.text = text;
    sentenceModel.wordsArray = wordsArray;
    
    return sentenceModel;
}


- (void)setWordsArray:(NSArray *)wordsArray{
    _wordsArray = wordsArray;
    
    //根据句子出现的频率构造一个字典
    __block NSMutableDictionary *wordsDic = [NSMutableDictionary dictionary];
    [wordsArray enumerateObjectsUsingBlock:^(NSString *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
        
        //若字典中已有这个词的词频 则停止计算
        if ([[wordsDic objectForKey:obj1] integerValue]) {
            *stop1 = YES;
        } else {
            __block NSInteger count = 1;
            [wordsArray enumerateObjectsUsingBlock:^(NSString *obj2, NSUInteger idx2, BOOL * _Nonnull stop2) {
                if ([obj1 isEqualToString:obj2] && idx1 != idx2) {
                    count += 1;
                }
            }];
            
            [wordsDic setObject:@(count) forKey:obj1];
        }
    }];
    _wordsDic = wordsDic;
}

@end
