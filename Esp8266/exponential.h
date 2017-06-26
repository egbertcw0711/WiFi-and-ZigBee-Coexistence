class ExponentialDist {
private:
  double MEAN;
  int RANDOM_SEED;
public:
  ExponentialDist();
  ExponentialDist(double interval, int seed);
  double generate();
};
