//
//  LYHealthManager.m
//  LYDemo
//
//  Created by liyang on 2018/1/25.
//  Copyright © 2018年 kosien. All rights reserved.
//

#import "LYHealthManager.h"
#import <HealthKit/HealthKit.h>

@interface LYHealthManager ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation LYHealthManager

#pragma mark - Life Cycle

+ (instancetype)defaultManager
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

- (HKHealthStore *)healthStore
{
    if (_healthStore == nil) {
        _healthStore = [[HKHealthStore alloc] init];
    }
    return _healthStore;
}




#pragma mark - Private Methods

// 获取健康数据权限
- (void)getAuthorization:(LYHealthAuthorizationBlock)authorization
{
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *readDataTypes = [self dataTypesRead];
        [self.healthStore requestAuthorizationToShareTypes:nil readTypes:readDataTypes completion:^(BOOL success, NSError * _Nullable error) {
            if (authorization) {
                authorization(success, error);
            }
        }];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"不支持健康数据" forKey:NSLocalizedDescriptionKey];
        NSError *aError = [NSError errorWithDomain:@"com.myself.healthError" code:HKErrorHealthDataUnavailable userInfo:userInfo];
        authorization(NO, aError);
    }
    
}

// 读取步数
- (void)getStepCount:(LYHealthResultBlock)result
{
    [self getAuthorization:^(BOOL success, NSError *error) {
        //如果获取健康数据权限成功
        if (success) {
            HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
            
            HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:stepCountType predicate:[self predicateForSamplesToday] limit:HKObjectQueryNoLimit sortDescriptors:@[timeSortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
                NSInteger totleSteps = 0;
                for (HKQuantitySample *quantitySample in results) {
                    HKQuantity *quantity = quantitySample.quantity;
                    HKUnit *heightUnit = [HKUnit countUnit];
                    double usersHeight = [quantity doubleValueForUnit:heightUnit];
                    totleSteps += usersHeight;
                }
                NSLog(@"当天行走步数 = %zd", totleSteps);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (result) {
                        result(totleSteps, error);
                    }
                });
            }];
            [self.healthStore executeQuery:query];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result) {
                    result(0, error);
                }
            });
        }
    }];
    
}




#pragma mark - Other Methods

// 写权限（需要哪个就加哪个）
- (NSSet *)dataTypesToWrite
{
    HKQuantityType *heightType       = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType       = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType *temperatureType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    return [NSSet setWithObjects:heightType, temperatureType, weightType, activeEnergyType, nil];
}

// 读权限（需要哪个就加哪个）
- (NSSet *)dataTypesRead
{
    /*
    HKQuantityType       *heightType       = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType       *weightType       = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantityType       *temperatureType  = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    HKQuantityType       *distanceType     = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    HKQuantityType       *activeEnergyType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKCharacteristicType *birthdayType     = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *sexType          = [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
     */
    HKQuantityType       *stepCountType    = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    return [NSSet setWithObjects:stepCountType, nil];
}

// 当天时间段
- (NSPredicate *)predicateForSamplesToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];
    return predicate;
}


@end
