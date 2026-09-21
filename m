Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE14BEE59
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005059; cv=none; b=meiiq6rCRVrNYgr7Y6jV9Ti3GkN83wzMWw8eeMsXqvlFOMeOJfdBvfNPGY5KrPDQZAqDZG/Iy+nicilvZ2oL9tR+kTQr192rVxb2pi4uhhIYF7ECOKgWldSsJRkMsLGMKriKt3mLzEAEFVuOovY2tzDFSZqquR1LaQMlV41gl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005059; c=relaxed/simple;
	bh=tNY8mp7Zd9XSXR2DbfXcW8LgeX+dz5snbtzbNJsAzuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHw2+Ma903H5jf9RzH7nNFQ6F4Jf30k6qTEQAUh3gmPz+4cB2Jbs/0v4WKBvCfXJMGbopmyPCP2eRHkrj2jpRGpJYzSZ/JAhwRfeCmVDfe0J7854dHOerkGTvMG3wgyxTQYyR75I9YrKQ9dou9RvmoRx1sSvy+HfpoU+eVKyErA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=YTLr/zOr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="YTLr/zOr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so17732345e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790005055; x=1790609855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/rARZR2bhx+oYDBih3ESVQmEAJ7+6xRagAey+ssOdNk=;
        b=YTLr/zOrn3iTTERVcK5huDLlcWDnSS040Ht6O9I7Tf5ab+otg4vMDXHs5zjHFFVA27
         PlAzAz41ZiCOhKklrSXPjEb0j1aq7RGNvMLmIWjTp6QzsDtLfQJ5e3vgkmyGLTX7fLiB
         ZUB9nMHu6gf7Jm/RBLdyvqTdQCIyeg3kcALWiUAGdh4voC0r9a6CcnGMAMmF4QOsCuvr
         s2g9r1tsUyiWjvqqZGVBKJ/mIYoZAoMlD5Riybi0jyNnenvImaVUOsRNNLsFlVR7E7dW
         0GrgQEDfjVUnAoDdu64r0hevb7f0csZJH68mQk2JzyrSwm7MNf+WwCam8pOLfBZKP5tm
         YZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005055; x=1790609855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/rARZR2bhx+oYDBih3ESVQmEAJ7+6xRagAey+ssOdNk=;
        b=ceRfxBkAwcNOORAkoBbX4I5J9Xdsq7CJ9k5pt7W2bh9CreqncoaeQLTwUH0jJGHQ6V
         OaAhKOUJenOw4iz6Z5ifwE7jKQxO5rM2FUVW1ycGbovjab5yPGjMhz7WGN7b/pDNei92
         bot3FT37c8MNZoP3KfXn0MFp2rpWenlufYhOPTpex6eE9NeycOVbkOh943dUiPycoa+c
         F1klL/K4jzRmsIC0iP6yW9/Aj/yDLiAfYKuffY6+zd979isjCZIXvJl0Xe4AWPp2FEvP
         ff209pWPu7IEYXRL46sdeMlBnEW3wLfNY/cyhA13GTfs7J57VtWHypJa+tt1wBKSdy8W
         6HqA==
X-Forwarded-Encrypted: i=1; AKwUvBw8QSPjQfbATynqxi+bo1cVmWis6OjKPnemh0QO5AQUaTO7uMJ/L7cnBTq/VQqJwjWsLQlI3wMKjLVw7we7@vger.kernel.org
X-Gm-Message-State: AFuF++lTHYBmxmMcTHfp/5ZfCgeUFEH5jDwys60YnLNR/Rl7GIZBRLpY
	UO/SJOmHNlK8DKxm7GfowdaRO6duZGQg/yE7JpOV0N3SoVYgzRc9qx1wFu1CfciAyPQ=
X-Gm-Gg: AYBFou3/p5PSN9iMqaYm8GZDFu/4v7ujxfeq9XYn3qePAfrNbkZCN9h4tbifamFQfBO
	SSF9ZEOwod7AAJX0bE12QlvMScjrzo2m4oFrjv6QBYMy/wV0uqW3G7ekgZJXCRMaKc0QUn7Ysiu
	01KtTXKruWT3K4isod074iIASwhb8kv48LOocL3ROMTtHUWNC9LhRq8LzObnJ89R94xYC9jPWj3
	+0e35gW261aG36SVxlbyrGShUpBUs9akSoWkAWrCYqrEQPUbtprn3w879SZ2QRteUKhvRnUdVrY
	VoSGdk+cs7CgE3cJdYGIRYwN8Padz4LJqMUj35yhnxdhBIfi58V+O9IhC4pv4MAzwI/wyW6Xcbm
	FAbfWNszr+toJL8/lAfUmabgvBbfVWUjrW/sWRgFc9L+bb08EtpKWrBDplWHOS3EZd/lXynTcC1
	BM2JwV2zkSlbicvC1gotwjSM2N1gMwjyVzoXJ4PKRQ/eaweJI+F+Snu13wut+mgnEMmChhfo1ap
	rcst0Q=
X-Received: by 2002:a05:600c:83cf:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-49fce783698mr82645135e9.19.1790005054514;
        Mon, 21 Sep 2026 08:37:34 -0700 (PDT)
Received: from localhost ([2a02:168:9d56:1:e1c4:67b1:23e:28ed])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm237438295e9.5.2026.09.21.08.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 08:37:33 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Kyle Zeng <kylebot@openai.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org,
	Bruno Produit <bruno.produit@trailofbits.com>,
	syzbot+d729df28d933979e017a@syzkaller.appspotmail.com,
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com,
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com,
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com,
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
Subject: [PATCH v2] hfs/hfsplus: serialize B-tree close against folio release
Date: Mon, 21 Sep 2026 17:37:29 +0200
Message-ID: <20260921153729.600313-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

B-tree nodes with a zero reference count remain in the node hash until
folio reclaim or tree teardown frees them.  The folio release callbacks
remove nodes while holding hash_lock, but hfs_btree_close() walks and
frees the same hash without that lock.  Reclaim can therefore unhash and
free a node after close has loaded its pointer, causing a use-after-free
or double-free. 

The following syzkaller crashes seem to be the same UAF in 
{hfs,hfsplus}_btree_close() (or {hfs,hfsplus}_bnode_unhash()) and follow 
the same pattern, but do not contain a reproducer to confirm. 

Detach each node with hfs_bnode_unhash() while holding hash_lock before
inspecting and freeing it.  Drop the lock before hfs_bnode_free() so a
large tree is not freed while holding a spinlock.  Apply the same fix to
the matching HFS+ implementation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d729df28d933979e017a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d729df28d933979e017a
Reported-by: syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2eac7d175baf21e6a5d5
Reported-by: syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7155b2fe09e033c91381
Reported-by: syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=adeb387cede15eb11607
Reported-by: syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae7f2423f3648100506d
Assisted-by: Codex:gpt-5.6-sol
Reported-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 fs/hfs/btree.c     | 7 +++++--
 fs/hfsplus/btree.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8fc9..4f0ddc76e 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -310,14 +310,17 @@ void hfs_btree_close(struct hfs_btree *tree)
 		return;
 
 	for (i = 0; i < NODE_HASH_SIZE; i++) {
+		spin_lock(&tree->hash_lock);
 		while ((node = tree->node_hash[i])) {
-			tree->node_hash[i] = node->next_hash;
+			hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
 			if (atomic_read(&node->refcnt))
 				pr_err("node %d:%d still has %d user(s)!\n",
 				       node->tree->cnid, node->this,
 				       atomic_read(&node->refcnt));
 			hfs_bnode_free(node);
-			tree->node_hash_cnt--;
+			spin_lock(&tree->hash_lock);
 		}
+		spin_unlock(&tree->hash_lock);
 	}
 	iput(tree->inode);
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd565..bd4dbdbc8 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -417,15 +417,18 @@ void hfs_btree_close(struct hfs_btree *tree)
 		return;
 
 	for (i = 0; i < NODE_HASH_SIZE; i++) {
+		spin_lock(&tree->hash_lock);
 		while ((node = tree->node_hash[i])) {
-			tree->node_hash[i] = node->next_hash;
+			hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
 			if (atomic_read(&node->refcnt))
 				pr_crit("node %d:%d "
 						"still has %d user(s)!\n",
 					node->tree->cnid, node->this,
 					atomic_read(&node->refcnt));
 			hfs_bnode_free(node);
-			tree->node_hash_cnt--;
+			spin_lock(&tree->hash_lock);
 		}
+		spin_unlock(&tree->hash_lock);
 	}
 	iput(tree->inode);
