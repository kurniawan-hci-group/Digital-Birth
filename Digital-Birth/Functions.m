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
