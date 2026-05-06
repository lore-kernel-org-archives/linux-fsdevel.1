Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC76494A19
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081938; cv=none; b=KWaJH2MgpBmVSLKeiRW02mw+gbzd2Ye/OJIDGDuCVH+zR/IPu4IcewixBCIQMwLioJs5rkB3STOxOuQvYD9pFAr4BQYJVv1mKrtAVjxf6piLdA6eCS+hp1BgURFXV1c9RnaZMzRt8Igf2VnVZjeAHq3W9kJOS0YtF2BLZ1JhVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081938; c=relaxed/simple;
	bh=JPyPxRNX+uB/owPL/LjSAuqbSPUmaQZDlWm+cum3d9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mY020RkDEKc6CUyRm1icBbdYYSFt/62tA2LlK05D8R5sfDjlpVFOcUAWRJZLtM03dL/d+rC6aEZvQhIgHipCnbCy9miVzi+flbCbSj/pZFBJsRZ+e5QrLt7+FbEP5Z5WRmbdfmK5BVccVMVyr5sU20tjNeLtOXqtqVx2oHn6cpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVmsCZkT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVmsCZkT"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c629a31d1d0so269701a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778081936; x=1778686736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OH4ziShIB2nW4667aVLH1Ypp1Iy/26GAj5mx4eXCQA=;
        b=iVmsCZkTW1HfWkl3+Bnv3809k3rF7mX4x0Cf2z3RUa7gHUx5La+uqKdVRjTNHvqHYR
         VjSkaVEF8e4LSsSnxGb+8kmH/981QtHNXJDw/sGZNgZD3oyT24W6Yd0yfBdrH+i/x+g1
         7TrenUAyXrj27S4rsqmqtr/FF4i+3TbXGZE1I7OnLSW/SZBTX90MjuDLj0S5Unl4DBbc
         Dxega2bEzKKskDCKUPKfKTdAzPrbjs6eF95+lBW4DOxPwRwIbc827SlZWCUj25GAm2Qz
         z9Jw2d9Frle88j8ghkgqSgaeN9MzO9QM5DSTBGEmqlqb8z7FUgAC3HP0AFbK/6dRprym
         pxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081936; x=1778686736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OH4ziShIB2nW4667aVLH1Ypp1Iy/26GAj5mx4eXCQA=;
        b=jPTCTIUMRQDUCFbK6B1EYWysEIKBsJCndx9gZz5trxGtufL0WLOp4K+hgX4BEqSbnz
         OZ5DLCkSb4mC+eIR7yVNrSWIAkY7+Is8IwJcH1GkRfM+BlvRiazaWxjcl3FfhecAMfPY
         bsUVXJlhoBGzkckEm9pvCNcBSWhChSNT01DHva010oAw66baJd8fw2bp8OhkcuN6pL9d
         2ap5SV7QEgH9XzIkXpYoQ50DPJbq/fZVPSk108y3brStb8/yfYDs9StZHWBNHb5cT+Vm
         uTADYnn31tLzsDkePkB7F9yWGISCaCga4VwR+6SOrsvZX4CfIXZXzZnkzRTY9Vy6fJDv
         CBGg==
X-Gm-Message-State: AOJu0Yy4uZaZ/VzTo3AVqeaxEmcipmsZNmf/wlHkb0P0ISJZPxGK1gip
	HHv7KqtoDON6WN0g0MHmJquTcGAy+wnO1yjJhO/Q/9PaItFL3Uz+yQp5YiAY4Q==
X-Gm-Gg: AeBDiesTaZuBq2is/42gcjdxwvRsh3rPHU3c9PLg0vLMsMdr27/XthHuhuJ8R2mMZcn
	AqzE6CgfrcOcL7Ls86AK1HwXbDrEdVBQayE5v53z/mVK/b3dc38zSAguXOvrSJbrHl361+KCF5H
	QnmfJ8eNFyDW6ypT2xTs1ISizA6HeuWQi50w/EK8MEFIhD9uiDl0o6UPJMZ02XIpYaJyD5UzF7K
	qa9dOrOd70mvyb+6E6yyRgN4okWlJdh3hQfm1U9Hm2bC8QIpc7v1gfiL9BY3OcAqiNUgm3baTBJ
	fDO3R+hkcNGGZZCcp5hP28VM+20DAJ9ZrQMoFBac4FBeLHTuBe1mGSRcqIENwYJJqrItn0WaUvb
	sQfHLtWYjxtePDPLKC59y+w25vh/NoDQb6qqTR4OiyOsnGSUOgu7acbIvHHklIkvHpryfxSI3XF
	mFwL5BW5Dve5pS2S31vWT2FVJJGjk=
X-Received: by 2002:a05:6a00:2e86:b0:835:3611:848f with SMTP id d2e1a72fcca58-83a5844836fmr2087282b3a.0.1778081935707;
        Wed, 06 May 2026 08:38:55 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83962e7e3fcsm7412871b3a.0.2026.05.06.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:38:55 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: fix out-of-bounds write in ntfs_index_walk_down()
Date: Thu,  7 May 2026 00:38:50 +0900
Message-ID: <20260506153850.774060-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_index_walk_down() used to update the index traversal depth
directly before writing parent_pos[] and parent_vcn[]. A malformed
directory index with too many child-node levels can therefore advance
pindex past MAX_PARENT_VCN and write past the fixed arrays in struct
ntfs_index_context, corrupting context state used by later index
traversal.

Use ntfs_icx_parent_inc() for walk-down transitions so the existing
depth limit is enforced before the arrays are updated. Make the helper
check the limit before incrementing pindex so failed callers do not
leave the context at an out-of-range depth.

This is reachable by iterating a crafted NTFS directory after the volume
has been mounted, including read-only mounts. The reproducer uses
getdents64() on an index root that points to an excessively deep chain
of child index blocks.

A crafted directory index with a chain of child-node entries reproduced
UBSAN array-index-out-of-bounds reports in ntfs_index_walk_down() and
subsequent KASAN reports in ntfs_index_walk_up(). With this change, the
same image is rejected with "Index is over 32 level deep" and no KASAN
or UBSAN report is emitted.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/index.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index a547bdcfa456..35c4eaa4e394 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -677,11 +677,11 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 
 static int ntfs_icx_parent_inc(struct ntfs_index_context *icx)
 {
-	icx->pindex++;
-	if (icx->pindex >= MAX_PARENT_VCN) {
+	if (icx->pindex >= MAX_PARENT_VCN - 1) {
 		ntfs_error(icx->idx_ni->vol->sb, "Index is over %d level deep", MAX_PARENT_VCN);
 		return -EOPNOTSUPP;
 	}
+	icx->pindex++;
 	return 0;
 }
 
@@ -1970,6 +1970,7 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 {
 	struct index_entry *entry;
 	struct index_block *ib;
+	int err;
 	s64 vcn;
 
 	entry = ie;
@@ -1979,14 +1980,20 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
 			ib = kvzalloc(ictx->block_size, GFP_NOFS);
 			if (!ib)
 				return ERR_PTR(-ENOMEM);
-			/* down from level zero */
+			/* is_in_root implies pindex == 0; move to the first child level. */
+			err = ntfs_icx_parent_inc(ictx);
+			if (err) {
+				kvfree(ib);
+				return ERR_PTR(err);
+			}
 			ictx->ir = NULL;
 			ictx->ib = ib;
-			ictx->pindex = 1;
 			ictx->is_in_root = false;
 		} else {
 			/* down from non-zero level */
-			ictx->pindex++;
+			err = ntfs_icx_parent_inc(ictx);
+			if (err)
+				return ERR_PTR(err);
 		}
 
 		ictx->parent_pos[ictx->pindex] = 0;
-- 
2.43.0

