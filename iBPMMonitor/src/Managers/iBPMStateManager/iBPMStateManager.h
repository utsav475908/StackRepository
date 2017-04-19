// *************************************************************************************************
// # MARK: Type Definition


typedef NS_ENUM(NSUInteger, AppName) {
    monitorApp,
    statusApp
};


// *************************************************************************************************
// # MARK: Public Interfaces


@interface iBPMStateManager : NSObject


// *************************************************************************************************
// # MARK: Class Methods


+ (iBPMStateManager *)sharedManager;


// *************************************************************************************************
// # MARK: Public Properties


@property (strong, nonatomic) NSString *currentLifeCycle;
@property (strong, nonatomic) NSString *currentInfoType;
@property (assign, nonatomic) AppName currentApp;


@end
