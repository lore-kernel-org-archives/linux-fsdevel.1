Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B292F531F;
	Fri, 17 Apr 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776409143; cv=none; b=t0CVTeaXHdi35HiCSpb995MPWI9B54L5Iy2p7dESPYFYmHLHkPpFzkohqKgMTLGyn85n2XpPpNKIlR8qSg0RWU+I/fjFOQxReb7nys+ifgn9A+2Ba01brfvz0Tu3cCVBW/DGw6raGucTGWkdHlGJhnU0/7jJfochRdRkAgVk4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776409143; c=relaxed/simple;
	bh=50U2zfv9PeuZPa0JCzbAB7DsNVLlBqHVp6nagMTSm0M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ff6bUACK54IKF3RYuddkCpNvOEJrVXAdUEGo2Slh7IDxSWKNyOUDZ9uFVFvqx4YnuhXp6Wfd2EiACjP6M/ynqiA7cwdd/gX5VD5MSM6QZLU1EB4r34BqFoZOLTwVxLNc62rdKNykDHZeJLBhSo3GBJ/sQh1QS5Nb4c4OzZMjAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VEYGAgoH; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VEYGAgoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776409131; bh=HRcsKAm0HC9xuo5jH0cSLPq761DEVJInNP3n9DAoRPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEYGAgoHhUVIkaLaAqn0IEEhbKZskMn2WTCN2k/QCxVAK3COBAfwR30upxn27rUS2
	 gRBJm/XNTCuNKKfYpE7HAF1YVtAIVQAjGJnYW+vDYge6sYYoWxL4RxZp/aCHFaATHD
	 s0e+JlWPnvutbc+9G2puikBCAvzfCH/wGxzUApL4=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id EB0B3056; Fri, 17 Apr 2026 14:58:48 +0800
X-QQ-mid: xmsmtpt1776409128t6ck4j4da
Message-ID: <tencent_C4F16CD096B0EAEAEE5ACDB07A266E382C0A@qq.com>
X-QQ-XMAILINFO: OOyEews/EdUgIxj2LcK15XYl/c7ZUvXYsaO/amZ4rhmi19nXt38hG53Y1WgCr1
	 FZNRON6wh8Zka44fs86WFMO5HFGX3mb2Eq5HV2LUOGpYL6UL2AyBiAXYDyg5UqdjHnhdXKNMMHpb
	 UzL6KdshhjGz8YRTixB5KXva99uJ7yorJCdV00xfKg8XFYKHaTcoI5j0oE5ooqrMAJNB8fTOkKy4
	 q05U1s/LK/4NY2AqIfaeYxP5Dr74llDAFBqFlfz6aScRBXc7/jISoHgD2nKgFhkBmwfC2oeDXZSd
	 iKZSSmeoycUFBGH05V43g4mnHXFAw51wn4DXBI2epBj7O2NrG7SGk1H+ZM4P30TZweobMP93tYOe
	 +2KlLm7T1jVhkrXKnvXOmMObSFDVHADP4PwqYQxQhYykX8WLXQiYM/e1MVfi8Z5gSK6yXpBJQNxW
	 fL/UB2PLhGsll/anFx4un3EOKovWScX+lvTykVN1uB1stp32IAMZBhUuqkxjupP9R+1RopVpVV4t
	 FrC+n9yV6IBBR0DPGVbVg2q6uKClzjXPV0Bw9Rgi3qLrJqpDTz7ImS0R6smfMAbNttLl4MVklIEI
	 ekvZGbh7wVRw/4a5KEMTgA89hxA1ckbIUMeslecJsX6kfGdncfbt2xJGUaO56ewu4V9r30KA6wAk
	 uG/fElTr2YbciVyhTj0RYnvBa7oBD62x/xMQV1XIV7tAVhlhlFBUy6ocve42TxF16YxOIucN4lJR
	 EJ1VaSGbO3QSOjH1kafZy487hJZ8OP69GPsFZwjWu5tDMjPDrfoM6ZudUSHyyB+W6eETM5LG+rU6
	 Kge2ohdsWCKviznKLtgFJZppNt7Knkmgf+FX6aF3FhvpH+P93cy07IGgb0THzI5MSir9nngNDLdt
	 hI0JUbsg+VvA7n2paiY/nmoAvd1S4az3VvrASNde/Yf6n8IgaX1O7HB4IumWhOqCVPU8uX8FVoDt
	 ZHq2wjybbQZMLX8AsCKDqkUsNxK1daBXwwFW3MoYpgv0rzUSFq0cEL0VA3CkQZ87Xbg+nR0Wm+o2
	 PS3UXbHTkS9Ung7www
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: Supports freeing newly created tree head
Date: Fri, 17 Apr 2026 14:58:49 +0800
X-OQ-MSGID: <20260417065848.415593-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69e1934c.a70a0220.7229.0011.GAE@google.com>
References: <69e1934c.a70a0220.7229.0011.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bnode_put() does not support deallocating a newly created btree
head node; therefore, regardless of whether hfsplus_bnode_find() succeeds
or fails, it cannot effectively reclaim the memory allocated for a newly
created head node.

When finding a head node, if the node is a newly created one, we can use
hfs_bnode_free() to reclaim its memory.

[1]
BUG: memory leak
unreferenced object 0xffff88811cabc840 (size 96):
  backtrace (crc 3e2dadb7):
    __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
    hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
    hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
    hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548

Fixes: 8ad2c6a36ac4 ("hfsplus: validate b-tree node 0 bitmap at mount time")
Reported-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98547b0428b6a6a3467c
Tested-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/bnode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff..65902104882a 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -598,14 +598,18 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 		if (key_size >= entry_size || key_size & 1)
 			goto node_error;
 	}
-	clear_bit(HFS_BNODE_NEW, &node->flags);
-	wake_up(&node->lock_wq);
+	if (num != HFSPLUS_TREE_HEAD) {
+		clear_bit(HFS_BNODE_NEW, &node->flags);
+		wake_up(&node->lock_wq);
+	}
 	return node;
 
 node_error:
 	set_bit(HFS_BNODE_ERROR, &node->flags);
-	clear_bit(HFS_BNODE_NEW, &node->flags);
-	wake_up(&node->lock_wq);
+	if (num != HFSPLUS_TREE_HEAD) {
+		clear_bit(HFS_BNODE_NEW, &node->flags);
+		wake_up(&node->lock_wq);
+	}
 	hfs_bnode_put(node);
 	return ERR_PTR(-EIO);
 }
@@ -694,6 +698,10 @@ void hfs_bnode_put(struct hfs_bnode *node)
 			hfs_bnode_free(node);
 			return;
 		}
+		if (test_bit(HFS_BNODE_NEW, &node->flags)) {
+			hfs_bnode_unhash(node);
+			hfs_bnode_free(node);
+		}
 		spin_unlock(&tree->hash_lock);
 	}
 }
-- 
2.43.0

