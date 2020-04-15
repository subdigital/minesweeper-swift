import SpriteKit

struct Resources {

    static var tiles: Tiles!

    private init() { }

    static func initialize() {
        let tilesTexture = SKTexture(imageNamed: "tiles")
        tiles = Tiles(tileSheet: SpriteSheet(atlas: tilesTexture, columns: 14, rows: 1, margin: 0, spacing: 0))
    }

    struct Tiles {
        let clear: SKTexture
        let undiscovered: SKTexture
        let one: SKTexture
        let two: SKTexture
        let three: SKTexture
        let four: SKTexture
        let five: SKTexture
        let six: SKTexture
        let seven: SKTexture
        let eight: SKTexture

        let flag: SKTexture

        let bomb: SKTexture
        let bombRed: SKTexture

        init(tileSheet: SpriteSheet) {
            clear = tileSheet.textureFor(row: 0, col: 0)!
            undiscovered = tileSheet.textureFor(row: 0, col: 9)!
            bomb = tileSheet.textureFor(row: 0, col: 11)!
            bombRed = tileSheet.textureFor(row: 0, col: 12)!

            one = tileSheet.textureFor(row: 0, col: 1)!
            two = tileSheet.textureFor(row: 0, col: 2)!
            three = tileSheet.textureFor(row: 0, col: 3)!
            four = tileSheet.textureFor(row: 0, col: 4)!
            five = tileSheet.textureFor(row: 0, col: 5)!
            six = tileSheet.textureFor(row: 0, col: 6)!
            seven = tileSheet.textureFor(row: 0, col: 7)!
            eight = tileSheet.textureFor(row: 0, col: 8)!

            flag = tileSheet.textureFor(row: 0, col: 10)!
        }
    }
}
