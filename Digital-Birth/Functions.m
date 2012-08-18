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
	for(NSString* tagOne in [actionOne objectForKey:@"tags"])
	{
		for(NSString* tagTwo in [actionTwo objectForKey:@"tags"])
		{
			if([tagOne isEqualToString:tagTwo])
				return true;
		}
	}
	
	return false;
}

bool isPosition(NSDictionary* action)
{
	if([[action objectForKey:@"category"] isEqualToString:@"position"])
		return true;
	
	for(NSString* tag in [action objectForKey:@"tags"])
		if([tag isEqualToString:@"position"])
		   return true;
	
	return false;
}