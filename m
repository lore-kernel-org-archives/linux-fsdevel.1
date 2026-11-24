Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560820;
	b=IzGuNkxQtGWMc1aUSFKBjEANiayTdQ6pIwUaMUi3uuRriTU1CvxCuqqsYA9X9P8JacMF
	 9elG45oOpNn8qUZML8nfC/1lk/N7+Bfxw5j7bdlbiqfowPb/hJc7oZWdZTXCG10olgWzB
	 bW72mAYp0ZbzOO5q275aLXm9CAVJoe4WLJKe4M/RQuQY8J3dr85K2LAKZSULhOdECgbLt
	 lmOMLhNllTIswZmxgcWyxwEz09W1yLwb2aDGsr1XS6JLnVVaRPsPhAX7klZennjX54Ovl
	 0VomxBD52+deWIq237cmqKAveVtA5rc37I/ALfEXMN83wdAY1ql91ajJSXTr29Ofkgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lKbBNWOf8c8dr+AruTTpzOy7qfgQ9AdhUe195RH18Hw=;
	b=j7lfc/5MfwxEI2qZSLAkwJFDBxxHaj9chg3d4Aj418VmI0WhMVAotXVW7kzoDgJs87Uq
	 heoUMGHSxHxUmBrXnjtQ9Fb6Yf/qAqxNXzuFOKJoofjGhPGJXlfNvetsm3rvTn0eRS1qn
	 LGrXhhwsxiDKNqxyeg139XuX+Jj84kvFJ9XyN0TqcIF+vZO/iDbnoGAXyfaDWfXsy3Wpx
	 wwYZwtAuJMOU1m+O4Gj0DpCpgAq6BKBrp0zWZJ1FyRNUYwTjFtpncVGvJvdXNZLOayXAQ
	 tP47rv6BTTaj/CzNKEUMxFMUIkCRcepw7i47mO2TR576jFqDXFfvGaK2Dx9Bq4piAkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DPQI5CZU;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0D606A327
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A0D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DPQI5CZU
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67db763cec7so5332162d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795560819; x=1796165619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lKbBNWOf8c8dr+AruTTpzOy7qfgQ9AdhUe195RH18Hw=;
        b=DPQI5CZUdM5dIT1KXM/8ZrRU6J3q32ct/SicAY2Jr12RRb/TIz5udK59shTyEOXsRg
         QMxPwJzF6JTgWJEFmC8PLCOq9p83zr48/Az1Ijz1cV2ukM3fuMTki0DN0o7Yo6PEQvo+
         ONj9cdDnmZdrVs5NaL8yF5ZJFQ1uCWBYFdOPWpxK/73aZ9eNegn2TGMePYAorr6wZVvM
         R4FOMHXQBocEcTx/UgX/H4WZHdsFAly8YbKx0sjgV3/DTbnvhPBnM7Q/8RZbMQiQrvEO
         BghjZ9zqaU0/2H3gzylDg+Jcpb7g8GzgVzO67jC5TPcemPY+wxq6tTMO2oFezKBvSYTp
         ZTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560819; x=1796165619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lKbBNWOf8c8dr+AruTTpzOy7qfgQ9AdhUe195RH18Hw=;
        b=Qu9Eq+XA3nKeYISbPpIvrL4mFwyA2kv8Jrvedm1iXody77PcLqBWAx2tXi7Nu1o8jb
         NWtEKUHnBiuDUp4CdD7w5RVD+lE5S9WRm4ou09vvwYBVcqu8LOYIpAdvqA1v4aIErzAk
         dtZc1zEewtRd36nFntnhi5yP9rlzshO8BCfGC7xG6Ej5f6sKxfNjHMOBzO70KYmR+uDp
         3NYLiO9x0n67iM0sYe/pdXB3CHPvTc/Z6g3G+mWhmH7l/TQCN5IT82BOT9Ex69zJUZ1x
         2k7lzJNhPvb2gvah2PxU0gGOXPSDp/8XUIXBX2PKM+DW75zTHlucXZnvmMapXo93RKcI
         sl/w==
X-Gm-Message-State: APuU4Z8af7oPv2MZlQ4yzqvFrDVGLQNtPuhrid/4cXzZSH0gdHy4X21o
	8sVKCVb7pX5AP39HSSFjaPVXGu6itNNVFBpTYE9kylg2gRIQdfv+nwTdm7nciksDKW0=
X-Gm-Gg: AZFdTZfOqdebDRUmpIwG5gItxDEf4CdXsOgt6aX15cgZB+r2K7omZ/dyb2Jsy3XP6e8
	yR1AnXA23WdJKz4txEMx1WdSYvy826KgpUzGy3AyJT4mbh1/EOAlVV2pun1a8ASQoFUY4JOYkTq
	0Cr3Jcex9/8c/NsHkIYPaflyT5+/XVF1fUgMhOZ6/WvcSRv5tiMcSKsLrIQ1+8vbd4lv6w/IltN
	QnwizhuGny1VH1/rBABhhbMDIVmDhG68EvSq+qzrXiJ7BJc544YVIexmSlvucTAlw1+M44mWwip
	/2vKzGSf8CHY2844AgIyIpR64uQLmuG30dcmgERtgEkrtlk3BJ78BMNKKWUW/Yp8A5fHwzOlg2n
	r5YcB2dwwDYs4xNsWqAmAUdkZeXz1CoN7Zfpp6CihKRzEqPI4ZnMS1QQc2gEeX59viCIDGanXOM
	sEO2suL+7DQLZPvIYbpCgWpNvIr4cFNdhXW4+1/2eH8WF3qwDvfWi7ieLXP11W/vyuHeBF/PizR
	NwmHiBoJY1UXZiHI8T1N1SF1R7g7P+zlJr6yCQS1LYInakR8ycy/vq6aGT5ck09bH4IVgRZXyIK
	amj9usZp/0m1uwiz7/l096Oi9g61mlLDb3PWJvvWACfdKkOdiWZVF9YKOUrW7xoNO0jvNJ2nilr
	D/CFXYtAydPQAOd4dZZK+ZYKEm8eNCqvN11fw5MZiuqtf0fiuB2tjCZQcoeF5q7At1VFd4sE=
X-Received: by 2002:a05:690e:441c:b0:67d:b34c:9f19 with SMTP id 956f58d0204a3-67df44bfeeamr3429902d50.106.1795560818847;
        Tue, 24 Nov 2026 14:53:38 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:c4f2:e852:cd48:35ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b7502sm7706219d50.20.2026.11.24.14.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:53:38 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 2/3] hfs: store timestamps after February 2040 in spare catalog fields
Date: Tue, 24 Nov 2026 14:53:29 -0800
Message-ID: <20261124225330.3879708-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124225330.3879708-1-slava@dubeyko.com>
References: <20261124225330.3879708-1-slava@dubeyko.com>
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

The timestamp wrapping issue has been fixed but it
restricts the supported time range to the one that the 32-bit
on-disk field can represent: from January 1, 1904 till
February 6, 2040 (local time). Any timestamp after
February 6, 2040 is clamped now.

HFS has no extended attributes on the volume. Extend the supported
time range by means of spare bytes of the catalog record. If the
modification date cannot be represented by the 32-bit on-disk
field, then the maximal value (0xFFFFFFFF, HFS_EXT_TIMESTAMP_MARK)
is stored into MdDat and the real value is stored into the spare
bytes of the same catalog record as big-endian 64-bit number of
seconds since January 1, 1904 (local time, as MdDat itself):

file record:      FndrInfo.fdIconID and FndrInfo.fdUnused[0..5]
directory record: Resrv[0..7]

The fsck_hfs tool checks that StBlk, RStBlk, and Resrv of the file
record are zero. As a result, these fields cannot be used. However,
fsck_hfs does not check the Finder info of the file record and
the reserved field of the directory record. Apple uses the same
8 bytes of the extended Finder info in HFS+ (document ID and date
added).

Read path: if MdDat is equal to HFS_EXT_TIMESTAMP_MARK and
the spare bytes contain the value that cannot be represented
by MdDat, then hfs_cat_read_mtime() returns the extended value.
Otherwise, the value of MdDat is used. If another implementation
(for example, Mac OS) updates MdDat, then the mark is removed and
the stale value of the spare bytes is ignored. If the spare bytes
contain zero or garbage, then HFS_MAX_TIMESTAMP_SECS is used.

Write path: hfs_cat_write_mtime() stores the modification date
into the catalog record. The spare bytes are cleared if the
timestamp becomes representable by MdDat again. The spare bytes
are not touched for the records with regular MdDat because
the record could be created by another implementation.
The extended value is updated together with MdDat in the same
catalog record. It means that it is protected by the catalog
tree lock and no additional locking or b-tree update is required.

Only MdDat is extended because HFS driver uses it for mtime,
atime, and ctime. The CrDat and BkDat fields are not exposed by
HFS driver and they are clamped. The hfs_cat_build_record()
uses the timestamp of the inode for the new record. As a result,
sb->s_time_max is set to HFS_EXT_MAX_TIMESTAMP_SECS.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/catalog.c | 10 +++---
 fs/hfs/hfs_fs.h  | 58 +++++++++++++++++++++++++++++--
 fs/hfs/inode.c   | 88 +++++++++++++++++++++++++++++++++++++++++++++---
 fs/hfs/super.c   |  6 +++-
 4 files changed, 149 insertions(+), 13 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 490c5e130da3..76924783b136 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -35,14 +35,14 @@ void hfs_cat_build_key(struct super_block *sb, btree_key *key, u32 parent, const
 
 static int hfs_cat_build_record(hfs_cat_rec *rec, u32 cnid, struct inode *inode)
 {
-	__be32 mtime = hfs_mtime();
+	time64_t mtime = inode_get_mtime_sec(inode);
 
 	memset(rec, 0, sizeof(*rec));
 	if (S_ISDIR(inode->i_mode)) {
 		rec->type = HFS_CDR_DIR;
 		rec->dir.DirID = cpu_to_be32(cnid);
-		rec->dir.CrDat = mtime;
-		rec->dir.MdDat = mtime;
+		rec->dir.CrDat = __hfs_u_to_mtime(mtime);
+		hfs_cat_write_mtime(rec, mtime);
 		rec->dir.BkDat = 0;
 		rec->dir.UsrInfo.frView = cpu_to_be16(0xff);
 		return sizeof(struct hfs_cat_dir);
@@ -53,8 +53,8 @@ static int hfs_cat_build_record(hfs_cat_rec *rec, u32 cnid, struct inode *inode)
 		if (!(inode->i_mode & S_IWUSR))
 			rec->file.Flags |= HFS_FIL_LOCK;
 		rec->file.FlNum = cpu_to_be32(cnid);
-		rec->file.CrDat = mtime;
-		rec->file.MdDat = mtime;
+		rec->file.CrDat = __hfs_u_to_mtime(mtime);
+		hfs_cat_write_mtime(rec, mtime);
 		rec->file.BkDat = 0;
 		rec->file.UsrWds.fdType = HFS_SB(inode->i_sb)->s_type;
 		rec->file.UsrWds.fdCreator = HFS_SB(inode->i_sb)->s_creator;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 0d710a45c61d..a07675e29fe6 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -219,6 +219,8 @@ extern void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
 extern int hfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 extern int hfs_inode_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 			     struct iattr *attr);
+time64_t hfs_cat_read_mtime(hfs_cat_rec *rec);
+void hfs_cat_write_mtime(hfs_cat_rec *rec, time64_t ut);
 extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 				__be32 __log_size, __be32 phys_size,
 				u32 clump_size);
@@ -286,11 +288,63 @@ static inline __be32 __hfs_u_to_mtime(time64_t ut)
 
 	return cpu_to_be32(lower_32_bits(ut));
 }
+
+/*
+ * Linux specific extension of HFS on-disk layout that makes possible
+ * to support timestamps after HFS_MAX_TIMESTAMP_SECS.
+ *
+ * If the modification date cannot be represented by the 32-bit on-disk
+ * field, then the maximal value (HFS_EXT_TIMESTAMP_MARK) is stored into
+ * MdDat of the catalog record and the real value is stored into
+ * the spare bytes of the same catalog record as big-endian 64-bit
+ * number of seconds since January 1, 1904 (local time):
+ *
+ *   file record:      FndrInfo.fdIconID and FndrInfo.fdUnused[0..5]
+ *   directory record: Resrv[0..7]
+ *
+ * fsck_hfs does not check these bytes. Another implementation that
+ * updates MdDat removes the mark. As a result, the stale value in
+ * the spare bytes is ignored.
+ */
+#define HFS_EXT_TIMESTAMP_MARK		cpu_to_be32(U32_MAX)
+#define HFS_EXT_TIMESTAMP_SIZE		sizeof(__be64)
+/* settimeofday() limits sys_tz.tz_minuteswest by +/-15 hours */
+#define HFS_MAX_TZ_SECS			(15 * 60 * 60)
+/* maximal 64-bit on-disk value that can be converted into time64_t */
+#define HFS_EXT_MAX_MAC_DATE		((u64)TIME64_MAX - HFS_MAX_TZ_SECS)
+#define HFS_EXT_MAX_TIMESTAMP_SECS	\
+	((time64_t)HFS_EXT_MAX_MAC_DATE - HFS_UTC_OFFSET - HFS_MAX_TZ_SECS)
+
+static inline bool hfs_mt_is_ext_timestamp(__be32 mt)
+{
+	return mt == HFS_EXT_TIMESTAMP_MARK;
+}
+
+static inline bool hfs_ext_mt_is_valid(u64 mt)
+{
+	return mt > U32_MAX && mt <= HFS_EXT_MAX_MAC_DATE;
+}
+
+static inline time64_t __hfs_ext_m_to_utime(u64 mt)
+{
+	time64_t ut = (time64_t)mt - HFS_UTC_OFFSET;
+
+	return ut + sys_tz.tz_minuteswest * 60;
+}
+
+static inline u64 __hfs_u_to_ext_mtime(time64_t ut)
+{
+	ut = clamp_t(time64_t, ut,
+		     HFS_MIN_TIMESTAMP_SECS - HFS_MAX_TZ_SECS,
+		     HFS_EXT_MAX_TIMESTAMP_SECS);
+	ut -= sys_tz.tz_minuteswest * 60;
+	ut += HFS_UTC_OFFSET;
+
+	return ut < 0 ? 0 : ut;
+}
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)   (struct timespec64){ .tv_sec = __hfs_m_to_utime(time) }
-#define hfs_u_to_mtime(time)   __hfs_u_to_mtime((time).tv_sec)
 #define hfs_mtime()		__hfs_u_to_mtime(ktime_get_real_seconds())
 
 static inline const char *hfs_mdb_name(struct super_block *sb)
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index f1122ffae712..388fe24bf093 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -19,6 +19,8 @@
 #include <linux/xattr.h>
 #include <linux/blkdev.h>
 #include <linux/fileattr.h>
+#include <linux/unaligned.h>
+#include <kunit/visibility.h>
 
 #include "hfs_fs.h"
 #include "btree.h"
@@ -343,12 +345,88 @@ static int hfs_test_inode(struct inode *inode, void *data)
 /*
  * hfs_read_inode
  */
+/*
+ * The spare bytes of the catalog record that keep the extended
+ * modification date: fdIconID and fdUnused[0..5] of the file record,
+ * Resrv[0..7] of the directory record.
+ */
+static void *hfs_cat_ext_mtime(hfs_cat_rec *rec)
+{
+	if (rec->type == HFS_CDR_DIR)
+		return rec->dir.Resrv;
+
+	return &rec->file.FndrInfo;
+}
+
+/*
+ * hfs_cat_read_mtime - get modification date of the catalog record
+ * @rec: file or directory catalog record
+ *
+ * If MdDat is equal to HFS_EXT_TIMESTAMP_MARK and the spare bytes
+ * contain the valid extended value, then the extended value is returned.
+ * Otherwise, the value of MdDat is returned.
+ */
+time64_t hfs_cat_read_mtime(hfs_cat_rec *rec)
+{
+	__be32 mt;
+	u64 ext_mt;
+
+	if (rec->type == HFS_CDR_DIR)
+		mt = rec->dir.MdDat;
+	else
+		mt = rec->file.MdDat;
+
+	if (hfs_mt_is_ext_timestamp(mt)) {
+		ext_mt = get_unaligned_be64(hfs_cat_ext_mtime(rec));
+		if (hfs_ext_mt_is_valid(ext_mt))
+			return __hfs_ext_m_to_utime(ext_mt);
+	}
+
+	return __hfs_m_to_utime(mt);
+}
+EXPORT_SYMBOL_IF_KUNIT(hfs_cat_read_mtime);
+
+/*
+ * hfs_cat_write_mtime - set modification date of the catalog record
+ * @rec: file or directory catalog record
+ * @ut: modification date (seconds since January 1, 1970)
+ *
+ * If @ut cannot be represented by MdDat, then HFS_EXT_TIMESTAMP_MARK
+ * is stored into MdDat and the real value is stored into the spare
+ * bytes of the record. The spare bytes are cleared only if they keep
+ * the stale extended value. Otherwise, they are left untouched because
+ * the record could be created by another implementation.
+ */
+void hfs_cat_write_mtime(hfs_cat_rec *rec, time64_t ut)
+{
+	__be32 *mt;
+	void *ext_mt = hfs_cat_ext_mtime(rec);
+	u64 value = __hfs_u_to_ext_mtime(ut);
+
+	if (rec->type == HFS_CDR_DIR)
+		mt = &rec->dir.MdDat;
+	else
+		mt = &rec->file.MdDat;
+
+	if (value > U32_MAX) {
+		*mt = HFS_EXT_TIMESTAMP_MARK;
+		put_unaligned_be64(value, ext_mt);
+		return;
+	}
+
+	if (hfs_mt_is_ext_timestamp(*mt) || value == U32_MAX)
+		memset(ext_mt, 0, HFS_EXT_TIMESTAMP_SIZE);
+
+	*mt = cpu_to_be32(value);
+}
+EXPORT_SYMBOL_IF_KUNIT(hfs_cat_write_mtime);
+
 static int hfs_read_inode(struct inode *inode, void *data)
 {
 	struct hfs_iget_data *idata = data;
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	hfs_cat_rec *rec;
-	struct timespec64 mtime;
+	struct timespec64 mtime = {};
 
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
@@ -385,7 +463,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 			inode->i_mode |= S_IWUGO;
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
-		mtime = hfs_m_to_utime(rec->file.MdDat);
+		mtime.tv_sec = hfs_cat_read_mtime(rec);
 		inode_set_ctime_to_ts(inode, mtime);
 		inode_set_atime_to_ts(inode, mtime);
 		inode_set_mtime_to_ts(inode, mtime);
@@ -401,7 +479,7 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-		mtime = hfs_m_to_utime(rec->dir.MdDat);
+		mtime.tv_sec = hfs_cat_read_mtime(rec);
 		inode_set_ctime_to_ts(inode, mtime);
 		inode_set_atime_to_ts(inode, mtime);
 		inode_set_mtime_to_ts(inode, mtime);
@@ -581,7 +659,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		    be32_to_cpu(rec.dir.DirID) != inode->i_ino) {
 		}
 
-		rec.dir.MdDat = hfs_u_to_mtime(inode_get_mtime(inode));
+		hfs_cat_write_mtime(&rec, inode_get_mtime_sec(inode));
 		rec.dir.Val = cpu_to_be16(inode->i_size - 2);
 
 		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
@@ -609,7 +687,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		else
 			rec.file.Flags |= HFS_FIL_LOCK;
 		hfs_inode_write_fork(inode, rec.file.ExtRec, &rec.file.LgLen, &rec.file.PyLen);
-		rec.file.MdDat = hfs_u_to_mtime(inode_get_mtime(inode));
+		hfs_cat_write_mtime(&rec, inode_get_mtime_sec(inode));
 
 		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
 			    sizeof(struct hfs_cat_file));
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a63b92709984..f4983e39daf5 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -348,7 +348,11 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_time_gran = NSEC_PER_SEC;
 	/* on-disk timestamps are in local time */
 	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS + sys_tz.tz_minuteswest * 60;
-	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS + sys_tz.tz_minuteswest * 60;
+	/*
+	 * Timestamps after HFS_MAX_TIMESTAMP_SECS are stored in
+	 * the spare bytes of the catalog record.
+	 */
+	sb->s_time_max = HFS_EXT_MAX_TIMESTAMP_SECS;
 	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
-- 
2.53.0

