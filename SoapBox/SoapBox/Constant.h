//
//  Constant.h
//  SoapBox
//
//  Created by Gregoire on 9/21/13.
//  Copyright (c) 2013 Josh. All rights reserved.
//

#ifndef SoapBox_Constant_h
#define SoapBox_Constant_h

#define BARBUTTONFRAME CGRectMake(0, 0, 30, 30)

#define METERS_PER_MILE 1609.344

#define APP_LINK "itms://itunes.com/apps/soapboxx"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define DEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width

#define GRAY1 [UIColor colorWithRed:19/255.0f green:19/255.0f blue:19/255.0f alpha:1.0f]

#define GRAY2 [UIColor colorWithRed:31/255.0f green:31/255.0f blue:31/255.0f alpha:1.0f]

#define RADIUS_SCALAR 75

//for colors
#define BLUE 4
#define GREEN 8
#define YELLOW 12
#define ORANGE 16
#define RED 20

#endif
