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
    
    var showSubitems: Bool {
        viewModel.subitems.isEmpty == false
    }
    
    var items: [BDButtonTrayItem] {
        showSubitems ? viewModel.subitems : viewModel.items
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
            if viewModel.locked {
                lockIndicator(padding: EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
            } else {
                expandIndicator(
                    systemImage: "chevron.compact.up",
                    size: CGSize(width: trayDiameter, height: 25),
                    padding: EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
                )
            }
            
            if viewModel.expanded {
                VStack(spacing: itemSpacing) {
                    if showSubitems {
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
        .overlay(verticalTrayItemLabels, alignment: .bottomTrailing)
        .overlay(mainButton, alignment: .bottom)
        .animation(.spring())
        .gesture(trayExpandCollapseDragGesture())
    }
    
    
    // MARK: Compact Body
    
    var verticalCompactBody: some View {
        HStack(spacing: 16) {
            if viewModel.locked {
                lockIndicator(padding: EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
            } else {
                expandIndicator(
                    systemImage: layoutDirection == .leftToRight ? "chevron.compact.left" : "chevron.compact.right",
                    size: CGSize(width: 25, height: trayDiameter),
                    padding: EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0)
                )
            }
            
            if viewModel.expanded {
                HStack(spacing: itemSpacing) {
                    if showSubitems {
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
        
        let disabled = item.disabled || (viewModel.expanded && viewModel.shouldDisableMainItemWhenExpanded)
        
        let diameter = trayDiameter + (viewModel.expanded ? 0 : 8)
        
        let color = getColor(for: item, disabled: disabled)
        
        let background = Circle()
            .fill(viewModel.trayColor)
            .shadow(color: viewModel.trayShadowColor, radius: 6)
        
        let label = trayItemLabel(title: item.title, textColor: color)
            .offset(x: -(diameter + 16))
            .opacity(verticalSizeClass == .compact ? 0 : 1)
            .transition(.move(edge: .trailing))
            .animation(.interactiveSpring(response: 0.5))
        
        return BDButtonTrayItemView(
            item: item,
            size: itemSize,
            activeColor: getColor(for: item, disabled: disabled),
            inactiveColor: getColor(for: item, disabled: disabled)
        )
        .frame(width: diameter, height: diameter)
        .contentShape(Circle())
        .background(background)
        .overlay(label, alignment: .trailing)
        .animation(.spring())
        .allowsHitTesting(disabled == false)
        .onReceive(item.objectWillChange, perform: viewModel.objectWillChange.send)
    }
    
    func getColor(for item: BDButtonTrayItem, disabled: Bool) -> Color {
        if disabled {
            return item.inactiveColor ?? viewModel.itemInactiveColor
        } else {
            return item.activeColor ?? viewModel.itemActiveColor
        }
    }
}


// MARK: - Expand & Lock Indicator

extension BDButtonTrayView {
    
    func lockIndicator(padding: EdgeInsets) -> some View {
        Circle()
            .fill(viewModel.expandIndicatorColor)
            .frame(width: 7, height: 7)
            .padding(padding)
    }
    
    func expandIndicator(systemImage: String, size: CGSize, padding: EdgeInsets) -> some View {
        Button(action: {
            let willExpand = self.viewModel.expanded == false
            self.viewModel.onTrayWillExpand?(willExpand)
            self.viewModel.expanded = willExpand
        }) {
            Image(systemName: systemImage)
                .font(.system(size: 32))
                .frame(width: size.width, height: size.height)
                .contentShape(Rectangle())
                .rotationEffect(.degrees(viewModel.expanded ? 180 : 0))
                .animation(.spring())
                .padding(padding)
                .foregroundColor(viewModel.expandIndicatorColor)
        }
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
        let item = BDButtonTrayItem(title: "", image: .system("xmark.circle"), action: action)
        let color = viewModel.expandIndicatorColor
        return BDButtonTrayItemView(item: item, size: itemSize, activeColor: color, inactiveColor: color)
    }
    
    func trayItemButtons(items: [BDButtonTrayItem]) -> some View {
        ForEach(items) { item in
            BDButtonTrayItemView(
                item: item,
                size: self.itemSize,
                activeColor: self.getColor(for: item, disabled: item.disabled),
                inactiveColor: self.getColor(for: item, disabled: item.disabled)
            )
                .onReceive(item.objectWillChange, perform: self.viewModel.objectWillChange.send)
        }
    }
    
    var verticalTrayItemLabels: some View {
        VStack(spacing: itemSpacing) {
            VStack(alignment: .trailing, spacing: itemSpacing) {
                ForEach(items) { item in
                    self.trayItemLabel(
                        title: item.title,
                        textColor: self.getColor(for: item, disabled: item.disabled)
                    )
                }
            }
            .padding(.bottom, trayDiameter + 8 + 16) // mimic tray item buttons
        }
        .frame(maxWidth: .infinity, minHeight: 0)
        .opacity(viewModel.expanded ? 1 : 0)
        .offset(x: -(trayDiameter + 16))
    }
    
    func trayItemLabel(title: String, textColor: Color) -> some View {
        Text(LocalizedStringKey(title))
            .frame(maxWidth: 250)
            .frame(height: itemSize.height)
            .font(.system(size: 17, weight: .regular))
            .lineLimit(1)
            .fixedSize()
            .padding(.horizontal, 16)
            .foregroundColor(textColor)
            .background(viewModel.trayColor)
            .cornerRadius(itemSize.height / 2)
            .shadow(color: viewModel.trayShadowColor.opacity(0.5), radius: 3, x: 0, y: 0)
            .opacity(title.isEmpty ? 0 : 1)
            .animation(nil)
    }
}
