/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: SearchTabContent
 * Author: Victor
 * Date: 2023/07/07 14:33
 * Description: 
 * -----------------------------------------------------------------
 */
import Constants from '../../util/Constants'
@Preview
@Component
export struct SearchTabContent {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  datas = ["aa","bb","cc","dd"]
  colors = [Color.Pink,Color.Blue,Color.Brown,Color.Orange]

  build() {
    Stack() {
      Swiper() {
        ForEach(this.datas, (item: string) => {
          Text(item)
            .width('90%')
            .height('100%')
            .backgroundColor(this.colors[this.currentIndex]).textAlign(TextAlign.Center)
            .fontSize(36)
        }, item => item)
      }
      .index(this.currentIndex)
      .autoPlay(false)
      .interval(4000)
      .indicator(false)
      .loop(false)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        console.info(index.toString())
        this.currentIndex = index
      })

      Tabs({ barPosition: BarPosition.Start, controller: this.controller }) {
        TabContent() {
        }.tabBar(this.TabBuilder(0, 'green'))
        .height(20)

        TabContent() {
        }.tabBar(this.TabBuilder(1, 'blue'))
        .height(20)

        TabContent() {
        }.tabBar(this.TabBuilder(2, 'yellow'))
        .height(20)

        TabContent() {
        }.tabBar(this.TabBuilder(3, 'pink'))
        .height(20)
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(Constants.MATCH_PARENT)
      .height(56)
      .backgroundColor('#99000000')
    }
    .align(Alignment.Top)
  }

  @Builder TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }

}
 