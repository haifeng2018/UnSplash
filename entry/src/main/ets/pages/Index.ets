import { NavList, TabId } from '../model/HomeTabModel'
import Constants from '../util/Constants'
import { HomeTabContent } from '../view/widget/HomeTabContent'
@Entry
@Component
struct Index {
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          HomeTabContent()
        }.tabBar(this.TabBuilder(TabId.HOME))

        TabContent() {
          Text('search')
        }.tabBar(this.TabBuilder(TabId.SEARCH))

        TabContent() {
          Text('upload')
        }.tabBar(this.TabBuilder(TabId.UPLOAD))

        TabContent() {
          Text('me')
        }.tabBar(this.TabBuilder(TabId.ME))
      }
      .vertical(false)
      .barWidth(Constants.MATCH_PARENT)
      .barHeight($r('app.float.vp_80'))
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(Constants.MATCH_PARENT)
      .backgroundColor($r('app.color.white'))
    }
    .width(Constants.MATCH_PARENT)
    .height(Constants.MATCH_PARENT)
    .justifyContent(FlexAlign.Center)
  }

  @Builder TabBuilder(index: number) {
    Column() {
      Image(this.currentIndex === index ? NavList[index].icon_selected : NavList[index].icon)
        .width($r('app.float.vp_36'))
        .height($r('app.float.vp_36'))
        .objectFit(ImageFit.Contain)
        .opacity(this.currentIndex === index ? 1 : 0.4)
        .scale({x:this.currentIndex === index ? 1.1 : 1.0,
          y:this.currentIndex === index ? 1.1 : 1.0})
    }.justifyContent(FlexAlign.Center)
  }
}