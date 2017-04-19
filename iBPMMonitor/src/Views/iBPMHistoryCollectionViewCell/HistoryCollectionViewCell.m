// *************************************************************************************************
// # MARK: Imports


#import "HistoryCollectionViewCell.h"


// *************************************************************************************************
// # MARK: Implementation


@implementation HistoryCollectionViewCell


// *************************************************************************************************
// # MARK: Initialization


- (void)awakeFromNib {
    [super awakeFromNib];
    [self.layer setBorderWidth:1];
    self.attribute1.font = [UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:12];
    self.attribute2.font = [UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:12];
    self.attribute3.font = [UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:12];
    self.Attribute4.font = [UIFont iBPMApplicationTextBoldFontWithSizeWithFontSize:12];
}


// *************************************************************************************************
// # MARK: Public Interface Implementation


- (void)setID:(NSString *)tempName {
    self.name.text = tempName;
    [self.name setTextColor:[UIColor blueColor]];
}


- (void)setAttributes:(NSMutableDictionary *)tempAttrDictionay withDomain:(NSString*)domain {
    NSDictionary *plistDictionary = [NSDictionary
                                     dictionaryWithContentsOfFile:[[NSBundle mainBundle]
                                                                   pathForResource:@"HistoryFilters"
                                                                   ofType:@"plist"]];
    NSLog(@"Plist contents: %@",plistDictionary);
    NSDictionary *plistAttributes = [plistDictionary valueForKey:domain];
    NSArray *keys = plistAttributes.allKeys;
    switch (keys.count) {
        case 1:
            self.attribute1.text = [plistAttributes valueForKey:[keys objectAtIndex:0]];
            self.attr1Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:0]];
            break;
        case 2:
            self.attribute1.text = [plistAttributes valueForKey:[keys objectAtIndex:0]];
            self.attribute2.text = [plistAttributes valueForKey:[keys objectAtIndex:1]];
            self.attr1Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:0]];
            self.attr2Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:1]];
        case 3:
            self.attribute1.text = [plistAttributes valueForKey:[keys objectAtIndex:0]];
            self.attribute2.text = [plistAttributes valueForKey:[keys objectAtIndex:1]];
            self.attribute3.text = [plistAttributes valueForKey:[keys objectAtIndex:2]];
            self.attr1Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:0]];
            self.attr2Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:1]];
            self.attr3Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:2]];
        case 4:
            self.attribute1.text = [plistAttributes valueForKey:[keys objectAtIndex:0]];
            self.attribute2.text = [plistAttributes valueForKey:[keys objectAtIndex:1]];
            self.attribute3.text = [plistAttributes valueForKey:[keys objectAtIndex:2]];
            self.Attribute4.text = [plistAttributes valueForKey:[keys objectAtIndex:3]];
            self.attr1Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:0]];
            self.attr2Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:1]];
            self.attr3Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:2]];
            self.attr4Value.text = [tempAttrDictionay valueForKey:[keys objectAtIndex:3]];
        default:
            break;
    }
}

@end
