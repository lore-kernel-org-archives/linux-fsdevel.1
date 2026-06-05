Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB83FDC08
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636158; cv=none; b=dG4SZGfCHczV70trw9T0qCT1z5NJRCxdtBHK0cdsgnJ/Pb8x9tWKtLGJC95iKESYzbdoFoJw9d+UpssMVhW3qlWarlxO039Pz2oKgH09ocIjqr+ipEpAJXv7Vyp4tdIVVc0RMy0NLZoI2LpN9q6Tgw0NPB0ckEr4dC9eMOZCEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636158; c=relaxed/simple;
	bh=NkT6SkdVBuo58Fup6JWAyVVAiGFPaWIlg3v1vN+eIyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzziOs96tzy6WOK5SKhvvEYGL3RbwtDL00vy4H3Uv61mxUKNYZZhTX3/ofBST659t4tHJzXklVmWqJFZW529mLvb86okH6iCvGNdWOoM6o6umxENJuADI3aKk2mjndk0tkQq57GR2hGf7pbDLicMrUkJz9Z6JGE5YFBO4dgMh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QZSB+OjK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QZSB+OjK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=60Ie7Gxqg5uNv7UibLyTP1O8tsXeiofIJHH21Y/o5Qw=; b=QZSB+OjKJkSvyCrdspgX+CjMbZ
	bWVCeFVa42Wxv1CGPYuiY8it3Auo7gocgThEgOMO2nqnagrd1XzKZF1b5ufO0AkvCItvrvzEbrpeG
	2KJ2enT/qZxHDRyjTPZCLPjHSRwzp+4JrDIaVSqvtFUt7CkLyP3ZEFyKmR82ZT0M5McyZF2L5/wyO
	oHEaA7Ol9BAfo68tCZH78Y1JGiwi5NgTAGtnV48456M29Zt6WTilifTEMx5Fm5xjWqmELSQgiUA+D
	Hc0bfnQqZg9SVedr1prWrG2hYBX1f+iKEc+isBEpQhbwM0q5obyK2wRaLcOwzYV5SNsix4S5Vep86
	HaHArQ3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnz-00000005Tuu-12U3;
	Fri, 05 Jun 2026 05:09:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 17/22] d_walk(): shrink rcu_read_lock() scope
Date: Fri,  5 Jun 2026 06:09:05 +0100
Message-ID: <20260605050910.1306432-18-viro@zeniv.linux.org.uk>
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

we only need it to bridge over from ->d_lock scope of child to ->d_lock
scope of parent; dropping ->d_lock at rename_retry doesn't need to be
in rcu_read_lock() scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf4bd6c37d04..94749442fa68 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1491,14 +1491,15 @@ static void d_walk(struct dentry *parent, void *data,
 	/*
 	 * All done at this level ... ascend and resume the search.
 	 */
-	rcu_read_lock();
 ascend:
 	if (this_parent != parent) {
 		dentry = this_parent;
 		this_parent = dentry->d_parent;
 
+		rcu_read_lock();
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&this_parent->d_lock);
+		rcu_read_unlock();
 
 		/* might go back up the wrong parent if we have had a rename. */
 		if (need_seqretry(&rename_lock, seq))
@@ -1506,7 +1507,6 @@ static void d_walk(struct dentry *parent, void *data,
 		/* go into the first sibling still alive */
 		hlist_for_each_entry_continue(dentry, d_sib) {
 			if (likely(!(dentry->d_flags & DCACHE_DENTRY_KILLED))) {
-				rcu_read_unlock();
 				goto resume;
 			}
 		}
@@ -1514,7 +1514,6 @@ static void d_walk(struct dentry *parent, void *data,
 	}
 	if (need_seqretry(&rename_lock, seq))
 		goto rename_retry;
-	rcu_read_unlock();
 
 out_unlock:
 	spin_unlock(&this_parent->d_lock);
@@ -1523,7 +1522,6 @@ static void d_walk(struct dentry *parent, void *data,
 
 rename_retry:
 	spin_unlock(&this_parent->d_lock);
-	rcu_read_unlock();
 	BUG_ON(seq & 1);
 	if (!retry)
 		return;
-- 
2.47.3

