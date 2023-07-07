/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: HomeTabSwiperContent
 * Author: Victor
 * Date: 2023/07/07 16:31
 * Description: 
 * -----------------------------------------------------------------
 */
import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { HomeApi } from '../../api/HomeApi';
import Constants from '../../util/Constants';
import HttpRequest from '../../util/HttpRequest';
import RouterPath from '../../util/RouterPath';
import { PageState } from './refresh/PageState';
import { RefreshConfig } from './refresh/RefreshConfig';
import LMList from './refresh/LMList';
import { TopicPhotoInfo } from '../../bean/TopicPhotoInfo';
import { TopicInfo } from '../../bean/TopicInfo';

@Preview
@Component
 export struct HomeTabSwiperContent {
  @Provide(RefreshConfig.REFRESH_DATA_TAG) datas: Array<any> = [];
  @Provide(RefreshConfig.REFRESH_STATE_TAG) pageState: number = PageState.Loading;

  private topicInfo:TopicInfo;

  @State currentPage: number = 1

  sendFollowRequest () {
    HttpRequest.url = this.getRequestUrl()
    HttpRequest.request({
      onSuccess: (value) => {
        this.pageState = PageState.Success;
        if (this.currentPage === 1) {
          this.datas = value
        } else {
          this.datas = this.datas.concat(value);
        }
      },
      onFail: (errorCode) => {
        this.pageState = PageState.Fail
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  aboutToAppear() {
    this.sendFollowRequest()
  }

  refreshData () {
    this.currentPage = 1
    this.sendFollowRequest()
  }

  loadMoreData () {
    this.currentPage++
    this.sendFollowRequest()
  }

  build() {
    LMList({
      itemLayout: (data,index) => this.itemLayout(data,index),
      onRefresh: () => {
        this.refreshData()
      },
      onLoadMore: () => {
        this.loadMoreData()
      }
    })
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
      .backgroundColor($r('app.color.color_F9F9F9'))
  }

  @Builder itemLayout (info: TopicPhotoInfo,index) {
    Column() {
      if (index == 0) {
        this.headerLayout(this.topicInfo)
      }
      Stack(){
        Image(info.urls.small)
          .width(Constants.MATCH_PARENT)
          .height(Constants.MATCH_PARENT)

        Text(info.user.name)
          .width(Constants.MATCH_PARENT)
          .fontColor($r('app.color.white'))
          .fontSize($r('app.float.fp_18'))
          .maxLines(1)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .margin({left:$r('app.float.vp_20'),bottom:$r('app.float.vp_20')})
      }
      .width(Constants.MATCH_PARENT)
      .height($r('app.float.vp_456'))
      .backgroundColor($r('app.color.white'))
      .align(Alignment.Bottom)
    }
  }

  @Builder headerLayout (info: TopicInfo) {
    Stack() {
      Image(info.cover_photo.urls.small)
        .width(Constants.MATCH_PARENT)
        .height($r('app.float.vp_520'))
        .blur(98)

      Column() {
        Text(info.title)
          .width(Constants.MATCH_PARENT)
          .fontColor($r('app.color.white'))
          .fontSize($r('app.float.fp_28'))
          .textAlign(TextAlign.Start)
          .margin({bottom: $r('app.float.vp_10')})

        Text(info.description)
          .width(Constants.MATCH_PARENT)
          .fontColor($r('app.color.white'))
          .fontSize($r('app.float.fp_18'))
          .maxLines(2)
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .margin({bottom: $r('app.float.vp_20')})

        Button('Submit a photo',{ type: ButtonType.Normal, stateEffect: true })
          .width(Constants.MATCH_PARENT)
          .height($r('app.float.vp_40'))
          .backgroundColor($r('app.color.white'))
          .fontColor($r('app.color.color_333333'))
          .borderRadius($r('app.float.vp_5'))
      }
      .padding({left:$r('app.float.vp_20'),right:$r('app.float.vp_20'),bottom: $r('app.float.vp_20')})
    }
    .alignContent(Alignment.Bottom)
    .width(Constants.MATCH_PARENT)
    .height($r('app.float.vp_456'))
  }

  getRequestUrl (): string {
    let url = `${HomeApi.BASE_URL}topics/${this.topicInfo.slug}/photos?page=${this.currentPage}&per_page=10&${HomeApi.AUTH}`
    return url
  }
}