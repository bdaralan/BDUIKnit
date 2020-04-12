# BDUIKnit

BDUIKnit is a collection of SwiftUI custom reusable UI components and extensions.

## Project Goals

- To collect my personal custom reusable UI and extensions and put them in one place.
- To create custom reusable UI and share them.
- To learn and share what I learnt building these UI & extensions.

## Todo

- [ ] Gotta have a logo. σ(^_^;)
- [ ] Add screenshots for every UI components.
- [ ] Add a quick how-to for all of them.
- [x] Add `ButtonTrayView`
- [x] Add `Color` extensions
- [x] Add `ModalTextField`
- [ ] Add `ModalTextView`

## UI Preview

### Quick Introduction

Most of the UI components are following **MVVM** design pattern; so, there will always be **Views** and their corresponding **View Models**. Some view model has UI customization properties. Others are extracted out to a configuration object. Not all view models are `class`, some of them are `struct`.

### `BDButtonTrayView`

A tray-like view that is normally pinned to the bottom-trailing of a scene.

![BDButtonTrayPreview-1][button-tray-preview]

<p align="center"><small>Regular Vertical Size Class</small></p>

![BDButtonTrayPreview-2][button-tray-preview-horizontal]

<p align="center"><small>Compact Vertical Size Class</small></p>

*Get Started:*

- `BDButtonTrayView`
- `BDButtonTrayViewModel`
- `BDButtonTrayConfiguration`
- `BDButtonTrayItem`

For sample code, see [`ButtonTrayViewPreview`](https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ButtonTrayViewPreview.swift)

### `BDModalTextField`

A modal text field intended to be used as a presentation sheet when need to get input from user.

![BDModalTextFieldPreview][modal-text-field-preview]

*Get Started:*

- `BDModalTextField`
- `BDModelTextFieldModel`

For sample code, see [`ModalTextFieldPreview`](https://github.com/iDara09/BDUIKnitProject/blob/master/BDUIKnitProject/ModalTextFieldPreview.swift)

<!-- Preview Image Link -->

[button-tray-preview]: https://drive.google.com/uc?id=1By9KpfGEFXDeb4pjxoIIE82GEnyDDXWg

[button-tray-preview-horizontal]: https://drive.google.com/uc?id=14He_C4QiDxDA7a4YBwrCeXYBPWdGLDjg

[modal-text-field-preview]: https://drive.google.com/uc?id=1sy3BwKuUSNtIKvuuvGwDPXtsavWRVMfr
