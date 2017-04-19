// *************************************************************************************************
// # MARK: Pbulic Interfaces


@interface UIView (Fold)


- (void)foldOpenWithTransparency:(BOOL)withTransparency
             withCompletionBlock:(void (^)(void))completionBlock;


- (void)foldClosedWithTransparency:(BOOL)withTransparency
             withCompletionBlock:(void (^)(void))completionBlock;


@end
