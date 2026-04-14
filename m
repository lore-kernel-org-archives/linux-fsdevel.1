Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A012EDD78
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131800; cv=none; b=AgdY9sebNqxzVjysfntv6FzGs6Hy69vMofOeXVw0TPybvuLgcPTYKqBJvUgNiXF5N2Lqc4Nk+JHZA+l4zz0+C3qQR3h+S6oMu1514Qr4rEDAaWMMsg4O30Fuv+8U2GL4XYC5NfbX6yMsZlOmvOATV5O2UP6fNbGk7GpPyInjNw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131800; c=relaxed/simple;
	bh=85pNC5vEdgGMvRTfth1N9wOwvmCOSwVjkZ3eUsZZkl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l/OjFI3WEktgJEy28zT/lG1AteKP5oV1hdRy31FQgn0EdTPIk7WR2UA/uEDS8t3mF+7HMEj3lZyoN83M6vUbUU1IIpwRxZml+GvtteMJZGTErVCnF2+O2+7ENBeK8n59KfYTfSNavJCZpv3hqqrAvbNDjjsvF1dsD/n84cc/1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1mMfKZA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1mMfKZA"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82c70e4654eso2205467b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776131797; x=1776736597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YMfYbXP1FT74ETBselWjg6OStd152nmOJb74V1LxHW8=;
        b=s1mMfKZAHEFWC7Ulf6GzdtsZqvtA95mgwOTiKuaLJpulZrPEaRONZrMrVaVa3vwFPr
         zcmEi8aDz91ew+xsZQ7lNOIJkP41EUGRCtJmW01uhu8lmwzLXzhOVEYK+mc8wIs4bOiK
         NaQDbxnSMnuOlKpYSYu70MrE/NwWVkyTp928fS6L1VtAko4na/VWuRZO/fmgxLOz6jxR
         SIT0vj/4KmkSfvVLFanRRTYCp3DZExdiw8zoRIJLRatIp9v0qGT7IdhbEME/NLg9WmKB
         Awl3yE/awq/vifLXbcJB4VCWp9D8MBEI6DVd3G/3aPfo0CPLT/c9HFCaRE5BJ6ZmCbzu
         y+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776131797; x=1776736597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMfYbXP1FT74ETBselWjg6OStd152nmOJb74V1LxHW8=;
        b=q1Z3dYAdBYbKnxplX0RW/famuFO25gHMqgfocq6f38e4lK+GbinNeyMEoosMzwUk7W
         b4caj3lXNtb+uDEX0k4wpYvIy0+d0jj7n5zQwLf1MguPtPyxLTVn4AnoRJPLv21/0vG8
         BpsCTEZReYCgMSgvBrjxV/R0NOzqYts0IjHOwjCVuspJ0h5721H99n6gSOy92i/yS1gj
         DFXNARhlfxddfWWHJ6RfETK5WXYksDB2lWaVYBilccZQimvUtVu2XXCm3/1ONfWkTqdE
         6T5kGTzXUl+CYsubl77iIYL7+wWGj6yhT3MnvPfeP+WD8zJ7/+OsAB0qfxuTPELNHFJy
         cdQA==
X-Forwarded-Encrypted: i=1; AFNElJ8IhGgXpxq5EsA49Bg5O6BP3jlzmXpif1Krv4O9KGZyIFLqBzCgD6gYhokxHa+V4bzJTESIbWvC8OPCoGlr@vger.kernel.org
X-Gm-Message-State: AOJu0YyOd5XtEA+BrpV9lj1S8tSbU3ev3v1WIvP6NUYZDK3/aaCE9MMu
	2FEN1iabSgg2y6BJoU9f/zLejHEBhkh8i08Wd0VdYL3tYYWLRY/7RpdO
X-Gm-Gg: AeBDieuk4EYRN2cxwEvmp1C2TiFQQFhXwm4fAypTTOg4rcrJ5SJxGWcUxRUr9o36CMu
	0Vkd97Sv2F2Lv0V44StWTsweKUShwTyFztHbkwP0gMEixvst+Sy7jh+Y5x0uwN0jNC397DDdX9X
	dtX9zinBZ+wT2v8T5ajqlUnmbos8cQRCUOQXtWVI5zuKJIcVmi1hL9pamNoL3k0ON+sxNhZUNo9
	2yIwzYGdis7szQun4Xh5L0PI0U3LMQM14lOMKW0DX/OGsrwkrRU3XLvnApo5bAtS5av88e85TPR
	nl+y+XrkI38YFLaLblWTkT+aFFSLaNbhvwKwjO5/ymkUDPd+aZ0Ly8yQjez2bcIP9/OZSiZ2wCr
	JbBjCnAj7kKKW8VGLT5XLr6KcOVgqjX7KkcDgeu6sE2m93KqxXYoGZRnIzd2rvP4fq7f9sSg9iP
	ikAfS9Aa02E0jzakm+9PVCdTiRN9eGxNqvnE5QOYmgfvB88iz6Yoa8Gfm5dFSHhnjtV4jaCBTrT
	HBkMDjBmWGTHGub6w==
X-Received: by 2002:a05:6a00:f0a:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-82f0c24e21emr14125019b3a.7.1776131797253;
        Mon, 13 Apr 2026 18:56:37 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:445c:f4a3:a803:e3c6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e1a2dsm13070584b3a.44.2026.04.13.18.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 18:56:36 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: fix ignored error return in hfsplus_delete_cat
Date: Tue, 14 Apr 2026 07:26:30 +0530
Message-ID: <20260414015630.65081-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
extended attributes associated with a catalog entry, but silently
discards its return value.

When the xattr deletion fails on a corrupt filesystem image (as
triggered by syzbot), hfsplus_delete_cat() incorrectly returns 0
(success) to its callers, allowing execution to continue with the
filesystem in an inconsistent state and eventually triggering a
general protection fault in hfsplus_cat_write_inode().

Fix this by capturing the return value of hfsplus_delete_all_attrs()
and propagating genuine errors back to the caller. -ENOENT is
excluded since it signals normal loop termination (no more xattrs
left to delete) and is not an error condition.

Changes in v2:
  - Fixed commit message: hfsplus_delete_cat() is called from multiple
    callers (hfsplus_unlink, hfsplus_rmdir, hfsplus_rename,
    hfsplus_evict_inode, hfsplus_fill_super), not just hfsplus_unlink()
    as incorrectly stated in v1.

Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes file")
Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hfsplus/catalog.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..adbaeabc06ab 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
-		if (HFSPLUS_SB(sb)->attr_tree)
-			hfsplus_delete_all_attrs(dir, cnid);
+		if (HFSPLUS_SB(sb)->attr_tree) {
+			int attr_err = hfsplus_delete_all_attrs(dir, cnid);
+
+			if (attr_err && attr_err != -ENOENT) {
+				pr_err("hfsplus: failed to delete xattrs for cnid %u: %d\n",
+				       cnid, attr_err);
+				err = attr_err;
+			}
+		}
 	}
 
 out:
-- 
2.43.0

