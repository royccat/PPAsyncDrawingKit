//
//  PPTextStorage.m
//  PPAsyncDrawingKit
//
//  Created by DSKcpp on 2016/10/16.
//  Copyright © 2016年 DSKcpp. All rights reserved.
//

#import "PPTextStorage.h"
#import "PPAsyncDrawingKitUtilities.h"

@implementation PPTextStorage
{
    CFMutableAttributedStringRef attributedString;
    struct {
        unsigned int didProcessEditing: 1;
    } delegateHas;
}

- (instancetype)init
{
    if (self = [super init]) {
        attributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    }
    return self;
}

- (void)setDelegate:(id<PPTextStorageDelegate>)delegate
{
    if (_delegate != delegate) {
        _delegate = delegate;
        delegateHas.didProcessEditing = [delegate respondsToSelector:@selector(pp_textStorage:didProcessEditing:range:changeInLength:)];
    }
}

- (NSString *)string
{
    if (attributedString) {
        return (NSString *)CFAttributedStringGetString(attributedString);
    }
    return @"";
}


- (id)attribute:(NSString *)attrName atIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    if (attributedString) {
        if (self.length >= location) {
            CFRange _range = PPCFRangeFromNSRange(*range);
            return (NSDictionary *)CFAttributedStringGetAttributes(attributedString, location, &_range);
        }
    }
    return nil;
}

- (void)setAttributes:(NSDictionary<NSString *,id> *)attrs range:(NSRange)range
{
    CFAttributedStringSetAttributes(attributedString, PPCFRangeFromNSRange(range), (__bridge CFDictionaryRef)attrs, NO);
    if (delegateHas.didProcessEditing != 0) {
        [self.delegate pp_textStorage:self didProcessEditing:1 range:range changeInLength:0];
    }
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    if (str == nil && range.length == self.length) {
        str = nil;
    }
    CFAttributedStringReplaceString(attributedString, PPCFRangeFromNSRange(range), (__bridge CFStringRef)str);
    if (delegateHas.didProcessEditing != 0) {
        [self.delegate pp_textStorage:self didProcessEditing:1 range:range changeInLength:0];
    }
}

@end
