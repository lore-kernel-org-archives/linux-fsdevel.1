Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9593480340
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188667; cv=none; b=GotSVD4ydoeTtSZpcwKBOd7D83JdFT/1GDd1DwmM9r92CwYF491Qnd7kCDsmqjg5cPwoeVuAhoV+kbGcOmfLI0pkXth9RAPqOSU8xuyNHP7FxTtLsPqB0gPNUBIDkOqucxqiIi7gz0HsUjjNfMHOrrxVc7B33RdhKdAqSPiYhk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188667; c=relaxed/simple;
	bh=q0QaQO++/PvA1DQe3ls4tZMPt5G9WPx1L4vtJDSJKXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMZ+bgyZJKcM3d7PySAV1IL56nXMXzkl+jAqDnHDlWeVOaVF669vjHIs3D2Enc+BWRL7MCDfqRx6hRYpkPeSfmzpM85nv2/2RtEThH7eHhlCb/5e7orq3TQWfLRxMO53Mhewad95J1z7lhADm/h2j6WWheHfgEowSpDtwx9+izY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEYKhaYs; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEYKhaYs"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7c2fa14795aso23215157b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188665; x=1779793465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SyXZe52KMUC2ic8Hq1mf3+02KbtP8Oos7zC9gOb7ro=;
        b=pEYKhaYsNiVrS6Uxo+j/UGT2ja2e6nG2yFksFP1d9amf3RJMXjRgR3CQ3sx5oxEj+m
         ZQ6iw5dAlsv2pUMqI6wE09y7B2jtT322nEypKsKLTizHbEex/YBhvhtBkhSmaNL1W36a
         Lvz/3QoTi6I0o1J77DwgH+4rDx/cXbwJybgeG0uCzMdJMViNVxqkvz05qpoHmoVagEqq
         tigosddlt6xpJwkxy3eY+TgpfTGPgaEhoWpoS3VmMEW/ArZJaKhFFBc4p3vsqezCNJXA
         BhceQ4h5neSKiYNGizFpsLMBVz05rb4qsZ+7KCYHRdh05xnAl+irMf7m2GTkyxrhJYwf
         oJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188665; x=1779793465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6SyXZe52KMUC2ic8Hq1mf3+02KbtP8Oos7zC9gOb7ro=;
        b=girvxe24qdZ0ePQ9xY+2/qas+qh7urN+iawmy5L0soxeeimPjiZpHcdcIHc7jzP1Oj
         gc+cdBKc7weVdTygJRWitQmtaA0KXxZ7Mn2F/tgwQ9BghFWMeRW3t7AdLW4+wlDWqN/2
         2wRSWAiBJIgfKsvsaCt4HwBAs3Bj1kSn19S6O+/kuYAK2GSvaT86TDTADXOUsUyqr2xJ
         wZmmpk6WjJKKSDsshUI6e10AveWOhyeUVntx7yBedT/q8LXL5nLP2Nll4W7+9ZSRpAfG
         t0ns1y7SGYPxnpK3YECswMg5Uxr5tz3wN1DDKvh4Kx9PvHiUoJtct96CgT87SKLfCqFg
         ekkw==
X-Forwarded-Encrypted: i=1; AFNElJ/Plo8nYPYxsw3bX4s2aB+de1O3X+TgcyC8mgB9eWNPFkapA+Fd94uqjagf/ZMF/LsZNDAknu8R90QJhRh+@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfCq7y4/fiB7Xrt6RQMsgd3Pan86yaxMXCxzGrl2IuIr3ZaH2
	Q9MnL4In46Dl8naQPyWgr7J0czbrhTElYy9n4vXG+/UzfUboaoTpYWvD
X-Gm-Gg: Acq92OGpBpvrFf9IYCLjjYVTFLWYEjtXNs4AMLpxJRgG37ls3LKFqmf14oYnxdElKBl
	e8xPzvgC0F8jOx9J6/bI+NB04gclwYNkYbJSGRVjREo/ebKoUZigm5oV/eEMfiwQ/cWH38/DJNL
	rtdPhi26Uy7ti/DhkeN1+/vrK/uCQL0AVzD+Yi5Mo3nKgdWapElBG5/MusK9SYGLTerrY08FRuq
	LVEBkGxL7lmc3Spsg0hdnoMHJGX8HD2goVUa5Aa6RCNKZ5qusB+W5tnnROnw/BpXUVwOntBt8jQ
	CnxKDGKYo4EbYQd9t3S1C6F7nZfdOlyC2DPLkroKpHFWPlEII5Vy+bQzUKmxUNaEoYhgU1P1lgL
	CiRCCKE8eUnKFvbnBHWFz0OM/gNxCtvpui6I/JkO45IfdCFIkO/GeBtcsgAhOpP3DfDx3J1hkwB
	wILn8+3AObqWbYSJZYz7v40aPJxutnrPsk5wxPD9BUJBPob5e5bllpeJh0WbG/BB73hbJ0ssAcG
	0VXXFvVlnfmmBowAF1gf6VJZjWNpIE=
X-Received: by 2002:a05:690c:6c10:b0:7bf:107b:f859 with SMTP id 00721157ae682-7c959f7e881mr226344557b3.16.1779188664814;
        Tue, 19 May 2026 04:04:24 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm35206827b3.25.2026.05.19.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:24 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ocfs2: reject dinodes with non-canonical i_mode type
Date: Tue, 19 May 2026 07:04:02 -0400
Message-ID: <20260519110404.1803902-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519110404.1803902-1-michael.bommarito@gmail.com>
References: <20260519110404.1803902-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ocfs2_validate_inode_block() currently accepts any non-zero i_mode value.
ocfs2_populate_inode() then copies that mode verbatim into inode->i_mode
and dispatches on i_mode & S_IFMT to the file/dir/symlink/special_file
iops; an unrecognised type falls through to ocfs2_special_file_iops and
init_special_inode().

Reject dinodes whose type bits do not name one of the seven canonical
POSIX file types.  Use fs_umode_to_ftype(), the same generic file-type
conversion helper OCFS2 already uses for directory entries, so the
accepted inode type set matches the kernel file-type vocabulary instead
of open-coding a local switch.

Apply the same structural check to the online filecheck read path.
filecheck keeps its own error namespace, so it reports malformed i_mode
through the filecheck logger and OCFS2_FILECHECK_ERR_INVALIDINO instead
of calling ocfs2_error(), but it must not allow a malformed dinode to
proceed into ocfs2_populate_inode().

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260517111015.3187935-1-michael.bommarito%40gmail.com
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index a510a0eb1adcc..e149ccbdc03ce 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -13,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/iversion.h>
+#include <linux/fs_dirent.h>
 
 #include <asm/byteorder.h>
 
@@ -64,7 +65,12 @@ static int ocfs2_filecheck_read_inode_block_full(struct inode *inode,
 static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 						struct buffer_head *bh);
 static int ocfs2_filecheck_repair_inode_block(struct super_block *sb,
-					      struct buffer_head *bh);
+						      struct buffer_head *bh);
+
+static bool ocfs2_valid_inode_mode(umode_t mode)
+{
+	return fs_umode_to_ftype(mode) != FT_UNKNOWN;
+}
 
 void ocfs2_set_inode_flags(struct inode *inode)
 {
@@ -1494,6 +1500,24 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	/*
+	 * Reject dinodes whose i_mode does not name one of the seven
+	 * canonical POSIX file types.  ocfs2_populate_inode() copies
+	 * i_mode verbatim into inode->i_mode and then dispatches via
+	 * switch (mode & S_IFMT) to file/dir/symlink/special_file iops;
+	 * an unrecognised type falls into ocfs2_special_file_iops with
+	 * init_special_inode(), which interprets i_rdev.  Constrain the
+	 * type here so the dispatch only ever sees a value mkfs.ocfs2 /
+	 * VFS can produce.
+	 */
+	if (!ocfs2_valid_inode_mode(le16_to_cpu(di->i_mode))) {
+		rc = ocfs2_error(sb,
+				 "Invalid dinode #%llu: mode 0%o has unknown file type\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le16_to_cpu(di->i_mode));
+		goto bail;
+	}
+
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
 		struct ocfs2_inline_data *data = &di->id2.i_data;
 
@@ -1624,6 +1648,15 @@ static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr,
 		     le32_to_cpu(di->i_fs_generation));
 		rc = -OCFS2_FILECHECK_ERR_GENERATION;
+		goto bail;
+	}
+
+	if (!ocfs2_valid_inode_mode(le16_to_cpu(di->i_mode))) {
+		mlog(ML_ERROR,
+		     "Filecheck: invalid dinode #%llu: mode 0%o has unknown file type\n",
+		     (unsigned long long)bh->b_blocknr,
+		     le16_to_cpu(di->i_mode));
+		rc = -OCFS2_FILECHECK_ERR_INVALIDINO;
 	}
 
 bail:
@@ -1812,4 +1845,3 @@ const struct ocfs2_caching_operations ocfs2_inode_caching_ops = {
 	.co_io_lock		= ocfs2_inode_cache_io_lock,
 	.co_io_unlock		= ocfs2_inode_cache_io_unlock,
 };
-
-- 
2.53.0
