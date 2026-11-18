Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039333;
	b=T2VvT3uYncxhNr6whto0H0jCKju7NLE0UbD1y/nj+4J25J8s87Tn93sDeGTqNFqwt3Qp
	 Zj+03bYh79aCJSOVeuOyX12gI0p29eErnoDSuZlN+50CapQZRH4gCuRu4u2oIVlxwQNMp
	 oUneceUPhxLYeiDRAivlE3QUJG8dwwKBInoRmOd83Pk5PIcV657XxyEoFhUiD7c0BTfTp
	 AfEbq3DXWmS6ScYD8fVIf+B5y5ccUO6D2GWIO6CufqCcJLH34+plaXwahiqz2423wyfxe
	 UQG7echZ7D0xVDabmfq8gPqpvD6hHEuupEEbx+Ykn1+ubGaOXGn4DqSj5ZBlBvwoYTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039333;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1qf7uSDTfTPQk21efhm/tBhbA5RvbiTTxPmHSCVNVdY=;
	b=F0W+rK6d6VnJL2BarhLa7UW73gtK0ceYtb+lwtNH++9Gq9vAW+QUcbOQv6CujR9vnkwg
	 GcsxstGtxiajj8S+CTQxkJoBf5dnb0mW+5plMyJqHHQRVdePeEM27OZDzdetrmD0EOQYZ
	 CKD5OPCflYNfO07fmh1fXXLqEJ0c/YEEOI5LlE2NN6xALWsHQ5gTBcmZUGj0JZOeirMuP
	 4wZDKMD/ds16lmpCAG+LuTcYOUy1F/fwqEdD6WnexM6+3iraNCegtxe5u02M/1muqBBDQ
	 x3R2QFO0Meo7kSWnfGaxRnpN08bBzP7gJ1OV24cma6tNPLXytFdwkgTVDPHokNWpQiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hxHgjYM2;
	arc=none smtp.remote-ip=95.215.58.147
Received: from mta1.migadu.com (out-147.mta1.migadu.com [95.215.58.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27033606A330
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 22:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27033606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hxHgjYM2
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eU2UIWc/uDPlgdmNIZspsaWM4Vgx4y9vwFWYm84K9e4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795039331; v=1; x=1795644131;
 b=hxHgjYM2anoEq74CI9NwQcPpC6JjbuySHHxCHdrvnKt8whXC+LRgApCTd+8/Vc6L+z2zzkTO
 1+qJ1dU/T2VRCYSfCn2jQi6m2N2qqUw73L2u1iwLoLWxw5BD4WY1KP6+AWxu8hnhkpq2hbL+Swq
 MOlBdYLYXEiBTWxwXVtliWi8=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8c0479c3466e940;
	Wed, 18 Nov 2026 22:02:11 +0000
X-Mizu-Trace-ID: b8c0479c3466e940
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Ian Kent <raven@themaw.net>,
	"T . J . Mercier" <tjmercier@google.com>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] kernfs: don't take kernfs_iattr_rwsem to publish KERNFS_REMOVING
Date: Wed, 18 Nov 2026 14:01:51 -0800
Message-ID: <20261118220154.2965621-5-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261118220154.2965621-1-shakeel.butt@linux.dev>
References: <20261118220154.2965621-1-shakeel.butt@linux.dev>
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

__kernfs_remove() takes kernfs_iattr_rwsem for writing while it marks
a subtree KERNFS_REMOVING, inside kernfs_rwsem.  Commit 507d8ce13f5b
("kernfs: Don't set_nlink for directories being removed") added it so
that a refresh would not set the i_nlink of a directory whose removal
has started.  The refresh no longer sets i_nlink, so the lock is not
needed.

The flag is only set here, under kernfs_rwsem.  Inode setup reads it
under kernfs_rwsem.  getattr reads it without and reports the old link
count or 0, either of which is right for a stat() racing the removal.

Drop the lock, mark the store and the load, and read the flags once in
kernfs_dir_nlink(), as the type bits share the word.

kernfs_iattr_rwsem write acquisitions (lock_stat), before -> after:

  5 dummy netdevs created and removed     1110 ->  740
  100 cgroup mkdirs and 100 rmdirs        4500 -> 3000

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c   | 10 ++++++----
 fs/kernfs/inode.c |  7 +++++--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index ef23eac684c6..890aca5d8d70 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1604,15 +1604,17 @@ static void __kernfs_remove(struct kernfs_node *kn)
 
 	pr_debug("kernfs %s: removing\n", kernfs_rcu_name(kn));
 
-	/* prevent new usage by marking all nodes removing and deactivating */
-	down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
+	/*
+	 * Prevent new usage by marking all nodes removing and deactivating.
+	 * KERNFS_REMOVING is only set here, under kernfs_rwsem.
+	 * kernfs_dir_nlink() reads it without that lock.
+	 */
 	pos = NULL;
 	while ((pos = kernfs_next_descendant_post(pos, kn))) {
-		pos->flags |= KERNFS_REMOVING;
+		WRITE_ONCE(pos->flags, pos->flags | KERNFS_REMOVING);
 		if (kernfs_active(pos))
 			atomic_add(KN_DEACTIVATED_BIAS, &pos->active);
 	}
-	up_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
 	/* deactivate and unlink the subtree node-by-node */
 	do {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 2f463c0354a5..ca234f69882b 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -165,9 +165,12 @@ static inline void set_inode_attr(struct inode *inode,
  */
 static bool kernfs_dir_nlink(struct kernfs_node *kn, unsigned int *nlink)
 {
-	if (kernfs_type(kn) != KERNFS_DIR)
+	/* KERNFS_REMOVING can be set concurrently; read the flags once. */
+	unsigned short flags = READ_ONCE(kn->flags);
+
+	if ((flags & KERNFS_TYPE_MASK) != KERNFS_DIR)
 		return false;
-	*nlink = (kn->flags & KERNFS_REMOVING) ? 0 :
+	*nlink = (flags & KERNFS_REMOVING) ? 0 :
 		 READ_ONCE(kn->dir.subdirs) + 2;
 	return true;
 }
-- 
2.53.1-Meta

