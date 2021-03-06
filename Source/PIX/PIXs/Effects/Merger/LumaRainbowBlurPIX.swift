//
//  LumaRainbowBlurPIX.swift
//  PixelKit
//
//  Created by Hexagons on 2018-08-09.
//  Open Source - MIT License
//

import LiveValues
import RenderKit
import CoreGraphics

@available(*, deprecated, message: "New PIX Name: LumaRainbowBlurPIX")
public typealias RainbowLumaBlurPIX = LumaRainbowBlurPIX

public class LumaRainbowBlurPIX: PIXMergerEffect, PIXAuto {
    
    override open var shaderName: String { return "effectMergerLumaRainbowBlurPIX" }
    
    // MARK: - Public Properties
    
    public enum RainbowLumaBlurStyle: String, CaseIterable {
        case circle
        case angle
        case zoom
        var index: Int {
            switch self {
            case .circle: return 1
            case .angle: return 2
            case .zoom: return 3
            }
        }
    }
    
    public var style: RainbowLumaBlurStyle = .angle { didSet { setNeedsRender() } }
    public var radius: LiveFloat = 0.5
    public var quality: SampleQualityMode = .mid { didSet { setNeedsRender() } }
    public var angle: LiveFloat = LiveFloat(0.0, min: -0.5, max: 0.5)
    public var position: LivePoint = .zero
    public var light: LiveFloat = 1.0
    
    // MARK: - Property Helpers
    
    override public var liveValues: [LiveValue] {
        return [radius, angle, position, light]
    }
    
    open override var uniforms: [CGFloat] {
        return [CGFloat(style.index), radius.uniform * 32 * 10, CGFloat(quality.rawValue), angle.uniform, position.x.uniform, position.y.uniform, light.uniform]
    }
    
    // MARK: - Life Cycle
    
    public required init() {
        super.init(name: "Luma Rainbow Blur", typeName: "pix-effect-merger-luma-rainbow-blur")
        extend = .hold
    }
    
}

public extension NODEOut {
    
    @available(*, deprecated, renamed: "_lumaRainbowBlur(with:radius:angle:)")
    func _rainbowLumaBlur(with pix: PIX & NODEOut, radius: LiveFloat, angle: LiveFloat) -> LumaRainbowBlurPIX {
        _lumaRainbowBlur(with: pix, radius: radius, angle: angle)
    }
    
    func _lumaRainbowBlur(with pix: PIX & NODEOut, radius: LiveFloat, angle: LiveFloat) -> LumaRainbowBlurPIX {
        let rainbowLumaBlurPix = LumaRainbowBlurPIX()
        rainbowLumaBlurPix.name = ":rainbowLumaBlur:"
        rainbowLumaBlurPix.inputA = self as? PIX & NODEOut
        rainbowLumaBlurPix.inputB = pix
        rainbowLumaBlurPix.radius = radius
        rainbowLumaBlurPix.angle = angle
        return rainbowLumaBlurPix
    }
    
}
