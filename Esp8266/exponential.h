class ExponentialDist {
private:
  double MEAN;
  int RANDOM_SEED;
  double OFFSET;
public:
  ExponentialDist();
  ExponentialDist(double interval, int seed, double offset);
  double generate();
};
