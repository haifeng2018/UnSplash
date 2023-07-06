/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: HomeTabModel
 * Author: Victor
 * Date: 2023/06/16 12:02
 * Description: 
 * -----------------------------------------------------------------
 */

export interface NavItem {
  icon: Resource;
  icon_selected: Resource;
  id: number;
}

export enum TabId {
  HOME,
  SEARCH,
  UPLOAD,
  ME
}

export const NavList: NavItem[] = [
  {
    icon: $r('app.media.ic_home_normal'),
    icon_selected: $r('app.media.ic_home_checked'),
    id: TabId.HOME
  },
  {
    icon: $r('app.media.ic_search_normal'),
    icon_selected: $r('app.media.ic_search_checked'),
    id: TabId.SEARCH
  },
  {
    icon: $r('app.media.ic_upload_normal'),
    icon_selected: $r('app.media.ic_upload_checked'),
    id: TabId.UPLOAD
  },
  {
    icon: $r('app.media.ic_me_normal'),
    icon_selected: $r('app.media.ic_me_checked'),
    id: TabId.ME
  },
]
