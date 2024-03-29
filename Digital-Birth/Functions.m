//
//  Constants.h
//  Digital-Birth
//

#import "Functions.h"

int get_random_int_with_variance(int mean, int variance)
{
	float randomFactor = -9.0;
	
	randomFactor += arc4random() % 6 + 1;
	randomFactor += arc4random() % 6 + 1;
	randomFactor += arc4random() % 6 + 1;
	
	printf("3d6 roll: %d\n", (int) randomFactor + 9);
	
	randomFactor /= 9.0;
	
	return mean + (variance * randomFactor);
}

float get_random_float_with_variance(float mean, float variance)
{
	float randomFactor = -9.0;
	
	randomFactor += arc4random() % 6 + 1;
	randomFactor += arc4random() % 6 + 1;
	randomFactor += arc4random() % 6 + 1;
	
	printf("3d6 roll: %d\n", (int) randomFactor + 9);
	
	randomFactor /= 9.0;
	
	return mean + (variance * randomFactor);
}

CGRect rectFor1PxStroke(CGRect rect)
{
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, 
					  rect.size.width - 1, rect.size.height - 1);
}

bool actionsShareTags(NSDictionary* actionOne, NSDictionary* actionTwo)
{
	for(NSString* tagOne in actionOne[@"tags"])
	{
		for(NSString* tagTwo in actionTwo[@"tags"])
		{
			if([tagOne isEqualToString:tagTwo])
				return true;
		}
	}
	
	return false;
}

bool isPosition(NSDictionary* action)
{
	if([action[@"category"] isEqualToString:@"position"])
		return true;
	
	for(NSString* tag in action[@"tags"])
		if([tag isEqualToString:@"position"])
		   return true;
	
	return false;
}

NSString* stringForTimeInterval(NSTimeInterval interval)
{
	printf("	Entering stringForTimeInterval!\n");
	
	printf("	the interval is: %f\n", interval);
	
	// Get the system calendar
	NSCalendar* sysCalendar = [NSCalendar currentCalendar];

	// Create the NSDates
	NSDate* date1 = [[NSDate alloc] init];
	NSDate* date2 = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date1]; 
	
	// Get conversion to months, days, hours, minutes
	unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;

	NSDateComponents* conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
	

	printf("	Exiting stringForTimeInterval!\n");
	
	return [NSString stringWithFormat:@"%ld hours, %ld minutes", (long) [conversionInfo hour], (long)[conversionInfo minute]];
}