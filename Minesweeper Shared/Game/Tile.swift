import SpriteKit

class Tile {
    let node: SKSpriteNode

    let coordinate: TileCoordinate
    var isBomb: Bool = false
    var isRevealed: Bool = false
    var isFlagged: Bool = false

    init(coordinate: TileCoordinate) {
        node = SKSpriteNode()
        node.color = .blue
        node.anchorPoint = CGPoint(x: 0, y: 1.0)
        self.coordinate = coordinate
    }
}

extension Tile : CustomDebugStringConvertible {
    var debugDescription: String {
        "Tile[\(coordinate.debugDescription)]\(isBomb ? "💣" : "")"
    }
}
