import SpriteKit


class GameBoard {
    let node: SKShapeNode
    let size: Int

    private var tiles: [Tile]

    private var numberOfTiles: Int {
        size * size
    }

    private var tileSize: CGSize {
        CGSize(
            width: node.frame.width / CGFloat(size),
            height: node.frame.height / CGFloat(size)
        )
    }

    init(size: Int) {
        self.size = size

        node = SKShapeNode()
        node.fillColor = .red
        node.strokeColor = .clear
        node.position = .zero

        tiles = []
        generateBoard()
    }

    private func generateBoard() {
        var tileX = 0
        var tileY = 0
        (0..<numberOfTiles).forEach { _ in
            let coord = TileCoordinate(x: tileX, y: tileY)
            let tile = Tile(coordinate: coord)
            tile.node.texture = Resources.tiles.undiscovered
            node.addChild(tile.node)
            tiles.append(tile)

            tileX += 1
            if tileX >= size {
                tileX = 0
                tileY += 1
            }
        }

        let numberOfBombs = Int((CGFloat(numberOfTiles) / 10).rounded(.up))
        var bombs: [Tile] = []

        while bombs.count < numberOfBombs {
            guard let tile = tiles.randomElement() else { break }
            guard !tile.isBomb else { continue }
            tile.isBomb = true
            bombs.append(tile)
        }

        print("TILES:")
        print(tiles)
    }

    func repositionBoard(to boardSize: CGSize) {
        node.path = CGPath(rect: CGRect(x: -boardSize.width/2, y: -boardSize.height/2, width: boardSize.width, height: boardSize.height), transform: nil)

        var col = 0
        var row = 0

        tiles.forEach { tile in
            tile.node.size = tileSize

            let x = node.frame.minX + CGFloat(col) * tileSize.width
            let y = node.frame.maxY - CGFloat(row) * tileSize.height

            tile.node.position = CGPoint(x: x, y: y)

            col += 1
            if col >= size {
                col = 0
                row += 1
            }
        }
    }

    func gameOver() {
        tiles.filter { $0.isBomb }
            .forEach { $0.node.texture = Resources.tiles.bomb }
    }

    func revealTile(at position: CGPoint) {
        guard let tile = tileAt(position: position) else { return }

        if tile.isBomb {
            tile.isRevealed = true
            gameOver()
            tile.node.texture = Resources.tiles.bombRed
            return
        } else {
            reveal(tile: tile)
        }
    }

    func toggleFlag(at position: CGPoint) {
        guard let tile = tileAt(position: position) else { return }
        guard !tile.isRevealed else { return }

        tile.isFlagged.toggle()
        if tile.isFlagged {
            tile.node.texture = Resources.tiles.flag
        } else {
            tile.node.texture = Resources.tiles.undiscovered
        }
    }

    private func reveal(tile: Tile) {
        tile.isRevealed = true
        let adjacentBombCount = numberOfAdjacentBombs(for: tile)
        tile.node.texture = textureForAdjacentBombCount(adjacentBombCount)

        if adjacentBombCount == 0 {
            // sprawl out
            for tile in adjacentTiles(for: tile).filter({ !$0.isRevealed }) {
                if !tile.isBomb {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(30)) {
                        self.reveal(tile: tile)
                    }
                }
            }
        }
    }

    private func textureForAdjacentBombCount(_ count: Int) -> SKTexture {
        switch count {
        case 0: return Resources.tiles.clear
        case 1: return Resources.tiles.one
        case 2: return Resources.tiles.two
        case 3: return Resources.tiles.three
        case 4: return Resources.tiles.four
        case 5: return Resources.tiles.five
        case 6: return Resources.tiles.six
        case 7: return Resources.tiles.seven
        case 8: return Resources.tiles.eight
        default: fatalError("Should not have more than 8 neighboring bombs")
        }
    }

    private func adjacentTiles(for t: Tile) -> [Tile] {
        [
            tile(at: t.coordinate.north),
            tile(at: t.coordinate.northEast),
            tile(at: t.coordinate.east),
            tile(at: t.coordinate.southEast),
            tile(at: t.coordinate.south),
            tile(at: t.coordinate.southWest),
            tile(at: t.coordinate.west),
            tile(at: t.coordinate.northWest)
        ].compactMap { $0 }
    }

    private func numberOfAdjacentBombs(for tile: Tile) -> Int {
        adjacentTiles(for: tile)
            .filter { $0.isBomb }
            .count
    }

    private func tile(at coordinate: TileCoordinate) -> Tile? {
        guard (0..<size).contains(coordinate.x)
            && (0..<size).contains(coordinate.y) else {
                return nil
        }
        let tileIndex = (coordinate.y * size) + coordinate.x
        let tile = tiles[tileIndex]
        return tile
    }

    private func coordinate(at pixelPosition: CGPoint) -> TileCoordinate {
        let tileX = Int(pixelPosition.x / node.frame.width * CGFloat(size))
        let tileY = Int(pixelPosition.y / node.frame.height * CGFloat(size))
        return TileCoordinate(x: tileX, y: tileY)
    }

    private func tileAt(position: CGPoint) -> Tile? {
        let x = position.x + node.frame.width/2
        let y = node.frame.height - position.y - node.frame.height/2

        guard x > 0 && x <= node.frame.width &&
            y > 0 && y <= node.frame.height else { return nil }

        let coord = coordinate(at: CGPoint(x: x, y: y))
        return tile(at: coord)
    }
}
