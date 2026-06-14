Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4270537F735
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481078; cv=none; b=hABvoX6LqDan34KKxSOdGHtHTMZ/FUXtXY8QN4MnKdxjtBurXNoTc9f43cXZQiJ0aPVgSMXZhdyVefjnGeFl13pMZ00NT5uAVdewuTR0qscsDGIXNZqqHbhBqenGaB7D/B1QijdiLwXcfXGGi40q/QYPPIjVmd4wkj4O505/f8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481078; c=relaxed/simple;
	bh=74whO/Vk9KAflRQ3mQ/c6sGBsSJ8L8dxWLlz7sTvKD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6NzwoNFT2C5p1kZG8zWokKO1XEYSkDaePT3r9uFe0j/x1cxoPNUS7JEDZwiLwndChU1a1y5UMwu0XFyJOH53tYioRItEG/SO9KuuTROyYbSpILpgIeWOvL7+xasBJNUOLg+JpXyQiBQJrlNNIaY7ClHdJbfwOV8Sl0iLRyEm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnCH7hUl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnCH7hUl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf1cda2b17so19203955ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481077; x=1782085877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7i/jKfcshdbG8JPMhx0G4Fj/kOYYeFwqk27ZGFUGYQ=;
        b=HnCH7hUl+GYHj1vjR1NBAw0zu9qYk1H6avdBTHaN0RHj+CDvGG2awnua0p5Hw6p9bg
         czhgQtKVfaUXL853JaqV9qhhu9rDL0WArsEocw+1tufMNWF3UZbaSvT4PW/TZr3tTRqY
         GNAJGIUZX785tfjfEZsrD1SJajv9TQOVzRraup8I66btkxVYSZBuPFXdljnScDpG12b0
         hzTInpptcalUrgEmf2P/+HWL4fNeIuqIayRtmuf7Lq+f0fOvzMxsf40OQmzqdYyUpQyy
         3HhmODD154v9XnFgCtZj3lZLo9B36Z3F9xN3vrJbaOJH2g7ewhGLHYxo8Pxv771dBsYS
         KKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481077; x=1782085877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n7i/jKfcshdbG8JPMhx0G4Fj/kOYYeFwqk27ZGFUGYQ=;
        b=npF6i9ty5/DZeg7yy6Kb9JIAiQ5N5JWeSJK25Wjcv01AlX3e0hLq9slxNsnQ7xizhk
         SQKmyc69BYZvOj02zIHA7CDIGdYDJjOrm3NZPemOpkgddHYB3Jwb0R1Li9j4x/a5W8ba
         X+Akj1tcHysrv2p+0z6nTo3qZApiJnT/c6l0BAor4RqNtQnIV/XvHm1OyoNimOlC2PKF
         81vyU9Y9IW/SlEZq8XMMjiXHErmJ7WGfFgWB6eb835yRqeDdYTBQVqplH3eCGJADhoEN
         TA7mqA+cohGGIe7V6VnqqeW91kNYXrDMazRFh9HSsjNdRsPjm1XFXKwbxX4C9XYHLkQY
         +PCw==
X-Forwarded-Encrypted: i=1; AFNElJ/pN5VnnmTfpofmq3G+GqubDK71nZoRsOIil56w8M4y2OEC77uS5EKmyO4yQnW3QqDOV88oBqUznOk8lDkK@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmpSA/JJdBYS4/vix97/XBWD0nH+aGAXrgtKrVqmQVlsbAHnl
	nKfCwqPoCmPxHeg3ZS5T9pCAUeAJ0FiHu/xY3yRKO0Bz7SoV/aUTvjFasW8FZg==
X-Gm-Gg: Acq92OFrzHImncoaKUav11QJ8bRbRmL1qN6yWFA6og125IzWg81uYv4EMnYLEQWUplv
	rSTdkyDw8wOU4x/dA/FjxzlVg1GKJ9rFKE/AccXO89Oj6xPu+xkUvYLFFjnr44LYf3SEHzqb76G
	dXERUaXG8qGSX6cKXcx/gl/o548HC8Oi12oELuJHSerS8PNruf9a9UNQ7Gtyv3APvXXscq5mTSB
	P0x9S2VS8xBqQU4qpJlLOjd36aEUd91AfGke4kRnB4adbcveR57NAxC9BlM5TIR+PeffXg0QoQD
	klZLZyMDPw7thiUNvJ3kfwJH4tLijbEsQaaMZmf67PRjsWUG7wXkSM4ggb7MMB+Qze4ms+MB8+N
	RDkZ7hsv/a+9/0ymFN0M6lG1rrqdXQq+0d3Kna4tdCM6mwXY7MKPdq1K8rFPgJHC1gJnQniEXIX
	oVP3IcAs6qioEtuwRkYejZrWMbhKDAPw==
X-Received: by 2002:a17:902:f645:b0:2bd:d6f1:3388 with SMTP id d9443c01a7336-2c3fd9ec190mr100785695ad.28.1781481076610;
        Sun, 14 Jun 2026 16:51:16 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:51:15 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] ntfs: support creating Windows native symlinks
Date: Mon, 15 Jun 2026 08:49:57 +0900
Message-ID: <20260615-topic-symlink-v2-6-648a769d01f8@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8804; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=74whO/Vk9KAflRQ3mQ/c6sGBsSJ8L8dxWLlz7sTvKD0=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3Q9au554ua2oQ0bPI1jbyUGKIw3GbxhA0B9
 lY2DWRh+aWJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai890AAKCRA08jD6945I
 09n/EACEaFHbz1JSVNSJ8IvpgbSVKWzJ8r2S9eQdu2F9JUjAzDlFb1jH7Kx6qoqur32wm3r3lrT
 B+9OeFRJEb6Bsx880LxAlhB1YBoTJJNJA9J6q4EmFENlp34tvusSuiHLdtMsaVpg85HamFHva4N
 krxAuEpVqEXRft9QH4yD89llKbiXA0F4HYC8FQPsJp1hhqbHbKgpQNidKQuRo7d2Mh4SAxA6m8W
 Ol42J0Kij7RIf47dUjgbIWwpi/TfRV3/FgNdMZgL5yvws4xOl83jIm4ZzWG0PuwJCqFkXXHXe45
 x+hcI/AJVXoOW6PLPppZWbMEbBbbGTIKUu3phmbeSSV2pEXsHhLaUpAMOTWYhDiS6HPMQMqlpM3
 +VBF9kKbYnOHwHAlg9oLTqZwJ+L30cOp90f+0sz9xBykIaqWk+7iIG3skHi6Jej8a2EOQbIASpv
 rXPvJtR+mOJiBIiLOlKay+RVIfAZ2Et48sLYq5vyusZtUkvtfQ3snPm7Y5eg9CYvQNBZ5J4+RIQ
 Zq6XTLMa+++b0idHLqAuMjtKHQrxd5SD3M1m+Qlq1A087bPXg1FAB6f0xHlWTuW8RZ3DBRHpgeL
 NLyj9Y1vOi70T50Ik/8dbQGwtL0FcQHImfpBu6pUh4lKI0uXQMO7JHaCBe6fRExpiV8Nsp2hCtk dvWl0K/oo9o25tw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

And introduce the symlink=<value> mount option to configure how symbolic
links are created. The option accepts "wsl" or "native", with "wsl"
being the default.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/inode.c   |   4 ++
 fs/ntfs/namei.c   |   5 ++-
 fs/ntfs/reparse.c | 131 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/ntfs/reparse.h |   2 +
 fs/ntfs/super.c   |  19 ++++++++
 fs/ntfs/volume.h  |   2 +
 6 files changed, 160 insertions(+), 3 deletions(-)

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
index 91ae0c75e275..fa523dc3691e 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -365,6 +365,13 @@ unsigned int ntfs_reparse_tag_dt_types(struct ntfs_volume *vol, unsigned long mr
 	return dt_type;
 }
 
+static bool ntfs_is_drive_letter(const char *target)
+{
+	return ((target[0] >= 'A' && target[0] <= 'Z') ||
+		(target[0] >= 'a' && target[0] <= 'z')) &&
+		target[1] == ':';
+}
+
 /*
  * ntfs_translate_symlink_path
  *
@@ -410,8 +417,7 @@ int ntfs_translate_symlink_path(struct dentry *dentry, const char *target,
 		path += 4;
 
 	/* target must start with a drive character or '/'. */
-	if (((path[0] >= 'A' && path[0] <= 'Z') ||
-	     (path[0] >= 'a' && path[0] <= 'z')) && path[1] == ':') {
+	if (ntfs_is_drive_letter(path)) {
 		if (path[2] && path[2] != '/')
 			return -EOPNOTSUPP;
 		tail = path + 2;
@@ -792,6 +798,127 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 	return err;
 }
 
+int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
+				    const char *target, int target_len)
+{
+	int err = 0;
+	bool is_absolute, prt_sub_shared = true;
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
+	/* Determine if target is absolute (starts with drive letter like C:/ or C:\) */
+	is_absolute = target_len > 2 &&
+		ntfs_is_drive_letter(target) &&
+		(target[2] == '/' || target[2] == '\\');
+
+
+	/* Normalize and prepare NLS paths */
+	prt_name = kstrdup(target, GFP_NOFS);
+	if (!prt_name)
+		return -ENOMEM;
+
+	/* Replace '/' with '\' */
+	for (i = 0; i < target_len; i++) {
+		if (prt_name[i] == '/')
+			prt_name[i] = '\\';
+	}
+
+	if (is_absolute) {
+		/* Prepend '\??\' to Substitutename */
+		sub_name = kmalloc(target_len + 5, GFP_NOFS);
+		if (!sub_name) {
+			err = -ENOMEM;
+			goto out;
+		}
+		snprintf(sub_name, target_len + 5, "\\??\\%s", prt_name);
+		prt_sub_shared = false;
+	} else {
+		/* For relative symlinks (including absolute paths without drive letters),
+		 * SubstituteName and PrintName are identical.
+		 */
+		sub_name = prt_name;
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
+	data->flags = is_absolute ? 0 : cpu_to_le32(SYMLINK_FLAG_RELATIVE);
+
+	/* Copy names to path_buffer */
+	memcpy(data->path_buffer, sub_name_utf16, sub_len * sizeof(__le16));
+	memcpy(data->path_buffer + sub_len, prt_name_utf16, prt_len * sizeof(__le16));
+
+	err = ntfs_set_ntfs_reparse_data(ni, (char *)reparse, total_reparse_len);
+	if (!err) {
+		int len = strlen(sub_name);
+
+		for (i = 0; i < len; i++) {
+			if (sub_name[i] == '\\')
+				sub_name[i] = '/';
+		}
+		ni->target = sub_name;
+		sub_name = NULL;
+		if (prt_sub_shared)
+			prt_name = NULL;
+		ni->reparse_tag = IO_REPARSE_TAG_SYMLINK;
+		ni->reparse_flags = is_absolute ? 0 :
+			cpu_to_le32(SYMLINK_FLAG_RELATIVE);
+	}
+
+out:
+	kfree(prt_name);
+	if (!prt_sub_shared)
+		kfree(sub_name);
+	kvfree(sub_name_utf16);
+	kvfree(prt_name_utf16);
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

