Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB383DD866
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249661; cv=none; b=NT8mY4JkGEbv81UntZBlFrxYFEcrRjHc3JdwJ7hsRbrbSvCsMgVb1MaIKu2jQmNdHe1XjGT9Yw6lDrOH3Mt+tzjI1rdrxL2oQcFIR9Zg5NJA8VHBn5xCLms1s5/fer8PWCpaqBBUpRTw4YO358c/95v2ULa5IhjcUYu1U+SMKd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249661; c=relaxed/simple;
	bh=mt+JmKw3sU5g8dP87l80+wAa37YGSjw/oUi59DYrpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjc6UGH0tqif5Xt8UvF/BIbAHy9C7f89UbrJKN9cG3RnZVicNn4frXUewi5ORw8AEIplYrkn61wsMjtTdISzzKr/B/giIktBzZTy3KWrtXnxyc68DobX7yO7DDkz4plaVpSZmjV2O2PTYFzuyBqHpsEyF9SUsh9SvosEa83m45k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ7/Ueig; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ7/Ueig"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842358aaf36so301726b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249658; x=1781854458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05bT4hFs2JyxZMQsak70tJ/pABYR3hkaKhUdW0lLXv0=;
        b=MZ7/UeigfwvO//6WvchKTf7/4O28WOYGTQ51eW+07Uz4RIOW9Z5hPXxuug4JohzOvl
         vSxpdekNO5j/ePEDBj8E7fynIuveUfsICCusom4HgHWkIOBXMZ0RO+97EpdM+mRPpD8z
         1NV6CRQuuq4fb0nmVEd3/YJtnxmyzrcy+A+glHHGUg1ukd2kMMD2Yd3wmUFjUz9jqFiG
         /TBYEdLSAKsY/moW8vBo4ma4k/74MPhMn3EevUQRpED2/y3aDZTKoNZJNBv3ujrHCTeF
         KyP0wlpJ5bpzw2D2DSmdpNrkt/wLt53+BoDdpT2B3p85v5gposK8y/3U2hzXEMMgNUeO
         MG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249658; x=1781854458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=05bT4hFs2JyxZMQsak70tJ/pABYR3hkaKhUdW0lLXv0=;
        b=iwiAzm85Oligq+FKtiW8JsqhZYuHIv9It7PjjeTy5GDsRIwjV5yZj6RBSpYcRp1lkF
         +jV6z/yv8Z4mvZeYzs6kaE9Iovybxyh1Hj+E651392K+WFqa/UOehX9U4JWiitqomGTg
         PZX33VFySRnceFi5tWLJipOE3WWcJxD5g7zEXl+g1BLiMmVSaHNP5CDD0XD2NijZNsCm
         T33/mvjnWIIAuFjn1ADFRYr8BsduWNC3TL1QfC6GGG2X6Fv/UcdKYCAbMOMa5GvAxGps
         ZffTaBn9BHMpfgb8DaYeC4Aaab2B9cpGWWn8DGaWysjmLox4cFEmfZwTiVIqeCZWxmKj
         EFRA==
X-Forwarded-Encrypted: i=1; AFNElJ9rsplfHpG5+TOmIl59W5ZEfOscnV86ItLPGSwtU4ksh4IZd0VsOh3I9WLY7oWaOvua608SFL+cYq4kcg/9@vger.kernel.org
X-Gm-Message-State: AOJu0YylSM2iKxhDdCQn6wznu8iSe4MG5BKWzxNA1MDgF+LSKMvbxi8L
	yQYwgrnXHcVzs5yjb9+izP3Io/8+/cZqzn0hoaWW+O8N6rvRiLlVMz6t
X-Gm-Gg: Acq92OGnX2mDCorbtepLTvqE6F+Wlh0ZG+mgQRgQYIpoCZd8aOp7kb+bcWnIrM4Hd8T
	RhUKX2ACqq2H2c26xG9XrseEJuJcK6bCo4haIE1nNmwARLkS4b7Pz/JJj//DjyLLnwQyPtwVFZp
	Z3Yy2H0oIllnJKy0VkOquR8lAVIAblBDrq4Qr3i7LS4yA6Na1uHFtRwENJZxVgd4AcYefhW53jr
	fEdb/d6UEj0As/mM6ryFulVNK3v800sohqJQSlXWq/46aLCwyWVbnoG8+BS7C4RcQv9JY+Sy2IO
	49gZOrVv6a0KCSKbWf1iW62dBMyt6Lom6JNMpYsGeYAoIqs+rIZE9WoER/T39EM4WHju+gtOQN2
	v0L47FFehrVoety710u7rmYPoMzU0N/tVa0cefEwZCG62yV8z0ZI1jaILeF+pn7G8HjK6Agasos
	Ann16j1nJjFj1manMD/IMC+2XxQIxlJg==
X-Received: by 2002:a05:6a00:2351:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-8434ce5eaf1mr1917706b3a.41.1781249658470;
        Fri, 12 Jun 2026 00:34:18 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:17 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ntfs: add native_symlink mount option
Date: Fri, 12 Jun 2026 16:33:34 +0900
Message-ID: <20260612-topic-symlink-v1-4-cc1ebf9528e1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com>
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
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7Xv2sFPhw7lw2GRyG68xeoix1lc1D2ebo0zu
 Ifns+3Fl1qJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17wAKCRA08jD6945I
 0xIUD/42zol6hlk+KavHduTynLmfpP3SpKjQ6KLK4nHbJXzvFsFVJP39OFYJrERZoEUf503vGZU
 Hzki1j6dTj5j05GV84Blljo8qBTsH1zCnAJSR6LXX4Au8qRLtgd2kGRKeZCM6RM7Kv63ZhuRYic
 y9hTVLEEgMIBu4WcQRnHIH63PQ5PeH+r3qPWC47IPaHETIs0W890N1amGzhpdyH2/RuSnMIamlF
 tZZPJop13rPRnrv9y2yQFHLelw/lWLOnPSRoOgiqZqLeWK6SzQYlO1zEUVvPyxgnl/QAHhJoJhq
 8j65KBCTBGzU5Awp76rUgq2zjCFTwU5HifQ/hC8i9rW1F+95AsK9/gQdlytEN0BbIG2NiB3dRGn
 dslKHJe2gtl6vC//PeVg/dv1sG/3y//ab0f3GDnse6B8wEFZFoBTMF9KaaBRnDnCyDYPlQPF4ya
 SDxQEG0itR3NrOcoZGo0WjZpEYX0++GTgKNXKxggXZmwI8CitKLkXgtWDGw7PWGw6zQILDYBlKL
 ORfNyjrwGmM4P+Xi2/XSFg8v6AH/izEXZsgLeSZG72sR8aCz7wu5k1igPHOqF5Cdx6wHjJ9Fyyx
 60ze+9KRzoHOpRVsIFejR1mR346XiikcxSsLGzE/4E/23dU769l4yV02aRaTD/urK7klXsdE58/ rMhUZLiPQVIMpFg==
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

