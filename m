Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D0437F00A
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481073; cv=none; b=PCd7vbR1UoZXXdmNol2h31Ib/HROGgHUwHmqnerM0v/b1SFw7c318WMy/ylbVPHI+jkYHmxc4VSz9xdjJIM0ZKGD9awdoIgZHsHDxSfrYQKDMBUT/12joDS2WQZg3vMEcbfoXHyaO012NEU0cP0TVZAL6BcCo+OdHi5/Cve8wCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481073; c=relaxed/simple;
	bh=WZYUF72Xkerj0D//LCComnJLpWN2NH28Ez6pSUiLuJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZrVfMzCZBppd1QZXC4hXvboOQdk+2xOjdy6Eotoa/DmJaCPXM4qtXQ5VShYgqTI1bhRZJoVo3uhjqpQyAs+BsYiYaIeu5mATY1UdloNjfLqvRXeH4HjABZyYzIAs0eYHF56aXD2RQwGMaBjFDH5PJeoWMrG+KnL6bSjEdpxcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8X0CabZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8X0CabZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf20f6be6bso19900105ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481071; x=1782085871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bcM0BEHZZySzT7ywKGxmQCcb3j01ofeeqLISk4RkOg=;
        b=C8X0CabZaWma7DFtfKpqoXmk7hIyTi9rXr8ZNa5A2fvIuhkydM/q4K7yvXktSGmRNu
         qmx5kRqBp7DLSFSPSstmhK2Km3HtEcaQ9nplK8CG6hJJ48qRuKXmSUUXoC7qxhfNeMr2
         ASd00vRcv+/WwCPOHmOyRy24Y/XfSRLT3jn9hN3W9DHlg8JtBlb7BFvMMVE8SOt7OY9+
         Rr6vqFqPIORuCdlwLyYxJauVEYzUMxu2SOfy1qzpnoWFuTkm8Gjy91WCMrC8XFDmsgEu
         MVKNLuCO0R1AHl65SdeOIpc3dX2OYVvC1Ljjdo9a5RUPkJJ/f7VNVwLTzzyxeemTlwbf
         PuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481071; x=1782085871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0bcM0BEHZZySzT7ywKGxmQCcb3j01ofeeqLISk4RkOg=;
        b=Ym2DMH98BvbtcCRUGKN9Pj1zUdFpq0sW+yDXuAf757FCdkwH5XzXTxyhOaRkmwzW80
         UNRXIQL2IX+0kY9A3o1xW3quWOXPu9Xs+zf9kTS2d8GRKWjjYDeaK8iDR0N9gVlQqLvb
         B4segie35Cpnv6pcqY1MlW49S6nPPt4FPo77aC+4usCIzu1drA6LOhT7++CePgvKAugr
         lCI1u88ZYAffhJxdyk5Z43YYSszL0xG7OWi98ZYjb1LUZCpRXg41MuQmlbK/+Ht+iWAJ
         6SHw4g/tNOL5xHvUVTSoCM+tGHniRTceRgUENSTdFS4moXmu8aPUxdckfKjoh+rJAWEh
         ZiwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9bfCWyLpTuD99bId6Lr+tQLFolo4+xfcpvtNVroJAjJqlF8VW3hm7UC0zHJP5ONUDa+YsiqIC5HPLvv2vB@vger.kernel.org
X-Gm-Message-State: AOJu0YxaD5xiJOWKK0WNBWbMVRbmGLR2Z5mhk7ujDxXx6pXPUxiDDHqL
	syiiqcJwhlvf3fLrq4dUW1m6+cKROxCJhyLNDB8wCNNxm4zO6tfl61lX
X-Gm-Gg: Acq92OFdtP0yV4lo+eZ+8X9CwAomMte1xm73nSB+UQVLPPK+GOystutQpoTG/1/ZYLq
	2mt2/liYUBCkZa0rZ7izotWVmx3zX9c6sfIBGFbnEJFAuJ2CxM/d4dAIi5dcQtrUEr+Uld+zmZq
	Vbj3ZqJq7OPp58adk6t5T3EseRQLjN4MqNg97q8IdjLAAEIlNa8LgrIFVRCPiKetmIpLkdhoJaK
	kuTPicgMwcv2rf21kF6fDinsCMonWhORWKWIjuXrUTFusLjZl6C118UR5LawErGYm/PvYiR3roW
	PIi2OR/rz6UUP3DapMa1NqbTWMwKTtt/2Vr76RfPfS/JlM8YDeVTW5e6lPvHRvw+aXuHb1sekG8
	e4cvtCQfWI3seFGs/vwKuPhKdbKX9OeAWCBEO+nR+JrMNdXtdD40Uz/gWbbF4fofyp9RJsZMjE0
	LknGUiEc9LISm65LQQM0CvCZNrZ1jCWn4QRDd+2lh8
X-Received: by 2002:a17:903:2cf:b0:2c1:6715:a4ea with SMTP id d9443c01a7336-2c411f73a6emr128630215ad.30.1781481071438;
        Sun, 14 Jun 2026 16:51:11 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:51:10 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ntfs: clean up target name conversion for WSL symlinks
Date: Mon, 15 Jun 2026 08:49:56 +0900
Message-ID: <20260615-topic-symlink-v2-5-648a769d01f8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
References: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=WZYUF72Xkerj0D//LCComnJLpWN2NH28Ez6pSUiLuJo=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3QKYxN74swdA01gJsHbQo/IsrTQ+JSwbFEJ
 7pirUWGMfuJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai890AAKCRA08jD6945I
 03LPD/4hMNTfGWmXwnA+iz5VelVHdR0Pxsu/ViDSXblMtLwEqcUqBcBhn5RVkXRf78zCePf7+Ic
 GoaKnrgHeRpO2zDcQN8rOT7HQw9tR8SyLRw0E96GOkeHsmv/QnQUMpS+8zQ054mNcCORhzLYiKM
 H13tG5Q/SlTZ5LWby3hnSv/CJ8X4NCfWcWk3A8DsrAHsy8mXyr9ns8dBvzrk8hgR1vhuqlw3S/+
 hoHhszKRVvVR8ezuzVhELfuUITdyPwH6wzPOTalKDCbyCgQQq9EyC5JlTKEVLnrEnPxlWv+tcPq
 0Rs1+2JWGWAEM4asGUYIWTJPo6bVYSrVYcJ1P+3ZPoiU7894NZF1bJxxfBI9VTzz/HMnAU/d1iZ
 A6w2xyL7sEKd1D1LL7/vJhMEgrzn9OHcavWAEzJSX50IwfOv5cOtOXtVOpC1/FBGR/4uF9wgA5l
 RS19KVWCmFHfDsuqGEIiYN3HltIfrP4D2YiO9rQdk8sXOdiScEw59PuBRFlDH3CG+5INGlNROdW
 tavUcjtOIznvPpUiQfSyI5wrXgR8n1rjw+0izkRe2moVmImliXHmTi41w+Fzs6mORY0kzeLaDLk
 5evgMO4JuxFqipEJYMUr5U1gnPwzAFhRQg5xWNx+PFMWbSCWivkkhiuCr5iqjJ8PBBjbIMGPiXc 99WeGk3w7jq0gdQ==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

WSL symlink target names are stored as narrow NLS/UTF-8 strings on
disk. Converting the target name to Unicode in ntfs_symlink and
converting it back to NLS in ntfs_reparse_set_wsl_symlink is
redundant.

Remove this conversion and pass the symname directly to the reparse
data setter.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/namei.c   | 17 ++---------------
 fs/ntfs/reparse.c | 56 +++++++++++++++++++++++++++----------------------------
 fs/ntfs/reparse.h |  2 +-
 3 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 9c1c36acfad2..88c0b05dde3b 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -394,7 +394,7 @@ static int ntfs_sd_add_everyone(struct ntfs_inode *ni)
 
 static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		__le16 *name, u8 name_len, mode_t mode, dev_t dev,
-		__le16 *target, int target_len)
+		const char *target, int target_len)
 {
 	struct ntfs_inode *dir_ni = NTFS_I(dir);
 	struct ntfs_volume *vol = dir_ni->vol;
@@ -1409,9 +1409,7 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	int err = 0;
 	struct ntfs_inode *ni;
 	__le16 *usrc;
-	__le16 *utarget;
 	int usrc_len;
-	int utarget_len;
 	int symlen = strlen(symname);
 
 	if (NVolShutdown(vol))
@@ -1432,23 +1430,12 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		goto out;
 	}
 
-	utarget_len = ntfs_nlstoucs(vol, symname, symlen, &utarget,
-				    PATH_MAX);
-	if (utarget_len < 0) {
-		if (utarget_len != -ENAMETOOLONG)
-			ntfs_error(sb, "Failed to convert target name to Unicode.");
-		err =  -ENOMEM;
-		kmem_cache_free(ntfs_name_cache, usrc);
-		goto out;
-	}
-
 	if (!(vol->vol_flags & VOLUME_IS_DIRTY))
 		ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
 
 	ni = __ntfs_create(idmap, dir, usrc, usrc_len, S_IFLNK | 0777, 0,
-			utarget, utarget_len);
+			   symname, symlen);
 	kmem_cache_free(ntfs_name_cache, usrc);
-	kvfree(utarget);
 	if (IS_ERR(ni)) {
 		err = PTR_ERR(ni);
 		goto out;
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index 33e5a4198e9b..91ae0c75e275 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -753,43 +753,41 @@ static int ntfs_set_ntfs_reparse_data(struct ntfs_inode *ni, char *value, size_t
  * Set reparse data for a WSL type symlink
  */
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
-		const __le16 *target, int target_len)
+				 const char *target, int target_len)
 {
 	int err = 0;
-	int len;
 	int reparse_len;
-	unsigned char *utarget = NULL;
 	struct reparse_point *reparse;
 	struct wsl_link_reparse_data *data;
 
-	len = ntfs_ucstonls(ni->vol, target, target_len, &utarget, 0);
-	if (len <= 0)
-		return -EINVAL;
-
-	reparse_len = sizeof(struct reparse_point) + sizeof(data->type) + len;
+	reparse_len = sizeof(struct reparse_point) + sizeof(data->type) +
+		target_len;
 	reparse = kvzalloc(reparse_len, GFP_NOFS);
-	if (!reparse) {
-		err = -ENOMEM;
-		kfree(utarget);
-	} else {
-		data = (struct wsl_link_reparse_data *)reparse->reparse_data;
-		reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
-		reparse->reparse_data_length =
-			cpu_to_le16(sizeof(data->type) + len);
-		reparse->reserved = 0;
-		data->type = cpu_to_le32(2);
-		memcpy(data->link, utarget, len);
-		err = ntfs_set_ntfs_reparse_data(ni,
-				(char *)reparse, reparse_len);
+	if (!reparse)
+		return -ENOMEM;
+
+	ni->target = kstrdup(target, GFP_NOFS);
+	if (!ni->target) {
 		kvfree(reparse);
-		if (!err) {
-			ni->target = utarget;
-			ni->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
-			ni->reparse_flags = 0;
-		} else {
-			kfree(utarget);
-			ni->target = NULL;
-		}
+		return -ENOMEM;
+	}
+
+	data = (struct wsl_link_reparse_data *)reparse->reparse_data;
+	reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
+	reparse->reparse_data_length =
+		cpu_to_le16(sizeof(data->type) + target_len);
+	reparse->reserved = 0;
+	data->type = cpu_to_le32(2);
+	memcpy(data->link, target, target_len);
+	err = ntfs_set_ntfs_reparse_data(ni,
+					 (char *)reparse, reparse_len);
+	kvfree(reparse);
+	if (err) {
+		kfree(ni->target);
+		ni->target = NULL;
+	} else {
+		ni->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
+		ni->reparse_flags = 0;
 	}
 	return err;
 }
diff --git a/fs/ntfs/reparse.h b/fs/ntfs/reparse.h
index ed7b93c359c1..e36557f29677 100644
--- a/fs/ntfs/reparse.h
+++ b/fs/ntfs/reparse.h
@@ -14,7 +14,7 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
 				char **translated);
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
-			const __le16 *target, int target_len);
+				 const char *target, int target_len);
 int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode);
 int ntfs_delete_reparse_index(struct ntfs_inode *ni);
 int ntfs_remove_ntfs_reparse_data(struct ntfs_inode *ni);

-- 
2.43.0

