Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A553655EC
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621680; cv=none; b=IGsvZ/gblb8HZdgpVZ7QiOrI9p1vt6zw68zkA4oBVP8UoKwXDspoTgEwvHjG/r67xfmnnSUscw1/knHsmvyFA7LBhREn7r7SYoioPaHDKBsDHI25F0utbXiKThzrtZGeuA4dVT1DQKDJs0cDZX2DVeNER7RwXtb4uWm6X5KjaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621680; c=relaxed/simple;
	bh=nTKqFaIO4eWueECCBUw01WYSenLBpxO8tTFhLp4DI8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh5puGt72hYp1aTw5D/6CihNaoFAixys1nyN0+Z0O510xqhAhNyeIbx9R/z6OTtacwo8Jip/Vru5d+3hl8iFswPez1vWb/kXdf/aoWII8erv3VCa203A1TFLRmcSK/DfYMDsqJvOP5lrkTAp8Pd/aTfZSeGD6dFkPZ/toWN8K3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhZDp/RP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhZDp/RP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-80e2cfe6918so23432817b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621678; x=1786226478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Vy4j4aElKFiT0ILAbTnwQA9DPnzOxaRGdQq6jv8GAw=;
        b=mhZDp/RPeORtxayAJxHijgqC9qNm90l4P6i0Flu6B7+HSOSH9Agxm2V6wYLOoQTrxS
         TddmwBfvofGm3zZ83wrO+BuGkV51HHmPYQv+Gvbfp8vetuZqreaUE2SPC4Cjwt4MDuUX
         sYimmrLQBHLWYLIN1uL/WwC6+WlHx0JkxFef/66FFooATqEJUxAHq//26qs0cEoktsJi
         P3lirHZ5MpcYubzWfmwIMARnWO/BTaamaDt+UTffZUKqut3/LvaYvA/Nz+7YWDxiIooE
         4NVEf7NPoH8VMlHeBcL8xlFuIvS7HCwrBohWIEB3edibmaVdm6fmYlgwEzhajtEaUTXV
         NkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621678; x=1786226478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Vy4j4aElKFiT0ILAbTnwQA9DPnzOxaRGdQq6jv8GAw=;
        b=agbMvQInwkhK20J8qQLdFEg8zSRqZ+2nA9o1F80K64ORRpi9u8iP9JWwthl/sFQNgq
         GNaKwSo1ubzKgWG2fRbPtKzTMvDqr9zaeivPgRdKAWO+whfcgfLedljPjMHI4er2A8Qv
         1YGeYMD42byn1pBCDeNNHzvjoGOc91S2OSTMfodiq4HwpM91zWbRcheAPsUHS3YWw8n8
         kYvfD++FsQmBpNQtpRN7Bz819nHRb84CXSt+hzaiSO3NPMHHNVkoVn/PgP2RN16YHgD/
         TAxDo1OI3s0WPWBBrWr/p+GejNCXN4NP8ewrke0cnNDIsFBLYxwq6KpiDnvKSDf7/JKh
         GkCw==
X-Forwarded-Encrypted: i=1; AHgh+RqvaqaALgRMt6VJqzTHP74Qme8S7KMMe2290+O9x/8AbChtLO3CeNmhSxQUdtZ/vYKRqIL5Vjo6x2QYn0IX@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAeCCtNbrLK4/q4klvGscaFki56w8/bEtj3dy8Yger+DkToY3
	zQZKOYYTGxtnnSuLuMMnFlzRHeJkTCGHre8uFvpvaZELGK2YoSbt5sZc
X-Gm-Gg: AR+sD11axi9nWktZ4zzu2F7rxoufMBF7kDS6d0l7lEnRAB7rZKTO6SUW/QKmx57ePkQ
	okDcxBbXospf4WhIi24Bd4eJxzXYHmTa86cNY1sDIruoyVjynytpqy4m+G0MC9z022VcJZ91I1S
	6ew4CKf8sTqPJIdPZKShNBVftwHOHQTpmiWm5sQ/frIJ3nOugkeAPKdmq67ZLHSRxbXf4peBsIX
	cUw1aNoBjeenYFbsLQUYOyb6E/eewFvsgxoOiQCBtx2Uu86Pu23mNF9Eke60SwdJijManqh231A
	+HnWGLyM0GKq8UEJ7AyHjOSpZ1OAcOapTbnsFGQZ/VPsT9mldqW3EwvsPc8fRR9cARF6AUwqiuT
	VoS+UmHn3FVtGIM1ZodYFgZXX+IqsaydZeDX0bx9BdQFqK6kx8f5BKkbglelytMcZrxycOqBswD
	/3LmylUcwGW5weU1NM/jVkUT6MAHQEum+tulX50JX4mtc+OA44FIWSGhLnXsgSQvQaFkJN8iYRe
	rzcu78=
X-Received: by 2002:a05:690c:4442:b0:81e:c972:e8c3 with SMTP id 00721157ae682-81fd4ba85d1mr75578147b3.29.1785621677847;
        Sat, 01 Aug 2026 15:01:17 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:16 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-karma-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>
Subject: [PATCH 06/19] buffer: detect metadata write errors with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:50 -0400
Message-ID: <adebc1e3de48c3e997057d10cb78756dec03b800.1785621505.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785621505.git.coshi036@gmail.com>
References: <cover.1785621505.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both places in this file that report a metadata write error to a caller do
it by testing !buffer_uptodate() after waiting for the write.  That works
only because the write completion handlers clear BH_Uptodate when the write
fails, which is what this series is removing: a buffer whose write failed
still holds the correct data, and saying otherwise makes callers rewrite,
re-read or WARN over a buffer that was never wrong.

BH_Write_EIO is the flag that actually means "the last write of this buffer
failed", and both handlers already set it via mark_buffer_write_io_error().
Test that instead.

No behaviour change: today a failed write through bh_end_write() or
bh_end_async_write() sets BH_Write_EIO and clears BH_Uptodate together, so
the two tests agree.  They stop agreeing at the end of the series, and this
one stays right.

In __sync_dirty_buffer() the flag also refers unambiguously to the write we
just issued, because __bh_submit() clears it when it resubmits a buffer for
write.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50a63d964815..ac978d9090c2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -618,7 +618,7 @@ int mmb_sync(struct mapping_metadata_bhs *mmb)
 		}
 		spin_unlock(&mmb->lock);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			err = -EIO;
 		brelse(bh);
 		spin_lock(&mmb->lock);
@@ -2743,7 +2743,7 @@ int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
 
 		bh_submit(bh, REQ_OP_WRITE | op_flags, bh_end_write);
 		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh))
+		if (buffer_write_io_error(bh))
 			return -EIO;
 	} else {
 		unlock_buffer(bh);
-- 
2.43.0

