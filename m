Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268039;
	b=mIhGh6P+sNpx1jyBIkk97fMIzbEATuna2hreVPEBUqLhLnSSnZsyc/yfBiaYR/7QLZf1
	 PLPvyPKJHcSg1hd1O6yxZQOjLE73qVvn4FKiZgi88bdUWBviG6M5HKDE7NNqV2hXBIkB9
	 ADh6ZURCymJBhI5tVWgUO+xjChNdF1YMlsnpwb6eqFKv9hO50+2D6yS4k5yMQTUueZnLf
	 vA8PnvzRWVYeKfcBJPRE9OL79t27dbLr8SiPNtExXqOQsu4w4GysnfQQOKIAY9seRxjOf
	 7E1zKQML6KcKoOk8Xw2giWgAiMfmeTIaUCt17ogqMrXTwTI0gdqdZrSouPuT4SVRwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XMaH2oBg8xRNuNzotRLSEHexFQVSeOij6oPIzS2W/RE=;
	b=HVRhS7lIE0zb07se6yGCLHc67H6hc/5HZeINGAOx+/YupNo8HT0L9ZixxsuiBsJmlyXx
	 1lg+eYktvGg+4/caNDdADMcTmQXYZqjPrCddmKLa4JSUX/jJjWJY9T7zOM9PMGd9Yh6bl
	 tB+2LE9VOMDMMp85IO5E9edNGnIKuVq9gibtmAKd/zipWZdYLbXJ/DLgPEx198uvhINGy
	 n0RByeQPYGWH8dY4Ptbns/XfCvPqFGRKhnJv9sC4PwFTfvjRl1v+3sAidKQs9rUa/35Q4
	 THR2F0lzseNt7vEtaxvYuxNy0b6sgAZn+anOoBIJn4aBRUosdPN6Z1ou+3lSl/xEYAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HaisK15W;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93F60A263A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B93F60A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HaisK15W
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1696699f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268038; x=1793872838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMaH2oBg8xRNuNzotRLSEHexFQVSeOij6oPIzS2W/RE=;
        b=HaisK15WjgoI0pBk6v1af6oP4NQXDtPwWqhH5hqU8IaectijJhTBrh6rNJ2f3Y+ly5
         U3q/TR+vSJwZJN69Wihxzi+jLczmqRNfYEVpZoBDmksYMYEWV3wVc2E4JV8sfwdsZVyw
         VAuQaeZoS8pDoxJ5i5w+l2DgPVJ3Wl+4HTJeL/MrxoDQM3mEFwZEvxFeTBg9pyTQFmr3
         tFHNgY8wLTXqK5XuLj3ZauOc12iT5shZXtRlw2YLsQariwk0a6jbSQRbkJIqTAMytsS5
         Nj0OWxUGJapbgzXEW0GhuBTMwTTRS/qjW47i9oKVE2Td7G8cGXGM1+OK92NfVqO4WJ0N
         dzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268038; x=1793872838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XMaH2oBg8xRNuNzotRLSEHexFQVSeOij6oPIzS2W/RE=;
        b=UzrbrJRck4Dbet941BRlwJksUz7/JcnaGPaZkLM3HUJLr8clh8Euw/hPBphk2BEeKr
         cIQ3m/47yMllXv3AhKlQokJasfx5sB9VTOvRxSPgBkwjXizsTdxeU/SmidnQEjCVB+3y
         uef0BkYin2UOxzUPOkFp3kgjHymK+qtKYICHBbWjSjHnnrKMDq2u8A8sjlRPlnKZDep9
         v89hmFYK7547QBzLo7m50Csf9vf6NzEShqgkyYJ2lxOq5lnasV1KIkx7DOxEan+5z3i1
         o5skKxCXitn/+//F/+qlbgwhd1yBwQoVsVgVt6xZGZSl9GHKMljdjc53zffAW+qKL+9f
         DINQ==
X-Forwarded-Encrypted: i=1; AKwUvBxQk21FDLPmrHxszXa7h0EO9RjKTsE2g49ojTMccmF3ZTrHlyTln8fugIJ04Twhxbqp0VqM2kPz8QAQy3Qr@vger.kernel.org
X-Gm-Message-State: AFq9FYISSKq2w4N5v7HD/VOLOLg+UAfgP89pKWn60OuoSmPODE0wDU9G
	TGVC71LBlFkT0cFrfNtxNrVqe/OCKoP+kNIK5BiBJCZ1B8OKT7p11Hdm
X-Gm-Gg: AYBFou1ja6MDYJCk6rmhVkzGvurz3HhEHzaSfecmijEgTyRwUOBZIUWMSHyf6Kkqe/9
	YvBKZKcI2dYsvln5RYXcgsVl/K9uwVDZYW+qY7vXsFL+hWtZEsHgTwM+tuEZFaGNR6M6JXFjP5/
	H4a/0txc5t6/WtRfeB68716gEaPezYImd+kggkxGHRK/NLhRZWYTBWJwovdvWijLGH+N3rJAPxE
	jAfpeuwrOGSjbMuUWVOIKa/tgZf+133tNDOXwkgw7XaB7jFDOXpG1nVifbiT5faG8yCB25xx39j
	KUmRxNxCLWIZljl1gy4soO7Scf4BpJNkdqKhFrhkesjeO/gxH3RlXKNJPqhz4aP0TxhMZa6C+Q2
	aIu/LghA9Lm+vUkAkKOiNNKJSRVMjA8NUZHP+qOoeuJSv6u5zDanbmCW1fEjAG4I3Db+3qmFhtc
	7mMtOZ6pSS7VahN/7Z1lhFOxTnTPpKO4nxKngjYDRKywAy6iSRiBBAUL9zabhvKdOF2uG5fKYoB
	/P7o7SWXQCXmYpSQ/So4ntKV1jI2RBlgj+nhtDEdQ2SMxmIA3te6/CyT1af138KFkkuIkzk+eVK
	i0wP4KjmxRgRfeDYtUzxL+umOXiK
X-Received: by 2002:adf:e009:0:20b0:48e:5550:c64c with SMTP id ffacd0b85a97d-48e5d44e556mr8749691f8f.14.1793268037412;
        Thu, 29 Oct 2026 03:00:37 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34025569f8f.9.2026.10.29.03.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:00:36 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 1/3] bpf: Add bpf_path_getattr()
Date: Thu, 29 Oct 2026 11:59:50 +0200
Message-ID: <20261029095952.44833-2-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
References: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Direct inode reads can differ from statx(), especially on overlayfs.

Add a sleepable LSM kfunc to query a trusted path and return a compact
result with statx semantics. Use vfs_getattr_nosec() to avoid calling
security_inode_getattr() again, and validate the request and output buffer.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 108 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 35ccd98a4de6..95d7b0de2453 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -1,23 +1,127 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Google LLC. */
 
+#include <linux/align.h>
 #include <linux/binfmt_misc.h>
 #include <linux/bpf.h>
 #include <linux/bpf_lsm.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/cred.h>
 #include <linux/dcache.h>
 #include <linux/fs.h>
 #include <linux/fsnotify.h>
 #include <linux/file.h>
+#include <linux/kdev_t.h>
 #include <linux/kernfs.h>
 #include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/net.h>
 #include <linux/xattr.h>
 
+#include "internal.h"
+#include "mount.h"
+
+/**
+ * struct bpf_file_stat - attributes returned by bpf_path_getattr()
+ * @ino: inode number
+ * @dev: device number in huge_encode_dev() format
+ * @mnt_id: legacy mount ID, or unique ID if STATX_MNT_ID_UNIQUE is requested
+ * @size: file size in bytes
+ * @attributes: STATX_ATTR_* flags
+ * @attributes_mask: supported bits in @attributes
+ * @mode: file type and permissions
+ * @uid: owner UID in the current task's user namespace
+ * @gid: owner GID in the current task's user namespace
+ * @result_mask: available STATX_* fields represented in this structure
+ *
+ * Ownership includes mount idmapping. Unmapped IDs use the overflow UID or GID.
+ */
+struct bpf_file_stat {
+	u64 ino;
+	u64 dev;
+	u64 mnt_id;
+	u64 size;
+	u64 attributes;
+	u64 attributes_mask;
+	u32 mode;
+	u32 uid;
+	u32 gid;
+	u32 result_mask;
+};
+
+#define BPF_FILE_STAT_FIELDS (STATX_TYPE | STATX_MODE | STATX_UID | STATX_GID | \
+			      STATX_INO | STATX_SIZE | STATX_MNT_ID | \
+			      STATX_MNT_ID_UNIQUE)
+
 __bpf_kfunc_start_defs();
 
+/**
+ * bpf_path_getattr - query attributes of a trusted path
+ * @path: resolved, trusted path
+ * @request_mask: bits from STATX_BASIC_STATS, STATX_MNT_ID and STATX_MNT_ID_UNIQUE
+ * @query_flags: AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC or AT_STATX_DONT_SYNC
+ * @out__uninit: naturally aligned result buffer
+ * @out__sz: must equal sizeof(struct bpf_file_stat)
+ *
+ * Only sleepable LSM programs may call this kfunc. The caller must not hold
+ * locks that conflict with the filesystem's getattr operation.
+ *
+ * Uses vfs_getattr_nosec() to avoid a direct security_inode_getattr() call.
+ * Results follow statx(2), including mount IDs and STATX_ATTR_MOUNT_ROOT.
+ * The mount ID is legacy unless STATX_MNT_ID_UNIQUE is requested. Fields not
+ * requested may also be returned.
+ *
+ * Return: Zero on success or a negative error code. Unsupported mask bits,
+ * query flags, size or alignment return -EINVAL. With a valid size, the output
+ * is initialized on every return; an invalid size leaves it untouched.
+ */
+__bpf_kfunc int bpf_path_getattr(const struct path *path, u32 request_mask,
+				 u32 query_flags, struct bpf_file_stat *out__uninit,
+				 u32 out__sz)
+{
+	struct bpf_file_stat *out = out__uninit;
+	struct kstat stat;
+	int ret;
+
+	if (out__sz != sizeof(*out))
+		return -EINVAL;
+	memset(out, 0, sizeof(*out));
+
+	if (!IS_ALIGNED((unsigned long)out, __alignof__(*out)))
+		return -EINVAL;
+
+	if (request_mask & ~(STATX_BASIC_STATS | STATX_MNT_ID | STATX_MNT_ID_UNIQUE))
+		return -EINVAL;
+	if (query_flags & ~AT_STATX_SYNC_TYPE ||
+	    (query_flags & AT_STATX_SYNC_TYPE) == AT_STATX_SYNC_TYPE)
+		return -EINVAL;
+
+	ret = vfs_getattr_nosec(path, &stat, request_mask, query_flags);
+	if (ret)
+		return ret;
+
+	out->ino = stat.ino;
+	out->dev = huge_encode_dev(stat.dev);
+	if (request_mask & STATX_MNT_ID_UNIQUE) {
+		out->mnt_id = real_mount(path->mnt)->mnt_id_unique;
+		stat.result_mask |= STATX_MNT_ID_UNIQUE;
+	} else {
+		out->mnt_id = real_mount(path->mnt)->mnt_id;
+		stat.result_mask |= STATX_MNT_ID;
+	}
+	out->size = stat.size;
+	out->attributes = stat.attributes & ~STATX_ATTR_CHANGE_MONOTONIC;
+	if (path_mounted(path))
+		out->attributes |= STATX_ATTR_MOUNT_ROOT;
+	out->attributes_mask = stat.attributes_mask | STATX_ATTR_MOUNT_ROOT;
+	out->mode = stat.mode;
+	out->uid = from_kuid_munged(current_user_ns(), stat.uid);
+	out->gid = from_kgid_munged(current_user_ns(), stat.gid);
+	out->result_mask = stat.result_mask & BPF_FILE_STAT_FIELDS;
+	return 0;
+}
+
 /**
  * bpf_get_task_exe_file - get a reference on the exe_file struct file member of
  *                         the mm_struct that is nested within the supplied
@@ -504,6 +608,7 @@ BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_task_exe_file, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_path_d_path)
+BTF_ID_FLAGS(func, bpf_path_getattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
@@ -515,8 +620,9 @@ BTF_ID_FLAGS(func, bpf_sock_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
-/* Side-effecting kfuncs that stay exclusive to LSM programs. */
+/* Kfuncs that stay exclusive to LSM programs. */
 BTF_SET_START(bpf_fs_kfunc_lsm_only_ids)
+BTF_ID(func, bpf_path_getattr)
 BTF_ID(func, bpf_set_dentry_xattr)
 BTF_ID(func, bpf_remove_dentry_xattr)
 BTF_SET_END(bpf_fs_kfunc_lsm_only_ids)
-- 
2.56.0

