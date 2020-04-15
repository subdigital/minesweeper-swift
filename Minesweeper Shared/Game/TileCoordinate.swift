struct TileCoordinate {
    let x: Int
    let y: Int

    var west: TileCoordinate {
        TileCoordinate(x: x-1, y: y)
    }

    var north: TileCoordinate {
        TileCoordinate(x: x, y: y - 1)
    }

    var south: TileCoordinate {
        TileCoordinate(x: x, y: y + 1)
    }

    var east: TileCoordinate {
        TileCoordinate(x: x + 1, y: y)
    }

    var northEast: TileCoordinate {
        TileCoordinate(x: x + 1, y: y - 1)
    }

    var southEast: TileCoordinate {
        TileCoordinate(x: x + 1, y: y + 1)
    }

    var southWest: TileCoordinate {
        TileCoordinate(x: x - 1, y: y + 1)
    }

    var northWest: TileCoordinate {
        TileCoordinate(x: x - 1, y: y - 1)
    }
}

extension TileCoordinate : CustomDebugStringConvertible {
    var debugDescription: String {
        "\(x), \(y)"
    }
}
