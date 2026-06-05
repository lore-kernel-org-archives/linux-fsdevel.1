Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA83115BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636159; cv=none; b=EL8/BgnuRoOkebiWehxKAEcQjVI69wWlSiGKmfrK4vGc6ZmutQDvrFK0tVEdwMWMwlDbhNLMRstIg6FRgw3BxKA3Uw56/Hf0sjvsRSrWtjB5UBTKUK4Xe73Et9RmGp0Xa7htym8tYggWkmYHJzuB93dvff/N6JuBG7mp6K3Lkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636159; c=relaxed/simple;
	bh=aAdfaKkMiziO06/tV/FA2GT8fI/boPBGzFp8gPl9Y0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F91OwAvDFG/6mcN9N3uf/V67mLvL5f0ojh9InXPPUBXTIjV61X/oXkvFLlsL930ilRrdF5hLiZzoTxEh4jYzjVjIcbovld0HcyGerRxSjuphNDByDzcke54ejLLc5vevk1ZYOE3I6WfYTydURTjZj3Er2fYeeqwPdMTXj03k6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rzFSNnor; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rzFSNnor"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=7UXTNcgAOnYzSlyEyz07Yk4AqacG2a8cEa5jS+hjCkE=; b=rzFSNnorTQ/z++UrAtB+FEaS4e
	nd3gDyB2cJgcnVv0nHg7mx7fm3dhdc7FloFSbzjIQ8xnDo12RyKDnxEOOBm4EObi3Do7xQobP1Lp6
	6v0xrtzyUxyL4wgL1vuaxs+fqin06zlIQWrHg/zqPU0cU1ufxmhnOufuK7+ZWvo2+skyPhmfy/+Bc
	p5KmvltV1P5dQNi/asSn4IoK7H9Lx4wHfGHh7aHnbxgj0FdUROOn4DOciVoxPxmy4NeWGH1GbuQtK
	T5BBbFQzE2oAd5UWLYmPEB5nve8rgi8zjlr0fFGn2qjQzaC/R3kReoQShu2brfZnFt94SoV5KdRTc
	rTMV9PxA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMo0-00000005Tvx-4BYz;
	Fri, 05 Jun 2026 05:09:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 22/22] make cursors NORCU
Date: Fri,  5 Jun 2026 06:09:10 +0100
Message-ID: <20260605050910.1306432-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
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
index e7487c92c21a..1f50100bce49 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1443,6 +1443,8 @@ static void d_walk(struct dentry *parent, void *data,
 	read_seqbegin_or_lock(&rename_lock, &seq);
 	this_parent = parent;
 	spin_lock(&this_parent->d_lock);
+	if (unlikely(this_parent->d_flags & DCACHE_DENTRY_CURSOR))
+		goto out_unlock;
 
 	ret = enter(data, this_parent);
 	switch (ret) {
@@ -1996,7 +1998,7 @@ struct dentry *d_alloc_cursor(struct dentry * parent)
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

