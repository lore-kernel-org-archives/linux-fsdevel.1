Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028244;
	b=5Hor4F2vboSAx2d4Gh1wEn3dIHC5G4S/VZuppCsxK/P8BTtdw2t/w/r1qNiRL7PvoTVj
	 rzb3ClxRffrl0q1LZU5FM3nBecp8esjHDWWsbPXObZPwAst4OP4ymLbRk840sLkrgEyVy
	 E4HZhT0u94epMWYzcuXnn6HpVujBXP4vPeCsudWPgIfebtBcMozwyl+MpUUBpP2YIJmfv
	 q2rHbynyQWtUx7aEtxEjs+XQXUEENP6FWQvgQEBjaa5N6ssDcY8KSQ7dKGq0lk1Saaw9w
	 G7yCcLVF6jxCP+R4/tMWCv2S8w86Hj88s7YN4pH3Pky7s+bZRSbxuf76j6XGLcWdFrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lypC8MurV7HRH3c/w8NFFi643nEkO5cK6HfBNA//Ydg=;
	b=Q2svRIE9L62XeyvuE6BULI1TgYClEFUDhOiF3uDA5GtxWDgN6dSTgTfDjxQOfd4IOXj7
	 yaPki0Y11rJ2YX3vYAGRmgmH3rIt/NlbVY2/FtPHemE5H51uAWShAgeK4cK1/BRQbreka
	 OQoqnipP6lJPiPqoJg2qZ3GMS2M9JdeR5e9fFcqSuZHwTXWweSy75uZ/bnJ1tSZHvrgIb
	 /Q9R+zSU8Gp4lyczsQQaIeJmyFybBYwrNR4195RWCR4jD8u8mUzGzBxUxpQqY1IDbrMVa
	 3JeqfMt+XYU46qHWbPEeCePV59jf7mrhOFfIigyL1YwKHLng2kAONlrBpXuZ5dH+uzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rW2lIEEv;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFDF606A31B
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EFDF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rW2lIEEv
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1931ff67a29so937347c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793028243; x=1793633043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lypC8MurV7HRH3c/w8NFFi643nEkO5cK6HfBNA//Ydg=;
        b=rW2lIEEvuwSAkL2jbAgcmTJAk2n+zIa5LQNm9NMbYf+KxdQHyfVjH63yHrBxgk7Jth
         FofeGnaiNRBRGDM1ZEjLi7ukfmQQ442OVNEpqB9tVqeu//e6dO93DCUsjbzMCzQCsj8V
         NeziUvl9f8EBqzO+lImbGAtNtiez6xRwXrLN/8R45WGAwU6Mn4601xigCsdb2NKIlwTA
         C718GoOJRycgYQtA2xh876S9UpIr09e9BOdmBZBBCxxcIqPWHmKGmyi6Zo3NkgSn9rzR
         9Txx281PM+KH7G43s89AAaazOXsyGwFvmhAxfYkxhtI+TcWpjXRkaIPeJQvFLZ3XqqRe
         /4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793028243; x=1793633043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lypC8MurV7HRH3c/w8NFFi643nEkO5cK6HfBNA//Ydg=;
        b=xxmzVCIJ+2ml97QbgaoWDile7nWgN/Sv+ZhmatQDBBTTkrZRGZe94+7CSPtGZCcTFZ
         1rMzdQK4EnOXTv0fnSWtqvQ7yDYK8TgZDQLHOxyjpD/TJ13D6um+EIT3Q1cZPhaYppbC
         xbd4VE+FpfzyvCXwFWlO/7zpMnhnXpjGSEto9McvGijtJ/XYXPstsVSv4b0qYLONOAGQ
         8to3lNcWpHSZfNqeXvoFeEnpHic3SLlkQO8rbbkR1hN9J4T8OFG7c9A+GLUzQWei65Nd
         zirvrMMME/Hq1EULpyYH4MgdW4PVaucBE/d3OQwhZJ0bHBCUM/ikNcVcfbhgOOiyFqtY
         9HtA==
X-Gm-Message-State: AFq9FYLA63AVZsJGUxnyr/G11ZKnPQaQZl6C50r+EPn3WbpBzeeZjKJz
	/JFabc+HkF8oWYVtzcTv3tGXg6wuDHlvezaGBGnd6ls1k4zQNOe5L+qZ
X-Gm-Gg: AYBFou0LA+K0FydsPCn+N0lbmNsHZnWS1/CKJzTRsnLZK+wYcZrLJqEkckBSSLQMnib
	k7UUckylMTOqwra8TTlaGRub+HDnedNZLgy5MfQD/6nDgsPJWgjIXcqCoJXpKKmkwN8HT86q1p+
	h3E+ARhozaf4WJ9NAYPg2PTSfiN7GpKDvwLSqoFGw4OGgZDSzoamxdGd1K015SetGDm+hdJnnag
	WsjNCQ7mcSiTTFOF8v81iLiMjc/+wPAB7pEC7kT/P8J6rdI3tgUbh6oZuiGrnwS3Gjh78z4OyPn
	NDddH1a68WbzpeEBWgFnsw/X93DvROrcbEMS3k2W0J/NK81kX/j+mzCYE9X9D9fJsAfTK9VMxyD
	imMTQr8oozERQ9NCoBtFLqdsmoH/PNAnGBA2EihKLtbADrKoDAUukJL7hvnVB2ZXJ3S4n9O1lxj
	+j2FDJvuZIDd8Mrf+WEjoKSyw8XMsLEBt3w4t4eHLK1ZG9g0zf1GI5u1yzQDQkzV3ewRYZQMoQE
	Mpssw+yZX3wnHA2ZB5ei1KsC2rBxcLTF2jbJDWwmsHJWyfcSwCYzfIMXpMbBPSy8++4A7E=
X-Received: by 2002:a05:7022:1114:b0:18d:ac5a:89ef with SMTP id a92af1059eb24-1993639e52cmr10117949c88.31.1793028242124;
        Mon, 26 Oct 2026 08:24:02 -0700 (PDT)
Received: from localhost.localdomain ([61.255.248.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f83cedsm31749966c88.13.2026.10.26.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:24:01 -0700 (PDT)
From: Song jeonghak <thdwjdgkr123@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Edward Adam Davis <eadavis@qq.com>,
	Song jeonghak <thdwjdgkr123@gmail.com>,
	syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: free failed b-tree nodes in hfs_bnode_put()
Date: Tue, 27 Oct 2026 00:21:39 +0900
Message-ID: <20261026152139.458677-1-thdwjdgkr123@gmail.com>
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
lock, then free it. A failed node was never handed out for use, so unlike
a deleted node it has no b-tree map bit to release and no contents to
zero out. A later hfs_bnode_find() of the same node number now reads the
node from disk again instead of getting the cached failure.

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

