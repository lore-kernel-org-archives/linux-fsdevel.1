Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414553750B9;
	Thu, 16 Apr 2026 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383056; cv=none; b=RjK4E/9wkiVwRtMSVqqR6KGmIuxrXJVKfoXwLCBF/g7gxifd0unAtK/3VIdslF1gJjWkJoCCV7lvoWyFyRdsFOSlwwhlZkU23zTVVUmgAdiMom7iXmsXTr9rTJM1+xX9O7GXoegd/aCTIhWF013INSW7YDuqYeGhcxNX/qvda9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383056; c=relaxed/simple;
	bh=Kiymikq0X0+gkP8CuEaoY/Zfxpyhgd06S4r9aetmuvM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=V/I4ISgVPL7grKpOBZ+8OqkMIt2/sug9Q/tDszq5ERfMgOzxUt7n2ZJI9mJ06BSEPeagO3VyBiGsy8pwhiDjHq2DSerNa/pDkeNgVJdS+/fI+lKArX871n37jLli1L0u9L27oFIPSq805EyeMFtBWHZv5QafSwHHR8WE/Fs4wjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h0SS7OLx; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h0SS7OLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776383045; bh=5JZyq/d9oUdAxdYdjeN1RD8LEk2YpzfPinvpTPJaSOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0SS7OLxoCx1p5cApXUZg4kBQE7/ysshB2M1C9HY0ipxVb/lMhwrsQJqh9wACWvkz
	 2Agf7sqRuVWpE2amTqXrQuO8j+0diftSvaLhjUceFQw6tAfEan8eYHWp+ixbSelW+l
	 iq4GTSGeGTzD2HlZo4+ITgl7sq0TiTvcyt90zcuU=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id B01A7465; Fri, 17 Apr 2026 07:44:01 +0800
X-QQ-mid: xmsmtpt1776383041thph2xfa1
Message-ID: <tencent_5ED373437A697F83A4A446B771577626CD05@qq.com>
X-QQ-XMAILINFO: MlsYLnHA0UVj+A8RzaGJr4qpAZYRTSmYWn7blD2RFlarsLz1aq5Xru2cNUIYv9
	 rGMVFC/Kqk/M0lRDxexPb69aVQ7XYDZdEJ9vk+B6SDjQIsxFkrp6UVzKoAQ26MTHkhbkWhGdc4rX
	 erQXrejq2eHc0f8IZPces52zkjG5UmvueTtCGu0CGrRFDSSdY3Y3nI95NsXKSmsOuVvjXZLHNzXC
	 SheKFipwPDhWSgBS4iOsg+C/hfDIQvSKNqKtdiO4b7XkkhKf20g07CY1pC4ypFL/RkYzIQqEtnwJ
	 ZXk2t7l1eWtV5vJQBpxFDiza7Wc7QmzbUA+CAbLRyF0KJIaNgRLsfnOl5ms+z7n9J94sVh+hNcyQ
	 7Ldwh9Wy38Mchf9TzedArp06P9njuRFBjm+TVH1FvlFfzPPydR7hCsjMm+SYEhk0jVIytg5bBGEV
	 nOelrRnQAIXY9WGrzBEXMD717XEGwiYIKl9YIX0C4bltQEgmeJM4oKA5T1zlQ6bZTkbR0PZBWXGC
	 nMDjuHiF34of9tyC9kSRAptIBgzdQkUgxUBxhqS15tC+oLJhnxUTyNWyB0Tx6nN0wLNkTLMbyE+l
	 TJhzR7EGLM+4xTfNLtXRzZSrfBWq1vBm2wHwyoIO1n7sIJOJWgUTY29bA0GVoXpj3UbAmuTB12kt
	 DGKFdqLNozV++SbiT+oRR0UrqG3xAykOvdNXJMTQfeJ3O238tIzp5Aa4p9jeJg+knjhSLUV/o/I2
	 EMtITVB/kIybv/yY/L1tXGrvvgaS1rkNlCC4kRDTBM6xCiDg8ayProRLgT7GY2O+O2WaS4Dz/VKR
	 /djLbhM9uB8w4nLLb9XbYkN8moyQcFkuW7wdyKGOV4ju7VSgyoCxeggAkjIDEcuQ1XSiWJbui2Fb
	 HWij0cmGPk38p4bkBE8Lh1QffaPjtnCDgrVbQuJFqFkSDKHLhVgkcj8YATJWP58uBvCjwFr1qrr8
	 RQz/MvTc0YAqcvxKa0qplgMe96nopGVb01zFXew6dVOfZ3gsb8dKJXyTKxv4ar+R+BZC6td5u7sL
	 Rax3khshl0VOQcHTQY6+dVPWuLkuwzTJ6L7s6zJyHDg5rIi+Ghkd8uSOBvx3BSiokGT+D1Xz3rTT
	 UMK8M+68zMYzykG3hxdAJYrKrV9EVPvzDGqNyABhhRqDMx/yQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: [PATCH v3] hfsplus: Add a sanity check for btree node size
Date: Fri, 17 Apr 2026 07:44:02 +0800
X-OQ-MSGID: <20260416234401.395203-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B176296323B84453B767B76D66D513600305@qq.com>
References: <tencent_B176296323B84453B767B76D66D513600305@qq.com>
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
v2 -> v3: using const min size

 fs/hfsplus/btree.c         | 2 ++
 include/linux/hfs_common.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 761c74ccd653..394542a47e60 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -365,6 +365,8 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 	}
 
 	size = tree->node_size;
+	if (size < HFSPLUS_NODE_MINSZ || size > HFSPLUS_NODE_MXSZ)
+		goto fail_page;
 	if (!is_power_of_2(size))
 		goto fail_page;
 	if (!tree->node_count)
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 07dfc39630ab..45fb4c9ff9f5 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -513,6 +513,7 @@ struct hfs_btree_header_rec {
 /* HFS+ BTree misc info */
 #define HFSPLUS_TREE_HEAD			0
 #define HFSPLUS_NODE_MXSZ			32768
+#define HFSPLUS_NODE_MINSZ			512
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
 #define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
-- 
2.43.0

