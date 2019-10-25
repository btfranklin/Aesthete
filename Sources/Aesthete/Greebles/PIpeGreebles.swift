//  Created by B.T. Franklin on 10/5/19

import CoreGraphics
import DunesailerUtilities

public struct PipeGreebles: Greebles {
    
    private struct Pipe {
        let path: CGPath
        let endPoints: [CGPoint]
        
        init(xUnits: CGFloat = 1, yUnits: CGFloat = 1, allowOffSide: Bool) {
            let insetRect = CGRect(x: 0, y: 0, width: xUnits, height: yUnits).insetBy(dx: 0.1, dy: 0.1)
            let outsetRect = CGRect(x: 0, y: 0, width: xUnits, height: yUnits).insetBy(dx: -0.3, dy: -0.3)
            var endPoints = [CGPoint]()
            var path: CGMutablePath

            let constrainingRect = allowOffSide ? outsetRect : insetRect
            let startingPoint = CGPoint.random(inX: constrainingRect.minX...constrainingRect.maxX,
                                               inY: constrainingRect.minY...constrainingRect.maxY)
            endPoints.append(startingPoint)
            
            var currentPoint: CGPoint
            var pipeValid: Bool
            repeat {
                pipeValid = true
                currentPoint = startingPoint
                path = CGMutablePath()
                path.move(to: startingPoint)
                
                var direction = PipeDirection.allCases.randomElement()!
                var nextPoint: CGPoint
                let segmentCount = Int.random(in: 1...3)
                for _ in 1...segmentCount {
                    let length = CGFloat.randomGaussian(withStandardDeviation: 0.1, withMean: 0.4, withMaximum: 0.65, withMinimum: 0.1)
                    let diagonalLength = length / CGFloat(2).squareRoot()
                    switch direction {
                    case .north:
                        nextPoint = CGPoint(x: currentPoint.x, y: currentPoint.y+length)
                    case .northeast:
                        nextPoint = CGPoint(x: currentPoint.x+diagonalLength, y: currentPoint.y+diagonalLength)
                    case .east:
                        nextPoint = CGPoint(x: currentPoint.x+length, y: currentPoint.y)
                    case .southeast:
                        nextPoint = CGPoint(x: currentPoint.x+diagonalLength, y: currentPoint.y-diagonalLength)
                    case .south:
                        nextPoint = CGPoint(x: currentPoint.x, y: currentPoint.y-length)
                    case .southwest:
                        nextPoint = CGPoint(x: currentPoint.x-diagonalLength, y: currentPoint.y-diagonalLength)
                    case .west:
                        nextPoint = CGPoint(x: currentPoint.x-length, y: currentPoint.y)
                    case .northwest:
                        nextPoint = CGPoint(x: currentPoint.x-diagonalLength, y: currentPoint.y+diagonalLength)
                    }
                    
                    if !allowOffSide && !insetRect.contains(nextPoint) {
                        pipeValid = false
                    }
                    
                    path.addLine(to: nextPoint)
                    currentPoint = nextPoint
                    direction = direction.getRandomChange()
                }
            } while !pipeValid
            
            endPoints.append(currentPoint)
            
            self.path = path.copy()!
            self.endPoints = endPoints
        }
    }
    
    private enum PipeDirection: CaseIterable {
        case north
        case northeast
        case east
        case southeast
        case south
        case southwest
        case west
        case northwest
        
        func getRandomChange() -> PipeDirection {
            let options: [PipeDirection]
            switch self {
            case .north:
                options = [.west, .northwest, .northeast, .east]
            case .northeast:
                options = [.east, .north]
            case .east:
                options = [.north, .northeast, .southeast, .south]
            case .southeast:
                options = [.south, .east]
            case .south:
                options = [.west, .southwest, .southeast, .east]
            case .southwest:
                options = [.west, .south]
            case .west:
                options = [.north, .northwest, .southwest, .south]
            case .northwest:
                options = [.west, .north]
            }
            return options.randomElement()!
        }
    }
    
    public let xUnits: CGFloat
    public let yUnits: CGFloat
    public let themeColor: HSBAColor
    public let pipeCount: Int
    public let allowOffSide: Bool
    
    public init(xUnits: CGFloat = 1, yUnits: CGFloat = 1, themeColor: HSBAColor, pipeCount: Int, allowOffSide: Bool = true) {
        self.xUnits = xUnits
        self.yUnits = yUnits
        self.themeColor = themeColor
        self.pipeCount = pipeCount
        self.allowOffSide = allowOffSide
    }
    
    public func draw(on context: CGContext) {
        context.saveGState()
        context.setAllowsAntialiasing(true)
        
        var pipes = [Pipe]()
        for _ in 1...pipeCount {
            pipes.append(Pipe(xUnits: xUnits, yUnits: yUnits, allowOffSide: allowOffSide));
        }
        
        // Draw all the endpoints first
        let endpointRadius = CGFloat(0.04)
        for pipe in pipes {
            context.saveGState()
            
            let endPoint1 = pipe.endPoints[0]
            let endPoint2 = pipe.endPoints[1]
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setFillColor(CGColor.create(from: themeColor.saturationAdjusted(by: -0.25)))
            context.fillPath()
            
            context.addEllipse(in: CGRect(x: endPoint1.x-endpointRadius,
                                          y: endPoint1.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.addEllipse(in: CGRect(x: endPoint2.x-endpointRadius,
                                          y: endPoint2.y-endpointRadius,
                                          width: endpointRadius*2,
                                          height: endpointRadius*2))
            context.setStrokeColor(.black)
            context.setLineWidth(0.003)
            context.strokePath()
            
            context.restoreGState()
        }

        // Now draw all the actual pipes
        let themeCGColor = CGColor.create(from: themeColor.saturationAdjusted(by: 0.1))
        var pipeNumber: CGFloat = 1.0
        for pipe in pipes {
            context.saveGState()
            
            context.setShadow(offset: CGSize(width: 1 * pipeNumber + 1,
                                             height: -1.5 * pipeNumber - 1),
                              blur: pipeNumber)
            
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.setLineWidth(0.05)
            context.setStrokeColor(.black)
            context.addPath(pipe.path)
            context.strokePath()
            
            context.setStrokeColor(themeCGColor)
            context.setLineWidth(0.045)
            context.addPath(pipe.path)
            context.strokePath()
            
            context.restoreGState()
            
            pipeNumber += 1.0
        }

        context.restoreGState()
    }
    
}

