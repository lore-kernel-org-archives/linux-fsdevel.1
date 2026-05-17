Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7336166A
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016242; cv=none; b=DP5fuhAKO8dRSTFDWElNIlrv4kKMNYS6pypbDubEIzy/G4TTatU0j9jK5//zjNZ/utEX3Vay+riTSoeIDBJkSI51Ve7laRpNrVSiA83W7gPc73KvrUeJRONu+DmNVe6eYGs4d3kTjdwBh7WGLaYFDxw3PBK4BDyoN4nreO3VT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016242; c=relaxed/simple;
	bh=+BSdzo13XZQuvp/wIYzH8e9IUezizz0p0fekzWmT8+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9Y03MFGmHhnSH3WyOMXg7pS/Urm3/bgrff5fMw4O3h6HDhE8/6Z9yaeD51QTUDQwkzjw1eCo6bDkVCKDQUm9l/mwZUBDsRZgQkaUjY1BOVbVcnUx9NzcLYyq13P/NIMEbAfa4BupiIwweKmCR00zz4mMpgRrb0d9dilswbzJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek3zJIdJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek3zJIdJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d75bfb259so8551071cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 04:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016236; x=1779621036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lADOBMRjpA9lHPB2reV9gREFqcmYd+mh1OlNIA4DhzU=;
        b=ek3zJIdJBN4z+eUzM7OvtKijFrdAVHZ5YohPeRvEqw/zILwoTN1QsCNFzOA8QSLl/Z
         8myFm0BDto5L7+nIRr9DFDz+cGyVcyOgWS+QyNBJXMvGzcRsnxRfbsBfj31jYGWGzvjG
         c1fChLSpLiyaQpvMr7VUm28ib8AcoMQ5smSBTJS+wezhl/nQ2iyBH2I88TmvWX1g1pFb
         kC6iggsZaSkCGnCsG7Oi+2HblSj9gseSzfPw6fQyVE4EPtKyeyBjeSd4BUar35GT5c/e
         fcFXPWRBFVBUfGxPRXB2OGE0fmDahKTLT1SfRiuIE3PNVT+ZBHwt+85+J0F8O/oGMkG4
         B6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016236; x=1779621036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lADOBMRjpA9lHPB2reV9gREFqcmYd+mh1OlNIA4DhzU=;
        b=aaiIwoatX3klFVD6BQVnBJgZi5i6RzlVN+gfpXaMOlziRdcSHRlVLCUcg10drm2tBj
         H7M45aaOvLDRfCC7MaL5CuBeQiKJeTmpQMBAo4r+eP4RFMJS4x0qgCMwmJLBjdmiUeW6
         YI0SgaZ0yobn4VTt41bcGi1ddRU8QohG63XfqRb4GRvt268JYHsr+7kD+Ym9rlqRD3No
         vwXoUR9iCXiWy4BdnocFOH0vnH8ikD0yFtrwv+VawiJqw5A3gAQBuxxz2TgZ9CIsc4pT
         fnVfZeP86dN0BOHGzAXsBbBzHsCtUaM5+IFiFJlPoHF8UtxQuPzX1y7Nno7vB2XmMCsg
         lNlQ==
X-Forwarded-Encrypted: i=1; AFNElJ96++gVO/1xt5OoHGbR6q+R0pd5YkQWycsn95UC9pH/mr5QyRh1PFkJlU+3JgL4XHDIQ7Oy3SgXxh+7sgDo@vger.kernel.org
X-Gm-Message-State: AOJu0YwEl7URTidEzzZ5AwhaiAbukdMSXoZIT7OijPeDnKlRpNZc3hqD
	P0MG+icQYanyZ6SQ4K/hfekSzAMJj4VgIsSU21bmGQWRqjP3Iw4h9NfFHcScF+pi
X-Gm-Gg: Acq92OGcLlQIYqlDOweD4/6tuUOSg3Glw39uBag85hPlbWpnA6NRFicO/LWKJwXkMuq
	ueL1V7Vr8Rp5evfKI2WC6av/yZzWbLh4FSMnN2RYB9T+TTgH+ly1JBDS/JznVbyvUPebXYVqcVW
	qgIn77lE2/KU24X8MvtZC+4qmoBOH0SfgyKiu7ABrPw2AldG2bTeuSNw16+OuQLa3ZgGr0gl1nB
	Ke3DR0meEGA12ft00xoGAfUCzHtKsf1mqvzs+YyeAvdDwCCTIMfDRb3/3LqM7cMFOybv5jamKn/
	UOb0o1tBOibZXEyKBFT7C3AT8IrRU90nfsah15OzxSh7BsnS14BQ3sqI1tZ3Ha+HxYdeE7OrHGL
	mKoq54JwTVytzjS1I0iwJsbwWQQ8ngSmeJHgexiC2TtL9Wdm38dWCbu7E1QczwnZj2tBJu/ks5P
	F6iaORUWj6A2YxyOTFfDi151F30FBoSZLFSmajdzcSzeuj/mvrWeoY5gsKM3L1WTm0QJlt2trQC
	fZMz+Y2hGITjmV8t/Ydw61IWRLtmJCLqCkkqZjlN6bF07fecczk3g==
X-Received: by 2002:ac8:57ca:0:b0:50d:89bc:f450 with SMTP id d75a77b69052e-5165a001072mr179709841cf.11.1779016236025;
        Sun, 17 May 2026 04:10:36 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm100306651cf.13.2026.05.17.04.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:10:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ocfs2: reject regular files with non-zero i_size and zero i_clusters
Date: Sun, 17 May 2026 07:10:14 -0400
Message-ID: <20260517111015.3187935-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517111015.3187935-1-michael.bommarito@gmail.com>
References: <20260517111015.3187935-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On a volume mounted WITHOUT OCFS2_FEATURE_INCOMPAT_SPARSE_ALLOC, a
regular file with non-zero i_size, zero i_clusters, and no
OCFS2_INLINE_DATA_FL flag is structurally malformed: the extent
map declares no allocated clusters yet the size header claims
the file has content.  ocfs2_populate_inode() copies i_size into
the in-core inode and dispatches to ocfs2_aops; subsequent reads
or truncates then operate on an inconsistent extent state.

This is the shape an attacker who keeps the rest of the extent
list intact (to satisfy the inline-data, refcount, chain-list,
and per-field validators already in this function) would produce
when forging only the inode header to publish a synthetic file
size on a victim node.  It is also the shape on-disk corruption
of the i_clusters field produces.  Reject early in the
validator.

The check is restricted to non-sparse volumes
(ocfs2_sparse_alloc() returns false).  On non-sparse mounts the
allocator path always grows clusters before i_size:
ocfs2_extend_file() takes the !sparse branch into
ocfs2_extend_no_holes(), which calls ocfs2_extend_allocation()
to journal new clusters first, and only then
ocfs2_simple_size_update() journals the larger i_size.  The
truncate path likewise lowers i_size in ocfs2_orphan_for_truncate()
and then frees clusters in ocfs2_commit_truncate(), which uses
ocfs2_clusters_for_bytes(new_i_size) as its new_highest_cpos:
when new_i_size > 0 the floor is at least one cluster, so the
on-disk dinode never legitimately exposes a non-inline regular
file with i_size > 0 and i_clusters == 0 on a non-sparse volume.

On sparse-alloc volumes the same shape is legitimate: an
ocfs2_extend_file() call goes through ocfs2_zero_extend() +
ocfs2_simple_size_update(), which grows i_size on its own
without changing i_clusters; a freshly truncate -s 1M of a
sparse regular file is therefore on-disk
(i_size = 1048576, i_clusters = 0).  The check therefore opts
out via ocfs2_sparse_alloc(OCFS2_SB(sb)).

System inodes (OCFS2_SYSTEM_FL) carry their own size and
cluster invariants validated by the allocator, journal, quota,
and truncate-log subsystems; skip them here.  The inline-data
fast path is filtered separately by its own dedicated branch
below: its well-formed case is exactly i_clusters == 0 with
i_size <= id_count.  Symlinks legitimately keep i_clusters ==
0 with non-zero i_size (fast symlinks), so this check is
restricted to S_IFREG.

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 305e22cc9b1d9..c63d2ced6b338 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1571,6 +1571,47 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	/*
+	 * On a non-sparse volume, a regular file with non-zero i_size
+	 * and zero i_clusters that is not marked as inline data is
+	 * structurally malformed: the extent map declares no allocated
+	 * clusters yet the size header claims the file has content.
+	 * ocfs2_populate_inode() would still publish i_size to VFS and
+	 * leave the extent state inconsistent for any later read or
+	 * truncate.  This is the shape an attacker who keeps the rest
+	 * of the extent list intact (to satisfy the inline-data,
+	 * refcount, chain-list, and per-field validators above) would
+	 * produce when forging only the inode header to publish a
+	 * synthetic file size on a victim node.  It is also the shape
+	 * on-disk corruption of the i_clusters field produces.
+	 *
+	 * The check opts out on sparse-alloc volumes, where the
+	 * extend path (ocfs2_extend_file -> ocfs2_zero_extend ->
+	 * ocfs2_simple_size_update) legitimately grows i_size without
+	 * allocating clusters.  On non-sparse volumes the equivalent
+	 * path (ocfs2_extend_no_holes) journals clusters first and
+	 * i_size second, and truncate-down floors i_clusters at
+	 * ocfs2_clusters_for_bytes(new_i_size) which is >= 1 whenever
+	 * new_i_size > 0, so the rejected shape never appears on disk.
+	 *
+	 * Skip system inodes (OCFS2_SYSTEM_FL) and the inline-data
+	 * fast path (handled below).  Symlinks legitimately keep
+	 * i_clusters == 0 with non-zero i_size (fast symlinks), so
+	 * restrict to S_IFREG.
+	 */
+	if (!ocfs2_sparse_alloc(OCFS2_SB(sb)) &&
+	    S_ISREG(le16_to_cpu(di->i_mode)) &&
+	    !(le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL) &&
+	    !(le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) &&
+	    le64_to_cpu(di->i_size) != 0 &&
+	    le32_to_cpu(di->i_clusters) == 0) {
+		rc = ocfs2_error(sb,
+				 "Invalid dinode #%llu: regular file i_size %llu with i_clusters 0 and no inline-data flag on non-sparse volume\n",
+				 (unsigned long long)bh->b_blocknr,
+				 (unsigned long long)le64_to_cpu(di->i_size));
+		goto bail;
+	}
+
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
 		struct ocfs2_inline_data *data = &di->id2.i_data;
 
-- 
2.53.0

