#include "exponential.h"
#include <cstdlib>
#include <cmath>

ExponentialDist::ExponentialDist()
  : MEAN(5.0), RANDOM_SEED(1), OFFSET(0) {}

ExponentialDist::ExponentialDist(double interval, int seed = 1, double offset = 0) 
  : MEAN(interval), RANDOM_SEED(seed),OFFSET(offset)
  {
    srand(RANDOM_SEED);
  }
  
double ExponentialDist::generate()
{
  double u = rand() / (double) RAND_MAX;
  double result = -MEAN * log(1-u) + OFFSET;
  return result;
}
