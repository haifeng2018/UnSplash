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

@Preview
@Component
export struct HomeTabContent {
  @State currentIndex: number = 0
  @State datas: Array<any> = [];

  aboutToAppear() {
    this.sendTopicsRequest()
  }

  sendTopicsRequest () {
    HttpRequest.url = HomeApi.TOPICS
    HttpRequest.request({
      onSuccess: (value) => {
        // this.pageState = PageState.Success;
        this.datas = value
      },
      onFail: (errorCode) => {
        // this.pageState = PageState.Fail
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    Column() {
      Swiper() {
        ForEach(this.datas, data => {
          if (data.status === 'open') {
            Stack() {
              this.headerLayout(data)
              Column(){
                Text(data.title)
                  .width(Constants.MATCH_PARENT)
                  .fontColor($r('app.color.color_333333'))
                  .fontSize($r('app.float.fp_36'))
                  .textAlign(TextAlign.Start)
                  .padding({left:$r('app.float.vp_20'),right:$r('app.float.vp_20')})

                Text(data.description)
                  .width(Constants.MATCH_PARENT)
                  .fontColor($r('app.color.color_333333'))
                  .fontSize($r('app.float.fp_22'))
                  .maxLines(6)
                  .textOverflow({overflow: TextOverflow.Ellipsis})
                  .margin({top: $r('app.float.vp_20')})
                  .padding({left:$r('app.float.vp_20'),right:$r('app.float.vp_20')})

                List({ space: 20 }) {
                  ForEach(data.preview_photos, item => {
                    ListItem() {
                      Column() {
                        Image(item.urls.small_s3)
                          .width(Constants.MATCH_PARENT)
                          .height($r('app.float.vp_198'))

                        Stack() {
                          Image(item.urls.small_s3)
                            .width(Constants.MATCH_PARENT)
                            .height($r('app.float.vp_198'))
                            .blur(18)
                            .rotate({
                              x: 0,
                              y: 1,
                              z: 0,
                              centerX: '50%',
                              centerY: '50%',
                              angle: 180
                            }) // 组件以矢量(0,1,0)为旋转轴，绕中心点顺时针旋转180度
                        }
                        .width(Constants.MATCH_PARENT)
                        .height($r('app.float.vp_198'))
                        .rotate({
                          x: 0,
                          y: 0,
                          z: 1,
                          centerX: '50%',
                          centerY: '50%',
                          angle: 180
                        }) // 组件以矢量(0,0,1)为旋转轴，绕中心点顺时针旋转180度
                      }
                      .width($r('app.float.vp_298'))
                      .height(Constants.MATCH_PARENT)
                      .padding({left: $r('app.float.vp_10'),right:$r('app.float.vp_10')})
                    }
                  })
                }
                .height($r('app.float.vp_400'))
                .margin({top: $r('app.float.vp_20')})
                .listDirection(Axis.Horizontal)
                .chainAnimation(true)
              }
              .width(Constants.MATCH_PARENT)
              .offset({y: $r('app.float.vp_118')})
            }
            .align(Alignment.BottomStart)
          }
        })
      }
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
      .vertical(true)
      .indicator(false)
      .index(0)
      .autoPlay(true)
      .interval(10000)
      .loop(false)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
    }
  }

  @Builder headerLayout (info: TopicInfo) {
    Image(info.cover_photo.urls.small)
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
      .blur(98)
  }

}