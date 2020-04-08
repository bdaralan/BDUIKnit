//
//  BDButtonTrayView.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// A tray view that can expand and collapse.
///
/// The tray can contain many item buttons and has one main button.
public struct BDButtonTrayView: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.layoutDirection) private var layoutDirection
    
    @ObservedObject var viewModel: BDButtonTrayViewModel
    
    @ObservedObject var configuration: BDButtonTrayConfiguration
    
    let itemSpacing: CGFloat = 40
    
    let itemSize: CGSize = .init(width: 30, height: 30)
    
    let trayDiameter: CGFloat = 60
    
    var showMainItems: Bool {
        viewModel.subitems.isEmpty
    }
    
    var items: [BDButtonTrayItem] {
        showMainItems ? viewModel.items : viewModel.subitems
    }
    
    var itemActiveColor: Color {
        showMainItems ? configuration.itemActiveColor : configuration.subitemActiveColor
    }
    
    var itemInactiveColor: Color {
        showMainItems ? configuration.itemInactiveColor : configuration.subitemInactiveColor
    }
    
    
    // MARK: Constructor
    
    public init(viewModel: BDButtonTrayViewModel, configuration: BDButtonTrayConfiguration? = nil) {
        self.viewModel = viewModel
        self.configuration = configuration ?? .init()
    }
    
    // MARK: Main Body
    
    public var body: some View {
        if verticalSizeClass == .compact {
            return AnyView(verticalCompactBody)
        } else {
            return AnyView(verticalRegularBody)
        }
    }
    
    
    // MARK: Regular Body
    
    var verticalRegularBody: some View {
        VStack(spacing: 16) {
            expandIndicator(
                systemImage: "chevron.compact.up",
                size: CGSize(width: trayDiameter, height: 25),
                padding: EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
            )
            
            if viewModel.expanded {
                VStack(spacing: itemSpacing) {
                    if !showMainItems {
                        backToMainItemsButton
                    }
                    trayItemButtons(
                        items: items,
                        active: itemActiveColor,
                        inactive: itemInactiveColor
                    )
                }
                .padding(.bottom, trayDiameter + 8 + 16)
                
            } else {
                Color.clear.frame(width: trayDiameter, height: trayDiameter)
            }
        }
        .frame(minWidth: trayDiameter, maxWidth: trayDiameter, minHeight: trayDiameter)
        .background(configuration.trayColor)
        .cornerRadius(trayDiameter / 2)
        .shadow(color: configuration.trayShadowColor, radius: 6, x: 0, y: 3)
        .overlay(mainButton, alignment: .bottom)
        .overlay(verticalTrayItemLabels, alignment: .bottomTrailing)
        .animation(.spring())
    }
    
    
    // MARK: Compact Body
    
    var verticalCompactBody: some View {
        HStack(spacing: 16) {
            expandIndicator(
                systemImage: layoutDirection == .leftToRight ? "chevron.compact.left" : "chevron.compact.right",
                size: CGSize(width: 25, height: trayDiameter),
                padding: EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
            )
            
            if viewModel.expanded {
                HStack(spacing: itemSpacing) {
                    if !showMainItems {
                        backToMainItemsButton
                    }
                    trayItemButtons(
                        items: items,
                        active: itemActiveColor,
                        inactive: itemInactiveColor
                    )
                }
                .padding(.trailing, trayDiameter + 8 + 16)
                
            } else {
                Color.clear.frame(width: trayDiameter, height: trayDiameter)
            }
        }
        .frame(minWidth: trayDiameter, minHeight: trayDiameter, maxHeight: trayDiameter)
        .background(configuration.trayColor)
        .cornerRadius(trayDiameter / 2)
        .shadow(color: configuration.trayShadowColor, radius: 6, x: 0, y: 3)
        .overlay(mainButton, alignment: .trailing)
        .animation(.spring())
    }
}


// MARK: - Main Button

extension BDButtonTrayView {
    
    var mainButton: some View {
        let diameter = trayDiameter + (viewModel.expanded ? 0 : 8)
        
        let background = Circle()
            .fill(configuration.trayColor)
            .shadow(color: configuration.trayShadowColor, radius: 6)
        
        let imageColor = viewModel.expanded ? configuration.buttonInactiveColor : configuration.buttonActiveColor
        
        return Button(action: handleMainButtonTapped) {
            Image(systemName: configuration.buttonSystemImage)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(imageColor)
                .frame(width: diameter, height: diameter)
        }
        .background(background)
        .animation(.spring())
        .disabled(viewModel.expanded)
    }
    
    func handleMainButtonTapped() {
        viewModel.action?()
    }
}


// MARK: - Expand Indicator

extension BDButtonTrayView {
    
    func expandIndicator(systemImage: String, size: CGSize, padding: EdgeInsets) -> some View {
        Button(action: handleExpandIndicatorTapped) {
            Image(systemName: systemImage)
                .font(.system(size: 32))
                .frame(width: size.width, height: size.height)
                .contentShape(Rectangle())
                .rotationEffect(.degrees(viewModel.expanded ? 180 : 0))
                .animation(.spring())
                .padding(padding)
                .foregroundColor(configuration.expandIndicatorColor)
        }
    }
    
    func handleExpandIndicatorTapped() {
        let willExpand = !viewModel.expanded
        viewModel.onTrayWillExpand?(willExpand)
        viewModel.expanded = willExpand
    }
}

// MARK: - Tray Item Buttons

extension BDButtonTrayView {
    
    var backToMainItemsButton: some View {
        let action: (BDButtonTrayItem) -> Void = { item in
            self.viewModel.subitems = []
        }
        let item = BDButtonTrayItem(title: "", systemImage: "xmark.circle", action: action)
        let color = configuration.expandIndicatorColor
        return BDButtonTrayItemView(item: item, size: itemSize, activeColor: color, inactiveColor: color)
    }
    
    func trayItemButtons(items: [BDButtonTrayItem], active: Color, inactive: Color) -> some View {
        ForEach(items) { item in
            BDButtonTrayItemView(item: item, size: self.itemSize, activeColor: active, inactiveColor: inactive)
        }
    }
    
    var verticalTrayItemLabels: some View {
        VStack(spacing: itemSpacing) {
            VStack(alignment: .trailing, spacing: itemSpacing) {
                ForEach(items) { item in
                    Text(item.title)
                        .frame(height: self.itemSize.height)
                        .font(.system(size: 17, weight: .regular))
                        .lineLimit(1)
                        .fixedSize()
                        .padding(.horizontal, 16)
                        .foregroundColor(item.disabled ? self.itemInactiveColor : self.itemActiveColor)
                        .background(self.configuration.trayColor)
                        .cornerRadius(self.itemSize.height / 2)
                        .shadow(color: self.configuration.trayShadowColor.opacity(0.5), radius: 3, x: 0, y: 0)
                        .opacity(item.title.isEmpty ? 0 : 1)
                        .animation(nil)
                        .onReceive(item.objectWillChange, perform: { _ in self.viewModel.objectWillChange.send() })
                }
            }
            .padding(.bottom, trayDiameter + 8 + 16) // mimic tray item buttons
        }
        .frame(maxWidth: .infinity, minHeight: 0)
        .opacity(viewModel.expanded ? 1 : 0)
        .offset(x: -(trayDiameter + 16))
        .animation(.interactiveSpring(response: 0.5))
    }
}
