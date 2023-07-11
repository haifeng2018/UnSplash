/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: UserInfo
 * Author: Victor
 * Date: 2023/07/07 17:15
 * Description: 
 * -----------------------------------------------------------------
 */
import List from '@ohos.util.List';
import { PreviewPhotoInfo } from './PreviewPhotoInfo';
import { ProfileImageInfo } from './ProfileImageInfo';
import { UserLinkInfo } from './UserLinkInfo';
 export class UserInfo {
   id: string;
   updated_at: string;
   username: string;
   name: string;
   first_name: string;
   last_name: string;
   twitter_username: string;
   portfolio_url: string;
   bio: string;
   location: string;
   links: UserLinkInfo;
   profile_image: ProfileImageInfo;
   instagram_username: string;
   total_collections: number;
   total_likes: number;
   total_photos: number;
   accepted_tos: boolean;
   for_hire: boolean;
   photos: List<PreviewPhotoInfo>;
 }
 