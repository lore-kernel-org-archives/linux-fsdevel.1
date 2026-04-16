Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50DA381AE5;
	Thu, 16 Apr 2026 09:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333306; cv=none; b=FMgqsSfKtgKfa9IvbkhXRkvsmZo42Vh67ANI27Q1yzc9FhftXjv5o4i2WkWlOpjX6o3TL3XfJb6sPvtgjnSRX8LKzgwgAVA7xN6+0ZcjF/g4lK8RNByhHadAEufXrwX95sDMOQxZeLfWiRwi0uiS5RcVG3urNzTqVfS+olyow/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333306; c=relaxed/simple;
	bh=CipxoUSAZnj8AigpJqVo4PCtBcOv2QnIWvoQJ5Hgv/o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dalJjqVec2tTkHYcXcCc55/oN3WW/R+yhecWUwa4t1/p2mxoyPOHlEHxUkTI/9URn22xG+ebCB79w0KFNHMxs36H+bPVfyNICVW6Gyov/rg30E/GqX5QvihcSIRB/k5I1QMPT91cM93HTyCJM8a/yFI4cJPrz0IRPwt4XB5U06I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ujr1gffo; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ujr1gffo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776333293; bh=bMqkCvlELOobU3pG1W/bsa/0Ps7U0ZQU32t2UHqS9m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ujr1gffo86T25la+HFyqEcjVOAiOvlZt/V7LKszeHOcJ7pUQQJZadz/yQJr1AMahD
	 cotmcthVANwvtTkd3ouW6fqLcEhIcKHSAt+g6Ml3sUFx1q7ez8vzJqN/ORbZKrsuOi
	 gWOffPAyESnr6A34DaZb5+aAWXq6WNzMTNndg3qw=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D633D08F; Thu, 16 Apr 2026 17:53:35 +0800
X-QQ-mid: xmsmtpt1776333215tbmz58m8w
Message-ID: <tencent_616EF42CB16F489418E932EFEACCB479460A@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLJIJuGBs8ebKBXxWFi7YmUjZF/VfxqxyD4pEGFA0IuzWQM9SFl4
	 vYbYDexrCFC4QKG0yEMIkMRkGzY6UiRNf5JFRPLGX4RdhWXztYUOvLaIt5ztTzd03m5Cn+q4Kwob
	 Bz/8LGcvDtawjE2oznxppAUePmgvK4ay4OhHUtaWE5fsL3psohHU/qyuUa0hR+VIEZF6XBTw5ZK6
	 1oFIqCARNdhFtdYLhOnurmxRGzTzVN1EgCGCgyC+VVvT67zLbZJx79kSkg8AnkGw2zKN8U3Efv2Z
	 SiGBvAUZDVYa20TQoVOPXQIhv69tOSz+VlmIYBJMcwgZBD/ehVe1qzl+V0TIjyNY2DAUoW+ZOQct
	 www/pPiNuzAXlNm+qzjkSuzx2/JNSZ9QhRNyUwNfzU/D5gBg4a72/hErLw8Jt17VNp+JDayz6cRZ
	 FKmkISxCTiTh29YE1s8lm1jA/luU+2uVFjCmz4V5+xEYKal85C38Xn9M59oZ13kW4xsbe/5GkH29
	 EScKDyEkLXweneoAXXKX3L2oaHYs+fZfR4Mjy43uBTlaUsVE/PVKzd6bPyPiMK+2EazXYQLOtO2u
	 3HpvAFUactV5wCJdBA+fuT/2aRR7LsCVyXT2ZFKJpJzWmzcA39Fz+haufMgjGJPpWB4W/E7qyoUn
	 EmCa1cIU0nb7Cd0mDzh+dZVhj0qyfbIxl00jKZnfjm4CqFs9S5V8DcpQ6mMpqucg5gMQlKnLRgo/
	 Suhd5MAyqpNP7DA8KngsVMDTHK4+5Ltgrkw2K8ohmxzBMPT7VpBUm4VF8EJIBuLGiGNMwmUXFTU9
	 TjcO+Zu0wUbK2De0AIyXBTWHaZLIma7Xly9EJrHjS3u3XwbwSHJQDX1pJsOcLk0WeWKMMXn8Xz46
	 GtZThkjQ88tKaB6wDK9RiIfw7/Ak1prbJOCDEF74Y5wJGw3S4YiaInEX/unRqPgMkU4M565Pv8t/
	 WcQn/0VzipG97G9Vs2x4H5GUzxlsMrirCCb1pC29Sa9hxoZYZrq3Ugfbmc8JvMH+o3lLfFoSnrwM
	 Al0Lu2vc20JcMHl+Qr73gcxJtnF0qDw3XBw5cBz7CB+dQfBCe8b/JfpRC44Vtrnk715/UR4G/eZW
	 AxxuE6
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vdubeyko@redhat.com
Subject: [PATCH v2] hfsplus: Add a sanity check for btree node size
Date: Thu, 16 Apr 2026 17:53:35 +0800
X-OQ-MSGID: <20260416095334.385114-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_8ECE3364C36FE975C3A64444176177734605@qq.com>
References: <tencent_8ECE3364C36FE975C3A64444176177734605@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an uninit-value bug in [1] with a corrupted HFS+ image,
during the file system mounting process, specifically while loading the
catalog, a corrupted node_size value of 1 caused the rec_off argument
passed to hfs_bnode_read_u16() (within hfs_bnode_find()) to be excessively
large. Consequently, the function failed to return a valid value to
initialize the off variable, triggering the bug [1].

Every node starts from BTree node descriptor: struct hfs_bnode_desc.
So, the size of node cannot be lesser than that. However, technical
specification declares that: "The node size (which is expressed in bytes)
must be power of two, from 512 through 32,768, inclusive." Add a check
for btree node size base on technical specification.

[1]
BUG: KMSAN: uninit-value in hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
 hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
 hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382
 hfsplus_fill_super+0x111f/0x2770 fs/hfsplus/super.c:553
 get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
 get_tree_bdev+0x38/0x50 fs/super.c:1717
 hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:709
 vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]

Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount time")
Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: change check base on technical specification

 fs/hfsplus/btree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 761c74ccd653..857705c3fe0d 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -365,6 +365,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	}
 
 	size = tree->node_size;
+	if (size < sb->s_blocksize || size > HFSPLUS_NODE_MXSZ)
+		goto fail_page;
 	if (!is_power_of_2(size))
 		goto fail_page;
 	if (!tree->node_count)
-- 
2.43.0

