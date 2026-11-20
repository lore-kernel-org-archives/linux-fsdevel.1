Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137165;
	b=WwUnjkb8jDo5YRUvkEIV96P53CBk5ZVBTz1PXDleCz7tC9N9ckTipl3NB68i4jITcc7c
	 lwvygMR5UGMpx6WEm4yKvvAyL811WObnXqm9Xt8oJLJLGq3Ar4VS4PJQHKHFJ4ipGi7nV
	 4Vwh9zy9i8v96ang4ome4IT4LjFOkA0gJdrTEwpaj3kbX1p7ujiFXP9iMYmb7oPc5yIQQ
	 xvhHFu6nGsIBU/Prj1zoRgKz/CUJ5HBY2utLHGbm+V1u54jeKU9bRnWPTOrqwPAHo+DVm
	 bydiXIlPcBKYivjbikGZIctjAEzpMWesMwpiCMouM+rAmj+ljmbyELHBPS5taWLa8NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137165;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=duDYOTbV74r8lTHlc4onSvfNrC22SLF5wmvjyDLB0Ok=;
	b=Z7U1PCeynmlqpnkFogu8+pe4c/Ec03Jr5kQA6zXaP3xIyeTfg0h/W0xNPnV5lgVJAkw0
	 hpIWJpSFrtpKDA+QRrE+d1fp4nEVwsWMONEfCfac/SaxF3p6uYmGavWaoBm5yyGIW6ue5
	 Nda2qr+dWEn2EXYYpq740P2dEdfJE9rawWNYma8XkbgsjGtwpSbY3XnCr62mNNNBF0gvq
	 BsP7LfKOnDgAzCuR+iYwFLyi1lghFizRCevfurgS9fxh2PjwAZl9bbwT1G7EFDyUv5wr1
	 6S2K3LgIZZHGCMcHkvazDxdjlATU92e2VMbyQyZXqleFNIuTKtduMwxCea1CH4i6H9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ChE2fq1k;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA4606A330
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 01:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AA4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ChE2fq1k
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b51389f58cso4430627b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 17:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795137164; x=1795741964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duDYOTbV74r8lTHlc4onSvfNrC22SLF5wmvjyDLB0Ok=;
        b=ChE2fq1kjq7vtyn4L6lm6QYpl+pl473+pP+/QidVKQOhD25hGlhxIZjA6KbU+daHHk
         KKoqnSTz+lM65ubSSBI9u4+K0UCYzGNjzVqHHAGsZPQKfQSZzhqZRLhs+AwAr2o/EyGn
         il3di7UoBRMQX1ZpKZaLlv/FBesLVZK6zQ+4jFRebPmc0KyNxCoce9XyUlqnqGXiuY2e
         P1tpo8OP0E2Oo6hgdqHUQQCVN1XboW4cXB8rDUBsIqFBWSRer4pAn9/rsB9HT2MarxP/
         TgaM9NWAG0WSN7/XVLk7nD5j4equiqrgZybENPxAhaMBVkzxtU/DKRuM4Z7a9h+3HMeA
         HxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137164; x=1795741964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=duDYOTbV74r8lTHlc4onSvfNrC22SLF5wmvjyDLB0Ok=;
        b=E2q17jIaGaSVZV4Sbt/IzkzgQGbCJwnHBupsUCS/vjdC8FbcdIAtS9TxiGy1rlWxmJ
         RlU+D0+DKgd7vp6xspMz6ecnuErVQQa3bMG1MmVTkDb4Fe9/nJLdak42YPrW8iXCwBjR
         miuhBooo6ljGAOnmmmZ1/rMhDuMhr9xz/e33i8t1fbmh+9dInd2q3GXoeYUsQE1srrzY
         R0HKP0vlphkcTxruiWrd4Y8IlnkgZdg3FrR2vk+0BF5Mq7FG3Hyc/OxoaKUoaHbXTq48
         S6SLyiBnf361ORbt+XpVUZXpxNYDcg/k7l8LsrAf+AE7nvRifdf443lRcc9QN8uFmEAR
         F1MQ==
X-Gm-Message-State: APuU4Z+AJbFBOMBiKIN5Svg+5X7lv3yPanIAq86N8QyM7zVv8If0DznF
	zalfzujfQGzNZERh1q0eAne3TeKEdFjYAYpvHl//MgpbqD6BhFGqUaqmCjuDpufs6wc6mR98L/J
	dz6KlKPM=
X-Gm-Gg: AZFdTZcb83gfRw8f/YXSn88Gx7fCqNBwbiX2fy6gCug0KwhE5ubSBdn4gSPdvJfLgMh
	WidLcYtTvh0kZmLzwMnlbUF39SZvekZhLqGJEyUyzlbYqOhqYj7Qm6Hp2S9BKeFIPc3Pl9n2Dus
	nk0f8uzrJ2vvNYPp0bRHqS8ALUOS1IymRTwXRrpGUlK7waQ7C7w2JgXyQXWiYnxFAAfifeUkulv
	CL4KPN7z1MQkepAKwLRWqI5qCV2C0JKVe7IPaSrXGTUjYwGwfF8c+QeKY7Vhgg/ZXsrzauw+6zJ
	gSGh6n3EiPjaWYHDMZ5UZQYby2BRg+Gk/31Xze3u748Id5NJAYPuc6YmiItEPFDSdmnz/qCbDG0
	PWSJEFfiJ2y1rKQzjyCYBVJd4jgO8lXBL/bwMf40tteF1/AenpA0HFEpfaCGS6CmXFjHxxGX7Pp
	P38EkR11WMSJo0trWyciyJI9WNZAfd2EQTspCOCRsc81+jApCgtTium8dMzoQTrxie53wJL2B/+
	JOCz78eIkH79eJTFfOxMypS2qs4uiszML72zQCEUBIpEhMhegSjsC2kazHuprmPpy7mzy2fYFJe
	AWFYvdeGNmg/IBSMuU+CLcwRxXOhhM18GCk8dgcdQhzDB5R7RbKavQsmjV4+LHq32EAn4WLCfmU
	RCeHE2BDwhA9+Z20aF2nYghHE1OlQbTysbKNa+9lDPAoYXqDHq4CcgMXBuelzeBpwrZEv
X-Received: by 2002:a05:690c:29b:b0:8b3:38f3:8644 with SMTP id 00721157ae682-8b52032afb0mr7388077b3.11.1795137164440;
        Thu, 19 Nov 2026 17:12:44 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:a9a8:c05:b82:7f12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202fb08csm7461207b3.24.2026.11.19.17.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:12:44 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v4 1/3] hfsplus: fix timestamp wrapped issue
Date: Thu, 19 Nov 2026 17:12:35 -0800
Message-ID: <20261120011238.789758-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120011238.789758-1-slava@dubeyko.com>
References: <20261120011238.789758-1-slava@dubeyko.com>
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

cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfs/hfs_fs.h            | 13 -------------
 fs/hfsplus/hfsplus_fs.h    | 17 +++++------------
 fs/hfsplus/super.c         |  4 ++++
 include/linux/hfs_common.h | 13 +++++++++++++
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 2744508e01e6..2d56f8b1a5fa 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -261,19 +261,6 @@ extern int hfs_mac2asc(struct super_block *sb,
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
index dd88053cc9b3..3df09414f7f3 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -531,26 +531,19 @@ bool is_hfs_thread_record_type(u16 type)
 
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
index f3283e9b42c8..516885d91e51 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -659,6 +659,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
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
index 802d1590e4a3..eb119a1c565f 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -687,4 +687,17 @@ typedef union {
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
2.53.0

