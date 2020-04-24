//
//  BDButtonTrayView.swift
//  
//
//  Created by Dara Beng on 4/7/20.
//

import SwiftUI


/// A tray-like view that is normally pinned to the bottom-trailing of a scene.
///
/// The tray can contain many item buttons and has one main button.
///
public struct BDButtonTrayView: View {
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.layoutDirection) private var layoutDirection
    
    @ObservedObject var viewModel: BDButtonTrayViewModel
    
    let trayDiameter: CGFloat = 60
    let itemSpacing: CGFloat = 40
    let itemSize: CGSize = .init(width: 30, height: 30)
    
    var showMainItems: Bool {
        viewModel.subitems.isEmpty
    }
    
    var items: [BDButtonTrayItem] {
        showMainItems ? viewModel.items : viewModel.subitems
    }
    
    
    // MARK: Constructor
    
    public init(viewModel: BDButtonTrayViewModel) {
        self.viewModel = viewModel
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
                    trayItemButtons(items: items)
                }
                .padding(.bottom, trayDiameter + 8 + 16)
                
            } else {
                Color.clear.frame(width: trayDiameter, height: trayDiameter)
            }
        }
        .frame(minWidth: trayDiameter, maxWidth: trayDiameter, minHeight: trayDiameter)
        .background(viewModel.trayColor)
        .cornerRadius(trayDiameter / 2)
        .shadow(color: viewModel.trayShadowColor, radius: 6, x: 0, y: 3)
        .overlay(mainButton, alignment: .bottom)
        .overlay(verticalTrayItemLabels, alignment: .bottomTrailing)
        .animation(.spring())
        .gesture(trayExpandCollapseDragGesture())
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
                    trayItemButtons(items: items)
                }
                .padding(.trailing, trayDiameter + 8 + 16)
                
            } else {
                Color.clear.frame(width: trayDiameter, height: trayDiameter)
            }
        }
        .frame(minWidth: trayDiameter, minHeight: trayDiameter, maxHeight: trayDiameter)
        .background(viewModel.trayColor)
        .cornerRadius(trayDiameter / 2)
        .shadow(color: viewModel.trayShadowColor, radius: 6, x: 0, y: 3)
        .overlay(mainButton, alignment: .trailing)
        .animation(.spring())
        .gesture(trayExpandCollapseDragGesture())
    }
}


// MARK: - Main Button

extension BDButtonTrayView {
    
    var mainButton: some View {
        let item = viewModel.mainItem
        
        let action = { self.viewModel.mainItem.action(item) }
        
        let disabled = item.disabled || (viewModel.expanded && viewModel.shouldDisableMainItemWhenExpanded)
        
        let activeColor = item.activeColor ?? .accentColor
        
        let inactiveColor = item.inactiveColor ?? Color(.quaternaryLabel)
        
        let diameter = trayDiameter + (viewModel.expanded ? 0 : 8)
        
        let background = Circle()
            .fill(viewModel.trayColor)
            .shadow(color: viewModel.trayShadowColor, radius: 6)
        
        return Button(action: action) {
            Image(systemName: item.systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(disabled ? inactiveColor : activeColor)
                .frame(width: diameter, height: diameter)
        }
        .background(background)
        .animation(.spring())
        .disabled(disabled)
        .onReceive(item.objectWillChange, perform: viewModel.objectWillChange.send)
    }
    
    func itemColor(for item: BDButtonTrayItem) -> Color {
        if item.disabled {
            return item.inactiveColor ?? viewModel.itemInactiveColor
        } else {
            return item.activeColor ?? viewModel.itemActiveColor
        }
    }
}


// MARK: - Expand Indicator

extension BDButtonTrayView {
    
    func expandIndicator(systemImage: String, size: CGSize, padding: EdgeInsets) -> some View {
        let action = {
            let willExpand = !self.viewModel.expanded
            self.viewModel.onTrayWillExpand?(willExpand)
            self.viewModel.expanded = willExpand
        }
        
        return Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 32))
                .frame(width: size.width, height: size.height)
                .contentShape(Rectangle())
                .rotationEffect(.degrees(viewModel.expanded ? 180 : 0))
                .animation(.spring())
                .padding(padding)
                .foregroundColor(viewModel.expandIndicatorColor)
        }
        .disabled(viewModel.locked)
    }
    
    func trayExpandCollapseDragGesture() -> some Gesture {
        DragGesture().onEnded { drag in
            guard self.viewModel.locked == false else { return }
            
            let horizontal = self.verticalSizeClass == .compact
            
            // use the predicted translation to consider velocity
            let translation = drag.predictedEndTranslation
            
            // this indicates if the swipe should be recognized
            // example: if swipe up or down, the translation in y direction
            // should be greater then the translation in x direction
            // otherwise, the intention was not to swipe in y direction
            let isValidDrag: Bool
            if horizontal {
                isValidDrag = abs(translation.width) > abs(translation.height)
            } else {
                isValidDrag = abs(translation.height) > abs(translation.width)
            }
            
            guard isValidDrag else { return }
            
            // this indicates the drag amount with velocity
            // use x value if horizontal, else use y
            let value = horizontal ? translation.width : translation.height
            
            switch self.layoutDirection {
            case .leftToRight:
                // should expand
                if value < -25, self.viewModel.expanded == false {
                    self.viewModel.onTrayWillExpand?(true)
                    self.viewModel.expanded = true
                    return
                }
                
                // should collapse
                if value > 25, self.viewModel.expanded {
                    self.viewModel.onTrayWillExpand?(false)
                    self.viewModel.expanded = false
                    return
                }
            
            case .rightToLeft:
                // should expand
                if value > -25, self.viewModel.expanded == false {
                    self.viewModel.onTrayWillExpand?(true)
                    self.viewModel.expanded = true
                    return
                }
                
                // should collapse
                if value < 25, self.viewModel.expanded {
                    self.viewModel.onTrayWillExpand?(false)
                    self.viewModel.expanded = false
                    return
                }
            
            @unknown default:
                print("⚠️ have not supported layout direction: \(self.layoutDirection) ⚠️")
            }
        }
    }
}


// MARK: - Tray Item Buttons

extension BDButtonTrayView {
    
    var backToMainItemsButton: some View {
        let action: (BDButtonTrayItem) -> Void = { item in
            self.viewModel.subitems = []
        }
        let item = BDButtonTrayItem(title: "", systemImage: "xmark.circle", action: action)
        let color = viewModel.expandIndicatorColor
        return BDButtonTrayItemView(item: item, size: itemSize, activeColor: color, inactiveColor: color)
    }
    
    func trayItemButtons(items: [BDButtonTrayItem]) -> some View {
        ForEach(items) { item in
            BDButtonTrayItemView(
                item: item,
                size: self.itemSize,
                activeColor: self.itemColor(for: item),
                inactiveColor: self.itemColor(for: item)
            )
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
                        .foregroundColor(self.itemColor(for: item))
                        .background(self.viewModel.trayColor)
                        .cornerRadius(self.itemSize.height / 2)
                        .shadow(color: self.viewModel.trayShadowColor.opacity(0.5), radius: 3, x: 0, y: 0)
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
