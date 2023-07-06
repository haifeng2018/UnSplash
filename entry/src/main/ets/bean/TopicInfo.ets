/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: TopicInfo
 * Author: Victor
 * Date: 2023/06/16 15:42
 * Description: 
 * -----------------------------------------------------------------
 */
import List from '@ohos.util.List';
import { CoverPhotoInfo } from './CoverPhotoInfo';
import { PreviewPhotoInfo } from './PreviewPhotoInfo';
 export class TopicInfo {
   id: string;
   slug: string;
   title: string;
   description: string;
   published_at: string;
   updated_at: string;
   starts_at: string;
   ends_at: string;
   status: string;
   cover_photo:CoverPhotoInfo;
   preview_photos: List<PreviewPhotoInfo>;
 }