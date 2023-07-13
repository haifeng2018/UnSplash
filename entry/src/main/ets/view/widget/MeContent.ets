/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: MeContent
 * Author: Victor
 * Date: 2023/07/12 17:10
 * Description: 
 * -----------------------------------------------------------------
 */
import { photos_tabs } from '../../model/MePageModel'
import Constants from '../../util/Constants'
import { MyCollectionsTabContent } from './MyCollectionsTabContent'
import { MyLikesTabContent } from './MyLikesTabContent'
import { MyPhotosTabContent } from './MyPhotosTabContent'
@Component
@Preview
export struct MeContent {
  @State currentIndex: number = 0

  build() {
    Column() {
      Row(){
        this.TabBuilder(0)
        this.TabBuilder(1)
        this.TabBuilder(2)
      }
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_40'))
      .backgroundColor($r('app.color.color_4DEEEEEE'))
      .borderRadius($r('app.float.vp_8'))

      Swiper() {
        MyPhotosTabContent()
        MyLikesTabContent()
        MyCollectionsTabContent()
      }
      .width(Constants.MATCH_PARENT)
      .vertical(false)
      .indicator(false)
      .index(this.currentIndex)
      .autoPlay(false)
      .interval(10000)
      .loop(false)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        this.currentIndex = index
      })

    }
    .margin({top: $r('app.float.vp_30'),left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
  }

  @Builder TabBuilder(index: number) {
    Text(photos_tabs[index])
      .height(Constants.MATCH_PARENT)
      .layoutWeight(1)
      .backgroundColor(this.currentIndex === index ? $r('app.color.color_4DEEEEEE') : $r('app.color.transparent'))
      .borderRadius($r('app.float.vp_8'))
      .padding($r('app.float.vp_12'))
      .textAlign(TextAlign.Center)
      .fontSize(this.currentIndex === index ? $r('app.float.fp_18') : $r('app.float.fp_16'))
      .fontColor($r('app.color.white'))
      .onClick(() => {
        this.currentIndex = index
      })
  }
}
 