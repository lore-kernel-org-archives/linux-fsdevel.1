Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD42FF672
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728060; cv=none; b=o2mahrQaPd2riIPnXSLB4b3YnIysKWzpgFN/wUbVuqdS7EzyjON7TPXG+IGPTlswQGcnugg3WpszdAKZ/p8bCQfgpoZ9l53SdSPJWYBfdsiEsd48P5hFaupnZkNkttqaXQUudd/yS1Lpjiw6+QYpmEhd3kp097wyY1VA5+GgHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728060; c=relaxed/simple;
	bh=FTCFPDxznd2VnSWF1/IP5a2tyREzKaS26U4h2kBWQpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCb+CQmusOo/v9C+l4jBAtaWR18cdAKKOVeTfIdpOVegHEAVUZU6drVpqbeby44HLw7Rqs/OkQHf4AS+8O+vAv/IfCPjkXwRnD8JDvakyCVZpTnovVR2dwzjuJAqRvq7FD5D7UWB40i5y6ZdjCg75Tw3CoANAVp/hGLdVL0S750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8AOHvlc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8AOHvlc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso26273035ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780728059; x=1781332859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi2g1ORMQplpFEWEapSXzP8JusgWR8+hu6m3SYXtI+o=;
        b=r8AOHvlcs/HPKcqJU6gVJ0F7EYptg22a6QHcIo7FsKOWOnfN1mz/f6sPsPDYs+lOHp
         Uo5nNhbs+fsBMcbRUraEoF08PyWS/pPKsky7iJJq87seiPIYNYtHk8hKlcWuOtqDWhm7
         xkf145wI18VurHgHHDaLccvLnvrUS7N1fUc39emOd3BL5LDTj7maeClCaQdKTm9ODNb2
         FE94GdFxSBRdxWzNm1BgWdBEMRzyQtJ18Me7iaNl7qMJMsftarR2RNFnex5KeQv4lEdH
         1g4YuTQeGPBjpC26ZVqvyBE3jnBY5/3h0+vC74XQC9tsPgG8zlHuAlpf/dRBSPK9/XAC
         i5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780728059; x=1781332859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fi2g1ORMQplpFEWEapSXzP8JusgWR8+hu6m3SYXtI+o=;
        b=MPlwNhvOVyVBBkaQp0s6+4Xz9k2uOGTvXNuXZkRRKMEIH5W06L/l5W2BIuAisKf31x
         oiqe8NDEsZMN8z6QM0up9c2v/Kj+Bg1zuZScXmpROG9QgAxk/w9d0muzdVsBJVhYmSyn
         GCc5IokapOWGmoakMFohlDHKJK9fSwcqhVI6GPAODAZFWNgcnyPAzPrvzSNEeXa9NPKF
         UL1093Diu+5Gwne8A/mVyOUbia/1Wsrd80aMtiLV9VUUWHU9TVvjbvQscbtKQXeo7gFw
         f9ZBuaL8/O6Q6RAhL51l9M7t6ocrsxg2uaq9b9asEnYTR0iDX0Zipak3Znp2xcGm9+J9
         ZlHw==
X-Gm-Message-State: AOJu0YyjoLeECng4tQ4huo9cygB8qDy3EtG0gIGk4vYD8+mTzvnA8+zr
	3yDlLWQgv6VehfUidb51+ZEq4LtvP+HEcf5heYY0fNVNgaZBMZ90SK0f
X-Gm-Gg: Acq92OGkH+IL9IUYj5hdPpNqqkPiMB09AQniwXD1HBT+I7xgkGnSvJ2i7XKmaF4038n
	fNG8U5kPl02tHuzUEEc8IVdtQD7MWcLBzXff6lEsEpPGs5UCt5e2mmcUMdDPBIzrup1wKnRpuzR
	eO7dt/roQL0bMQie11cmvCW3UI7VdAvPjCkeWJ9gWpb++xXZ1r17qrTKuqk+VXtgBITzcw4Qv7T
	E2TBSRjaTrtnpOeVSPFsHhNDwwIgR3BK6qFAIJLiZqQb0BYlXv9f8mZwL0orurnPZRf3HZpTQ4I
	mVMMLGWjK5/6JlSsKm+r0Vp0FyOSDDiH0QpLimDIWAJqg4V+2s6kHugPNAb92KRaZrRjm/uw8E2
	GVbO/9MyoT5Zta8Kn/RpwEB9/uRam72w/FXK86/jlMybrvIVH2GB7jqsF9577IyQuLRy8ZgzIqn
	leHcn/30taFi1lIN8pX8Ag9pUHxiHpkwb2BDxa9iUVkls6TNLkjQNcGEymRM/vLdkgWDpgWePb2
	QqK
X-Received: by 2002:a17:903:1252:b0:2bd:eeb6:ff28 with SMTP id d9443c01a7336-2c1e820dae7mr74635345ad.12.1780728058696;
        Fri, 05 Jun 2026 23:40:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:947f:47d0:d807:4407:d4e8:8895])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cfb4sm117159815ad.59.2026.06.05.23.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 23:40:58 -0700 (PDT)
From: Hem Parekh <hemparekh1596@gmail.com>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fs-audit <a@b.c>
Subject: [PATCH] befs: validate b+tree node geometry to prevent out-of-bounds reads
Date: Fri,  5 Jun 2026 23:40:55 -0700
Message-ID: <20260606064055.5977-1-hemparekh1596@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260606063706.5844-1-hemparekh1596@gmail.com>
References: <20260606063706.5844-1-hemparekh1596@gmail.com>
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
