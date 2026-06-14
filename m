Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57F37FF5E
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481070; cv=none; b=jggEVLjtW51hbXhNKROVCNGSknNxQJYJUeei0kqxHSAOTe193fF1/0MnHyBAjX4hEC1m/ILQKJeeecviQA46ISsJvJN4ynNfzaWxCnquM/LPyAnBNfUdfQ2BwOvWEF/K9pS+ydtqSaHqhdrg4I/y0PSLUEtoBHQjmM4oqNEP32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481070; c=relaxed/simple;
	bh=mt+JmKw3sU5g8dP87l80+wAa37YGSjw/oUi59DYrpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnRFLJaPLP1kR2OctpbN3rZqI0h9zxfhpTZDjxfn5vMfAsg7yyglfJKJqPRilUTJAk4T0RhWxudJ8TFgn0+JnSJaCapcS/LhUNF5APNb10EIQZaM6Uf/+sNbjHY7L43xANoFnAUEX6Pi1+7rdic4BUs0utuTmDq44zPWostokp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDzvOJHm; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDzvOJHm"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c855599a77aso1208507a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481068; x=1782085868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05bT4hFs2JyxZMQsak70tJ/pABYR3hkaKhUdW0lLXv0=;
        b=lDzvOJHm5jOVipe/uWV2PvSSlUv1IBMd7UE1/l6d7VG/ZuAovOGdcXsgna29NUiKJF
         PanMyl5yUdMGOifZfU9S/xk6Nu5N1pGpuf5I7/F7w6Bis2XcvTVM/X9vzqGC9pA7dZul
         jJOmtCWtJmZiPdmUkuugej8f8Q68Q0HvYEHXE3LfN1z1UY5ILegJ3cddgVg6tB7WkiUG
         etfOBcRbySjwrnv0pzKFNx9GejR/WwjtNV1oM+Y2xQViBFQCFauRT/XJbBJlx/UzVNHP
         7hsIv1oqGOBLqUQlFeqq+W/Js1WYHsm2jCZCw1kMpJjBrvvfzAtGdhVuphpm8F5aGMiz
         kUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481068; x=1782085868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05bT4hFs2JyxZMQsak70tJ/pABYR3hkaKhUdW0lLXv0=;
        b=S8kHI8ulH52ICQ5xO2Iw0f3jtlT6/mSW19S7oPf8Ta3M0DZ83zKtkQW73JwzgHUidg
         3bl2FVGkyRO8okcE2aLDHxbuq+qH1TvfY1z0bEj9SI7n3i+YidxG1+2dUQUC2Ab8uQox
         MvD+xDw7UtFn6pQc1m9gwws58epW/dhB19ue5CIkKixd8W/Rx5XXLkWGORJjXaHWrgd7
         yVBThp7bpUQW+b95ygCLTPpQpeP5kQOIUGPnxAsYFln6rcEEZzbKVHWlEg/ytdNk54Ky
         Vn2xXN95qWG8yZFi9iMyrwVCmdooIpz1px6pDryP+1OBPbqOtchA5qDzQe9zuHXV3d6i
         y8xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DDsH8q96mjS+GEKXo38HJCgomrvZ4R41zRM5CB7YtFxD4gVYJVATtWcJt3o3CFcOYfhterHicgSJK2jeu@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6+yYNm9pnpvQPhMZLIcEfjG2Fuk1Kw6B1FdJrI4aLz/idFwx
	yNDdBn5+6M6qnq3H6H/s98pEUCXZMAE1T8CnoEBp0gFCbVCEP13S+v4V
X-Gm-Gg: Acq92OFcZLKGiGXRy0dkFGvYUMy0PrnpUuao8MjMOJ8BPRDWun6iYoMITiTZXGY0u4/
	jYKGfn08TMUJp/pihp/NXvHTqte388qf2pJan3yBpfPc24cP2o6QuDFebDRUxZ/zc260d1GzHf2
	lEkeXK0AkecYc8Iq+X47BHVEgs8QGD2oO3tOifQMw9H3fRBIgT1rTOE1MvDRlYUOHv6JTHTUM/F
	p2SP7WW1tVe+tUf0qAbJlXJMWW6WIvamgmH9JQMvRj15LYnxmGX45mL+DNaSE44m+31FYUt8uyp
	CKZ7/x3jiQDK56+7d5UBvdKs3e0fxrrdbTojVcRuw4+th1kULO9QdLmZiXSDompoYBAl82rXJUQ
	29OP1z7GncCPYvBPfp7TIMF5WmMgeY6mH1tq0Skbz6WKZ+bgP2RC6i+u5nY/5ZrDvzwT9NlJ4XK
	4R1Qqh69vWHeImjInMVNqwi+6O7bviOZMrglNJ8zV7
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr135483695ad.15.1781481067803;
        Sun, 14 Jun 2026 16:51:07 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:51:07 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] ntfs: add native_symlink mount option
Date: Mon, 15 Jun 2026 08:49:55 +0900
Message-ID: <20260615-topic-symlink-v2-4-648a769d01f8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4601; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=mt+JmKw3sU5g8dP87l80+wAa37YGSjw/oUi59DYrpr8=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3QB4AHH85nsuHlPX/lCaNWKKf4MvDp37jmq
 VseaoqECKKJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai890AAKCRA08jD6945I
 01vBEACdzotiZflWsnagGlI4hlrBzGZuZnsIogMoijwyeIQpVIMzDyFPOfJmY0xWjxprDfXkZcB
 qP8Zh35NdT+4yoS1tvIpLE0n3HENjbw/5awcvl0gHBvlhSH/sQkchjLSk5uNwLALM05g32kSJZ0
 Mp/dH38dBk4qO1R7mbzb2qZzpLvd8UcoC3GFfABdmCmJiszsVjwqtc9QX5dU2azf0LGUWi3SOUM
 bfSOGPA+mw720eQ22Z72I+GKBZPfb8Or2yWeQ1t7i8V8k/OG2PUdb675id+Fh6tO4OAP8gte5wX
 3pegjYb9cDcRqHb1kbFExo7W8RtBTHfgiwHcpHjJMAXg71luzE5f2zB9K6wLfUg117I0mfOCLBB
 lF4ETWNA2PWk2GUldhMCAxnGVKZs/ZQNOrTUR/XSNJWMY+5reS1AJ0rgOH9EK+52GNUk79tJOxC
 3nuhMxeVeglBrl3sgvJoQvbeO+dqAW5iloRfCUUzTdPZPhRSvDOyAK1nZkojWrL+cxnmOQOnlED
 PwnL8LiApOyKu+GU7iHGT427ZAglYaHN55kdm2K8nVaPoANpjGuP85Hf3C4aNt5ryKg8VZkB07N
 fkwmY2U1FwZojOwjrWSASuQoS0oB1YwREgQqSRbf6cRGQR996Oo6Yec6r4eG74a57ZTf2HWdo2p DkkqgR3aWJJsYNQ==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

Because bind-mounted subtrees of the volume may resolve to unexpected
locations, change converting junctions and non-relative symbolic links
into paths relative to the NTFS volume to be allowed only if the
native_symlink=rel mount option is specified.

Add the native_symlink=<value> mount option to configure how absolute
symbolic links and mount points (junctions) are handled.
The option accepts "raw" or "rel", with "raw" being the default.

Under "raw", the absolute target path (ni->target) is returned as-is
without translation. Under "rel", ntfs_translate_junction() is called
to rewrite the absolute path as a relative path anchored at the volume
root.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/file.c   | 14 ++++++++------
 fs/ntfs/inode.c  |  4 ++++
 fs/ntfs/super.c  | 19 +++++++++++++++++++
 fs/ntfs/volume.h |  3 +++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index 6b0dfc56577b..6a7b638e523d 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -22,6 +22,7 @@
 #include "ea.h"
 #include "iomap.h"
 #include "bitmap.h"
+#include "volume.h"
 
 #include <linux/filelock.h>
 
@@ -688,12 +689,13 @@ static const char *ntfs_get_link(struct dentry *dentry, struct inode *inode,
 	if (ni->reparse_tag == IO_REPARSE_TAG_MOUNT_POINT ||
 	    (ni->reparse_tag == IO_REPARSE_TAG_SYMLINK &&
 	     !(ni->reparse_flags & cpu_to_le32(SYMLINK_FLAG_RELATIVE)))) {
-		err = ntfs_translate_symlink_path(dentry, ni->target, &target);
-		if (err < 0)
-			return ERR_PTR(err);
-
-		set_delayed_call(done, kfree_link, target);
-		return target;
+		if (NVolNativeSymlinkRel(ni->vol)) {
+			err = ntfs_translate_symlink_path(dentry, ni->target, &target);
+			if (err < 0)
+				return ERR_PTR(err);
+			set_delayed_call(done, kfree_link, target);
+			return target;
+		}
 	}
 
 	return ni->target;
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 07ca799a8f9a..76595f2e30ff 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2378,6 +2378,10 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_puts(sf, ",discard");
 	if (NVolDisableSparse(vol))
 		seq_puts(sf, ",disable_sparse");
+	if (NVolNativeSymlinkRel(vol))
+		seq_puts(sf, ",native_symlink=rel");
+	else
+		seq_puts(sf, ",native_symlink=raw");
 	if (vol->sb->s_flags & SB_POSIXACL)
 		seq_puts(sf, ",acl");
 	return 0;
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index ca882e946a22..e032a247455c 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -43,6 +43,17 @@ static const struct constant_table ntfs_param_enums[] = {
 	{}
 };
 
+enum {
+	NATIVE_SYMLINK_RAW,
+	NATIVE_SYMLINK_REL,
+};
+
+static const struct constant_table ntfs_native_symlink_enums[] = {
+	{ "raw",		NATIVE_SYMLINK_RAW },
+	{ "rel",		NATIVE_SYMLINK_REL },
+	{}
+};
+
 enum {
 	Opt_uid,
 	Opt_gid,
@@ -66,6 +77,7 @@ enum {
 	Opt_acl,
 	Opt_discard,
 	Opt_nocase,
+	Opt_native_symlink,
 };
 
 static const struct fs_parameter_spec ntfs_parameters[] = {
@@ -91,6 +103,7 @@ static const struct fs_parameter_spec ntfs_parameters[] = {
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_flag("sparse",			Opt_sparse),
 	fsparam_flag("nocase",			Opt_nocase),
+	fsparam_enum("native_symlink",		Opt_native_symlink, ntfs_native_symlink_enums),
 	{}
 };
 
@@ -215,6 +228,12 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		else
 			NVolClearDisableSparse(vol);
 		break;
+	case Opt_native_symlink:
+		if (result.uint_32 == NATIVE_SYMLINK_REL)
+			NVolSetNativeSymlinkRel(vol);
+		else
+			NVolClearNativeSymlinkRel(vol);
+		break;
 	case Opt_sparse:
 		break;
 	default:
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index 3348394dbc0d..55298689a7bb 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -177,6 +177,7 @@ struct ntfs_volume {
  *
  * NV_Discard			Issue discard/TRIM commands for freed clusters.
  * NV_DisableSparse		Disable creation of sparse regions.
+ * NV_NativeSymlinkRel		Translate absolute Windows reparse targets (native_symlink=rel).
  */
 enum {
 	NV_Errors,
@@ -194,6 +195,7 @@ enum {
 	NV_CheckWindowsNames,
 	NV_Discard,
 	NV_DisableSparse,
+	NV_NativeSymlinkRel,
 };
 
 /*
@@ -230,6 +232,7 @@ DEFINE_NVOL_BIT_OPS(HideDotFiles)
 DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
 DEFINE_NVOL_BIT_OPS(Discard)
 DEFINE_NVOL_BIT_OPS(DisableSparse)
+DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
 
 static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 nr)
 {

-- 
2.43.0

