//
//  MovementComponent+Comparable.swift
//  PixelWorld
//
//  Created by Artem Pereverzev on 09.04.2025.
//
extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
