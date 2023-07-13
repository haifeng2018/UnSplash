import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import { UnSplashApi } from '../api/UnSplashApi';
import { TopicPhotoInfo } from '../bean/TopicPhotoInfo';
import Constants from '../util/Constants';
import HttpRequest from '../util/HttpRequest';
import http from '@ohos.net.http';
@Entry
@Component
struct PhotoDetailPage {
  @State datas: Array<any> = router.getParams()?.[Constants.DATA];
  @State index: number = router.getParams()?.[Constants.POSITION];
  @State shareId: string = router.getParams()?.[Constants.SHARE_ID];

  @State showLoading: boolean = false

  sendLikePhotosRequest (id: string) {
    this.showLoading = true;
    HttpRequest.setMethod(http.RequestMethod.POST)
    HttpRequest.url = UnSplashApi.LIKE_PHOTO.replace(':id',id)
    HttpRequest.request({
      onSuccess: (value) => {
        this.showLoading = false;
      },
      onFail: (errorCode) => {
        this.showLoading = false;
        promptAction.showToast({ message: 'errorCode = ' + errorCode});
      }
    })
  }

  build() {
    Stack() {
      Swiper() {
        ForEach(this.datas, data => {
          this.pageContent(data)
        })
      }
      .width(Constants.MATCH_PARENT)
      .height(Constants.MATCH_PARENT)
      .vertical(false)
      .indicator(false)
      .index(this.index)
      .autoPlay(false)
      .interval(10000)
      .loop(false)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .onChange((index: number) => {
        this.index = index
      })

      this.titleBar(this.datas[this.index])
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .backgroundColor($r('app.color.black'))
    .alignContent(Alignment.Top)
  }

  @Builder pageContent (data: TopicPhotoInfo) {
    Stack() {
      Image(data.urls.small)
        .width(Constants.MATCH_PARENT)
        .aspectRatio(data.width / data.height)

      this.actionLayout(data)

      if (this.showLoading) {
        LoadingProgress()
          .width($r('app.float.vp_100'))
          .height($r('app.float.vp_100'))
          .color(Color.Blue)
      }
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .sharedTransition(this.shareId, {
      duration: Constants.TRANSITION_ANIMATION_DURATION,
      curve: Curve.Smooth,
      delay: Constants.SHARE_ITEM_ANIMATION_DELAY
    })
  }

  @Builder actionLayout(data: TopicPhotoInfo) {
    Column() {
      Image($r('app.media.ic_fav_normal'))
        .width($r('app.float.vp_50'))
        .height($r('app.float.vp_50'))
        .objectFit(ImageFit.Contain)
        .backgroundColor($r('app.color.color_4D000000'))
        .clip(new Circle({ width: 50, height: 50 }))
        .padding($r('app.float.vp_6'))
        .margin({bottom: $r('app.float.vp_10')})
        .onClick(() => {
          this.sendLikePhotosRequest(data.id)
        })

      Image($r('app.media.ic_add_collection'))
        .width($r('app.float.vp_50'))
        .height($r('app.float.vp_50'))
        .objectFit(ImageFit.Contain)
        .backgroundColor($r('app.color.color_4D000000'))
        .clip(new Circle({ width: 50, height: 50 }))
        .padding($r('app.float.vp_6'))
        .margin({bottom: $r('app.float.vp_10')})

      Row() {
        Image($r('app.media.ic_photo_info'))
          .width($r('app.float.vp_50'))
          .height($r('app.float.vp_50'))
          .objectFit(ImageFit.Contain)
          .backgroundColor($r('app.color.color_4D000000'))
          .clip(new Circle({ width: 50, height: 50 }))
          .padding($r('app.float.vp_6'))

        Blank()
        Image($r('app.media.ic_download'))
          .width($r('app.float.vp_50'))
          .height($r('app.float.vp_50'))
          .objectFit(ImageFit.Contain)
          .backgroundColor($r('app.color.color_4D000000'))
          .clip(new Circle({ width: 50, height: 50 }))
          .padding($r('app.float.vp_6'))
      }
      .width(Constants.MATCH_PARENT)
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .alignItems(HorizontalAlign.End)
    .justifyContent(FlexAlign.End)

    .padding({bottom: $r('app.float.vp_20'),left: $r('app.float.vp_20'),right: $r('app.float.vp_20')})
  }

  @Builder titleBar(data: TopicPhotoInfo) {
    Row() {
      Image($r('app.media.ic_back'))
        .width($r('app.float.vp_30'))
        .height($r('app.float.vp_30'))
        .onClick(() => {
          router.back()
        })

      Text(data.user.name)
        .layoutWeight(1)
        .fontSize($r('app.float.fp_24'))
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .margin({ left: $r('app.float.vp_10'), right: $r('app.float.vp_10') })

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