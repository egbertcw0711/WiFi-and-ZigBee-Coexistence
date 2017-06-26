#include "exponential.h"
#include <cstdlib>
#include <cmath>

ExponentialDist::ExponentialDist()
  : MEAN(5.0), RANDOM_SEED(1) {}

ExponentialDist::ExponentialDist(double interval, int seed = 1) 
  : MEAN(interval), RANDOM_SEED(seed) {}
  
double ExponentialDist::generate()
{
  double u = rand() / (double) RAND_MAX;
  return -MEAN * log(1-u); // using uniform distribution to generate exponential distribution
}
