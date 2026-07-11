Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2A30E84E
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783803566; cv=none; b=hlAkL0OauvBT+1KLDJDFMIzAtjHvAqsCz6EBN2OyF4sRTJeEmTDakLdXqbbx4XcdCEfANcW40IJSjF1ST4lXU+C0XJtYpd468cb3pdh1Tm6f0M6m35QNcyiIHhVGugVEE6Z5g1ijwzFmYjJ/+nwuoN6KPyJqFgCF3+6Ey+Wc5Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783803566; c=relaxed/simple;
	bh=kw0OMQMrjvlSwGKPOoDzAWrf75ZhL3wz/Mmj/2mK3do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6KQLiYnVli1h6Qk4lQqsxo4AIqA7DLlX/Njiqll+7jMQzrVxBulthCaSdRJk3LpcqpdSqmwQ2C1mSsFgfPUEcNYjsSbwqw0kY/7VZLzPpgclUX97KeoRalfuOrdoyT1MePO286iups03xm+Njj/ECELRGNQAxXVlmzW/Wed+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2WghIb5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2WghIb5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485b358552so2145350b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 13:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783803563; x=1784408363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6t8DGVkdCLYUd0OR5aV/ertEnot2rifntCQT4Agz04=;
        b=a2WghIb5NZ2KYgmDdfhNud/2TV89IhAV3nTHRBAHvoHHRB/k4w7re3CW+YLJhNV+yL
         scm510K4hoJkkoiJ9PhJM49+0mijT77i2OTzqkOwChCsfAW4YaEFLwsCK62voSleviTK
         fjEB1llmd5KNpGoEmJq3l1BiIIu12GQAT0lJNHYFe1NA7iwha3F2eOQUdyTGWXA41gA0
         bzCP7hkPjf9CDUFjdKndiGiaElDOhhrEZcu5x/GCX4O0qjwT3vQihRlF/kTMdIfF0MqY
         85Yx8SPVhdQv73+SbI5getizQawVQYzzhZ3djhGnIY0jm373Oru39PwhXqgV/qlbVBoB
         nbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783803563; x=1784408363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6t8DGVkdCLYUd0OR5aV/ertEnot2rifntCQT4Agz04=;
        b=pNar2Rl7AsFtdjZvcd2Bw9cWyXUoGgQJdSnIKL3hsXOjNpYyzhi3rnI5RGGYksKN44
         i5soii77tEpTlq6NHgkgUt+WIkI2qZdg6gLBwbNZKd83OjtAByPHNHFoDGMQY4Jk3vH4
         ALsWKVcT6U5HAuFhfSuPVt2NK9cfemmySSTBc5XkcOhCw5/n6a7PheB3G5SngHKMPk08
         qPL1J7V8+bzUWdfkg9tZv6w6sSVdkKuQzobvH8QCT6cKVQKqnRfF+o6CmyYyZXkn2Vsv
         5PpUncRK6eAImAcReBRDOCYBnKRHBvVdFdduI4I7NyzKdsjMhm6gsjbY5ZErLsLptvLz
         QzIA==
X-Gm-Message-State: AOJu0YyMXOvl978tqG+RFQc91ZGD9XDjFxUZLVSf5DVEPYBmX7UK0O14
	PVWhgC2WPTXXrrY7mJT0MTuX7WBN7VX9N5HkAKDYnPdWTTb1cuFT8Sjg6ct5eQ==
X-Gm-Gg: AfdE7cl3BkFu5qKy/jjXFfQ9rp/mXe1LRb1sM2r3JucrFbKvorjeTd/9685yODKGKQr
	FMsYjQTb31dGpUCtJjrSfTa6SLlDm8aeCz7DdtVOUCyosEomlsCD1ttiU4q2F8/P2EgeSUgmBFs
	ZMWK4Z1zf4GLBK5ZkAvszvmgyIyuQuD/yZ/5QCekYwGvlAXEjVotGE4ogbDS0GCLYU51h1ZpZPZ
	RQ573VAHzpdz3CsKaMPiyipm2ED/Vp50Dr7KCQ1sB8src8VS8IEWDX7Ah0vDJjtO7S7yPiAWVR2
	pQViZQGVQ50raqEVkBPDag6IEnCNRmYchjqE4u2JBOKwB/hSmd9SbH4HSDNDwKfvEUDudzJNe6D
	Z4IY0IaHCKsJyfe3kz6gnM6jMMQ6QxEBsQ+w3x5w3NRZ1z9ECtHzAMGZAB1kXb4Q=
X-Received: by 2002:a05:6a00:802:b0:848:2f84:734 with SMTP id d2e1a72fcca58-8488990c921mr4151313b3a.71.1783803562857;
        Sat, 11 Jul 2026 13:59:22 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84880a44feasm2092057b3a.20.2026.07.11.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 13:59:22 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v3 2/5] minix: add base iomap begin/end functions
Date: Sat, 11 Jul 2026 13:59:06 -0700
Message-ID: <555d199291b37e5c1241df648b3adcd760c1fca6.1783707063.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1783707063.git.jbingham@gmail.com>
References: <cover.1783707063.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a new file, iomap.c, to fs/minix. This provides minix_iomap_begin,
which is the iomap-based version of get_block in itree_common.c. It also
provides minix_iomap_end, which is a no-op but required by the iomap_ops
struct. This also undoes the nest of gotos inherited from get_block and
uses a set of helper functions instead.

Suggested-by: Darrick J. Wong <djwong@kernel.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/minix/iomap.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 fs/minix/iomap.c

diff --git a/fs/minix/iomap.c b/fs/minix/iomap.c
new file mode 100644
index 000000000000..90e016aaa01e
--- /dev/null
+++ b/fs/minix/iomap.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * iomap functions for minix.
+ */
+
+static inline void minix_chain_cleanup(Indirect *chain, Indirect *partial)
+{
+	while (partial > chain) {
+		brelse(partial->bh);
+		partial--;
+	}
+}
+
+static inline void minix_iomap_set_mapped(struct iomap *iomap, sector_t phys,
+		unsigned int blkbits, sector_t iblock)
+{
+	iomap->type = IOMAP_MAPPED;
+	iomap->addr = (u64)phys << blkbits;
+	iomap->length = 1 << blkbits;
+	iomap->offset = (u64)iblock << blkbits;
+}
+
+static inline void minix_iomap_set_hole(struct iomap *iomap,
+		unsigned int blkbits, sector_t iblock)
+{
+	iomap->type = IOMAP_HOLE;
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->length = 1 << blkbits;
+	iomap->offset = (u64)iblock << blkbits;
+}
+
+/*
+ * minix_iomap_begin - map a file range to disk blocks. It acts as a replacement
+ * for get_block in itree_common.c, at least in the important ways, and is
+ * adapted from it, but it uses iomap instead of buffer_head.
+ */
+static int minix_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+	unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int blkbits = sb->s_blocksize_bits;
+	sector_t iblock = offset >> blkbits;
+	int create = flags & IOMAP_WRITE;
+
+	int offsets[DEPTH];
+	Indirect chain[DEPTH];
+	Indirect *partial;
+	int depth = block_to_path(inode, iblock, offsets);
+	int left;
+	int err = -EIO;
+
+	sector_t phys;
+
+	/* block is beyond max file size */
+	if (depth == 0)
+		return -EINVAL;
+
+	iomap->bdev = inode->i_sb->s_bdev;
+
+reread:
+	partial = get_branch(inode, depth, offsets, chain, &err);
+
+	/* Simplest case - block found, no allocation needed */
+	if (!partial) {
+		iomap->flags = 0;
+		phys = block_to_cpu(chain[depth - 1].key);
+		partial = chain+depth-1;
+		minix_iomap_set_mapped(iomap, phys, blkbits, iblock);
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	/* Next simple case - plain lookup or failed read of indirect block */
+	if (!create || err == -EIO) {
+		minix_iomap_set_hole(iomap, blkbits, iblock);
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	/*
+	 * This is held over from the original get_block logic, where it
+	 * acted as a guard in case truncate() deleted blocks from under that
+	 * function. There should not be a race with iomap operations, but
+	 * we're retaining the defensive coding here to be extra safe just in
+	 * case.
+	 */
+	if (err == -EAGAIN) {
+		minix_chain_cleanup(chain, partial);
+		goto reread;
+	}
+
+	left = (chain + depth) - partial;
+	err = alloc_branch(inode, left, offsets + (partial - chain), partial);
+	if (err) {
+		minix_chain_cleanup(chain, partial);
+		return err;
+	}
+
+	if (splice_branch(inode, chain, partial, left) < 0) {
+		minix_chain_cleanup(chain, partial);
+		goto reread;
+	}
+
+	/* Successful allocation, mapping it. */
+	iomap->flags = IOMAP_F_NEW;
+	phys = block_to_cpu(chain[depth - 1].key);
+	minix_iomap_set_mapped(iomap, phys, blkbits, iblock);
+	minix_chain_cleanup(chain, partial);
+
+	return err;
+}
+
+/*
+ * minix_iomap_end ends up being a nop; since minix doesn't have any extents or
+ * transactions to worry about, there isn't anything to update here. The on-disk
+ * indirect blocks get dirtied in minix_iomap_begin.
+ */
+static int minix_iomap_end(struct inode *inode, loff_t offset, loff_t length,
+	ssize_t written, unsigned int flags, struct iomap *iomap)
+{
+	return 0;
+}
-- 
2.47.3

