//
//  GGTypeDef.h
//  WOfficeApp
//
//  Created by Static Ga on 13-10-9.
//  Copyright (c) 2013年 Static Ga. All rights reserved.
//

#ifndef WOfficeApp_GGTypeDef_h
#define WOfficeApp_GGTypeDef_h

typedef enum {
    kHttpPostMethod,
    kHttpGetMethod,
    kHttpDeleteMethod,//Not achieved
    kHttpPatchMethod,//Not achieved
    kHttpPutMethod,//Not achieved
    kHttpHeadMethod,//Not achieved
}kHttpMethod;

typedef void (^GGSucessBlock)(id responseObj);
typedef void (^GGFailedBlock)(NSString *errorMsg);

#endif
