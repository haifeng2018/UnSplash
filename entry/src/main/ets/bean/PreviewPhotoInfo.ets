/*
 * -----------------------------------------------------------------
 * Copyright (C) 2018-2028, by Victor, All rights reserved.
 * -----------------------------------------------------------------
 * File: PreviewPhotoInfo
 * Author: Victor
 * Date: 2023/06/19 10:49
 * Description: 
 * -----------------------------------------------------------------
 */
import { CoverUrl } from './CoverUrl';
export class PreviewPhotoInfo {
  id: string;
  slug: string;
  created_at: string;
  updated_at: string;
  blur_hash: string;
  urls: CoverUrl;
}