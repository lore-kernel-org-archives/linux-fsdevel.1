Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07132DEA6B;
	Wed, 15 Apr 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241832; cv=none; b=OkaBph/YXrWAJ7PYjPug9FEF9Ej+O39meCPiBRd4DIG0HMrB2TuYh34DjKGOKsERKs87iOcU8soqkhLpH9eY/ISgqjvZjx3lri10MqmN6FAorAt7TV0djq59ZqFPvv1QEecnDRyFwQOzQf/xRlsQ3wrjyrhrewMoLTq2FMa+dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241832; c=relaxed/simple;
	bh=JDCKQawlr1qJCSQAQTDvLng2XETSmvFI27J4/TDQrqs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=flr4s+AfE3tpld3VcQGWrvNcgSHbnKM2XBepfsWbWmczaoGQTjua3xMywQ++yyPzuS9tPnxPhvhv3+L7JM8qBM6AL/FBnXVyHvoP2A8o2h7btCuPwPE2BlXJz5MFFxL8fsaK3I+5wYGF8NixTxIDOO8lQkKYKsKH/eMS7e9WemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p1ewSIZE; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p1ewSIZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776241821; bh=kmm8vQAUOrT1UHWaLFb9fXAUDG3jO4piAShky1s/kIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=p1ewSIZEDBYA9kN9EEFwa0AE6PiB+oyGfJm+KZBlr4+J3VGqh3/D1qL4E3kA4eFJE
	 iTHUbZBKojzrK2PPMimktTe6WJ/xPmCPScbqAjUakz2iJWwbR9yMp06R6OqGJsjSyY
	 iTzmaJeTnGMYNjryGNAVUQcnBZEr5PVFe+UVdhUI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 749182DC; Wed, 15 Apr 2026 16:29:09 +0800
X-QQ-mid: xmsmtpt1776241749t5gy9jg17
Message-ID: <tencent_1E9E3B1B234BA11B762595BA40BBFE33C608@qq.com>
X-QQ-XMAILINFO: NdB5/PuY7PjGLMpsxQP7z7wPTqpU3DRqf/UXjrzZgIgButyNrE9ebDVqQUdNNe
	 fK2f29MEhvtXElH4t+NVkypoafN8Vz+O/R69UIk4vA3khV0oHvOCGBN+7Yp/fq1TjPFg1oWRF9JT
	 F/rzpEglFdnLRmWx+HMqhQSYxpfc5v5yU2mVGiiXY0kbj4N0TgWrFap8xxYJQ8xc85aF7UpxNLlD
	 QmC3F3N6yIBKLfhb4XLtgu51yTqicATlT7PD8Wc9FM80QLqCtrYDVpCnXiFgtTRTEtnkx8/1JsM4
	 uYkIqFGYPAoOIR3n4gSZiJqCAh0CUR/D6vD4me/GryZcjhoqbGbze7vcLsEpIZ6dP8u/AlRs2sLx
	 +S5YoNGS4S1YXZdGYGdoFnCkLuTBBZfurxOF5+GTmIuIOEtYRXxnNubL34/ulFFi3yuvJ7jedJWi
	 BVKfHgsN0Ab7FkQbsxar3RT8jpMnCsUovVZHY1RW/1FmT8cDfYs4BLyq39ap4cc8rr2lZt6UdRJI
	 Q5DD3pufs+52iP0hEuT23bHMBOcObR/dQod0MmgN5tSWMV1xaVT74YcdfAnLV5fqNrqQ+Dh3s0F3
	 O8zWWDbmuGWV3KXWR/k4T8gnox4qkCohMqMYfgQ+dMCk6IrnP0JD+0Dn3JJccsvbl/u6C+UuxFLK
	 LcmvJ8QYzoAO1kzyHZTQ93D+FVYhizdlvjLKp5T/Z43O7+9qVcP6NzNIIyw19ONXNj5ju0KfV3Sr
	 fAaUjZvCwJ4vxDbYmT4XXCyqByhbqeyxwDYwYt+X1wjtDhLVtCxsZrHMtcMHmJAkA36FMaj7o/h0
	 xNYoqxjyNcnm0mWN86hG00gEsPwtFDO64IPe7zKZiwnZbZTWXNtqEjyM2IwloVVhhY8ddySOApZo
	 NUfL+n7umDUq/XgoIAPHGWhBH7FZMIR9R2u3Z20M8S6ftqnU3KxRvSw+uL7Bd/sFoP52pIOVeFTt
	 a0Rsy9NRDvF0pboqKG9CjS6CkYBxsfzuO62hnt4J6SXhJhHJHb8wCNVpquQUTbC3MFoDlgfjDxBP
	 EKmQnUqg==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: Add a sanity check for catalog btree node size
Date: Wed, 15 Apr 2026 16:29:09 +0800
X-OQ-MSGID: <20260415082908.313880-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69decbd0.a00a0220.468cb.006b.GAE@google.com>
References: <69decbd0.a00a0220.468cb.006b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a uninit-value bug in [1], during the file system mounting
process, specifically while loading the catalog, a corrupted node_size
value of 1 caused the rec_off argument passed to hfs_bnode_read_u16()
(within hfs_bnode_find()) to be excessively large. Consequently, the
function failed to return a valid value to initialize the off variable,
triggering the bug [1].

To prevent similar issues, a check for the catalog btree node size has
been added within the hfsplus_btree_open() function.

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
 fs/hfsplus/btree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 761c74ccd653..61050ffe425e 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -337,6 +337,11 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 			pr_err("invalid catalog btree flag\n");
 			goto fail_page;
 		}
+		if (tree->node_size < 2) {
+			pr_err("invalid catalog btree node size %u\n",
+				tree->node_size);
+			goto fail_page;
+		}
 
 		if (test_bit(HFSPLUS_SB_HFSX, &HFSPLUS_SB(sb)->flags) &&
 		    (head->key_type == HFSPLUS_KEY_BINARY))
-- 
2.43.0

