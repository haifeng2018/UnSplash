/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: MyPhotosTabContent
 * Author: Victor
 * Date: 2023/07/11 17:54
 * Description: 
 * -----------------------------------------------------------------
 */
import promptAction from '@ohos.promptAction';
import { UnSplashApi } from '../../api/UnSplashApi';
import { PopularPhotoInfo } from '../../bean/PopularPhotoInfo';
import Constants from '../../util/Constants';
import HttpRequest from '../../util/HttpRequest';

@Component
@Preview
export struct MyPhotosTabContent {
  @State datas: Array<any> = [];

  getPopularCellHeight(): number {
    let minHeight = 128
    let maxHeight = 298
    let ret = Math.floor(Math.random() * maxHeight)
    return (ret > minHeight ? ret : minHeight)
  }

  aboutToAppear() {
    this.sendMyPhotosRequest()
  }

  sendMyPhotosRequest () {
    HttpRequest.url = UnSplashApi.MY_PHOTOS
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
        .backgroundColor($r('app.color.color_80FFFFFF'))
      })
    }
    .width(Constants.MATCH_PARENT)
    .margin({top: $r('app.float.vp_10')})
    .lanes(2)
    .onScrollIndex((start, end) => {
    })
    .onScrollFrameBegin((offset: number) => {
      return { offsetRemain: 0 }
    })
  }

  @Builder itemLayout(data: PopularPhotoInfo) {
    Image(data.urls.small)
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_256'))
  }
}
 