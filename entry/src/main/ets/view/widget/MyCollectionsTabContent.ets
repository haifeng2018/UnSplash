/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: MyCollectionsTabContent
 * Author: Victor
 * Date: 2023/07/11 17:54
 * Description: 
 * -----------------------------------------------------------------
 */
import promptAction from '@ohos.promptAction';
import { UnSplashApi } from '../../api/UnSplashApi';
import { PreviewPhotoInfo } from '../../bean/PreviewPhotoInfo';
import { TopicInfo } from '../../bean/TopicInfo';
import Constants from '../../util/Constants';
import HttpRequest from '../../util/HttpRequest';
@Component
@Preview
export struct MyCollectionsTabContent {
  @State datas: Array<any> = [];

  aboutToAppear() {
    this.sendMyConnectionsRequest()
  }

  sendMyConnectionsRequest () {
    HttpRequest.url = UnSplashApi.MY_COLLECTIONS
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
    List({space: 10}) {
      ForEach(this.datas, item => {
        ListItem() {
          this.itemLayout(item)
        }
      })
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .margin({top: $r('app.float.vp_20')})
    .onScrollIndex((start, end) => {
    })
  }

  @Builder itemLayout(info: TopicInfo) {
    Column() {

      List({ space: 2 }) {
        ForEach(info.preview_photos, (data) => {
          ListItem() {
            this.cellLayout(data)
          }
        })
      }
      .width(Constants.MATCH_PARENT)
      .listDirection(Axis.Horizontal)

      Text(info.title)
        .fontColor($r('app.color.white'))
        .fontSize($r('app.float.fp_22'))
        .fontWeight(700)
        .width(Constants.MATCH_PARENT)
        .margin({top: $r('app.float.vp_10'),left: $r('app.float.vp_20')})

      Text(`${info.total_photos} photos`)
        .fontColor($r('app.color.white'))
        .fontSize($r('app.float.fp_18'))
        .width(Constants.MATCH_PARENT)
        .margin({top: $r('app.float.vp_5'),left: $r('app.float.vp_20')})

    }
    .width(Constants.MATCH_PARENT)
    .padding({top: $r('app.float.vp_10'),bottom: $r('app.float.vp_10')})
    .backgroundColor($r('app.color.color_4DEEEEEE'))
    .borderRadius($r('app.float.vp_10'))
  }

  @Builder cellLayout(data: PreviewPhotoInfo) {
    Image(data.urls.small)
      .width($r('app.float.vp_128'))
      .height($r('app.float.vp_110'))
      .backgroundColor($r('app.color.color_80FFFFFF'))
  }
}
 