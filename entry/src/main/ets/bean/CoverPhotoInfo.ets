/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: CoverPhotoInfo
 * Author: Victor
 * Date: 2023/06/16 16:11
 * Description: 
 * -----------------------------------------------------------------
 */

import { CoverUrl } from './CoverUrl';
 export class CoverPhotoInfo {
   id: string;
   slug: string;
   created_at: string;
   updated_at: string;
   promoted_at: string;
   color: string;
   blur_hash: string;
   description: string;
   alt_description: string;
   width: number
   height: number
   urls: CoverUrl;
 }