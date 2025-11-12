//
//  ShadowType.swift
//  Reca
//
//  Created by Shuja on 11/11/2025.
//

import UIKit

enum ShadowType {

    enum Direction {

        case up
        case down
    }

    private enum Constant {

        static var color: UIColor { Global.theme.shadow }
    }

    /// Light shadow with direction. Default direction is down.
    case light(direction: Direction = .down)
    /// Medium shadow with direction. Default direction is down.
    case medium(direction: Direction = .down)
    /// Strong shadow with direction. Default direction is down.
    case strong(direction: Direction = .down)

    var alpha: Float {
        switch self {
        case .light,
             .medium:
            return 0.08
        case .strong:
            return 0.16
        }
    }

    var x: CGFloat { .zero }

    var y: CGFloat {
        switch self {
        case .light(let direction):
            switch direction {
            case .down:
                return 2.0
            default:
                return -2.0
            }
        case .medium(let direction),
             .strong(let direction):
            switch direction {
            case .down:
                return 6.0
            case .up:
                return -6.0
            }
        }
    }

    var color: UIColor { Constant.color }

    var blur: CGFloat {
        switch self {
        case .light:
            return 6.0
        case .medium,
             .strong:
            return 20.0
        }
    }
}
