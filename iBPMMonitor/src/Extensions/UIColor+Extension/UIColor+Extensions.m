// *************************************************************************************************
// # MARK: Imports


#import "UIColor+Extensions.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation UIColor (Extensions)


+ (UIColor *)colorWithHex:(NSString *)hexValue {
    UIColor *result = [UIColor clearColor];
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != hexValue) {
        NSScanner *scanner = [NSScanner scannerWithString:hexValue];
        [scanner scanHexInt:&colorCode];
        redByte = (unsigned char)(colorCode >> 16);
        greenByte = (unsigned char)(colorCode >> 8);
        blueByte = (unsigned char)(colorCode);
        result = [UIColor colorWithRed:((CGFloat)redByte / 0xff)
                                 green:((CGFloat)greenByte / 0xff)
                                  blue:((CGFloat)blueByte / 0xff)
                                 alpha:1.0];
    }
    
    return result;
}



// *************************************************************************************************
// # MARK: Blue Color


+ (UIColor *)iBPMBlueColor {
    return [UIColor colorWithRed:0.251 green:0.329 blue:0.698 alpha:1.00];
}


+ (UIColor *)iBPMLightBlueColor {
    return [UIColor colorWithRed:0.784 green:0.878 blue:0.973 alpha:1.00];
}


+ (UIColor *)iBPMPrimaryBlueColor {
    return [UIColor colorWithRed:0.275 green:0.329 blue:0.698 alpha:1.00];
}


+ (UIColor *)iBPMiOSBlueColor {
    return [UIColor colorWithRed:21.0/255.0 green:126.0/255.0 blue:251.0/255.0 alpha:1.0];
}


+ (UIColor *)iBPMLogoBlueColor {
    return [UIColor colorWithRed:0.110 green:0.584 blue:0.820 alpha:1.00];
}


// *************************************************************************************************
// # MARK: Gray Color


+ (UIColor *)iBPMDarkGrayColor {
    return [UIColor colorWithRed:0.404 green:0.404 blue:0.404 alpha:1.00];
}


+ (UIColor *)iBPMDarkerGrayColor {
    return [UIColor colorWithRed:0.345 green:0.345 blue:0.345 alpha:1.00];
}


// *************************************************************************************************
// # MARK: Red Color

+ (UIColor *)iBPMRedColor {
    
    return [UIColor colorWithRed:0.945 green:0.337 blue:0.227 alpha:1.00];
}


// *************************************************************************************************
// # MARK: Red Color

+ (UIColor *)iBPMGreenColor {
    return [UIColor colorWithRed:0.188 green:0.804 blue:0.604 alpha:1.00];
}


@end
