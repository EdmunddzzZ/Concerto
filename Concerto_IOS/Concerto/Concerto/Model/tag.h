//
//  tag.h
//  Concerto
//
//  Created by EdmunddzzZ on 2021/5/3.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface tag : JSONModel
@property(nonatomic,strong)NSNumber *tagId;
@property(nonatomic,strong)NSString *tagContent;
@property(nonatomic,strong)NSString *tagColor;
@end

NS_ASSUME_NONNULL_END
