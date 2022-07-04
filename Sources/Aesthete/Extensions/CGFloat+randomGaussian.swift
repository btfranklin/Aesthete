//  Created by B.T. Franklin on 10/4/19

import CoreGraphics

extension CGFloat {
    
    private static var queudGaussian: CGFloat?
    
    /**
     Returns a random Gaussian float using the specified RandomNumberGenerator with the provided standard deviation and mean values, which default to a
     standard deviation of 1 and a mean of 0 if not provided.
     */
    public static func randomGaussian(withStandardDeviation standardDeviation: CGFloat = 1.0,
                                      withMean mean: CGFloat = 0.0,
                                      withMaximum maximum: CGFloat = .infinity,
                                      withMinimum minimum: CGFloat = -.infinity,
                                      using randomNumberGenerator: inout some RandomNumberGenerator) -> CGFloat {
        
        var result: CGFloat?
        repeat {
            
            let baseGaussian: CGFloat
            if let gaussian = CGFloat.queudGaussian {
                CGFloat.queudGaussian = nil
                baseGaussian = gaussian
                
            } else {
                var value1, value2, sumOfSquares: CGFloat
                
                repeat {
                    value1 = 2 * CGFloat.random(in: 0...1, using: &randomNumberGenerator) - 1
                    value2 = 2 * CGFloat.random(in: 0...1, using: &randomNumberGenerator) - 1
                    sumOfSquares = value1 * value1 + value2 * value2
                } while sumOfSquares >= 1 || sumOfSquares == 0
                
                let multiplier = sqrt(-2 * log(sumOfSquares)/sumOfSquares)
                CGFloat.queudGaussian = value2 * multiplier
                
                baseGaussian = value1 * multiplier
            }
            
            let parameterAdjustedGaussian = baseGaussian * standardDeviation + mean
            if (minimum...maximum).contains(parameterAdjustedGaussian) {
                result = parameterAdjustedGaussian
            }
        } while result == nil
        
        return result!
    }

    /**
     Returns a random Gaussian float with the provided standard deviation and mean values, which default to a
     standard deviation of 1 and a mean of 0 if not provided.
     */
    public static func randomGaussian(withStandardDeviation standardDeviation: CGFloat = 1.0,
                                      withMean mean: CGFloat = 0.0,
                                      withMaximum maximum: CGFloat = .infinity,
                                      withMinimum minimum: CGFloat = -.infinity) -> CGFloat {
        var randomNumberGenerator = SystemRandomNumberGenerator()
        return CGFloat.randomGaussian(withStandardDeviation: standardDeviation,
                                      withMean: mean,
                                      withMaximum: maximum,
                                      withMinimum: minimum,
                                      using: &randomNumberGenerator)
    }

    // Resets the random Gaussian calculation. This is necessary between subsequent runs using a seeded RNG to ensure
    // the the same sequence is repeated, since otherwise a lingering "queued Gaussian" may be returned.
    public static func resetRandomGaussian() {
        queudGaussian = nil
    }
    
}
