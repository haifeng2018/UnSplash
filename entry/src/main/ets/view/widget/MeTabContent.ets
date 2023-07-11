/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: MeTabContent
 * Author: Victor
 * Date: 2023/07/11 15:56
 * Description: 
 * -----------------------------------------------------------------
 */
import promptAction from '@ohos.promptAction'
import { HomeApi } from '../../api/HomeApi'
import { UserInfo } from '../../bean/UserInfo'
import { photos_tabs } from '../../model/MePageModel'
import Constants from '../../util/Constants'
import HttpRequest from '../../util/HttpRequest'
import { MyCollectionsTabContent } from './MyCollectionsTabContent'
import { MyLikesTabContent } from './MyLikesTabContent'
import { MyPhotosTabContent } from './MyPhotosTabContent'
@Component
@Preview
export struct MeTabContent {

  private scroller: Scroller = new Scroller()

  // 滑动的y偏移量
  private yTotalOffset = 0
  // 标题栏透明度
  @State titleBarOpacity: number = 1
  @State listScrollTop: boolean = true

  @State currentIndex: number = 0
  @State mUserInfo: UserInfo = null

  aboutToAppear() {
    this.sendUserInfoRequest()
  }

  sendUserInfoRequest () {
    HttpRequest.url = HomeApi.USER_INFO
    HttpRequest.request({
      onSuccess: (value) => {
        this.mUserInfo = value
      },
      onFail: (errorCode) => {
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        this.titleBar()
        this.content()
      }
      .width(Constants.MATCH_PARENT)
      .backgroundColor($r('app.color.color_333333'))
    }
    .scrollable(ScrollDirection.Vertical)  // 滚动方向纵向
    .scrollBar(BarState.Off)  // 滚动条常驻显示
    .scrollBarColor(Color.Gray)  // 滚动条颜色
    .scrollBarWidth(30) // 滚动条宽度
    .edgeEffect(EdgeEffect.None)
    .onScroll((xOffset: number, yOffset: number) => {
      console.error('onScroll-xOffset =' + xOffset)
      console.error('onScroll-yOffset =' + yOffset)
      this.yTotalOffset += yOffset
      const yTotalOffsetVP = px2vp(this.yTotalOffset)
      // 轮播图高度 350
      const scale = yTotalOffsetVP / 100
      this.titleBarOpacity = scale
      if (scale < 0) {
        this.titleBarOpacity = 0
        this.listScrollTop = true
      }
      if (scale > 1) {
        this.titleBarOpacity = 1
        this.listScrollTop = false
      }
    })
    .onScrollEdge((side: Edge) => {
      console.info('To the edge')
    })
  }

  @Builder content () {
    if(this.mUserInfo != null) {
      Column() {
        Image($r(this.mUserInfo.profile_image.small))
          .width($r('app.float.vp_80'))
          .height($r('app.float.vp_80'))
          .objectFit(ImageFit.Cover)
          .margin({'top':$r('app.float.vp_60')})
          .clip(new Circle({ width: '80vp', height: '80vp' }))
          .border({
            width: $r('app.float.vp_2'),
            color:$r('app.color.white'),
            radius:$r('app.float.vp_40'),
            style:BorderStyle.Solid
          })

        Text(this.mUserInfo.name)
          .width(Constants.MATCH_PARENT)
          .fontColor($r('app.color.white'))
          .fontSize($r('app.float.fp_20'))
          .textAlign(TextAlign.Center)
          .margin({'top':$r('app.float.vp_20')})

        Stack() {
          Divider().vertical(false)
            .width(Constants.MATCH_PARENT)
            .height($r('app.float.vp_40'))
            .backgroundColor($r('app.color.color_4DEEEEEE'))
            .borderRadius($r('app.float.vp_8'))

          Tabs() {
            TabContent() {
              MyPhotosTabContent()
            }.tabBar(this.TabBuilder(0))

            TabContent() {
              MyLikesTabContent()
            }.tabBar(this.TabBuilder(1))

            TabContent() {
              MyCollectionsTabContent()
            }.tabBar(this.TabBuilder(2))
          }
          .vertical(false)
          .barWidth(Constants.MATCH_PARENT)
          .barHeight($r('app.float.vp_40'))
          .barMode(BarMode.Fixed)
          .onChange((index: number) => {
            this.currentIndex = index
          })
          .width(Constants.MATCH_PARENT)
        }
        .alignContent(Alignment.Top)
        .margin({top: $r('app.float.vp_30'),left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
      }
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
    }
  }

  @Builder TabBuilder(index: number) {
    Text(photos_tabs[index])
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
      .backgroundColor(this.currentIndex === index ? $r('app.color.color_4DEEEEEE') : $r('app.color.transparent'))
      .borderRadius($r('app.float.vp_8'))
      .padding($r('app.float.vp_12'))
      .textAlign(TextAlign.Center)
      .fontSize(this.currentIndex === index ? $r('app.float.fp_18') : $r('app.float.fp_16'))
      .fontColor($r('app.color.white'))
  }

  @Builder titleBar () {
    if(this.mUserInfo != null) {
      Row() {
        Image($r('app.media.ic_trending_up'))
          .width($r('app.float.vp_40'))
          .height($r('app.float.vp_40'))

        Text(this.mUserInfo.name)
          .layoutWeight(1)
          .fontSize($r('app.float.fp_24'))
          .fontColor($r('app.color.white'))
          .fontWeight(700)
          .textAlign(TextAlign.Center)
          .margin({left: $r('app.float.vp_50'),right: $r('app.float.vp_10')})

        Image($r('app.media.ic_more'))
          .width($r('app.float.vp_40'))
          .height($r('app.float.vp_40'))
          .margin({right: $r('app.float.vp_10')})

        Image($r('app.media.ic_share'))
          .width($r('app.float.vp_40'))
          .height($r('app.float.vp_40'))
      }
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_56'))
      .backgroundColor($r('app.color.color_99000000'))
      .padding({left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
    }
  }
}
 