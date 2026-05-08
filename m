Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB440FDB2
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254468; cv=none; b=f5j1GSLA2Yvx2b1y+sjcPh2LN2Ag1Ie1MHiprK5WU3JpRFyeqjHU9Bp123kSipmVafVK5rxK8y5duqEppwXJlqg/zUasrO/QQjhujMnPkBYOwaFNz5ZWux/vBYZeVMCFwYEYjTQjLI0dRLPCZ0/rqk8lmyPGh/5YVYQOdrH//aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254468; c=relaxed/simple;
	bh=EnMncloGY38zNHH2IlD/jQ3ejkAbYcKTAZzgUACfn+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/SVoMbb4CwMISMmaNnYkclfD6X5QbmaI/zuwiDylNteFCvxRePIfeoces/vOmIodlRuesINA8mV5VpVTAJrsE6/TF0QEocjT3rhyLYDJUpxiAsI4/AWf+jMyLoclcMxDamyirOurLNfx/OYQ79G9bjIaA0gAgaJkOFjREkHifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdMQ7ayH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdMQ7ayH"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c824142c880so74391a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254466; x=1778859266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qq6X5xns9piV5RmWtTQbxwisodvE8nTQSWemS5y31r0=;
        b=CdMQ7ayHMTnQAmUROqKyBPffUNrNgKSvBnqLAyqa4jIarxFUGCa/pLMYnIB2MnJ71w
         Gkf1DQxysROzzMIT/uOvCVsrTLvUPNG5OcljeHVIjJx3QL1Y9YUA6YyZiPLM8yfAd2Oh
         Y0nRYz4ul/OxMTRfyEICzGt56SkZJz0VPa+Bs69LGEfugyzIUHkbFBPVh+NIcKCPioEs
         dH7sZNcFtLNQ3c17dTjlLU1We6qTSTcgyM9Jj0FUgsIx7A6A9GGLLgyWB6aHUfJdohKh
         0QtDMR271Mu7Qo/0Iay2fYwewwJo/lxDTZ5thqA78/O7ac5X1GcaWzPfQmLyqOF+S5Uq
         sDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254466; x=1778859266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qq6X5xns9piV5RmWtTQbxwisodvE8nTQSWemS5y31r0=;
        b=JI9gLnBmq5lyh5lZZD4/73ZolGmRfn6Bby2XrCSzgtgWwRNz8RSulElUoDgIZQSyeM
         xuh4GMltL7m6pMUbk8s2dhrGOS76OMSYgqoWLUDevSeUpTUlRCDzlp9GsGedrEV3Hyd3
         V9RHTCQxBf+fscvEawSUgLngARlDkqkGL+4kjHQmnDDJMPEKL9HGsuQ2SHwxjOUoUUnp
         Q/PuVEvg+iMjI8bGZwoTjMl/liHKhwDX/o2cXllAIxwEhmq382YxmiMzgfid9zM+Korb
         acD9aD0r2F9K3h+yQfdz0N2vb+IVhbCIYZThQvQs4Fki+gwoY2laPzwhD0Tg/vULrjiG
         PpsA==
X-Forwarded-Encrypted: i=1; AFNElJ+KtUy8nb+HWv0dmCHbEbaCvUPcdo4BQ9iNWC2CCV72d9QyQQZJVuFTWtUTIBiz2P0Jt7Z8Nv+oqS3Pxeby@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+hSITbKr+u4cx4YTIFR4xuLmKr12jXPda4z29ktaNNeN3n2G
	rXSrz2pcYoAPBnyuF2Kfpwec1WWifmCqWDMxNL1C68z4bgokrmQpzzgY
X-Gm-Gg: Acq92OGHMjPcekmHG5OmOlGd6b/2KYHW3VMzvDPKaUxRf7Ci3+NdWXb8x6Rj/IxtprP
	VnYa8djwOsyTckeUu+wry2wQu2CKxgTA/fYt+h4Ehppch+InLCaaMBfQygUVnVYxNCm7mS5qa50
	HfIrU+bBeC2escYINk+8gl+UQv3lAOUpEfoB/2BFKd/nfyzA0GrVhYlcQOOM8Iield2i7HBF9LQ
	UrBznUDEY1+yqGh797U3u6WBZIuV59RshZrpbWHvYiPXWWWhtX3r6f2XHbIhehSpUOqRErMcv0E
	mglBV5S2C0WZj5dXUj/xewdkHxxT/B+PSqHPLD7xamJPuUZr9FK4qAf+CUcJN4oZZOhTwxg6RAM
	X7avOUGCoBUAiVq07uzHb0LKXQMzjTGLOx+yLuqlVazBLqO4HENusal8IWd6q9kYeXAR/kf8HZ8
	pLmYNk1Qd5StFNoYhlKo3WeheytcY=
X-Received: by 2002:a17:903:1a2f:b0:2b9:42a3:6013 with SMTP id d9443c01a7336-2ba7afccfa5mr67838505ad.1.1778254465930;
        Fri, 08 May 2026 08:34:25 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d4094fsm26666365ad.19.2026.05.08.08.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:34:25 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ntfs: validate attribute name bounds before returning it
Date: Sat,  9 May 2026 00:34:10 +0900
Message-ID: <20260508153410.2624801-4-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508153410.2624801-1-charsyam@gmail.com>
References: <20260508153410.2624801-1-charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_attr_find() validates a named attribute before comparing it with the
requested name, but that check is currently after the AT_UNUSED handling.
When callers enumerate attributes with AT_UNUSED, ntfs_attr_find() can
return a malformed named attribute before checking whether name_offset
and name_length stay within the attribute record.

Some enumeration callers use the returned attribute name pointer
directly.  For example, one path passes (attr + name_offset, name_length)
to ntfs_attr_iget(), where the name can later be copied according to
name_length.  A malformed on-disk name_offset/name_length pair should not
be exposed to those callers.

Move the existing name bounds validation before returning attributes
during AT_UNUSED enumeration, and write it as an offset/remaining-size
check so the subtraction cannot underflow.  Extract the converted values
into local variables (name_offset, attr_len, name_size) to make the
intent explicit and avoid repeating the endian conversions inside the
bounds check.  This keeps matching attributes on the same checked path
while also covering attribute enumeration.

A small userspace ASAN model with attr length=32, name_offset=124 and
name_length=8 reproduces a heap-buffer-overflow read in the old
enumeration path.  With this change the same malformed attribute is
rejected before the name pointer is returned to the caller.

Fixes: d3ad708fecaa ("ntfs: Initial commit")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/attrib.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 330127975b26..f51917b4a494 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -675,6 +675,9 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 	__le16 *upcase = vol->upcase;
 	u32 upcase_len = vol->upcase_len;
 	unsigned int space;
+	u16 name_offset;
+	u32 attr_len;
+	u32 name_size;

 	/*
 	 * Iterate over attributes in mft record starting at @ctx->attr, or the
@@ -702,6 +705,20 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			return -ENOENT;
 		if (unlikely(!a->length))
 			break;
+		if (a->name_length) {
+			name_offset = le16_to_cpu(a->name_offset);
+			attr_len = le32_to_cpu(a->length);
+			name_size = a->name_length * sizeof(__le16);
+
+			if (name_offset > attr_len ||
+			    attr_len - name_offset < name_size) {
+				ntfs_error(vol->sb,
+					   "Corrupt attribute name in MFT record %llu\n",
+					   ctx->ntfs_ino->mft_no);
+				break;
+			}
+		}
+
 		if (type == AT_UNUSED)
 			return 0;
 		if (a->type != type)
@@ -715,14 +732,6 @@ static int ntfs_attr_find(const __le32 type, const __le16 *name,
 			if (a->name_length)
 				return -ENOENT;
 		} else {
-			if (a->name_length && ((le16_to_cpu(a->name_offset) +
-					       a->name_length * sizeof(__le16)) >
-						le32_to_cpu(a->length))) {
-				ntfs_error(vol->sb, "Corrupt attribute name in MFT record %llu\n",
-					   ctx->ntfs_ino->mft_no);
-				break;
-			}
-
 			if (!ntfs_are_names_equal(name, name_len,
 					(__le16 *)((u8 *)a + le16_to_cpu(a->name_offset)),
 					a->name_length, ic, upcase, upcase_len)) {
--
2.34.1
