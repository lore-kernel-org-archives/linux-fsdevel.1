Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA5285C8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257581; cv=none; b=f0LoO4wrNqHNRv7H4Q5zNQmpIleOAwL+gsf8pkZuoncbpzk90LFgKP0P5koDRdZVD8VchcvxmmIIUw84EbK1lUQ2b5bqs53m382nBUfhzGR91A4mBPxzBllnEGEtWaBKr+1GeZMH8Y6VwVpCe9DEU0MiDME1iSRivbpdhlHNWLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257581; c=relaxed/simple;
	bh=bllsLmC9jk99HV/gK1isQNIdIJNwAlgUSNsA5vawWM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9fjA1rlYZw1tluZfk5kJk8WyRwq2KwidiVndUTPPvZ53WK/RqTPnyX3uyHIEK3PD99DjaHl6RXbQ58KaPJsJ61JW+CSp/upUhmF5RegIBzyiGLFsaQAFy2boCWFwIjGILhNm1rvZ5VUMWqCcTdyRjVj2IO0UbeQp7s7zQrqaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=zYrOGBto; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="zYrOGBto"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d750eeaec3so1058083a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257579; x=1775862379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IevO0jL7BXgGS2hyD2bYVovc0qvt6dBkbqbfvfH8PqM=;
        b=zYrOGBtoWjQeLqeYpF4UZg3DICurjnqZERskqJ/gyub+dC7QmAdWNFLvXgaNnz86RR
         OsfS2bH9f9tPeKLCXuhykDs7lB3S3n+s7KI2GFlaw3zmvKgqq/sC4n0OnuVleafOBXnh
         UiuRaw+cD2aCMHtm5aBH3jvxJ3di04kjIotQ/ZYCvEClu+XEO6prVMtX6dhOyuynI3dj
         +Or7+3hduNYXck8kEjhmEih4xusqdsqn3NV/nF7OzpnAhbGtt80CdwykPRXKJVeRTEPa
         wZE5o6nKw+0ijwR3wBbKqNlzd0YNZvm4/dFgAAWxA1TaRAO/r9TC99TObH32GxSn8M7g
         MP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257579; x=1775862379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IevO0jL7BXgGS2hyD2bYVovc0qvt6dBkbqbfvfH8PqM=;
        b=VBMA1pYiN9uJCb70ngtBwv2IK4Seew/Zj0j+MzQi2/EJaAMaFBNAEWwreeXfWhXiJg
         AkVmRwFVRKssd/WZb+svPX/WbwSTnZneHS+VVNBAm5eLED6UPra0We+QK9te5vDuKzVD
         OoUwANA/iiwJqQkEuyRCmtYQZxEQ7K6UagavIgmP+l6sdQ/atYVjdBO3F28cFgTdQ2jW
         n0hNjGHEyVwY7hEO4A1XY/lStY/MND0Mr/0WtHn1iebc0CbdWf73T91igBYufQGGNSg1
         tFf6NQzIldUbmfYUAgWgad5M++rN9DiuyiHb9xOso7QDZZ66fgIYxYwO9tspbS4N27pr
         n9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXZTRk6I7CkoDhT2vEpMmp3Z/xOWmQOTpYDbrCbe68OnW8j21rp7vMeL4mgPXpWwae2xFF7tI0Y1FKlTB3v@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrERC2tU8rrvLyzxJpA+hLU3zT73Mng0AW+B+3XDyENabtxpN
	KxNra5UycXIke0aKi9RloFdUuTE5qBWhcJ0/mbDv9mkGSnxDMdnBlOM/Ol809rQEUhc=
X-Gm-Gg: ATEYQzyIMDKEK2PJteUP+IRayr1NC+aRxaHaquXk/OHY39ybGRnOBBPo/vMU65ap6Lb
	aCWw9llSvVow9Gv4sj9hiHEiA9lOG/MIQcFLdTOkpArTEOAS3aq93X2S+BSux/DJAvaN1lFs20k
	LLypEnq5sta/ObPEz+Jr5KoQ6gzaKK229LRjxjjjF9xfg85xJdk1GWGOv/KJvLBX0fdJqLpvLwD
	fYOSnA3FN4eOSnFtafsAIk0/1YsHk16yjuGlRELdi65Zi3gBIJ+MolOsfL0Ddy0jws/zp3tT4+9
	j8a/euZj+8/VCW50YczptHJPluLd76gsA8DaHujPvcdOrxV33wlylezXFBHe4QXTvIQ7jpqsrZ5
	UVWq49HYFlXx7Bzu71hhxDfDpBjb4+VE1DB80jXEu4THHDNrzLGXt+qpvud6prrxBWWSHASN+0E
	2N2qY9zdsfnY97pVK7U0yS83NcaRDSzKi21T6q2WyJR3xvz8VV5nOuEjIQwzSnsg7wvWxnyRREK
	7mmKy8kOwLBeagWeQt2yfP4
X-Received: by 2002:a05:6830:3783:b0:7d7:b6b2:6352 with SMTP id 46e09a7af769-7dbb6f961eamr2975252a34.13.1775257578734;
        Fri, 03 Apr 2026 16:06:18 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:18 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH 2/5] hfsplus: fix error processing issue in hfs_bmap_free()
Date: Fri,  3 Apr 2026 16:05:53 -0700
Message-ID: <20260403230556.614171-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403230556.614171-1-slava@dubeyko.com>
References: <20260403230556.614171-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we check only -EINVAL error code in hfs_bmap_free()
after calling the hfs_bmap_clear_bit(). It means that other
error codes will be silently ignored. This patch adds the checking
of all other error codes.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/btree.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index f1ed7c336593..80aa816ae1c0 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -146,8 +146,9 @@ struct hfs_bmap_ctx {
  * Returns the struct page pointer, or an ERR_PTR on failure.
  * Note: The caller is responsible for mapping/unmapping the returned page.
  */
-static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node, struct hfs_bmap_ctx *ctx,
-				u32 byte_offset)
+static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
+					  struct hfs_bmap_ctx *ctx,
+					  u32 byte_offset)
 {
 	u16 rec_idx, off16;
 	unsigned int page_off;
@@ -647,9 +648,12 @@ void hfs_bmap_free(struct hfs_bnode *node)
 
 	res = hfs_bmap_clear_bit(node, nidx);
 	if (res == -EINVAL) {
-		pr_crit("trying to free free bnode %u(%d)\n",
-				node->this, node->type);
-	} else if (!res) {
+		pr_crit("trying to free the freed bnode %u(%d)\n",
+			nidx, node->type);
+	} else if (res) {
+		pr_crit("fail to free bnode %u(%d)\n",
+			nidx, node->type);
+	} else {
 		tree->free_nodes++;
 		mark_inode_dirty(tree->inode);
 	}
-- 
2.43.0

