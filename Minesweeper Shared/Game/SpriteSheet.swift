import SpriteKit

struct SpriteSheet {
    let atlas: SKTexture
    let columns: Int
    let rows: Int
    let margin: Int
    let spacing: Int

    var frameSize: CGSize {
        let atlasSize = atlas.size()

        let horizontalSpacing = 2 * margin + spacing * (columns - 1)
        let verticalSpacing = 2 * margin + spacing * (rows - 1)

        return CGSize(
            width: (atlasSize.width - CGFloat(horizontalSpacing)) / CGFloat(columns),
            height: (atlasSize.height - CGFloat(verticalSpacing)) / CGFloat(rows)
        )
    }

    func textureFor(row: Int, col: Int, filteringMode: SKTextureFilteringMode = .nearest) -> SKTexture? {
        guard (0..<rows) ~= row && (0..<columns) ~= col else { return nil }

        let frameSize = self.frameSize
        let textureRect = CGRect(
            x: CGFloat(margin) + CGFloat(col) * (frameSize.width + CGFloat(spacing)) - CGFloat(spacing),
            y: CGFloat(margin) + CGFloat(row) * (frameSize.height + CGFloat(spacing)) - CGFloat(spacing),
            width: frameSize.width,
            height: frameSize.height)

        let atlasSize = atlas.size()
        let normalizedRect = CGRect(
            x: textureRect.origin.x / atlasSize.width,
            y: textureRect.origin.y / atlasSize.height,
            width: frameSize.width / atlasSize.width,
            height: frameSize.height / atlasSize.height
        )

        let texture = SKTexture(rect: normalizedRect, in: atlas)
        texture.filteringMode = filteringMode
        return texture
    }
}
