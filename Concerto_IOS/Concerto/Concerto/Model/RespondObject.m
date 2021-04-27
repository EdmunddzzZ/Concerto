//
//  RespondObject.m
//  Concerto
//
//  Created by EdmunddzzZ on 2021/4/27.
//

#import "RespondObject.h"

@implementation RespondObject
-(BOOL)isSuccessful
{
    if([self.status isEqual:@"200"])
    {
        return YES;
    }
    return  NO;
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
        return  YES;
}
@end
