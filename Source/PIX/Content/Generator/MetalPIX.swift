//
//  MetalGeneratorPIX.swift
//  Pixels
//
//  Created by Hexagons on 2018-09-07.
//  Copyright © 2018 Hexagons. All rights reserved.
//

import UIKit

public class MetalPIX: PIXGenerator, PIXMetal, PIXofaKind {
    
    var kind: PIX.Kind = .metal
    
    let metalFileName = "ContentGeneratorMetalPIX.metal"
    override open var shader: String { return "contentGeneratorMetalPIX" }
    
    var metalEmbedCode: String
    var metalCode: String? {
        do {
          return try pixels.embedMetalCode(uniforms: metalUniforms, code: metalEmbedCode, fileName: metalFileName)
        } catch {
            pixels.log(pix: self, .error, .metal, "Metal code could not be generated.", e: error)
            return nil
        }
    }
    
    public var metalUniforms: [MetalUniform] = [] { didSet { setNeedsRender() } }
    enum CodingKeys: String, CodingKey {
        case metalUniforms
    }
    override var uniforms: [CGFloat] {
        return metalUniforms.map({ metalUniform -> CGFloat in
            return metalUniform.value
        })
    }
    
    public init(res: Res, code: String) {
        metalEmbedCode = code
        super.init(res: res)
    }
    
    // MARK: JSON
    
    required convenience init(from decoder: Decoder) throws {
        self.init(res: ._128, code: "") // CHECK
        let container = try decoder.container(keyedBy: CodingKeys.self)
        metalUniforms = try container.decode([MetalUniform].self, forKey: .metalUniforms)
        setNeedsRender()
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(metalUniforms, forKey: .metalUniforms)
    }
    
}