Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3752D3CFF65
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785621695; cv=none; b=CMjb1uWbzJnyk2yPQv/YjHwCgKrrrwhcFWmV+MuJfV1W4Skz3Ip17YcUg7DoV3EMGRtvozyTY553hiy8nRsxrXSrTgJbzHme+/FL5D8SoTEW+yw0ADi0w+QvgBSo2q16AZBBqCttmudDWq4pma0Wbh1JOfvKpTgJx8f3zCnLxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785621695; c=relaxed/simple;
	bh=3dsw1Zg8M5wNaCMh6F9jO6eXBuRivbQ5EiuJWZtmA2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk9jz39aVgfDI9iuAuYrhvVpDylBrXrQ29xJypJbEAeOwqTWUXZC4qJ3B4pXDR+OpCclwZ4FIn5+x+pd20yEv0AKsG9xGHmTDyfoYJg2sk21b8KMKMv+evDwOuUvcJQItBAx9DiLR3+SSha70KimLqGWUkCNqK0EJ5YBH66R2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIdtbZ4O; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIdtbZ4O"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ed073fed0so31937747b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785621688; x=1786226488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/DniCfidRbKUpj3g8JSrdbI5dITb8OPbOoquygm/08o=;
        b=jIdtbZ4OTSOT9OPvleuuFCF4Pc38X/ywxPMR3t6kTu5fvOjwuri3CWPIDleEi+yfTd
         jNjRjG1uU4gjKFa4m0dUa1vBYSNz1jrwx9qJTMdLMx1EQ3UYJ51GPPdgyzjVvOtevzmt
         6UJhx2S1iWnz8BdBXkdKGdi1lb50HfS7boV7941Auh/IIbrBTOMNuSWbz5dE+aJOW+oG
         oKyznNI4+kb4B9WfmRt889vBo+GzDT5Ek5Zir6iOX8xJagkbiHQXlNFQdfgLJasR8FYK
         rTJsM/7wbLfAdvPU48ELbaRQt4tD+UVBk+43/CEbnMJyjdHZVFOh8PsqlwzZWdXFXgph
         F0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785621688; x=1786226488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/DniCfidRbKUpj3g8JSrdbI5dITb8OPbOoquygm/08o=;
        b=ET7KS5Vv4DdKhIeJpV6Uu9RzFFe4/0r7QeuZJn3LU8DbtdoL9f7gDW6mDyzb643nlG
         LHC8LLZLVFTl3bfCQJxj7uqgP9HP8jQfm9WP/mSTVk0qb8weRtoxyBVAXENIbMpr37y0
         ASUuIigsgo8PAcrt6eLLydhbTF0tGg3swSKDJhryH1JLThekD7A3SZhkhxeOWXFbMX2q
         +kL51B36iX5QVJBUfT8CTWVwJkPscJ/gi44Bsb+5QIF92xA6fLIi0+A+9k45Ds9LQ4Uw
         p2jwYxSWJryaE6RV2xv3SLttOfpbERoWPag/nse48RGWkgCOIMaBg7Q2x9hm4gBrEWDR
         8rtA==
X-Forwarded-Encrypted: i=1; AHgh+RoOXe4Nf5H6ZkzIAiRNkQdasTWhwDtznXZnHXnjPa7emmcRSafuF/94RfkgTbEF07zxDhkCdwi1kzghDYVd@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmbmGgr53WuL0Ap5JMHsf13WbU9ItXHNwDVY04RlJi+LPi3+d
	GHLlx2eEcxpFIRPa0F99nBJMyT60NOM5uBui3O3k94w3LhfgrA8cpbvZ
X-Gm-Gg: AR+sD12hyHr7Necr0cfZqNcwyOGl0muvHccer48/t/JVkzhw/JZfRS3LLiEya0c95Fp
	rMDMGadoCbCTBxndsmQnK7wAle5DGODzYoThEQ5yTiCguc5eALuNjxBrbC5mWMukaptnPOB4+y5
	rVNF2bnJGgYoQZsM/K3E/v/5DwpgzbFdUylcYJ1RmA/oBDAgHr8uE9C3/aYsu4oASR7j4XXVP4i
	vVIwJDRNNMwnUXnUD/pzEj63h/ALNgPhJv5k62zsrsnfG1MVetiv74QhvMCBINMNeRDw3eshKt0
	6CudPaAiIFzbWHeho+x8ofuGp2vo8sSzzrlNHcrvJSOoiwXcT+nk+Wnt4qk9+jtOgXV4s84zUZ+
	rqTw0Qe2usuheJ9BBkdSPKDpxCbN6G67z9dsk20You8nTPHrkcZPSMTOfK0bX92F2UlXh71ak03
	Jp9GZqcUdz0PDOiY2Ym+XCXDD5OZoA+1ac1/+JvtbEZk3vC42ia/Q7YCWZ1CGnZA3bKnJ3roLWX
	oZxsGA=
X-Received: by 2002:a05:690c:c15:b0:809:6b62:2f7a with SMTP id 00721157ae682-81fd4b72864mr76660857b3.21.1785621688522;
        Sat, 01 Aug 2026 15:01:28 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd0d6fbbsm29903767b3.25.2026.08.01.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 15:01:28 -0700 (PDT)
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
Subject: [PATCH 13/19] ocfs2: check for a metadata write error with buffer_write_io_error()
Date: Sat,  1 Aug 2026 18:00:57 -0400
Message-ID: <bd2c982e7c91fcfdb8a326ae8166853351398aa2.1785621505.git.coshi036@gmail.com>
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

ocfs2_write_block() and ocfs2_write_super_or_backup() detect a failed write
by looking at BH_Uptodate afterwards.  That relies on the write completion
handler clearing BH_Uptodate on error, which this series removes: a buffer
whose write failed still holds the data the filesystem asked to be written,
so declaring it not up to date is wrong and makes callers re-read it.

Test BH_Write_EIO instead.  Note that ocfs2_write_block()'s test is the
positive one, so the sense has to be inverted rather than the flag simply
swapped.

The comment in ocfs2_write_block()'s error arm needs updating for the same
reason.  It said the clustered uptodate information did not have to be
removed because the buffer was not marked locally uptodate; after this
series it is, so the reason no longer holds.  Not advertising the block to
the cluster is still the right thing to do - the data is in memory but not
on disk - so only the justification changes, not the behaviour.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 fs/ocfs2/buffer_head_io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 7bfe377af2df..733ceda79ca1 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -66,12 +66,14 @@ int ocfs2_write_block(struct ocfs2_super *osb, struct buffer_head *bh,
 
 	wait_on_buffer(bh);
 
-	if (buffer_uptodate(bh)) {
+	if (!buffer_write_io_error(bh)) {
 		ocfs2_set_buffer_uptodate(ci, bh);
 	} else {
-		/* We don't need to remove the clustered uptodate
-		 * information for this bh as it's not marked locally
-		 * uptodate. */
+		/*
+		 * The buffer still holds what we tried to write, but it did
+		 * not reach the disk, so don't advertise it to the cluster
+		 * as up to date.
+		 */
 		ret = -EIO;
 		mlog_errno(ret);
 	}
@@ -446,7 +448,7 @@ int ocfs2_write_super_or_backup(struct ocfs2_super *osb,
 
 	wait_on_buffer(bh);
 
-	if (!buffer_uptodate(bh)) {
+	if (buffer_write_io_error(bh)) {
 		ret = -EIO;
 		mlog_errno(ret);
 	}
-- 
2.43.0

