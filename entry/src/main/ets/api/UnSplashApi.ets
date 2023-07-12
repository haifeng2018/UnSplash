/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: UnSplashApi
 * Author: Victor
 * Date: 2023/06/16 14:31
 * Description: 
 * -----------------------------------------------------------------
 */

export class UnSplashApi {
  static readonly BASE_URL = 'https://api.unsplash.com/'
  static readonly AUTH = 'client_id=xc-uXz4GlgUeFsZPgWZICrGo_dfeQs4QvJmrzDMIkfo'

  static readonly TOPICS = `${UnSplashApi.BASE_URL}topics?${UnSplashApi.AUTH}&page=1&per_page=10`
  static readonly POPULAR_PHOTOS = `${UnSplashApi.BASE_URL}photos?order_by=popular&${UnSplashApi.AUTH}&page=1&per_page=10`

  static readonly USER_INFO = `${UnSplashApi.BASE_URL}users/victor423099?${UnSplashApi.AUTH}`
  static readonly MY_PHOTOS = `${UnSplashApi.BASE_URL}users/victor423099/photos?${UnSplashApi.AUTH}&page=1&per_page=10`
  static readonly MY_LIKES = `${UnSplashApi.BASE_URL}users/victor423099/likes?${UnSplashApi.AUTH}&page=1&per_page=10`
  static readonly MY_COLLECTIONS = `${UnSplashApi.BASE_URL}users/victor423099/collections?${UnSplashApi.AUTH}&page=1&per_page=10`

}