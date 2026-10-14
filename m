Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437A30ACEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 00:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791938271; cv=none; b=FPabUfbpmB7KhF7RMa3DVXiOGYcfc+im1D3BvjIiYJImuZAZHcoRwXNEvRrwqrGd+XnAjF9+XlIz82FZD45M4XyuJiXVI2mzQk1wO3zVTvdskf/OQi7ulNUBavlYmsXR3YcluMEHLuIMrKC8HG6/bmEjkKGjSUFbHxfAKziHzNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791938271; c=relaxed/simple;
	bh=IF6xi800bQg70p/YOaEzX7lIbgZssVLNkfMtxS1VX2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEfWeJI3/eToU8PDMpaZYNZX9+8yq/3Zh4jxt/NryiWs2q1YoYVmjPuPRpcDDhrTuQ6ra5OcNG+VbVSRTRj2o7ALisRTM2L9LO6wqy09U9O043d/rPYwve/GA+Nw+B4DqAHWV24ZYHU4nTQzADI/lfakAkSOB23Ct4ju8HRHQjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=eqTOqz3v; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="eqTOqz3v"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-677d35fd1d2so3511134d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791938269; x=1792543069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fonBvjZO/D/GM9L+MsZkX1d2b3mKIY2/WZMtCJsJfEU=;
        b=eqTOqz3v3wmsRc2AM4HP/6q6yoBRp5WHvDut1mkdciOHuAtpLhC+k74m6YAewP3K4A
         +GPpSRZ4XNR+8mzN0boZApGgCzsiHWX0L2qa7hjVOBIv10AsXgmWPVojiT0SnLbU9qwQ
         808ZUjO9sT2XLAnCxlGEqoZP2V2qDzc87H68IxbTdXiZxT7VOiQkKvdPrffR0nG99tYl
         b5dWEhXkEmgz1K3NPDU1obzuhAQmKrSfiTCtiSIboF6TGIj47w+Vybv4zCri3qiL5xg5
         /2+ewk6VFCHmILIfPtLgFXAQYI2MAjFlso2TjihxF3z2ek3y/zBDCa+Nlo6XiE5gTsJY
         QWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791938269; x=1792543069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fonBvjZO/D/GM9L+MsZkX1d2b3mKIY2/WZMtCJsJfEU=;
        b=rrZKUTGz2jBMTmcJVnexPGcAoBZFDgyld+JFhFcIT5KtP8f8EIov57+D1Zb8Au7POn
         A+YGA2tQkqfMLHz2+vaCUB+peK5RMzZBmDZgLuU4xflm5gHCy1r6C/zuTPhbX7/pmgjJ
         xmM5wbMtVGaD34tq3Kzn6PY1g4ixHegYpHThLDyty4dAkxQXvhi0Ot0+I6E1IHvp2Qpf
         wnUEP4NYe9QHGaXlc9hi7T0/CIMrLIbjmhNJgZVvBjnZcXWOpeiYogNQQS9hv/sUX5+W
         H/Z/0falAumTe/Y9TMzLksEO2kMbQC3KtD5eCrFCkgi/Kijy9xu1OdiGAjau0scYIQy6
         ju2w==
X-Gm-Message-State: AFq9FYI+5E3rQVaasufScmFykdGL07Jl9IuCcZtTa7QUT906aA06/cXc
	kj99QzMnaut9g2kcPs5QfSNqnICWjp/pZLdeJ5RE9OcBdjjRhtP+k5DsH0E88BTsbzM=
X-Gm-Gg: AYBFou0YXmlc+bTSSAEFq0gxibCVOVhy7lo/KdqZROnSJXQyvNxTT5JKmr4P67b9TOt
	8g18ktTFGj/PHvfcUVPUifzSBz6Ry42UtLtP7CzV2tZyosyaimP/LGA04/DjHR2KomJw9pH/lgF
	sTlfNah+wbKSK0HIYc2h5xOp47iik6cXwHxuadrSHKAtF9mVIh0PkEhhL+p/k7Oe0ZNEPyrrNcI
	uYoJZ72l3N+I/SQk3FmhVnPc5oQZW1kCDGAuK+o6EU51zv8bYrAzLHk31t2z17Hlfl6S1SIdyJC
	VN6Kuj8LPJ3ixghDRyJ5oJGZkvOgqauwxNADHdnExHpQbbRe1BLNaokAEwWcQwa+dPLVNtja2K4
	0wu2n8WmJDWPonG75DG5gfVo/p1LYxWSuVl/QSzhxEDFNdxv0ajn7NBXOKOgGJl66JwqCpbu+AZ
	Yb0kPJWoESS4SyclOuad7JFc34mjab918fn4nuxQlatCefaahCvmkdvW/UhXUnMoXBBJXkh376n
	ay2sXTxjbBgJEYTV8xnJm8BVLFMe6XKDuKB91+fm1nkGz7M8hRrg6ZQByRB3CcUoW4r6TT7KD3j
	HVWNYiCbe4y62KaC6fAC/A8BXIuw
X-Received: by 2002:a05:690e:4146:b0:677:d21f:b63f with SMTP id 956f58d0204a3-6793603f7e1mr3922393d50.49.1791938268820;
        Tue, 13 Oct 2026 17:37:48 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:98d3:ec2f:c938:3bc1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a15c13sm463194d50.7.2026.10.13.17.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:37:48 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 1/3] hfsplus: fix timestamp wrapped issue
Date: Tue, 13 Oct 2026 17:37:29 -0700
Message-ID: <20261014003731.369728-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014003731.369728-1-slava@dubeyko.com>
References: <20261014003731.369728-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/258 fails to execute
correctly:

FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.15.0-rc4+ #8 SMP PREEMPT_DYNAMIC Thu May 1 16:43:22 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/258 [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/258.out.bad)

The main reason of the issue is the logic:

cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET)

At first, we take the lower 32 bits of the value and, then,
we add the time offset. However, if we have negative value
(timestamp before January 1, 1970), then we make completely
wrong calculation. The reverse conversion has the same issue
because it treats any on-disk timestamp under HFSPLUS_UTC_OFFSET
(January 1, 1970) as a time between 2040 and 2106.

This patch corrects the logic of __hfsp_mt2ut() and
__hfsp_ut2mt(). Now, the on-disk timestamp is interpreted
as unsigned number of seconds since January 1, 1904. As a result,
the supported time range is from January 1, 1904 till
February 6, 2040.

The HFS_UTC_OFFSET constant has been moved into
include/linux/hfs_common.h and HFSPLUS_UTC_OFFSET has been
removed. The HFS_MIN_TIMESTAMP_SECS and HFS_MAX_TIMESTAMP_SECS
constants have been introduced in include/linux/hfs_common.h.
The hfsplus_fill_super() logic defines sb->s_time_min,
sb->s_time_max, and sb->s_time_gran. It means that VFS clamps
the timestamps that are out of the supported range.

[1] https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/133

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/hfs_fs.h            | 13 -------------
 fs/hfsplus/hfsplus_fs.h    | 17 +++++------------
 fs/hfsplus/super.c         |  4 ++++
 include/linux/hfs_common.h | 13 +++++++++++++
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e250f87a5e33..659b0ba733d4 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -255,19 +255,6 @@ extern int hfs_mac2asc(struct super_block *sb,
 /* super.c */
 extern void hfs_mark_mdb_dirty(struct super_block *sb);
 
-/*
- * There are two time systems.  Both are based on seconds since
- * a particular time/date.
- *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
- *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
- *
- * HFS implementations are highly inconsistent, this one matches the
- * traditional behavior of 64-bit Linux, giving the most useful
- * time range between 1970 and 2106, by treating any on-disk timestamp
- * under HFS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
- */
-#define HFS_UTC_OFFSET 2082844800U
-
 static inline time64_t __hfs_m_to_utime(__be32 mt)
 {
 	time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 916e6552e3f0..cd51afa22ece 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -525,26 +525,19 @@ bool is_hfs_thread_record_type(u16 type)
 
 int hfsplus_brec_read_cat(struct hfs_find_data *fd, hfsplus_cat_entry *entry);
 
-/*
- * time helpers: convert between 1904-base and 1970-base timestamps
- *
- * HFS+ implementations are highly inconsistent, this one matches the
- * traditional behavior of 64-bit Linux, giving the most useful
- * time range between 1970 and 2106, by treating any on-disk timestamp
- * under HFSPLUS_UTC_OFFSET (Jan 1 1970) as a time between 2040 and 2106.
- */
-#define HFSPLUS_UTC_OFFSET 2082844800U
-
 static inline time64_t __hfsp_mt2ut(__be32 mt)
 {
-	time64_t ut = (u32)(be32_to_cpu(mt) - HFSPLUS_UTC_OFFSET);
+	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
 
 	return ut;
 }
 
 static inline __be32 __hfsp_ut2mt(time64_t ut)
 {
-	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
+	ut += HFS_UTC_OFFSET;
+
+	return cpu_to_be32(lower_32_bits(ut));
+
 }
 
 static inline enum hfsplus_btree_mutex_classes
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index ff7d6b3336a6..657dfa40bdf3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -511,6 +511,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sbi->rsrc_clump_blocks)
 		sbi->rsrc_clump_blocks = 1;
 
+	sb->s_time_gran = NSEC_PER_SEC;
+	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS;
+	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS;
+
 	err = -EFBIG;
 	last_fs_block = sbi->total_blocks - 1;
 	last_fs_page = (last_fs_block << sbi->alloc_blksz_shift) >>
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..d4e91dea2362 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -667,4 +667,17 @@ typedef union {
 	struct hfsplus_attr_key attr;
 } __packed hfsplus_btree_key;
 
+/*
+ * There are two time systems.  Both are based on seconds since
+ * a particular time/date.
+ *	Unix:	signed little-endian since 00:00 GMT, Jan. 1, 1970
+ *	mac:	unsigned big-endian since 00:00 GMT, Jan. 1, 1904
+ */
+#define HFS_UTC_OFFSET 2082844800U
+
+/* January 1, 1904, 00:00:00 UTC */
+#define HFS_MIN_TIMESTAMP_SECS		-2082844800LL
+/* February 6, 2040, 06:28:15 UTC */
+#define HFS_MAX_TIMESTAMP_SECS		2212122495LL
+
 #endif /* _HFS_COMMON_H_ */
-- 
2.43.0

