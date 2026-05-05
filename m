Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3A3CF043
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960449; cv=none; b=R1JXAGWBLRvv/he4frYtkHpGHbXZMvSMovMNeJtaI/IcdLDz+GKf6nW7XOlP55nkBTrvbzptNz02Db9KJhgQEALbnyiccYFUIUCGSnPV5SPO26x5hBtq7EtZAXzc1khAIb6TZqSlODruYFKcZUAEUM7y4Zucqe4DXvXQsSTVAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960449; c=relaxed/simple;
	bh=aSlFRyC1v50+OsbbCuB6ro9UuI73lUt71N0FAylSDAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmO9SVbL7x9dt6XEvNXeGUaHCymEKRaxf4Y2MHhNcCIIl58c9nQQzi4ufkSlIphCqZsf01gAJH2KDgv8LKj4VeJQyElsgHnfm6NiPiuOqhlBVAKkT11QpLpqFozKjLL6qEPcC73olGkKiztuNprayTzuPnAWqmoUAf9M0yegiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ntpy6DHH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ntpy6DHH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IrYHLobbtLjSEAGxezvRghWFI+9XQZb4ZL2LHSmFlPo=; b=Ntpy6DHH5fi0283yuXpJVN3zHe
	FZgE1OmdGcYCmTC4Y3UyCOYCYjkxpcAxMDABJZtnGN6YMBpH44cfihsbRZOy9NvLbUr3aVQh7Edmj
	aLXkm7xO4UA21wnJ1IKxLbtlbB4/AuuePq1HpqcD1yf49PFfjg9YvMIQpoN70ogKSCOA1OikIlBp2
	irK3GtEl10DboKeu7CgEwj4CBp/9lFVEIpXdpznxCPgGPBTbHKyEZq9PVf+4lfz+pct1WH5dvFSFr
	5ts+Bp6btbAXa643/cf7MGu7oCdoI8CFJhw+mwkaiYFz9mIYfS7D6xO+Gi90SdHyVohiWT4CQkGxe
	VlBCP7Kg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8ji-00000005IAG-0xBM;
	Tue, 05 May 2026 05:54:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 25/25] make cursors NORCU
Date: Tue,  5 May 2026 06:54:12 +0100
Message-ID: <20260505055412.1261144-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

All it requires is making sure that d_walk() will skip *all*
CURSOR dentries, even if somebody passes it one as an argument.

Cursors are negative and unhashed all along, never get added to
LRU or to shrink lists and no RCU references via ->d_sib are
possible for those - dentry_unlist() makes sure that no killed
dentry has ->d_sib.next left pointing to a cursor.

Seeing that a cursor is allocated every time we open a directory
on autofs, debugfs, devpts, etc., avoiding an RCU delay when such
opened files get closed is attractive...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2b5cf6e52ed6..f64a02998184 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1429,6 +1429,8 @@ static void d_walk(struct dentry *parent, void *data,
 	read_seqbegin_or_lock(&rename_lock, &seq);
 	this_parent = parent;
 	spin_lock(&this_parent->d_lock);
+	if (unlikely(this_parent->d_flags & DCACHE_DENTRY_CURSOR))
+		goto out_unlock;
 
 	ret = enter(data, this_parent);
 	switch (ret) {
@@ -1982,7 +1984,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
 {
 	struct dentry *dentry = d_alloc_anon(parent->d_sb);
 	if (dentry) {
-		dentry->d_flags |= DCACHE_DENTRY_CURSOR;
+		dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
 		dentry->d_parent = dget(parent);
 	}
 	return dentry;
-- 
2.47.3

