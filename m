Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA040DB22
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967778; cv=none; b=f9+Z+kTFRep2REVsYq3vmUnyirr4R+FaUCy7MculYxfoo1g0DLFnvhGaaOnziPOp6xNqEdSHMpoRyBtkouhj3/OUhK6k9DjrmoH2OXgqGTrDdhVJVu8D0H+4c5Q5P5ZRDRC9bXCtFN+tc31cwII7YdV3kxNbaE5d6m3jiyp7erY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967778; c=relaxed/simple;
	bh=dTf0Tz0X4VVHgkG9msuKEzTghe8BHrC1N9I4A1dE7dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIGT83nDEOA1d4pEq9798+rcPDD/B/+SipyIfy5T36B6nyAM2qNDGst/bJRfshncd7yiXJVSHH0xgYk3AOC+o5Qb0H5bSX1/332/jond3CKCa/xXyddhBC5PotR06wnRcUOqtMHsn409PVlsrx6tzv7L4EhqgImp3jo+ZZd98lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfFCXAta; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfFCXAta"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso3255435b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967777; x=1787572577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yavRK7ZC/YlJzzUQXee9HV5ifkhoLGmP6A7lwIfErD0=;
        b=WfFCXAtaLRZoLbPTDmhhyMvwIHX31JNzTevjuRuQ9yqHs61X3SVhbXv4IWNIk8WuxX
         3SFWHibaSPEJ8Aywc2VA8eSzHwyvlbdnpVUf40dEpdixqEgKUisJDlJOXGSnBafibsrD
         dzSiWG2qnmLvQCeGNkEMoIrzWpdza/CVLsa8cF/xq4xGZmDpOq8Gej3vCpncEjzV/hYs
         qrxULH/spZM9oQ4TuwgZQ0pX6VS27yBB7gD09YHoSQCRrPHO191+Sqd1hP7Jzd5NlhZA
         ARNn2NVOhXzBFddgqJTsitkQWh0pAUZhWnbRAnDW3la+ip6H523uxRpM1JaJ2mo2sG7u
         xljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967777; x=1787572577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yavRK7ZC/YlJzzUQXee9HV5ifkhoLGmP6A7lwIfErD0=;
        b=n4duhhXCQSGvf+cdM4TErv5JjTKfTso/GuLFhx4nxFGyWDpf+JTMs2I1E9s6AyWrRD
         6pqo8Qw9t1XpeGPwyav1v7yHUgd1YHDT7XDO6hS767dlnNQ9bqjuUSC8y8NGKCoFCsrG
         tI228fMTePnWm0lc0ps1+61E/cqAN0N2JIw6j/Z05IrwWDSeXKglif/7akKJSUekGX7N
         hUiopmRl1BAHgGRoCm1vhM0mF6qJsqAwntFReU4QLebbg1W3auGIFiL5VpfTXJHvo4tk
         gUWBBV8PPbfR/A0mJVrcTNmF2DjY+WWxm3IvKsZ/1anOIn6kSFYkmikHzlxmJazxvAZq
         VrJg==
X-Gm-Message-State: AOJu0YyxsX5e7934I7I/rltHis3CrY3zoEUnEbG8M+mP+CRHSMtWi3fN
	ZX/A9HleNe85OTo+fAvAAAg+kCsFwVHvVf5Zig/ubzA4fRfkrUHJV8xOLmA/+C65Udo=
X-Gm-Gg: AR+sD12tuXIrBEIEjvhFFrfm+fT+1t3CWTncmTpjv0JgxVHpXelUnEr0c6PxTlRoO79
	ukraWtYF4i/eyS+9FHlLWL7kt0VJeaJSg4N9SDhZzlR07eMjaDEwyB7Z0/Zo2F61J32D07JDKC+
	dFhQUnNikwPI1P6AZWlUej6QBK8NzHxuhfKICgP1zJt6dt6zsQyEm+zAX3ulJwYWLvV3I82jQ7M
	7l1DEiukYFZk3U82JZ2tNQmawlbTK4CFXbl0pPVGsSaUQM1W9uGptfdMtwqYnhBUabNXnQlkPkk
	IsLG7LUSYd9poXUEWe43MMJYwvhNV2rzthlC8T+E85B+UI9uH764HRFEu5IRp1unQUfocNwL4Hs
	7eoYWVEU64ykDy9C36tYfhTMJT5ThrRsdSnNOsEcIurHuZxS10YMWPqr/kpbTYWAqbnSo2iZQ9K
	Jq5jnzjMVDn65/7nN9/PCrDS2fgYg3bGBg5mE/+ESkvd6DyCv4/7GMUKIFTMiQnNoasCdjB7uPu
	w1Eww3KB7C78apQk7y/FBAkHkKrcvdMvGDmVIPNCXleoCp9BDEi20+QCgPEzmyTqQDPFadG3O1d
	c70EMx58+ZVD7g2o3AowIKpyUAPe0rSTLOY0f+46ewEPrENZsgLR
X-Received: by 2002:a05:6a00:f8b:b0:84a:2e5f:d69c with SMTP id d2e1a72fcca58-84fde396e23mr26704239b3a.32.1786967776615;
        Mon, 17 Aug 2026 04:56:16 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6f8cdd1sm161099b3a.36.2026.08.17.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:56:16 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com
Subject: [PATCH v3] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
Date: Mon, 17 Aug 2026 19:56:09 +0800
Message-ID: <20260817115609.3586664-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817115609.3586664-1-matthias.goergens@gmail.com>
References: <20260814082326.3756669-1-matthias.goergens@gmail.com>
 <20260817115609.3586664-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On success FIDEDUPERANGE reports the requested length in bytes_deduped
even when the filesystem shortens a destination range and deduplicates
fewer bytes.  This predates the VFS hoisting of the ioctl (the btrfs
ioctl behaved the same way), and changing the default would change an
ABI that deployed consumers such as duperemove depend on: they advance
their offsets by bytes_deduped and expect the historical semantics.

Add a flag to opt into the truthful behaviour.  With
FILE_DEDUPE_RANGE_REPORT_PROGRESS set, bytes_deduped in each
destination's info is an advance hint for the next call on that
destination:

- if status is an error, bytes_deduped is 0;
- if status is FILE_DEDUPE_RANGE_DIFFERS, bytes_deduped is a safe
  advance step: one filesystem block, capped to the requested length
  so a sub-block request ending at EOF cannot be advanced past its
  end, and falling back to the requested length when the top-level
  inode reports a degenerate block size (stacked filesystems);
- if status is FILE_DEDUPE_RANGE_SAME, bytes_deduped is the number of
  bytes actually deduplicated;
- in both success cases a zero value means no further work is
  possible.

Unknown flag bits are rejected.  The flags field shares an anonymous
union with the old reserved2 name, so existing source keeps compiling
and the binary layout is unchanged; old kernels require the field to
be zero, so new callers setting the flag on old kernels get -EINVAL
rather than silently the old semantics.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matthias.goergens@gmail.com/
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/remap_range.c        | 25 +++++++++++++++++++++----
 include/uapi/linux/fs.h |  5 ++++-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 26afbbbfb10c2..ac88a81c12739 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -503,7 +503,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	if (!(file->f_mode & FMODE_READ))
 		return -EINVAL;
 
-	if (same->reserved1 || same->reserved2)
+	if (same->reserved1 || (same->flags & ~FILE_DEDUPE_RANGE_REPORT_PROGRESS))
 		return -EINVAL;
 
 	off = same->src_offset;
@@ -551,12 +551,29 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
 						    info->dest_offset, len,
 						    REMAP_FILE_CAN_SHORTEN);
-		if (deduped == -EBADE)
+		if (deduped == -EBADE) {
 			info->status = FILE_DEDUPE_RANGE_DIFFERS;
-		else if (deduped < 0)
+			if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS) {
+				u64 step = i_blocksize(src);
+
+				/*
+				 * Stacked filesystems (e.g. overlayfs) can
+				 * report a degenerate block size here; a
+				 * one-byte step would only misalign the
+				 * next call, so advance past the whole
+				 * request instead.
+				 */
+				if (step <= 1)
+					step = len;
+				info->bytes_deduped = min_t(u64, step, len);
+			}
+		} else if (deduped < 0) {
 			info->status = deduped;
-		else
+		} else if (same->flags & FILE_DEDUPE_RANGE_REPORT_PROGRESS) {
+			info->bytes_deduped = deduped;
+		} else {
 			info->bytes_deduped = len;
+		}
 
 next_loop:
 		if (fatal_signal_pending(current))
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bd87262f2e349..471f698beaa93 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -178,13 +178,16 @@ struct file_dedupe_range_info {
 	__u32 reserved;		/* must be zero */
 };
 
+/* flags for struct file_dedupe_range */
+#define FILE_DEDUPE_RANGE_REPORT_PROGRESS (1U << 0)
+
 /* from struct btrfs_ioctl_file_extent_same_args */
 struct file_dedupe_range {
 	__u64 src_offset;	/* in - start of extent in source */
 	__u64 src_length;	/* in - length of extent */
 	__u16 dest_count;	/* in - total elements in info array */
 	__u16 reserved1;	/* must be zero */
-	__u32 reserved2;	/* must be zero */
+	__u32 flags;		/* in - FILE_DEDUPE_RANGE_* flags */
 	struct file_dedupe_range_info info[];
 };
 
-- 
2.55.0

