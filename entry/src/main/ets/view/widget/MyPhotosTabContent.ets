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
import { HomeApi } from '../../api/HomeApi';
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
    this.sendRankingRequest()
  }

  sendRankingRequest () {
    HttpRequest.url = HomeApi.MY_PHOTOS
    HttpRequest.request({
      onSuccess: (value) => {
        this.datas = value.itemList
      },
      onFail: (errorCode) => {
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    WaterFlow() {
      ForEach(this.datas, data => {
        FlowItem() {
          this.popularCell(data)
        }
        .width(Constants.MATCH_PARENT)
        .height(this.getPopularCellHeight())
      })
    }
    .columnsTemplate("1fr 1fr")
    .itemConstraintSize({
      minWidth: 0,
      maxWidth: '100%',
      minHeight: 0,
      maxHeight: '100%'
    })
    .columnsGap(5)
    .rowsGap(5)
    .padding({left: $r('app.float.vp_20'), right: $r('app.float.vp_20')})
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .layoutDirection(FlexDirection.Column)
    .onReachStart(() => {
      console.info("onReachStart")
    })
    .onReachEnd(() => {
      console.info("onReachEnd")
    })
  }

  @Builder popularCell(data: PopularPhotoInfo) {
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
    .align(Alignment.Bottom)
    .onClick(() => {
      promptAction.showToast({ message: 'data.user.name = ' + data.user.name});
    })
  }
}
 