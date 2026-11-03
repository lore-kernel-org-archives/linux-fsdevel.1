Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672872;
	b=ThSY83kGD5AKhpKcDnFZ+N09gpcirDA5+9g1hOnvC+euxaOyA8u6HNPvYASWz7Q5twHj
	 937ERC+ZsGLC9TjGVTbBGV6X/KDgkCaGMbrq1eB2XljMjAPcHT0Bx24Y/8jrE3hZIb5t4
	 tT/nHZjd/xFqQfL9P7rQEsz83yVaVmY5DIixUgj2rHwmHFpVUqAwVpWywOHsZqxfhQmj3
	 dJe6RT8ZTJVHzdH8kLA9Uq6L0i8Vur/UndGFKJYBIQN/9BI0/moSvIjdpfLy8fNrr0E9i
	 IyiQFPtZu70G4/TvhbjOb94QfGv+zCnKCIK6BjzROoinwa7t3PAaFlx92etBFCZM6kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=N9b5P4R0OxwfaJ7nD/07qWvYSSSIbI12/NxxmTR8Z8M=;
	b=VTyg3IxjIeNhcl8Vaaci+X+bSJEJxPzdhlCDSVTX5oLHfSQQ809Bc+jJaxXwdNOlum1u
	 6JjqsVIfhYcwYKCtQ18zM94YcERRIcyADshXpMfSuuzaSkEAsNMdPQv7emCmJXA9Mg4lZ
	 XmQUMNXind/oq+zzk20I9xxBMFOY5EPPUYjOfM6H/j1zbgcv/5Nw2TQViAwLUagStZUQG
	 oli5LyUdXXUJaOBgYIhNWolbz3nApow8lcEplyIVvMXFTHzO1XTCAZmYgVm6+aZx+y4b5
	 aP7GiYTz6wmgbL5V0l2sz9tE9w3UUqS6Z42ZTAuMeP9vAcORxecPDOvUsV3/FtRozNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HHXO6qJa;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E8606A324
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 02:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183E8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HHXO6qJa
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a2551d7b5so291572eec.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 18:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672871; x=1794277671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N9b5P4R0OxwfaJ7nD/07qWvYSSSIbI12/NxxmTR8Z8M=;
        b=HHXO6qJamIH9YTOp6hlmQqsiTYtL0kVWzK+q5XnMrAfTDbBstJF445LjWYJecaDas3
         XQwi+TzvmSAnon3vNz8QZggoP/67q8bkFrpEVEZf3320dmG2hQPRPNGpE1KM231Q8lok
         zeYK7kLVBhbPNbVwtZ0c4lOIwjvk88Jd53WiDHEH0mOPBA7vMTfMIcYCUb6e2CQP39An
         K9tjXluTsrsH3R6dBSx9S+RqvRist9LK0g/4A6QJphWpIhbpgjPx2IGbEMsbjrg4cLg+
         pjmLU4fnEf7N/fihJmnOLttnmh/ba5h98W/p5hzxsvDAmYGwuy8KwB0rhLbFzrBoekH7
         iKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672871; x=1794277671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N9b5P4R0OxwfaJ7nD/07qWvYSSSIbI12/NxxmTR8Z8M=;
        b=fXGvJYZDLJVooz6vlD+LMiUKJsSm/BPAafzwcpBOo80565PBiroCbyqFhE9giWn9BL
         Ab5ER2QlZhm7de2p4hg8zUoSyISZ28z7YRNMsA8QTuGyYLiYkv33An+7qxTSQjfXL0OT
         Qa75WyH0zDrQKC2c+DWJ0sxYEziMJ7TjUrCduaveq8NO1xh21jtZt6OEBLSbBzC7JFn1
         /kT9mvTDLVZbRTYUaKVSpU3777Bx1o/HoA7rZFJzgwsxrdk9hSV8ls2oEtLo/dyHWVls
         7R2A/n5Jepru5WyQFWt6uEWNO9v3QFify/JlhAq3pSWzHoWJEowFq7xpIHJuyxQcQlVe
         wEhA==
X-Gm-Message-State: AFq9FYJbxU4Ii9eptH2BUc2GdFYVpKih3Av/ZKDk+UatPzUkqs2ODBDW
	pOazqvN3KK6zPg3YKmyjpDL4qOEdbcUansUNtbmRjNywCM/AOXGJ5BaQ
X-Gm-Gg: AYBFou0P8UpfJfZyHZbtpHMfPKeo0tItKCsz7BWMu+xei35CS/nfSPVLmUGXra5S5zK
	2wDNEV6eYe4IuId/+72D4VErwreY0LeJUCpReanhv4zv24KggMQ4L6swB+QemWkLbRUqmoVQf4S
	zT2ggvBGW1cpkL8QUBfzBnacgIlFcwXsmP5x9X6mBb56upFqTYRh3Z0elx5PbhFfO4/bVU0Gi0n
	n1sKvKqMCddJvtcyMxMgI3DOJLj1NDs1CIw4FWOgx88pcoVQoyCGQN4OIDL9LS31DKkOsYtCqiP
	DYIdKec8vsNnDw9cr0T2zTTuUgynCqSh5Uax7+PkZWsuz6SJYP0DfmWkPQvm9d35l2OEE14TP27
	83MBQjkZ8DcXNGk+8ECleXlvBMpElh84gF3MBYJ5o8q7jHZ8fKeMts4h5CF59yEyBoTjtGNlRa4
	y/OW7MaB5OcRlHlDxsgKFa4oHII/ereVnw/qG1l2SyeUTfkAkdpgYvVFazLV9+GEJEb+1T+LiQM
	xkdBxsnMW74JY+68JKvISheAon5oMh1h3x5nGkAKAarJN31t5DVzQJAxyqk83uheY8e57xxbQvh
	4OIogx4/44Ty294gohSgq64V9xKz6/Ie0iMyZ1+X5pzz
X-Received: by 2002:a05:7022:3c02:b0:196:b805:9546 with SMTP id a92af1059eb24-1ac5a67f996mr13146306c88.10.1793672870937;
        Mon, 02 Nov 2026 18:27:50 -0800 (PST)
Received: from localhost.localdomain ([61.255.248.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4b08bsm43931281c88.16.2026.11.02.18.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:27:50 -0800 (PST)
From: Song jeonghak <thdwjdgkr123@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: free failed b-tree nodes in hfs_bnode_put()
Date: Tue,  3 Nov 2026 11:25:22 +0900
Message-ID: <20261103022522.21918-1-thdwjdgkr123@gmail.com>
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

hfs_bnode_find() flags a node it fails to load with HFS_BNODE_ERROR and
then drops its reference with hfs_bnode_put(). When the last reference
goes away, hfs_bnode_put() only releases nodes flagged HFS_BNODE_DELETED.
Every other node stays hashed in tree->node_hash as a cache entry and is
freed later by hfs_btree_close().

That is fine while the tree is open, but hfs_btree_open() looks up the
header node itself. If that lookup fails, hfs_btree_open() unwinds with
iput() and kfree(tree) and never calls hfs_btree_close(). The failed node
is still hashed, nothing references it anymore, and it is leaked. syzbot
triggers this by mounting a corrupted image:

  hfsplus: failed to load extents file
  BUG: memory leak
  unreferenced object 0xffff8881040930c0 (size 96):
    __hfs_bnode_create+0x57/0x310 fs/hfsplus/bnode.c:476
    hfsplus_bnode_find+0x138/0x660 fs/hfsplus/bnode.c:554
    hfsplus_btree_open+0x30b/0x5d0 fs/hfsplus/btree.c:384
    hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:546

Free a node that is flagged HFS_BNODE_ERROR when its last reference is
dropped instead of leaving it hashed. This follows the existing
HFS_BNODE_DELETED handling: unhash the node under hash_lock, drop the
lock, then free it. Unlike a deleted node, a node that failed to load is
still part of the on-disk tree; only its in-memory copy is dropped. Its
bit in the allocation map therefore stays set and its on-disk contents
are left alone, so neither hfs_bmap_free() nor hfs_bnode_clear() is
called for it. A later hfs_bnode_find() of the same node number now
reads the node from disk again instead of getting the cached failure.

Tested with the syzbot C reproducer in QEMU (x86_64, kmemleak) on
next-20261023: the leak was reported in 3 of 3 runs before the change and
in 0 of 3 runs after it, two of which ran with slub_debug=FZPU. On a
valid image, creating 3000 files, deleting half of them, and remounting
gives identical results before and after, and fsck.hfsplus reports the
volume as OK. checkpatch.pl --strict and sparse report nothing for
bnode.c. This was not tested with KASAN or with concurrent access to the
same node.

Claude (Anthropic) was used to help with the root cause analysis, the
reproduction setup and drafting this changelog. The code change itself
was written by the submitter.

Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount time")
Reported-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98547b0428b6a6a3467c
Signed-off-by: Song jeonghak <thdwjdgkr123@gmail.com>
---
Changes in v2:
- Corrected the changelog. v1 said a failed node "has no b-tree map bit
  to release and no contents to zero out". That is wrong: the node is
  still part of the on-disk tree, so its map bit is set and its contents
  are on disk. They are left alone on purpose. No code change.
- Kept HFS_BNODE_ERROR as its own branch rather than folding it into
  the HFS_BNODE_DELETED one as Markus Elfring suggested, so the fix does
  not touch the existing HFS_BNODE_DELETED path. I can merge them if
  that is preferred.
- fs/hfsplus is unchanged between next-20261023 and next-20261102 and
  the patch applies as is, so the test results above still hold.

v1: https://lore.kernel.org/all/20261026152139.458677-1-thdwjdgkr123@gmail.com/

Viacheslav, v1 did not show up in your mail client. It was sent with
git send-email as plain text and is on lore at the link above. This
version is sent the same way.

This takes the direction Viacheslav suggested while reviewing Edward
Adam Davis's earlier attempt, "[PATCH] hfsplus: Supports freeing newly
created tree head" (April 2026): look at HFS_BNODE_ERROR in
hfs_bnode_put() rather than special-casing the header node. That thread
did not get a follow-up version.
Link: https://lore.kernel.org/all/tencent_C4F16CD096B0EAEAEE5ACDB07A266E382C0A@qq.com/

fs/hfs has the same structure: hfs_bnode_put() has no HFS_BNODE_ERROR
handling, and hfs_btree_open() looks up the header node and then frees
the tree without hfs_btree_close() on failure. I have not reproduced a
leak there, so this patch leaves fs/hfs alone.

sparse reports a few warnings elsewhere in fs/hfsplus (ioctl.c and
attributes.c) that are not touched by this patch.

 fs/hfsplus/bnode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa6f2e2..3d159db229e5 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -702,6 +702,14 @@ void hfs_bnode_put(struct hfs_bnode *node)
 			hfs_bnode_free(node);
 			return;
 		}
+
+		if (test_bit(HFS_BNODE_ERROR, &node->flags)) {
+			hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
+			hfs_bnode_free(node);
+			return;
+		}
+
 		spin_unlock(&tree->hash_lock);
 	}
 }
-- 
2.43.0

