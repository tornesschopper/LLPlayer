//
//  AppHelpers.m
//  ITAS2_New
//
//  Created by 辰 宫 on 15/2/12.
//  Copyright (c) 2015年 overmindgc. All rights reserved.
//

#import "FileHelpers.h"

@implementation FileHelpers

+ (void)deleteFileFromSandBoxWithFilePath:(NSString *)filePath
{
    // 删除已存在的的文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

+ (UIImage *)getImageFromSandBoxWithFilePath:(NSString *)filePath
{
    return [UIImage imageWithContentsOfFile:filePath];
}

+ (NSString *)saveImageToCacheSandBoxWithData:(UIImage *)image folder:(NSString *)folderName fileName:(NSString *)fileName
{
    return [self saveImageToSandBox:NSCachesDirectory withData:image folder:folderName fileName:fileName];
}

+ (NSString *)saveImageToDocumentSandBoxWithData:(UIImage *)image folder:(NSString *)folderName fileName:(NSString *)fileName
{
    return [self saveImageToSandBox:NSDocumentDirectory withData:image folder:folderName fileName:fileName];
}

+ (NSString *)saveImageToSandBox:(NSSearchPathDirectory)pathDirectory withData:(UIImage *)image folder:(NSString *)folderName fileName:(NSString *)fileName
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *filePath;
    if (folderName) {
        NSString *createFolderPath = [NSString stringWithFormat:@"%@/%@",docDir,folderName];
        if (![[NSFileManager defaultManager] fileExistsAtPath:createFolderPath])//判断createPath路径文件夹是否已存在
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:createFolderPath withIntermediateDirectories:YES attributes:nil error:nil];//创建文件夹
        }
        filePath = [NSString stringWithFormat:@"%@/%@/%@",docDir,folderName,fileName];
    } else {
        filePath = [NSString stringWithFormat:@"%@/%@",docDir,fileName];
    }
    
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
    [data writeToFile:filePath atomically:YES];
    return filePath;
}

+ (void)deleteFolderFromCacheSandBoxWithName:(NSString *)folderName
{
    [self deleteFolderFromSandBox:NSCachesDirectory withName:folderName];
}
+ (void)deleteFolderFromDocumentSandBoxWithName:(NSString *)folderName
{
    [self deleteFolderFromSandBox:NSDocumentDirectory withName:folderName];
}

+ (void)deleteFolderFromSandBox:(NSSearchPathDirectory)pathDirectory withName:(NSString *)folderName
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",docDir,folderName];
    // 删除已存在的的文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

@end