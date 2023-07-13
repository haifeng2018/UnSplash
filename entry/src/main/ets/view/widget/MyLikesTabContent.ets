/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: MyLikesTabContent
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
export struct MyLikesTabContent {
  @State datas: Array<any> = [];

  aboutToAppear() {
    this.sendMyLikesRequest()
  }

  sendMyLikesRequest () {
    HttpRequest.url = UnSplashApi.MY_LIKES
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
    List() {
      ForEach(this.datas, item => {
        ListItem() {
          this.itemLayout(item)
        }
      })
    }
    .width(Constants.MATCH_PARENT)
    .margin({top: $r('app.float.vp_10')})
    .onScrollIndex((start, end) => {
    })
    .onScrollFrameBegin((offset: number) => {
      return { offsetRemain: 0 }
    })
  }

  @Builder itemLayout(data: PopularPhotoInfo) {
    Stack(){
      Image(data.urls.small)
        .width(Constants.MATCH_PARENT)
        .height(Constants.MATCH_PARENT)

      Text(data.user.name)
        .width(Constants.MATCH_PARENT)
        .fontColor($r('app.color.white'))
        .fontSize($r('app.float.fp_18'))
        .maxLines(1)
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .margin({left:$r('app.float.vp_20'),bottom:$r('app.float.vp_20')})
    }
    .width(Constants.MATCH_PARENT)
    .aspectRatio(data.width / data.height)
    .backgroundColor($r('app.color.color_80FFFFFF'))
    .align(Alignment.Bottom)
  }
}
 