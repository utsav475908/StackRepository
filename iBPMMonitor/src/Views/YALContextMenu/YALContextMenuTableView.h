// *************************************************************************************************
// # MARK: Type Definition


typedef NS_ENUM(NSInteger, MenuItemsSide) {
    Left,
    Right
};

typedef NS_ENUM(NSInteger, MenuItemsAppearanceDirection) {
    FromTopToBottom,
    FromBottomToTop
};


// *************************************************************************************************
// # MARK: Forward Declaration


@class YALContextMenuTableView;


// *************************************************************************************************
// # MARK: Protocol


@protocol YALContextMenuTableViewDelegate <NSObject>


@optional


- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath;


@end


// *************************************************************************************************
// # MARK: Public Interfaces


@interface YALContextMenuTableView : UITableView


// *************************************************************************************************
// # MARK: Delegate


@property (nonatomic, weak) id <YALContextMenuTableViewDelegate> yalDelegate;


// *************************************************************************************************
// # MARK: Public Properties


@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) MenuItemsSide menuItemsSide;
@property (nonatomic) MenuItemsAppearanceDirection menuItemsAppearanceDirection;


// *************************************************************************************************
// # MARK: Public Interfaces


- (instancetype)initWithTableViewDelegateDataSource:(id<UITableViewDelegate, UITableViewDataSource>)delegateDataSource;
- (void)showInView:(UIView *)superview withEdgeInsets:(UIEdgeInsets)edgeInsets animated:(BOOL)animated;
- (void)dismisWithIndexPath:(NSIndexPath *)indexPath;
- (void)updateAlongsideRotation;


@end
