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
export struct NestedScrollTab {
  @State listPosition: number = 0; // 0代表滚动到List顶部，1代表中间值，2代表滚动到List底部。
  private arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16]
  @State scrollY: number = 0

  build() {
    Scroll() {
      Column() {
        Text(`scrollY = ${this.scrollY}`)
          .width("100%").height("40%").backgroundColor('#FF00FF')
          .fontSize(16).textAlign(TextAlign.Center)
          .onClick(() => {
          })

        List({ space: 20 }) {
          ForEach(this.arr, (item) => {
            ListItem() {
              Text("ListItem" + item)
                .width("100%").height("100%").borderRadius(15)
                .fontSize(16).textAlign(TextAlign.Center).backgroundColor(Color.White)
            }.width("100%").height(300)
            .onClick(() => {
              promptAction.showToast({message: `position = ${item}`})
            })
          }, item => item)
        }
        .width("100%")
        .edgeEffect(EdgeEffect.None)
        .onReachStart(() => {
          this.listPosition = 0
        })
        .onReachEnd(() => {
          this.listPosition = 2
        })
        .onScrollFrameBegin((offset: number) => {
          return { offsetRemain: 0 }
        })
      }
    }
    .width("100%").height("100%")
  }
}
 