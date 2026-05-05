Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE03CBE89
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960447; cv=none; b=inG3R3sWMgfyWnOe0+wOfBrqRz1+AEvkEG8pG+AuyNrTspnDYjaFh6v3CicSBYma8mkIRyhvCOc2iAD+pbzq41PjcaKp924qH2oeWXjrX0jSoFLN9O0UpfTXxm8gu1ORT+N3d7ktPkSth/kpjmV56SWBT/iGCjIPCGshovoETEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960447; c=relaxed/simple;
	bh=cNxX/8T9AlO4p9RsZ3Rm7G3vuYCf7VfwRqKpt0Mf/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUgDuW+Z21QqV4ElDTiT7e1hLfzCDlJnP7ZOQ2yMHzRZEBjQYVtgzs8up9rbWn5mqeH6mdhLF39CN0NIfJr+D5UY/Bg2oOHkBkd32qJsRvu8GTDJeayk4cGhNYcYfuQfRGeMMfKj+oGR/SMBjnKVHyiHBmmlqjgrxJjqxk+GmZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=giOaghNh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="giOaghNh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Sw2lcNnlV+A5OOdoYbLqzablcEr0dC49lbBjJIUsqZ4=; b=giOaghNheEaNjg8ygk0pIUOrGb
	0o5PWydbVOGumxLrgLKuWCaSQSeL9xe/Z+9JDRGRAwv2BBKsuyAcEt2HeHy2J+Hafg+/2H2UDQxNX
	IeO/aP4s+zAQHd4rHMeknPOhQdL7n2nNBLPXk0bektkgqrPcJCqewqISrIATEpE41XnThim9H1PJ0
	W2uagXuNvb5P46HgXc2oHi6UHcbykZ8nyvZZeuSlVf/18S6u0pFADt+94R8AH3cF6UDQ3rBWKKgFB
	HVO3mUNQxzVt5H0ikL5/7szgjDS7LVeXGJdlrNF0bMb/5nv+2ckbr6FkyKX6oole9XpfGl2lRgw4r
	jjq+839Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jf-00000005I9E-3xF1;
	Tue, 05 May 2026 05:54:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 17/25] reducing rcu_read_lock() scopes in dput and friends, step 6
Date: Tue,  5 May 2026 06:54:04 +0100
Message-ID: <20260505055412.1261144-18-viro@zeniv.linux.org.uk>
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

In the "got a victim" case in shrink_dcache_tree() we can
pull the rcu_read_unlock() call up to right after grabbing
->d_lock.

Document the resulting rcu_read_lock() scope - it spans from
unbalanced rcu_read_lock() in select_collect2() to unbalanced
rcu_read_unlock() in shrink_dcache_tree(), bridging two
->d_lock scopes into single RCU read-side critical area.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 5872f369ddaf..6822e8bfc6af 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1619,6 +1619,15 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 
 	if (dentry->d_lockref.count <= 0) {
 		if (!__move_to_shrink_list(dentry, &data->dispose)) {
+			/*
+			 * We need an enter RCU read-side critical area that
+			 * would extend past the return from d_walk() and
+			 * we are in the scope of ->d_lock that will terminate
+			 * before that, so we use rcu_read_lock() to bridge
+			 * over to the scope of ->d_lock in d_walk() caller.
+			 * The scope of rcu_read_lock() spans from here to
+			 * paired rcu_read_unlock() in shrink_dcache_tree().
+			 */
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
@@ -1663,8 +1672,20 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
 			struct dentry *v = data.victim;
-
+			/*
+			 * select_collect2() has picked a dentry that was
+			 * either dying or on a shrink list and arranged
+			 * for it to be returned to us.  We are still in
+			 * the RCU read-side critical area started there
+			 * (rcu_read_lock() scope opened in select_collect2()),
+			 * so dentry couldn't have been freed yet, but its
+			 * state might've changed since we dropped ->d_lock
+			 * on the way out.  Switch over to ->d_lock scope
+			 * and recheck the dentry state.
+			 */
 			spin_lock(&v->d_lock);
+			rcu_read_unlock();
+
 			if (v->d_lockref.count < 0 &&
 			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
 				struct completion_list wait;
@@ -1672,13 +1693,11 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				// it becomes invisible to d_walk().
 				d_add_waiter(v, &wait);
 				spin_unlock(&v->d_lock);
-				rcu_read_unlock();
 				if (!list_empty(&data.dispose))
 					shrink_dentry_list(&data.dispose);
 				wait_for_completion(&wait.completion);
 				continue;
 			}
-			rcu_read_unlock();
 			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
-- 
2.47.3

