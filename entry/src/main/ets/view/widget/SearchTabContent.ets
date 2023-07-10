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
import promptAction from '@ohos.promptAction'
import { HomeApi } from '../../api/HomeApi'
import { PopularPhotoInfo } from '../../bean/PopularPhotoInfo'
import { SearchCategoryInfo } from '../../bean/SearchCategoryInfo'
import { searchCategorys, searchHints } from '../../model/SearchPageModel'
import Constants from '../../util/Constants'
import HttpRequest from '../../util/HttpRequest'

@Preview
@Component
export struct SearchTabContent {

  @State datas: Array<any> = [];

  getPopularCellHeight(): number {
    let minHeight = 128
    let maxHeight = 298
    let ret = Math.floor(Math.random() * maxHeight)
    return (ret > minHeight ? ret : minHeight)
  }

  sendPopularPhotosRequest () {
    HttpRequest.url = HomeApi.POPULAR_PHOTOS
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
    this.sendPopularPhotosRequest()
  }

  build() {
    Column() {
      this.titleBar()
      List(){
        ListItem(){
          this.categoryTitle('Browse by Category')
        }
        ListItem(){
          this.categoryList()
        }
        ListItem(){
          this.categoryTitle('Popular')
        }
        ListItem(){
          this.popularList()
        }
      }
      .width(Constants.MATCH_PARENT)
      .margin({top: $r('app.float.vp_20')})
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .backgroundColor($r('app.color.color_333333'))
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

  @Builder popularList() {
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

  @Builder categoryTitle(category: string) {
    Text(category)
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_56'))
      .fontColor($r('app.color.white'))
      .fontSize($r('app.float.fp_28'))
      .fontWeight(800)
      .padding({left: $r('app.float.vp_20')})
  }

  @Builder categoryList() {
    Grid() {
      ForEach(searchCategorys, (data) => {
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

  @Builder categoryCell(data: SearchCategoryInfo) {
    Stack() {
      Image(data.image)
        .width(Constants.MATCH_PARENT)
        .height(Constants.MATCH_PARENT)
        .borderRadius($r('app.float.vp_10'))

      Text(data.category)
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
  }

  @Builder titleBar() {
    Stack() {
      Swiper() {
        ForEach(searchHints, item => {
          Text(item)
            .width(Constants.MATCH_PARENT)
            .height($r('app.float.vp_40'))
            .textAlign(TextAlign.Center)
            .fontSize($r('app.float.fp_18'))
            .fontColor($r('app.color.white'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }, item => item)
      }
      .vertical(true)
      .autoPlay(true)
      .indicator(false)
      .interval(3000)
      .margin({left:$r('app.float.vp_20'),right: $r('app.float.vp_20')})
      .backgroundColor($r('app.color.color_4DEEEEEE'))
      .borderRadius($r('app.float.vp_10'))

      Image($r('app.media.ic_search'))
        .width($r('app.float.vp_20'))
        .height($r('app.float.vp_20'))
        .margin({left:$r('app.float.vp_30')})
    }
    .alignContent(Alignment.Start)
    .width(Constants.MATCH_PARENT)
    .height($r('app.float.vp_56'))
  }

}
 