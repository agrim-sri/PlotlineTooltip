# **PlotlineTooltips: A Dynamic SwiftUI Tooltip Library**

An intuitive and customizable SwiftUI tooltip tailored to deliver a seamless user experience.With PlotlineTooltips, you can easily embed rich content, including images and icons, within interactive tooltips. This library is crafted with modern SwiftUI practices and emphasizes user configurability.

__Features__
* __Dynamic Alignments:__ Set tooltip alignments with ease. Supports multiple orientations including leading, trailing, top, and bottom.
* __Interactive Content:__ Seamlessly embed text, images, and system icons within tooltips.
* __User-friendly Configuration:__ Context menus enable end-users to adjust tooltip properties directly, enhancing the customization experience.
* __Adaptive Design:__ Built responsively for diverse SwiftUI views and device orientations

## Memory Profiling

<img width="1440" alt="Screenshot 2023-08-20 at 4 03 31 PM" src="https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/ca0faa6e-6cd9-4ca0-b3a7-4aece3532f86">


## Screenshot
|Screen 1|Screen 2|
|:---:|:---:|
|<img width="314" alt="Screenshot 2023-08-20 at 4 29 55 PM" src="https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/e4e3e588-98e1-407f-8da6-19f86d5f1138">|<img width="314" alt="Screenshot 2023-08-20 at 4 35 50 PM" src="https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/8c105e06-c5be-4d13-acff-bd45c03a165a">|
|<img width="314" alt="Screenshot 2023-08-20 at 4 29 55 PM" src="https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/6e6ef672-5744-4da4-a8a3-f460aeac4885">|<img width="313" alt="Screenshot 2023-08-20 at 4 34 38 PM" src="https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/f6d51fa9-dbc2-4f85-994a-8ddda3c75d28">|


## Screen Recording

https://github.com/agrim-sri/PlotlineTooltip/assets/96521043/57570e53-522d-4f82-935a-379e734d366d

## Usage

```swift
.tooltip(isPresented: $data.isPresented[index], alignment: alignments[data.alignmentIndexes[index]], constant: data.constants[index], foreground: {
                        HStack {
                            Image(data.imageNames[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            Label(data.tooltips[index], systemImage: "heart")
                        }
                        .frame(width: 200)
                        .padding(data.textPaddings[index])
                        .font(Font.system(size: data.textSizes[index]))
                        .foregroundColor(data.textColors[index])
                        .background(Color.black)
                    })
```
