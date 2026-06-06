Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5552FFF99
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780727847; cv=none; b=q986x6mCnzCVlsPgj/mv6kGFgaZaWuJN1q00WZqvE6YJ4UXNkTxBdGPPxKifesNavbutAAFrbHvImucJEJK4jzgR3UeSsPD79Ys8fXDaWe291/Igrpg4j3LQ04bYSOxwJkejf4jb1Ql8zTjMkUNNfKyxqT43csTdbUrj3gW/t2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780727847; c=relaxed/simple;
	bh=FTCFPDxznd2VnSWF1/IP5a2tyREzKaS26U4h2kBWQpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ppn4qc7QEAXvktCrgs1wAohygoc0sgfMqeER62FrNdLAtOYXOxsbi5ii18jDWS0zVKZ7SuWNpVWZbXAxip4bJT3ORz+uLOKoLF/rJX0ZhNgkELSLf+CaU+MZyodqxRVoZ9NmUmkoZKf6Js2YG6GiOi1bOFF2a08+SmIM/0L58N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezsj8UDR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezsj8UDR"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3543590so18191315ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780727845; x=1781332645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi2g1ORMQplpFEWEapSXzP8JusgWR8+hu6m3SYXtI+o=;
        b=Ezsj8UDRqMh63tr8f1+ClACQF1JVjGhAleLJIqNK9v9hy5qPd/hgaXUqBko4mhwVpW
         FtyrKnqg4+VLzhKX7w1uJxUZ5TCQx2QRBILT6tr8i0f4hQcG0S/ZGK7QIXe81u1BL3PJ
         uVzN0VJ1fiP/hKN3tqUFIn/cLLny+vz8kiCNViYDqlLYrf75qsW0+c76iNSYuVv7RN3X
         Iwh8C4y7LDRrxshxXX/Ic8CDYGNq4l+ipBkjg6u6adsWR0ndrF3wbXVLKzKWJVXRHGdk
         n88HtMfTshX8B4gOTZVPbPZnGuEAA/eejcKCDWEFJa2lIAHhqCL8eFaHKUkZ8d87wXh8
         lBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780727845; x=1781332645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi2g1ORMQplpFEWEapSXzP8JusgWR8+hu6m3SYXtI+o=;
        b=YRQDABl+49+Di1JITvCXchA593SfBTG5chPL94mUDjKGpWc1+e/z7PRHyKKkxmpBsb
         YN6a8A8MZIF33FHWbE9TKulQpYk/pxlyMwh+zLLPaIYRlJMiKziOr3c3myPc63A3xysf
         VVJdoTdj6lGyhgDsYUEdbL+kwbGUVfN0W1BO/9gILIegsXZNMHwJgfZaUd+bd5PXWrn/
         S1lvRkFyWCXDUiXfWJvwF3XgDPJgwPbbyShRSUTBIVkkvFlRPxdGFKaGrUL6wViiubze
         IrVlbEkL1HsfaCf29/+ImX+y8/WldGtyI2LsO9rJ2zhk+Yad9P2F7ax9kHV+wrg8GZw/
         x6sA==
X-Gm-Message-State: AOJu0YxBd94qo/Eimfx0fvaEm4F+kiZUOe7XLpROl9GuSCvWoYmDS+Re
	26v/IdRVheSlFSaPax5brTgjHNf5BtBd86zRrLUN3zvpbVyWovgR981M
X-Gm-Gg: Acq92OHNGwLkA6DDrEB2zfM7lxN4Qp11V9y99r0PVIeHhzIZyiNA7YoruNy1mFnaY+K
	KHcIFnZZVbKwyTvRGcNFNR3wf+CKw2mEwM1AEaunOga66TPp4YVSsDPNxHfI1jweAorv+2bVJnH
	L+0kjc+aoOEbYZGyOlLhopBzmvT+xPz2oXnU8ToSBxVo/5JXtVaAoT++h2E53MdJmzJNDaC/p4A
	UdJjdVS8hoXKEMhg67hPOL39bcNjxmfdQEmHzqMejJ0RUHccQcynRcmgtiuO5w5b+o+Cwq2nHO5
	QGMCk0WYtyOF+Lr/5OorvBxx+W15PWcctm6PywvXwYAgbSnJd3LvcbBWQkN4lQzSdSVYTUyqSy7
	Q/4e83mYWc8G9qAk/HY4rajpRSU8rwb+EhpWxjrykwZ9en78OBe5yw180Cu5b2meEzdWvzcVxxR
	ghb3HbJAfKfFDOq8s7klDftGDGsqA7vl22NVpo5ScyuUoIu686lF4Pl3BzjMAazVuvyIi6hydTR
	rZY
X-Received: by 2002:a17:902:fe0c:b0:2be:22cc:e227 with SMTP id d9443c01a7336-2c1e78e0291mr55587825ad.4.1780727845062;
        Fri, 05 Jun 2026 23:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:947f:47d0:d807:4407:d4e8:8895])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm116025135ad.82.2026.06.05.23.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 23:37:24 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fs-audit <a@b.c>
Subject: [PATCH] befs: validate b+tree node geometry to prevent out-of-bounds reads
Date: Fri,  5 Jun 2026 23:37:06 -0700
Message-ID: <20260606063706.5844-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: fs-audit <a@b.c>

A befs b+tree node is parsed inside a single block-sized buffer_head
returned by befs_read_datastream() (block_size is one of 1024/2048/4096/
8192 and is capped at PAGE_SIZE).  befs_bt_read_node() copies the on-disk
all_key_count and all_key_length fields (each an unsigned 16-bit value,
0..65535) out of the node header but never bounds-checks them against the
size of that buffer, and the b+tree node_size is likewise never compared
to block_size.

befs_bt_keylen_index(), befs_bt_valarray() and befs_bt_get_key() then
derive the keylen-index and value-array pointers directly from those
untrusted counts:

    off = ALIGN(sizeof(befs_btree_nodehead) + all_key_length, 8);
    keylen_index = od_node + off;            /* may exceed the block   */
    valarray     = keylen_index + all_key_count * sizeof(fs16);

With all_key_length close to block_size, or all_key_count large, these
pointers land past the end of the node buffer.  Indexing them in
befs_bt_get_key() (keylen_index[index - 1], keylen_index[index]) and the
value reads in befs_btree_read()/befs_find_key() are then out-of-bounds
reads of page-cache memory.  The path is reachable from an unprivileged
readdir()/lookup() on a mounted, crafted befs image.

befs_bt_get_key() additionally accepts index == all_key_count
(index > all_key_count), reading one element past the keylen array even
for an otherwise valid node; tighten the bound to >=.

Reject any node whose keylen-index + value arrays would extend past the
block that backs it, once, in befs_bt_read_node().

Signed-off-by: fs-audit <a@b.c>
---
 fs/befs/btree.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index aa24f1d..33a13da 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -219,6 +219,21 @@ befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 	node->head.all_key_length =
 	    fs16_to_cpu(sb, node->od_node->all_key_length);

+	/*
+	 * od_node points into a single block_size buffer_head.  Reject
+	 * nodes whose (untrusted) key counts/lengths would push the
+	 * keylen-index or value arrays past the end of that block, which
+	 * would otherwise cause out-of-bounds reads in befs_bt_get_key()
+	 * and befs_bt_valarray().
+	 */
+	if (ALIGN(sizeof(befs_btree_nodehead) + node->head.all_key_length, 8) +
+	    (size_t)node->head.all_key_count * (sizeof(fs16) + sizeof(fs64)) >
+	    BEFS_SB(sb)->block_size) {
+		befs_error(sb, "corrupt b+tree node: keys (%u/%u) exceed block size",
+			   node->head.all_key_count, node->head.all_key_length);
+		return BEFS_ERR;
+	}
+
 	befs_debug(sb, "<--- %s", __func__);
 	return BEFS_OK;
 }
@@ -678,7 +693,7 @@ befs_bt_get_key(struct super_block *sb, struct befs_btree_node *node,
 	char *keystart;
 	fs16 *keylen_index;

-	if (index < 0 || index > node->head.all_key_count) {
+	if (index < 0 || index >= node->head.all_key_count) {
 		*keylen = 0;
 		return NULL;
 	}
--
2.34.1
