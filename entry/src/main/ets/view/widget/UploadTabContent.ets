/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: UploadTabContent
 * Author: Victor
 * Date: 2023/07/10 17:41
 * Description: 
 * -----------------------------------------------------------------
 */
import promptAction from '@ohos.promptAction';
import { UnSplashApi } from '../../api/UnSplashApi';
import { TopicInfo } from '../../bean/TopicInfo';
import Constants from '../../util/Constants';
import HttpRequest from '../../util/HttpRequest';
@Preview
@Component
export struct UploadTabContent {

  @State datas: Array<any> = [];

  sendTopicsRequest () {
    HttpRequest.url = UnSplashApi.TOPICS
    HttpRequest.request({
      onSuccess: (value) => {
        this.datas = value
      },
      onFail: (errorCode) => {
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  aboutToAppear() {
    this.sendTopicsRequest()
  }

  build() {
    Column() {
      List(){
        ListItem(){
          this.categoryTitle('Contribute to Unsplash')
        }
        ListItem(){
          this.uploadCell()
        }
        ListItem(){
          this.categoryTitle('Submit to topics')
        }
        ListItem(){
          this.categoryList()
        }
      }
      .width(Constants.MATCH_PARENT)
      .margin({top: $r('app.float.vp_20')})
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .backgroundColor($r('app.color.color_333333'))
  }

  @Builder categoryTitle(category: string) {
    Text(category)
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_56'))
      .fontColor($r('app.color.white'))
      .fontSize($r('app.float.fp_28'))
      .fontWeight(800)
      .padding({left: $r('app.float.vp_20')})
  }

  @Builder uploadCell() {
    Stack(){
      Image($r('app.color.color_4DEEEEEE'))
        .width(Constants.MATCH_PARENT)
        .height(Constants.MATCH_PARENT)
        .objectFit(ImageFit.Contain)
        .borderStyle(BorderStyle.Dashed)
        .borderWidth($r('app.float.vp_4'))
        .borderRadius($r('app.float.vp_20'))
        .borderColor($r('app.color.color_666666'))

      Image($r('app.media.img_upload'))
        .width($r('app.float.vp_128'))
        .height($r('app.float.vp_128'))
        .objectFit(ImageFit.Contain)

    }
    .width(Constants.MATCH_PARENT)
    .height($r('app.float.vp_256'))
    .padding($r('app.float.vp_20'))

  }

  @Builder categoryList() {
    Grid() {
      ForEach(this.datas, (data) => {
        GridItem() {
          this.categoryCell(data)
        }
        .width($r('app.float.vp_128'))
        .height($r('app.float.vp_128'))
      })
    }
    .layoutDirection(GridDirection.Row)
    .rowsTemplate('1fr 1fr')
    .columnsGap($r('app.float.vp_10'))
    .rowsGap($r('app.float.vp_10'))
    .width(Constants.MATCH_PARENT)
    .height($r('app.float.vp_280'))
    .padding({left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
    .onScrollIndex((first: number) => {
    })
  }

  @Builder categoryCell(data: TopicInfo) {
    Stack() {
      Image(data.cover_photo.urls.small)
        .width(Constants.MATCH_PARENT)
        .height(Constants.MATCH_PARENT)
        .borderRadius($r('app.float.vp_10'))

      Text(data.title)
        .width(Constants.MATCH_PARENT)
        .height(Constants.MATCH_PARENT)
        .fontColor($r('app.color.white'))
        .fontSize($r('app.float.fp_18'))
        .textAlign(TextAlign.Center)
        .backgroundColor($r('app.color.color_4D000000'))
        .borderRadius($r('app.float.vp_10'))
        .padding($r('app.float.vp_5'))
    }
    .width($r('app.float.vp_128'))
    .height($r('app.float.vp_128'))
    .borderRadius($r('app.float.vp_10'))
    .backgroundColor($r('app.color.color_80FFFFFF'))
  }
}
 