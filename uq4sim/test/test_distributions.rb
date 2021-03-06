require 'test/unit'
require 'uq4sim/distributions'
require 'uq4sim/statistics'

# For real tests, see SAND2006-1706,
# http://gaston.sandia.gov/cfupload/ccim_pubs_prod/V&VLHS05.pdf

class Array # mixin statistical functions
  include Uq4sim::Statistics
end

class TestUniformDistribution < Test::Unit::TestCase

  include Uq4sim

  def setup
    srand 1234
  end

  def test_nominal_range
    100.times { assert_in_delta( 0.0, randu, 0.5 ) }
  end

  def test_specified_halfwidth
    100.times { assert_in_delta( 0.0, randu(1), 1) }
  end

  def test_specified_fractional_width_range
    100.times { assert_in_delta( 0.0, randu(0.4), 0.4 ) }
  end

  def test_statistics
    samples = []
    1000.times{ samples << randu }
    assert_in_delta( 0.0,  samples.mean,               0.01, "mean" )
    assert_in_delta( 0.0,  samples.median,             0.050, "median" )
    assert_in_delta( 0.29, samples.standard_deviation, 0.005, "sigma" )
    assert_in_delta( 0.0,  samples.skewness,           0.100, "skewness" )
    assert_in_delta( 1.8,  samples.kurtosis,           0.050, "kurtosis" )
  end

end

class TestNormalDistribution < Test::Unit::TestCase

  include Uq4sim

  def setup
    srand 1234
  end

  def test_nominal_statistics
    samples = []
    1000.times{ samples << randn }
    assert_in_delta( 0.0, samples.mean,               0.05, "mean" )
    assert_in_delta( 0.0, samples.median,             0.10, "median" )
    assert_in_delta( 1.0, samples.standard_deviation, 0.05, "sigma" )
    assert_in_delta( 0.0, samples.skewness,           0.10, "skewness" )
    assert_in_delta( 3.0, samples.kurtosis,           0.10, "kurtosis" )
  end

  def test_specified_sigma_statistics
    samples = []
    1000.times{ samples << randn(0.2) }
    assert_in_delta( 0.0, samples.mean,               0.05, "mean" )
    assert_in_delta( 0.0, samples.median,             0.05, "median" )
    assert_in_delta( 0.2, samples.standard_deviation, 0.05, "sigma" )
    assert_in_delta( 0.0, samples.skewness,           0.10, "skewness" )
    assert_in_delta( 3.0, samples.kurtosis,           0.10, "kurtosis" )
  end

end

class TestTriangularDistribution < Test::Unit::TestCase

  include Uq4sim

  def setup
    srand 1234
  end

  def test_nominal_range
    100.times { assert_in_delta( 0.0, randt, 0.5 ) }
  end

  def test_specified_halfwidth
    100.times { assert_in_delta( 0.0, randt(1.0), 1.0 ) }
  end

  def test_specified_fractional_width_range
    100.times { assert_in_delta( 0.0, randt(0.2), 0.2 ) }
  end

  def test_statistics
    samples = []
    1000.times { samples << randt }
    assert_in_delta( 0.0,      samples.mean,     0.010, "mean" )
    assert_in_delta( 0.0,      samples.median,   0.020, "median" )
    assert_in_delta( 3.0/72.0, samples.variance, 0.005, "variance" )
    assert_in_delta( 0.0,      samples.skewness, 0.050, "skewness" )
    assert_in_delta( 2.4,      samples.kurtosis, 0.050, "kurtosis" )
  end

end
