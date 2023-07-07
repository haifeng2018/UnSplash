/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028; by Victor; All rights reserved.
 * -----------------------------------------------------------------
 * File: TopicPhotoInfo
 * Author: Victor
 * Date: 2023/07/07 17:10
 * Description: 
 * -----------------------------------------------------------------
 */
import { CoverUrl } from './CoverUrl';
import { Link } from './Link';
import { UserInfo } from './UserInfo';

 export class TopicPhotoInfo {
   id: string;
   slug: string;
   created_at: string;
   updated_at: string;
   promoted_at: string;
   width: number;
   height: number;
   color: string;
   blur_hash: string;
   description: string;
   alt_description: string;
   urls: CoverUrl;
   links: Link;
   likes: number;
   liked_by_user: Boolean;
   user: UserInfo;
 }
 