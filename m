Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8C3B7752
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736972; cv=none; b=p1UAYmxe4DAiu9m84+/gXRBBSgeUonlIo+JJ5jsSGVfni9HoZTnuAVLEai/HyKnbug8MXHDQ3Gx5QYPiGxW4XFHZ94z+zla39VmWRki+fqMf3ps5IQcSM/RMxKLTntc86N0NKojm3wXr3s1/S2G+X2XIMQWvibINXjecgsIZGyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736972; c=relaxed/simple;
	bh=y6DmwY2NNPgvI5dt5D40qWsbuLNJ4qNAgz6w9YhiC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWC/+vvKSR1GMBQa831k16fapgZiDef1zz19CQiiRsb4+3HIqkr8HucgQY+JE+8JlL6RdQNBb1SDwSo/YT8Tco53x2In+HQlNdUpCd+qZtqnVcL2Wn1pnZeMHbiV5TQWtsZ5gsOZGybjm9GNsDnsvpnWZT7GLLU53jICLskW8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=azWJSIph; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="azWJSIph"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so494760f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1789736962; x=1790341762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ALGqgWpfi/Okg/wnkXal9Ie5Tl89DL6PBwvjP4sq+Ek=;
        b=azWJSIphmak9h/D1OAMcEOLZ17NoRoUnPB9wbYNMs3uy4PQiCEBwlNRm2rsoVsyfRS
         peRXbdKqfyvpjiJG1H14TF6xJZQ5qqm46ioqBRmJJEKe8GMDPfNQVqy9G9LQjEu3mds0
         /XdjWnjUSdYoJJS61IPjFQHGa5jseeNI5QOdPLyH+BXKHAHDSplNMZK2owkU1lsKWWU4
         eTwy7iLZSEsJfjd4RNKGluV7viNXOsB6mFGQ6jYGJ9MaAUG4OpVRrpUjH96TArdbhyFQ
         cYpxIA6RqK1CV5Ruz1SsmOOeQ9+eoNzxZ8uyWrPM+juBZSEAt41wxFy3tsGStPz6VX3e
         NgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789736962; x=1790341762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ALGqgWpfi/Okg/wnkXal9Ie5Tl89DL6PBwvjP4sq+Ek=;
        b=PncVSuROFHaJxbBFAMq96n17VN9s3f0yjcpLpWvqUVotC+D8TcaNvgUD0UV/01W3iZ
         Ax/qvVN7okL5rjtubWPraOZD7eR3OpQ95IuiMAT2BPeK9Kg3Bi2D5lRmXqGFCzYu8ziE
         O6d9KyOFSijdA7GYPpRUOTXk79CmisUcrO1cPcC2bRuD5DpE+7rg7ikr/LBgDpuszXJo
         rJAde3UMfAgHmAD6PvsHjVy4yL9BCXzNDmvOrLEuctUgy+m6G3m/S3aNc2wTYsMrNJ+v
         yhImZfAjO8ujfkelrZtd69AWYOhib/Nzp+3W17c1UyVvckTiRz7dCwwUayN6CCGlYt3/
         gg0w==
X-Forwarded-Encrypted: i=1; AKwUvBwbabbINOd301xcC5qRtI8v7tbvv7dqF/gmzW6Pzerc+MR8A2Nuo770fgvDG8OniaNjZSLOEZZvQjhmmTdn@vger.kernel.org
X-Gm-Message-State: AFuF++lbS1Q8kcNXsccJskf7SzVkWfOgTFqIvonngd0hG9lj4Azz/n5n
	R9/kuqoQYPRM8o7BFk6JHO9yn8eEMq/Nx7cSde4UvZsZrEMwYvrSnwk91DF8ERl3T1U=
X-Gm-Gg: AYBFou09S7oZYtVlYOQalpM0CtkfeEF1JUjg/ubG/Ws9Q8Ju0c0RRicPHGNpoyh52iF
	YpJ9y2b+ffZCoxJYpFVcxL6us5q5VrTlGH/dEc+pUVrOOkY8iULcJ4Tdp5HZxzrY6osVIKjE3Qg
	DXhHv4ipSZk1HOn48SjTt2O3RNCRHCA8MWCeB8bf/8khwlrAH9zJAcdJ/U6dxcJ14/zTzM/uP0Q
	w358g0RNW+h+mCxtLl9edhoC7dWBESzBp2rhHAXouYxAsIm8yB/+kw1xzIgZ9d7HJ68ix+IB3Kj
	82IsRWqqp57G0ujZsg5+H6AnZY4h4li8LxXMDPvaPHEs+NVYoyqyKqet1L6g9dTyD5QONFav5m1
	883bNCeHC8WJmUq5fmUTs2htV4kKe/RyzzMb5YLLhORVpkpMHLmPJyjL1v26TtmXEtlknq4Ccm5
	HiVj1PavUC94e2XfrKS+ehxERlz9STKc4kKXz9LdEYdJXbpr1sIvQjJZJ1OzaSl9xZ1Zu+7hvsW
	/JwZQ==
X-Received: by 2002:a05:6000:4021:b0:484:3314:eff6 with SMTP id ffacd0b85a97d-4871e3941f5mr6238328f8f.28.1789736962162;
        Fri, 18 Sep 2026 06:09:22 -0700 (PDT)
Received: from localhost ([2001:1620:544:1:9163:2f88:bd77:993])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4871ff55663sm3862924f8f.17.2026.09.18.06.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 06:09:21 -0700 (PDT)
From: Bruno Produit <bruno.produit@trailofbits.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: Kyle Zeng <kylebot@openai.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	syzbot+d729df28d933979e017a@syzkaller.appspotmail.com,
	syzbot+2eac7d175baf21e6a5d5@syzkaller.appspotmail.com,
	syzbot+7155b2fe09e033c91381@syzkaller.appspotmail.com,
	syzbot+adeb387cede15eb11607@syzkaller.appspotmail.com,
	syzbot+ae7f2423f3648100506d@syzkaller.appspotmail.com,
	Bruno Produit <bruno.produit@trailofbits.com>
Subject: [PATCH] hfs/hfsplus: serialize B-tree close against folio release
Date: Fri, 18 Sep 2026 15:08:53 +0200
Message-ID: <20260918130853.216497-1-bruno.produit@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

From: Kyle Zeng <kylebot@openai.com>

B-tree nodes with a zero reference count remain in the node hash until
folio reclaim or tree teardown frees them.  The folio release callbacks
remove nodes while holding hash_lock, but hfs_btree_close() walks and
frees the same hash without that lock.  Reclaim can therefore unhash and
free a node after close has loaded its pointer, causing a use-after-free
or double-free.

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
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
---
 fs/hfs/btree.c     | 11 ++++++++---
 fs/hfsplus/btree.c | 11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 41b4e8fc9..d85a1df9f 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -310,14 +310,19 @@ void hfs_btree_close(struct hfs_btree *tree)
 		return;
 
 	for (i = 0; i < NODE_HASH_SIZE; i++) {
-		while ((node = tree->node_hash[i])) {
-			tree->node_hash[i] = node->next_hash;
+		for (;;) {
+			spin_lock(&tree->hash_lock);
+			node = tree->node_hash[i];
+			if (node)
+				hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
+			if (!node)
+				break;
 			if (atomic_read(&node->refcnt))
 				pr_err("node %d:%d still has %d user(s)!\n",
 				       node->tree->cnid, node->this,
 				       atomic_read(&node->refcnt));
 			hfs_bnode_free(node);
-			tree->node_hash_cnt--;
 		}
 	}
 	iput(tree->inode);
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 2ea8cd565..a90c9f416 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -417,15 +417,20 @@ void hfs_btree_close(struct hfs_btree *tree)
 		return;
 
 	for (i = 0; i < NODE_HASH_SIZE; i++) {
-		while ((node = tree->node_hash[i])) {
-			tree->node_hash[i] = node->next_hash;
+		for (;;) {
+			spin_lock(&tree->hash_lock);
+			node = tree->node_hash[i];
+			if (node)
+				hfs_bnode_unhash(node);
+			spin_unlock(&tree->hash_lock);
+			if (!node)
+				break;
 			if (atomic_read(&node->refcnt))
 				pr_crit("node %d:%d "
 						"still has %d user(s)!\n",
 					node->tree->cnid, node->this,
 					atomic_read(&node->refcnt));
 			hfs_bnode_free(node);
-			tree->node_hash_cnt--;
 		}
 	}
 	iput(tree->inode);
