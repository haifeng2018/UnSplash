/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: HomeTabContent
 * Author: Victor
 * Date: 2023/06/16 12:17
 * Description: 
 * -----------------------------------------------------------------
 */
import promptAction from '@ohos.promptAction';
import { HomeApi } from '../../api/HomeApi';
import { TopicInfo } from '../../bean/TopicInfo';
import Constants from '../../util/Constants'
import HttpRequest from '../../util/HttpRequest';
import { HomeTabSwiperContent } from './HomeTabSwiperContent';

@Preview
@Component
export struct HomeTabContent {
  @State datas: Array<any> = [];
  private controller: TabsController = new TabsController()

  @State currentIndex: number = 0
  @State id_or_slug: string = ""
  @State list: Array<any> = [];

  aboutToAppear() {
    this.sendTopicsRequest()
  }

  sendTopicsRequest () {
    HttpRequest.url = HomeApi.TOPICS
    HttpRequest.request({
      onSuccess: (value) => {
        this.datas = value
      },
      onFail: (errorCode) => {
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    Stack() {
      Swiper() {
        ForEach(this.datas, data => {
          if (data.status === 'open') {
            HomeTabSwiperContent({
              topicInfo: data
            })
          }
        })
      }
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
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

      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        ForEach(this.datas,(data,index) => {
           if (data.status === 'open') {
             TabContent() {
             }.tabBar(this.TabBuilder(index - 1))
             .padding({top:$r('app.float.vp_50')})
           }
        })
      }
      .vertical(false)
      .barWidth(Constants.MATCH_PARENT)
      .barHeight($r('app.float.vp_56'))
      .barMode(BarMode.Scrollable)
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_128'))
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[$r('app.color.color_99000000'), 0.05], [$r('app.color.transparent'), 0.95]]
      })
      .onChange((index: number) => {
        this.currentIndex = index
      })

      this.titleBar()

    }
    .alignContent(Alignment.Top)
  }

  @Builder titleBar() {
    Row(){
      Image($r('app.media.ic_home_logo'))
        .width($r('app.float.vp_40'))
        .height($r('app.float.vp_40'))
        .objectFit(ImageFit.Contain)
        .margin({left: $r('app.float.vp_20')})

      Text('Unsplash')
        .height($r('app.float.vp_56'))
        .layoutWeight(1)
        .fontSize($r('app.float.fp_24'))
        .fontColor($r('app.color.white'))
        .fontWeight(700)
        .textAlign(TextAlign.Center)
        .margin({right: $r('app.float.vp_60')})
    }
    .width(Constants.MATCH_PARENT)
    .margin({top: $r('app.float.vp_10')})
    .padding({top:$r('app.float.status_bar_height')})
  }

  @Builder TabBuilder(index: number) {
    Stack() {
      Text(this.datas[index + 1].title)
        .height(Constants.MATCH_PARENT)
        .padding({left:$r('app.float.vp_20'),right:$r('app.float.vp_20')})
        .fontSize(this.currentIndex === index ? $r('app.float.fp_22') : $r('app.float.fp_20'))
        .fontWeight(this.currentIndex === index ? 700 : 500)
        .fontColor(this.currentIndex === index ? $r('app.color.white') : $r('app.color.color_80FFFFFF'))

      Divider()
        .strokeWidth('5vp')
        .width($r('app.float.vp_20'))
        .margin({bottom:$r('app.float.vp_5')})
        .color($r('app.color.white'))
        .opacity(this.currentIndex === index ? 1 : 0)

    }.alignContent(Alignment.Bottom)
  }
}