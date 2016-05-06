//
//  AppDelegate.h
//  RecruitmentProduct
//
//  Created by runsheng on 16/3/29.
//  Copyright © 2016年 RunShengInformation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

