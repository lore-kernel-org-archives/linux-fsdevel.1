Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085624749DB
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784807352; cv=none; b=r8gihANPiQTY7lfGZ5SmlbdViU+kWI72gnN5rcfnETCawatmg4zYNTugGz0E2g6OO9ZX6hNq0IpWV4OB3PUAMbxEHtKWjoguqgmx6QcBtYL6Ij4PNMZx1ikQs9bJb27fuy5BZTyUGpSHX81yOstYfeltv2pj8nihgF5LLMMw1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784807352; c=relaxed/simple;
	bh=u4WSZn8LpVoSFoR0j9C7HWeJrRajMHbArA1zRGf20q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHbqDhzxFMt5f0oifx+jyWp+yxL7+TlSRGPtepF+lwbt2g5chZCNthJF7OEd6wz+nKDK+0j+suaxHBBVoJ9eSNe1zgXODRdCpuWPrEIBA/z/5W9T5Oe+x1RojQLv9c7SK+72kfCrDnn37JWMlKLWyLpxrYVhMK4IVqTitX4jR0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBXjoQz8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBXjoQz8"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69c5f6f7a40so1076287a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784807334; x=1785412134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxorIkgqPrrBq5Tfe/wFMye9q74MZOclMs+Fvsmlsac=;
        b=sBXjoQz8VCpbqgBHzdkCiEAczjtvcvXTjH9x/ENtIXA2a3Iads4Vh5Wl2Crb0nWLRw
         1UgLcOWqxlE+I2lOAnKdJDER4f14YizTyO3ed1Rq67c8oKdJe73sp7D32kpdpNjauFnW
         RveitxC98nY5v4ZMtXnyolhb8/8Nq6jHlO0AagxL24qEPrscQcYMBnUAZSDMW10YvbD7
         Noy+3HSijndhK3BDdTk2jsssAe+/OEGoP5UCZeTKw0Ma1CZRnHgm3crwb/uajp/5R0Tg
         tgvyjGa0USjwcgrPq24w3E88CnQhiwSnhHlFheeehWCoUzDLmNYI4oCAbdwgnYNWvNR6
         Mv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784807334; x=1785412134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxorIkgqPrrBq5Tfe/wFMye9q74MZOclMs+Fvsmlsac=;
        b=JSh9+JSakvLWAhOZnGTUNEsdZIZW9NoPdtqCimvKh+vjeTt8MRT4peMzqc6/bbCNvx
         rAKF7CnLNNRAZCvPKZN6YWZapNnB+SgAUrECBVI8iEz67EsumyQ7uR23WQPnd9tk17gx
         iwZx8Ms4CZkwws8K8daTFeVPrnRY8bu0p2Yw5DGiOnuH4o6+osRlMynqsz0N8SEZP3aT
         k8VlnTlVwZ9LLYhZpP2YcEIYQQou0IDbg0exxOhE41Ol32RPz86kLZXElSB+tqYKu24A
         aDS+FYWpspyt4sitgJXF8vwZXq3fO8V+vDgOZ4RP4b4lXxhViE5L8XleyT0nXpE0njnm
         v32A==
X-Forwarded-Encrypted: i=1; AHgh+Roziz2HCSONEUIkhvwXJZkw2UdIRM/75PrsFJPsVk5A+sNTBmDlGM3rUoJLXrFc3bau0MRIbG6TKQkVNRir@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9hGm/trk0lRgIeaIl/Fg+3RqnkR44qXAi1Mpk6VU+WNIe5grI
	G847jtHH9gibk/ccjtUjodN3OI81fYHuzTLiioIYkwYJ+Ox2YJfpXMD3
X-Gm-Gg: AR+sD10APt0ASzgpIFPFRahD5QuONSxwxiwq+8oEaU/XezP8L+8/nvNHZYQL8bJ4OX5
	3ZNwn8TJimM7aLGctsKCNHOcyF3ST+Ux1kODWSJI9maNfqjI02W1zF1oZUBxhZR+Rtr5eXaU/DR
	cbosF1uOATcYZ2z7Aog0w2mNItcGxtNd/8werNR7CxGFGceNvUZekYG+eRmQFLoB5Isv1R0gtjf
	JJzFYcedmAWO2BuhoZC+MmIwRTIoszy6ASNZ0GqXrhmOk83ra3DPDHZPv70M6BIn64NOLt++Nzv
	3VZUzCotgi62CS/JjJ6JlcmWMjEKBwi9NUpNXg43nMjyRsBtlm2wlYxaDlgQl0Q3PE0fc4rAL0g
	WSqkRL6bPbg4g2wVoZN7FGUJjoyPBuHVjzTOniT+lVv/cXy4w6WaRHSm5GT6o4Fsm+XYyYEPRRg
	mmBHzIgTR2pmOWFQS4hw8QGz41hNU=
X-Received: by 2002:a17:907:2683:b0:c12:8664:6aec with SMTP id a640c23a62f3a-c1c5099c554mr122814666b.53.1784807334342;
        Thu, 23 Jul 2026 04:48:54 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac7eacsm225125066b.17.2026.07.23.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:48:53 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 4/5] ovl: add support for copy file range from another fs
Date: Thu, 23 Jul 2026 13:48:47 +0200
Message-ID: <20260723114848.1212429-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723114848.1212429-1-amir73il@gmail.com>
References: <20260723114848.1212429-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is technically possible for overlayfs to copy_file_range() from
the base fs of the real layer.

Set the vfs flag FOP_CROSS_FS_COPY and implement copy from another fs.

Implementation of copy to another fs is a bit more subtle and will be
handled by a followup patch.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c      | 22 ++++++++++++++++++++++
 fs/overlayfs/ovl_entry.h |  7 ++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f3d97eb146e85..169a48de565e9 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -533,6 +533,13 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	struct file *realfile_in, *realfile_out;
 	loff_t ret;
 
+	/*
+	 * Overlayfs may be able to copy to a non overlayfs dst which is on the
+	 * same sb or same fs type as real file_in fs, but not implemented yet.
+	 */
+	if (WARN_ON_ONCE(!is_ovl_fs(inode_out->i_sb)))
+		return -EXDEV;
+
 	inode_lock(inode_out);
 	if (op != OVL_DEDUPE) {
 		/* Update mode */
@@ -547,6 +554,19 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_out))
 		goto out_unlock;
 
+	/*
+	 * Overlayfs may be able to copy from a non overlayfs src which is on
+	 * the same sb or same fs type as upper fs.
+	 */
+	if (unlikely(!is_ovl_fs(inode_in->i_sb))) {
+		if (WARN_ON_ONCE(op != OVL_COPY)) {
+			ret = -EXDEV;
+			goto out_unlock;
+		}
+		realfile_in = file_in;
+		goto do_copy;
+	}
+
 	realfile_in = ovl_real_file(file_in);
 	ret = PTR_ERR(realfile_in);
 	if (IS_ERR(realfile_in))
@@ -565,6 +585,7 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 		}
 	}
 
+do_copy:
 	with_ovl_creds(inode_out->i_sb) {
 		switch (op) {
 		case OVL_COPY:
@@ -660,6 +681,7 @@ const struct file_operations ovl_file_operations = {
 	.splice_read    = ovl_splice_read,
 	.splice_write   = ovl_splice_write,
 
+	.fop_flags		= FOP_CROSS_FS_COPY,
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 	.setlease		= generic_setlease,
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 80cad4ea96a3e..8a1862cf87d78 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -112,10 +112,15 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
 
 extern struct file_system_type ovl_fs_type;
 
+static inline bool is_ovl_fs(const struct super_block *sb)
+{
+	return sb->s_type == &ovl_fs_type;
+}
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
 	if (IS_ENABLED(CONFIG_OVERLAY_FS_DEBUG))
-		WARN_ON_ONCE(sb->s_type != &ovl_fs_type);
+		WARN_ON_ONCE(!is_ovl_fs(sb));
 
 	return (struct ovl_fs *)sb->s_fs_info;
 }
-- 
2.54.0

