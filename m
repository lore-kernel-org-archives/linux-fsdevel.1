Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795060378;
	b=psxJOpD5rjrNMAKuB6IibSOszsCcK9MrcQdXRNMcZ8Xa9HnsMUkzdbDpaQAnuYZfaYsW
	 mlX3prdhMYD0pj6MFADpIpKHdhnwpt5tvEQlH/2NNYGJ8m4NfBeol2Zr96dsQvxpZk3IF
	 H7ABStsC2Ug80iXaUzRDaJywtM3bgui1N0nWacZ/Edbff9zOmMP5MZcHdQ8Ro1bE/wcXs
	 2XI430qYHL8ndW84gRv/NGHpWP83PgoTm+4VxSviDoJGrtClrJvu7aWdDG2lFppVzDmxC
	 4dSKXFRNuMRpanRZhJ9uFpNUjb9kjBZqOcXJubfPLxKKXQ2T5Mxa3nbdk93tFFSjOdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795060378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XSIy9FLQysYTgaYYrX+1jyfQu2/aKcX5jVQ/CvHepYI=;
	b=KTka34fYUahMJSwfUL/LnPs02mGDQouXKqOetsoNMuABWMby0/gusN2UgKNMuZvkt1Sm
	 1+fY4Vvlk63irVnmkZSLo753FzDt85D6C0K9mOyVKmqSF+wIcbmfrYOtM2gwYPz3yFudv
	 WUwk2zikkW1UQKh3f7Vm/UCaBnvHz8L6GYIIewKajJgBA3v3lb8s32y/DCqEPLvsYVFmH
	 oOIKkaJoqv5+YMM7TX+WPWhCIlaawYjHHeGz41SnqsXmcUHxxcYis2UInlci4Y6S1FMpQ
	 UBvtKO8dbYeySgYZ9N6hDRftUiRrfKpHHCznPxFq5nJtsPfoA6vWXTTAmgNDCBGtCsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNH10dt1;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9A606A32A
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:52:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA9A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oNH10dt1
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-381d542bc29so3323425eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795060377; x=1795665177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSIy9FLQysYTgaYYrX+1jyfQu2/aKcX5jVQ/CvHepYI=;
        b=oNH10dt1e8x/FdQ7ISHmN6efg4LzNr9C6Zis4UYcCMxvIxiApI2aBhEi3TloEkhy9/
         HagANDUFLz/jPUyi15EqM4derslz3zTe935YIGWto1R2pBHRCo1KrbpW29HPR7Xhjdtl
         ZMUDtOSRr+66Cann/rlKZLz1Q+mfD4Y1b/8FS1URhsxOa9+esmRV7A4i1HbPaFoaJCTj
         weBQy19o32Uk5AT7Ycrcpgw+/Iqjt6+axHPqVtQ5KggHGjJsr1IPwctdOTFVzYHPdRKS
         WAZCT0w7ZPh4Vap2EmbXYc9fqUwBBN8+WC+akiriNVUUQjLaUE4SXbRl/a1kEn9lbBAo
         qMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795060377; x=1795665177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSIy9FLQysYTgaYYrX+1jyfQu2/aKcX5jVQ/CvHepYI=;
        b=jdMSue8erFSEpR8c2sf3nPTnzO/JJCFm42kw58jaByOTk1Mv8aEz1TvEGhD9DnO5Tz
         eiCa4FOc2dsaZQtPVg4Prn2TfC5FN+siMCcexZpFHhxgPMj1jiIAautKKVGybRpbOXAj
         x0qvZNVtJDtjM0R421V412GyphlrEzntwtdlg1TdR12M0vOfYAbsKSmE82kdwL+VyHE/
         9DH422xGd9frdspUGbG80fk/uamgu53hClHPiQ8HnYAT4D7Daa03kdUo1L1+33Ajyj9M
         J3kpNcW21TO5xM25XBKZvpv8rshcZfH7GajfEOzB+nMp7EooHPqNlsz58SkssFiRUX+Z
         U7xQ==
X-Forwarded-Encrypted: i=1; AL+hErFj6mcDqiAtgsKkVMC27auEazhmedDskAgpxFEzQ9sTn8kTXNe23KNfADGRWl8W99zFy7rtzUA01FXPd+2x@vger.kernel.org
X-Gm-Message-State: APuU4Z8ba3Um4t46HO0y4IV+AOwZ+VpuckFEOPRxeq9ZSGUinfe2HFdq
	5YikywnikrtOAHZhtz893MVkfBx0lHKFHSgBpSp3jU2khDVk9TVcT8Z9VKuSmQ==
X-Gm-Gg: AZFdTZfxtZSWt87FWecy0TCqtg/1lEZNGaz75rNJMoBM4ncyDKtXaTYKoh5MQ0XNoms
	osCzL6umt3crh6Eyxv/E/LvNzBmxtEiFVJHuisQVeUc1VtJ8RLp6JreXuJjYprwYfu0Xm3u2E1+
	OP/vKlvhULpH5fF/W6JV9IqZ5hDwZmzGIcGhQDSQz41fAM40Tg692sJ8wLCDx6kuvf13Ipvm06N
	ijZlFyHkZ5lHf1uwN0XGITKBXOqcGW/lL184wMIeyc+zCSzSgpFr1vkG/JkWXhEmHR7BSQqorrF
	jKCFw8nOY7sL9WOncbABpZ8EsHRAmY10mZU2DDOe4iP9qEpkF4GyxQu4a91yK+BqouXVy/Bc/Hj
	annHDvYsPh2PYzg302b9/NRg0t71atwbduObwfbESdszDiAFz0DNeA+0Nti4v0yuOZRFROHyuAz
	6xR7/Za8FBNDvQ4WV6tOQBTDuQ0d1hK5ebQAfSDDQFPmr4vwLLnNhEb6IVoxa8FF6Uw57DFOF6R
	vzNo6vaVAVQ7AFg5ebjgXrRwSLolsEXT6JlzRD+5PkX45VzU3NaqXGLcBLAAPJce/IaoxDccNo9
	CKQi4pxFn6qHJkLuz96hUz6hdMwVs6zdW483h6RC6FMibug6thfhQ4jCJvcUWyM=
X-Received: by 2002:a05:7301:6184:20b0:36c:a44c:1763 with SMTP id 5a478bee46e88-38281813f4emr4287341eec.32.1795060377432;
        Wed, 18 Nov 2026 19:52:57 -0800 (PST)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6800338sm13049206eec.11.2026.11.18.19.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 19:52:56 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	shengyong1@xiaomi.com,
	yangyongpeng@xiaomi.com,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH] erofs: enable buffered RWF_DONTCACHE reads
Date: Thu, 19 Nov 2026 11:52:50 +0800
Message-ID: <b168501806b41e3f0be15efec4b54b371d8dd4e1.1795059802.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
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

From: Wenjie Qi <qiwenjie@xiaomi.com>

EROFS uses filemap_read() for buffered reads, including the inode-sharing
path, which preserves request flags when cloning the kiocb.

Advertise FOP_DONTCACHE in both file operation tables so preadv2() callers
can request that newly instantiated file-cache folios be dropped after
consumption. This is useful for one-pass reads that need not retain data
in the page cache.

For compressed reads, retain trailing readmore and propagate dropbehind
to the single-folio neighbor lookup. Readahead expansion already marks
new folios through readahead_control. Suppress prefix readmore so it
cannot refill pages already consumed and evicted. Ordinary readmore is
unchanged.

Tested sequential reads of 1-GiB files with 1-MiB requests on NVMe-backed
LZ4 and Zstd EROFS images in x86-64 QEMU/KVM with two vCPUs and 2 GiB RAM.
Each reader ran with memory.max=255852544 (244 MiB) and
memory.swap.max=0. Normal and dontcache ran in ten paired rounds per
layout, alternating their order and using a fresh guest for each run.

Results are arithmetic means of ten runs. Memory values average the
run-level time-weighted memory.current means. Percentage changes are
relative to normal reads:

                    MiB/s                  Mean memory, MiB
 Layout   normal/dontcache  change    normal/dontcache  change
 LZ4      2513.57/6350.61  +152.65%      169.53/17.39   -89.74%
 Zstd     2535.57/4066.49   +60.38%      179.01/18.17   -89.85%

In this test, dontcache reduced average cgroup memory by about 90%,
left no consumed file pages resident and recorded no memcg reclaim
scans or steals. Both layouts were faster in all ten pairs. This
offers a smaller cache footprint for one-pass reads on memory-constrained
systems.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Reviewed-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/erofs/data.c     |  1 +
 fs/erofs/internal.h |  5 +++--
 fs/erofs/ishare.c   |  1 +
 fs/erofs/zdata.c    | 10 +++++++++-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 968303afd..db0bac732 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -537,4 +537,5 @@ const struct file_operations erofs_file_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= filemap_splice_read,
 	.setlease	= generic_setlease,
+	.fop_flags	= FOP_DONTCACHE,
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 8363c0c05..cbe58576b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -321,10 +321,11 @@ static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 
 /* reclaiming is never triggered when allocating new folios. */
 static inline struct folio *erofs_grab_folio_nowait(struct address_space *as,
-						    pgoff_t index)
+						    pgoff_t index, bool dropbehind)
 {
 	return __filemap_get_folio(as, index,
-			FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+			FGP_LOCK | FGP_CREAT | FGP_NOFS | FGP_NOWAIT |
+			(dropbehind ? FGP_DONTCACHE : 0),
 			readahead_gfp_mask(as) & ~__GFP_RECLAIM);
 }
 
diff --git a/fs/erofs/ishare.c b/fs/erofs/ishare.c
index ea146fa8a..585bf4614 100644
--- a/fs/erofs/ishare.c
+++ b/fs/erofs/ishare.c
@@ -190,6 +190,7 @@ const struct file_operations erofs_ishare_fops = {
 	.get_unmapped_area = thp_get_unmapped_area,
 	.splice_read	= erofs_ishare_splice_read,
 	.fadvise	= erofs_ishare_fadvise,
+	.fop_flags	= FOP_DONTCACHE,
 };
 
 struct inode *erofs_real_inode(struct inode *inode, bool *need_iput)
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index e981e371d..19e6051f5 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -512,6 +512,7 @@ struct z_erofs_frontend {
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *head;
 	enum z_erofs_pclustermode mode;
+	bool dropbehind;
 
 	erofs_off_t headoffset;
 
@@ -1807,6 +1808,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 	erofs_off_t cur, end, headoffset = f->headoffset;
 	int err;
 
+	/* Avoid repopulating a prefix that dropbehind has already evicted. */
+	if (f->dropbehind && !backmost)
+		return;
+
 	if (backmost) {
 		if (rac)
 			end = headoffset + readahead_length(rac) - 1;
@@ -1836,7 +1841,8 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		pgoff_t index = cur >> PAGE_SHIFT;
 		struct folio *folio;
 
-		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index);
+		folio = erofs_grab_folio_nowait(f->sharedinode->i_mapping, index,
+						f->dropbehind);
 		if (!IS_ERR_OR_NULL(folio)) {
 			if (folio_test_uptodate(folio))
 				folio_unlock(folio);
@@ -1860,6 +1866,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
 	int err;
 
 	trace_erofs_read_folio(realinode, folio, false);
+	f.dropbehind = folio_test_dropbehind(folio);
 	z_erofs_pcluster_readmore(&f, NULL, true);
 	err = z_erofs_scan_folio(&f, folio, false);
 	z_erofs_pcluster_readmore(&f, NULL, false);
@@ -1890,6 +1897,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	int err;
 
 	trace_erofs_readahead(realinode, readahead_index(rac), nrpages, false);
+	f.dropbehind = rac->dropbehind;
 	z_erofs_pcluster_readmore(&f, rac, true);
 
 	/* traverse from last to first for best metadata I/O performance */

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

