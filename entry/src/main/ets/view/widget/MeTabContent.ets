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
import { UnSplashApi } from '../../api/UnSplashApi'
import Constants from '../../util/Constants'
import HttpRequest from '../../util/HttpRequest'
import { MeContent } from './MeContent'

@Component
@Preview
export struct MeTabContent {
  @State name: string = ''
  @State avatar: string = ''

  aboutToAppear() {
    this.sendUserInfoRequest()
  }

  sendUserInfoRequest () {
    HttpRequest.url = UnSplashApi.USER_INFO
    HttpRequest.request({
      onSuccess: (value) => {
        this.name = value.name
        this.avatar = value.profile_image.small
      },
      onFail: (errorCode) => {
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    Column() {
      this.titleBar()
      this.content()
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .backgroundColor($r('app.color.color_333333'))
    .justifyContent(FlexAlign.Start)
  }

  @Builder content () {
    Scroll() {
      Column() {
        Image(this.avatar)
          .width($r('app.float.vp_80'))
          .height($r('app.float.vp_80'))
          .objectFit(ImageFit.Cover)
          .margin({'top':$r('app.float.vp_110')})
          .clip(new Circle({ width: '80vp', height: '80vp' }))
          .border({
            width: $r('app.float.vp_2'),
            color:$r('app.color.white'),
            radius:$r('app.float.vp_40'),
            style:BorderStyle.Solid
          })

        Text(this.name)
          .width(Constants.MATCH_PARENT)
          .fontColor($r('app.color.white'))
          .fontSize($r('app.float.fp_20'))
          .textAlign(TextAlign.Center)
          .margin({'top':$r('app.float.vp_20')})

        MeContent()
      }
      .justifyContent(FlexAlign.Start)
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
  }

  @Builder titleBar () {
    Row() {
      Image($r('app.media.ic_trending_up'))
        .width($r('app.float.vp_30'))
        .height($r('app.float.vp_30'))

      Text(this.name)
        .layoutWeight(1)
        .fontSize($r('app.float.fp_24'))
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .margin({left: $r('app.float.vp_40'),right: $r('app.float.vp_10')})

      Image($r('app.media.ic_more'))
        .width($r('app.float.vp_30'))
        .height($r('app.float.vp_30'))
        .margin({right: $r('app.float.vp_10')})

      Image($r('app.media.ic_share'))
        .width($r('app.float.vp_30'))
        .height($r('app.float.vp_30'))
    }
    .width(Constants.MATCH_PARENT)
    .height($r('app.float.vp_56'))
    .backgroundColor($r('app.color.color_99000000'))
    .padding({left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
  }
}
 