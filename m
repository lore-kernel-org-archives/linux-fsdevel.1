Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683923DCDA0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 07:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249667; cv=none; b=B/Xt+e4B9mmS52AYvBn5ofmWHrbKg2JFf7ubcjClRoBItkOLkGvGhjjYJDG+XoQDfpYXy52qp2etqj6WZr3JmnUPKthJlIwqUalFj0J6ydhs3OjtvJmRE5dmzFLWLac3BBm2ldZPFpdp54kcHzXdUz2XrxlQ76AvJzjYPWx1CHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249667; c=relaxed/simple;
	bh=vgq6awuxEdZmXfybb32qWTSBG15PmRfKj3zYlSOnZpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HP2E1kdGe3r7qT487JiLahI92vFZVboyyLp8eRtM+ASKYnCPVQCgsfKw8n4teI9yxc3kEmh7iy7l83Vtgs5r5rons7HQ6b7wHOsJKVDAr7wSpayR3k37EU4G3msgvOenWwmq5q+tk9i9Zq/Gryet70A/uQEbTMLVboLZAhUgb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNGflFKm; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNGflFKm"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8434840cea8so327144b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 00:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781249666; x=1781854466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzodQ7ORdJ7UqrOgj5DfnpeJT+XlLbLEXfdy3nR6brE=;
        b=DNGflFKmBY5FYLHp+FgzKoNwwvWntijXjwEcuFIU+OUZ+XenlucD3PGulIVNY/ojZc
         F19wo/NtYqLhhcPeM4uglFkKn3LxRL3Plf/NU+ZqiBGZI77p+ijeTMYoGXTst92+LoIW
         8/uCkZ1tZFl50xkOqaB4H0wUHxbthSD5qM1LdA3srs4lEuT269j111f/ls+QRdU7AMVI
         fI80d0h0AXuJDs3Kiu2PaQEb9ka1rFTTh3Nn75hx67VKzIYw/k4uBNfFTcAFSzX9CStU
         WnBTO6gR+34VDQh3BO3Yg0gdRivGldewOrdYos3SblNulupvCv46xu0m5ZJF9nsZqkyn
         IwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249666; x=1781854466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzodQ7ORdJ7UqrOgj5DfnpeJT+XlLbLEXfdy3nR6brE=;
        b=WERAclCkh0R/Qt2QHC5n0Uw6mPegfekVUFDXX3cIDXV7p/wzwLpulTftiVkKzMrP7j
         I+H9clSRySgZqlY6MBi+5MS5v/FATWDjKTrBsMcBkfVsCb8rviwZGdpIbxuotWFl+PQi
         AaB2XUJeFYbgB/v+5GWFB70FHZY3e3fXRoSvt3w4fnWRTUcJxy4knhHd5lLnbKTIvlxv
         +DZTT08d1s1Pu9pG7DY4T91Sv2nim+S/5NB+9VEaQ60RjhDIBEgBJ99WGEIH20yubl6i
         ADZ4IJQj8vbrNRhTdTTOZK3uGPbfPD+EZfrAq1WCc+X7oSbP3B4J/OkktR+/rbqGpMVw
         Lh0w==
X-Forwarded-Encrypted: i=1; AFNElJ8AxEFaCT71Ys/LKk6MEH4AdiS2RpYsPD6OimrQ5TvWN8XKeXEIsZF+C8JtPK5HcvqDE0Fs1gwFSsFJeXh5@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3s/DGKsZeyR/mZ3uBxclAPLi5e3PXgudb0EgikvzUh8nIgm3
	q4qtbeZEs2qx3C2CG3xwIGbRcHywoGKqQejKB1gHFt9qAuuyTFJ7DsE2
X-Gm-Gg: Acq92OGI6jmnQ7btEM94VbE4+dYeax6BL20MHs1La+2O5SfE4y5mje+9SMy9STN4SpK
	+V+CZdq17ceH/PnZWrGafDpB9mHvkefXWi/CEMoSjiwRE3LD1rdAuNatZdjGZoW1Uj0S4CZZ9Rz
	ZPmpAFT52Nt8P5NSoDPBS733CNShxwXfMX0vEzEG4eOAvtWRe2S4qpfOfwqUlxX538jetN0+hFS
	eufZu639JneeEeLiTu+2oYCEceadsKD1j6tZWACknBTFNIiVPIrAybvUukwUwNxFjdVTghjpOoU
	hI3o5tZ3mIYZL1SQl2qd3aQNOx+sOYsglSybE0fl4XHFZdSlyLjUh9DKTbIbnDhCnkkFcOll812
	A1MH6/lPv7i6Qc51F9J3gcb5oeej+6k5lPViTHxH1v0Lhw1g/tJe1XqSi+hL5UQ02GX/4xP9I/T
	gJlPcOITbmr0vIzKscM1ExBHaqJnTptg==
X-Received: by 2002:a05:6a00:390d:b0:842:6004:3fd5 with SMTP id d2e1a72fcca58-8434ce40758mr1811603b3a.25.1781249665753;
        Fri, 12 Jun 2026 00:34:25 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05d7d7sm1374014b3a.60.2026.06.12.00.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:34:25 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] ntfs: support creating Windows native symlinks
Date: Fri, 12 Jun 2026 16:33:36 +0900
Message-ID: <20260612-topic-symlink-v1-6-cc1ebf9528e1@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8063; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=vgq6awuxEdZmXfybb32qWTSBG15PmRfKj3zYlSOnZpc=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqK7Xv1PbyD05aaCiWBPyI/Rtp+/PFsL5FkEr/e
 TAw5T0ZwcOJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCaiu17wAKCRA08jD6945I
 0wHsD/97F2pPjGu2JM6Fu7mDWH2P+5Q8dvIqXEZTi9tthDC69vrYWy2dghcKlyemVJlUVXgWc8N
 3wXHwfl4UZlr1gP91e9JM3Zcdr6YQhssIT88mV75e0zMqSyqc2/T/CMv+6lxOCq09YN/aCDfVi7
 rwfiy7YRTPXofRpr9GR9SORTtD8y8ROhXc7gxWS9jLDUCXwtVbbWiPEo2sj+haui+9D095hwp6E
 YwKxlOoupU9iG90SxUr/RJd6Qt50wLj+xYctBZarzpjuPUq3awfuRD9lbphZMGRWKRjRyFJy/9J
 pYA6OD5rcjyTqnhw1ayqsWqtZZ+5xGFdtUKO/EuyA1B/WIO4p8ZApkhLymkn59IVPKkyCv/F6KR
 VZBiL4hqcLXW220PYDxKuJcu9106aefaA6qIJwARtvamp5xDy134G1IRcOHCkWk4mxgi1by34bX
 lGN90HnIa8effVcNbyAxFyKnqqcYBdnTUcC3GgK939Vl3Ye06W1QNiOW25Ty4Wzn6ByPLj1/u6M
 YTARqMf4BoOUbKL7+5fFZJkRQExN53HMOP8Q9y+yHuHn6UcQPcJL2gNdAQrYvQ5MrybSJZ3SyY7
 ffHUM0PbbQTwj2MH6dcIsPIk0tIjjCMZs5kJu7fw9UL78U6WmFpMk8IvJ14QKjb9PYwrQ25KB5O mHH98QOLwdKjiQA==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

And introduce the symlink=<value> mount option to configure how symbolic
links are created. The option accepts "wsl" or "native", with "wsl"
being the default.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/inode.c   |   4 ++
 fs/ntfs/namei.c   |   5 ++-
 fs/ntfs/reparse.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ntfs/reparse.h |   2 +
 fs/ntfs/super.c   |  19 +++++++++
 fs/ntfs/volume.h  |   2 +
 6 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 76595f2e30ff..c2715521e562 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2382,6 +2382,10 @@ int ntfs_show_options(struct seq_file *sf, struct dentry *root)
 		seq_puts(sf, ",native_symlink=rel");
 	else
 		seq_puts(sf, ",native_symlink=raw");
+	if (NVolSymlinkNative(vol))
+		seq_puts(sf, ",symlink=native");
+	else
+		seq_puts(sf, ",symlink=wsl");
 	if (vol->sb->s_flags & SB_POSIXACL)
 		seq_puts(sf, ",acl");
 	return 0;
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index 88c0b05dde3b..78c159519f9c 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -608,7 +608,10 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap *idmap, struct inode *d
 			goto err_out;
 
 		if (S_ISLNK(mode)) {
-			err = ntfs_reparse_set_wsl_symlink(ni, target, target_len);
+			if (NVolSymlinkNative(vol))
+				err = ntfs_reparse_set_native_symlink(ni, target, target_len);
+			else
+				err = ntfs_reparse_set_wsl_symlink(ni, target, target_len);
 			if (!err)
 				rollback_reparse = true;
 		} else if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISSOCK(mode) ||
diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index eb1e4424e50d..f5b2a853bea1 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -786,6 +786,130 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 	return err;
 }
 
+int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
+				    const char *target, int target_len)
+{
+	int err = 0;
+	bool is_absolute;
+	char *norm_name = NULL;
+	char *sub_name = NULL;
+	char *prt_name = NULL;
+	__le16 *sub_name_utf16 = NULL;
+	__le16 *prt_name_utf16 = NULL;
+	int sub_len, prt_len;
+	int total_data_len, total_reparse_len;
+	struct reparse_point *reparse = NULL;
+	struct symlink_reparse_data *data;
+	int i;
+
+	/* Determine if target is absolute (starts with drive letter like C:) */
+	is_absolute = (target_len > 1 && target[1] == ':');
+
+	/* Normalize and prepare NLS paths */
+	norm_name = kstrdup(target, GFP_NOFS);
+	if (!norm_name)
+		return -ENOMEM;
+
+	/* Replace '/' with '\' */
+	for (i = 0; i < target_len; i++) {
+		if (norm_name[i] == '/')
+			norm_name[i] = '\\';
+	}
+
+	if (is_absolute) {
+		prt_name = kstrdup(norm_name, GFP_NOFS);
+		if (!prt_name) {
+			err = -ENOMEM;
+			goto out;
+		}
+		/* Prepend '\??\' to Substitutename */
+		sub_name = kmalloc(target_len + 5, GFP_NOFS);
+		if (!sub_name) {
+			err = -ENOMEM;
+			goto out;
+		}
+		strscpy(sub_name, "\\??\\", target_len + 5);
+		strcat(sub_name, norm_name);
+	} else {
+		/* For relative symlinks (including absolute paths without drive letters),
+		 * SubstituteName and PrintName are identical.
+		 */
+		prt_name = kstrdup(norm_name, GFP_NOFS);
+		sub_name = kstrdup(norm_name, GFP_NOFS);
+		if (!prt_name || !sub_name) {
+			err = -ENOMEM;
+			goto out;
+		}
+	}
+
+	/* Convert NLS paths to UTF-16 */
+	sub_len = ntfs_nlstoucs(ni->vol, sub_name, strlen(sub_name),
+				&sub_name_utf16, PATH_MAX);
+	if (sub_len < 0) {
+		err = sub_len;
+		goto out;
+	}
+
+	prt_len = ntfs_nlstoucs(ni->vol, prt_name, strlen(prt_name),
+				&prt_name_utf16, PATH_MAX);
+	if (prt_len < 0) {
+		err = prt_len;
+		goto out;
+	}
+
+	/* Check for buffer size limits */
+	total_data_len = sizeof(struct symlink_reparse_data) +
+		(sub_len + prt_len) * sizeof(__le16);
+	if (total_data_len > 16384) { /* 16KB max reparse tag size */
+		err = -EFBIG;
+		goto out;
+	}
+
+	total_reparse_len = sizeof(struct reparse_point) + total_data_len;
+	reparse = kvzalloc(total_reparse_len, GFP_NOFS);
+	if (!reparse) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Pack fields in reparse buffer */
+	reparse->reparse_tag = IO_REPARSE_TAG_SYMLINK;
+	reparse->reparse_data_length = cpu_to_le16(total_data_len);
+	reparse->reserved = 0;
+
+	data = (struct symlink_reparse_data *)reparse->reparse_data;
+	data->substitute_name_offset = 0;
+	data->substitute_name_length = cpu_to_le16(sub_len * sizeof(__le16));
+	data->print_name_offset = data->substitute_name_length;
+	data->print_name_length = cpu_to_le16(prt_len * sizeof(__le16));
+	data->flags = cpu_to_le32(is_absolute ? 0 : SYMLINK_FLAG_RELATIVE);
+
+	/* Copy names to path_buffer */
+	memcpy(data->path_buffer, sub_name_utf16, sub_len * sizeof(__le16));
+	memcpy(data->path_buffer + sub_len, prt_name_utf16, prt_len * sizeof(__le16));
+
+	err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse, total_reparse_len);
+	if (!err) {
+		for (i = 0; i < target_len; i++) {
+			if (norm_name[i] == '\\')
+				norm_name[i] = '/';
+		}
+		ni->target = norm_name;
+		norm_name = NULL;
+	}
+
+out:
+	kfree(norm_name);
+	kfree(sub_name);
+	kfree(prt_name);
+	if (sub_name_utf16)
+		kvfree(sub_name_utf16);
+	if (prt_name_utf16)
+		kvfree(prt_name_utf16);
+	kvfree(reparse);
+	return err;
+}
+
 /*
  * Set reparse data for a WSL special file other than a symlink
  * (socket, fifo, character or block device)
diff --git a/fs/ntfs/reparse.h b/fs/ntfs/reparse.h
index e36557f29677..c11a5bb7e6a5 100644
--- a/fs/ntfs/reparse.h
+++ b/fs/ntfs/reparse.h
@@ -15,6 +15,8 @@ int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
 				char **translated);
 int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 				 const char *target, int target_len);
+int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
+				    const char *symname, int symlen);
 int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode);
 int ntfs_delete_reparse_index(struct ntfs_inode *ni);
 int ntfs_remove_ntfs_reparse_data(struct ntfs_inode *ni);
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index e032a247455c..8abe7bee4c0d 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -54,6 +54,17 @@ static const struct constant_table ntfs_native_symlink_enums[] = {
 	{}
 };
 
+enum {
+	SYMLINK_WSL,
+	SYMLINK_NATIVE,
+};
+
+static const struct constant_table ntfs_symlink_enums[] = {
+	{ "wsl",		SYMLINK_WSL },
+	{ "native",		SYMLINK_NATIVE },
+	{}
+};
+
 enum {
 	Opt_uid,
 	Opt_gid,
@@ -78,6 +89,7 @@ enum {
 	Opt_discard,
 	Opt_nocase,
 	Opt_native_symlink,
+	Opt_symlink,
 };
 
 static const struct fs_parameter_spec ntfs_parameters[] = {
@@ -104,6 +116,7 @@ static const struct fs_parameter_spec ntfs_parameters[] = {
 	fsparam_flag("sparse",			Opt_sparse),
 	fsparam_flag("nocase",			Opt_nocase),
 	fsparam_enum("native_symlink",		Opt_native_symlink, ntfs_native_symlink_enums),
+	fsparam_enum("symlink",			Opt_symlink, ntfs_symlink_enums),
 	{}
 };
 
@@ -234,6 +247,12 @@ static int ntfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		else
 			NVolClearNativeSymlinkRel(vol);
 		break;
+	case Opt_symlink:
+		if (result.uint_32 == SYMLINK_NATIVE)
+			NVolSetSymlinkNative(vol);
+		else
+			NVolClearSymlinkNative(vol);
+		break;
 	case Opt_sparse:
 		break;
 	default:
diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
index 55298689a7bb..65fd3908af26 100644
--- a/fs/ntfs/volume.h
+++ b/fs/ntfs/volume.h
@@ -196,6 +196,7 @@ enum {
 	NV_Discard,
 	NV_DisableSparse,
 	NV_NativeSymlinkRel,
+	NV_SymlinkNative,
 };
 
 /*
@@ -233,6 +234,7 @@ DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
 DEFINE_NVOL_BIT_OPS(Discard)
 DEFINE_NVOL_BIT_OPS(DisableSparse)
 DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
+DEFINE_NVOL_BIT_OPS(SymlinkNative)
 
 static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 nr)
 {

-- 
2.43.0

