Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4683469F5
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943067; cv=none; b=BUVxTzcXo5gTEQn6XSYc2j8ndEQcjQ5r3BvLCsAGKP5iUA77BbsaDU7aLXKoCTtSMPcobE2KK1oNkQlYv/qrZXGq7yZqsLUZU+sjFuPRRoficmHqO0SVFHXY4B1RQ/2k3RNeJc8m0cKfPTLmel61JhDnkWCHpMedEW1U9UWwu40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943067; c=relaxed/simple;
	bh=nUQ4r9xd2ffStRvhBZ/55TJyhiOKtRa0tWDaSnM+sc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cw6/yxwqsiS1ZyTCj+3oP5i9Nw5Y+3AJsaYIPc3G+Vt0nO2PmpezNAt3Rtkgv4pWDG2XkzuUxbL+TULXpvm8GB1QCLR5KJwCVGMVj7vce7lCxOsImo5qzrhVjtBuKSY7LIrnEuDibWyxwajGKOFPkqWAFIrLphBAALQEdmgfHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WHO7NW3I; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WHO7NW3I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vI8Brpk0ytcJLzMlTca43QJ8X30aZbEdnbqu+PhbRes=; b=WHO7NW3ICR5hfqrJ84KgHLgvIo
	Wroskl4nSCRpLrD5K4eoxtdc+mXpr+XcBgC3rH9gC1FNLFHV0hn/8gBAgMQEvVCdarEgrTyN1/4yn
	I6p/y5VbpDApeO6t1KQfi+KaOPyqq7TUO5xWKgYNffWNjso5eynSgoO4wcj8fGmunjy3IUSt0csN1
	kWXoM4L2JZQk/fMGnjUgKWmKYyrk98w9/zsxc7pITnkK28bxOpPpCgvPArcMko8kukfHVPLpmG4Hs
	bBjOUsuirZ3FKeVhbMiRtcNMcznlMxMoI8Lqe30uXe70UTOwRmT8su0EHjbXg5wXb3bjmZh2/UUr6
	urhZPskA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyi-0000000A99X-0zjK;
	Sat, 11 Apr 2026 21:34:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 11/11] document dentry_kill()
Date: Sat, 11 Apr 2026 22:34:54 +0100
Message-ID: <20260411213454.2418381-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a848a082d056..64e2cd4847e1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -737,6 +737,44 @@ static bool lock_for_kill(struct dentry *dentry)
 	return false;
 }
 
+/**
+ * dentry_kill - evict a dentry
+ * @dentry:	dentry to be evicted
+ *
+ * All dentry evictions are done by this function.  The reference we are
+ * passed does not contribute to the refcount; the caller had either
+ * already decremented the refcount or it had never held one in the
+ * first place.  @dentry->d_lock is held by the caller and dropped
+ * by dentry_kill(@dentry).
+ *
+ * We are guaranteed that nobody had called dentry_free(@dentry)
+ * prior to the beginning of RCU read-side critical area we are in.
+ *
+ * Caller must not access @dentry after the call.
+ *
+ * If eviction of @dentry drops the last reference to its parent,
+ * the reference to parent is returned to caller.  In that case
+ * it is guaranteed to satisfy the requirements for dentry_kill()
+ * argument - its ->d_lock is held and we are guaranteed that nobody
+ * had passed it to dentry_free() prior to acquisition of its ->d_lock.
+ * Otherwise %NULL is returned.
+ *
+ * If @dentry is idle and remains such after we assemble the full
+ * locking environment for eviction (see lock_for_kill() for details)
+ * we mark it doomed (->d_lockref.count < 0) and proceed to detaching
+ * it from any filesystem objects.  Otherwise we drop ->d_lock and
+ * return %NULL.
+ *
+ * Once @dentry is detached from the filesystem objects, we complete
+ * detaching it from dentry tree. The parent, if any, gets locked
+ * and its refcount is decremented; dentry is carefully removed from
+ * the tree (see dentry_unlist() for details) and marked killed
+ * (%DCACHE_DENTRY_KILLED set in ->d_flags).  At that point it's just
+ * an inert chunk of memory, accessible only via RCU references
+ * and possibly via a shrink list.  If it is not on any shrink lists,
+ * we call dentry_free(), which schedules actual freeing of memory.
+ * Othewise freeing is left to the owner of the shrink list in question.
+ */
 static struct dentry *dentry_kill(struct dentry *dentry)
 {
 	struct dentry *parent = NULL;
-- 
2.47.3

