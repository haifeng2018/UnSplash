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
   total_photos: number;
   cover_photo:CoverPhotoInfo;
   preview_photos: Array<PreviewPhotoInfo>;
 }