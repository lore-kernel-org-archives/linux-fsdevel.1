Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490003CC9F3
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960447; cv=none; b=IwIjOP3hMeyQtKHu2QYViQIc8X91Y++DK2T9vSbwNuDYN25w1FxiUtUg0wenjijpvFu5a2kag6D8MTED7n14HOTCCNsjbvc5qbs3MTKeRsplCUPVD8VI2pJUdxFfJphnRuqVYyoJS++1rtYPqBdo6b15sd/ek7BafJ3V45zf/mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960447; c=relaxed/simple;
	bh=BN+cg70BYUrWJH6JaYaw9J8x/151RJM+vqgUoeF1iR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rczu7GgQz/lR7+5xXmlzqONYyeMniVKdyYSGUyk6qBSnu0g61W+Ux31h0zgX2OQhiFMVvG1Ki0SzkevdOqzuIOEU7v4yFQ6nqMYK2FKZpH3cFFYY2VeGco8VonO1PLB0ZmVDKp1AZ4i5v4/6EnCC6t1Z9MtQzjvxSizVGOwWIxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YL8kR1Ew; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YL8kR1Ew"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JLkY3+GLAmV+SnRlU/lszKqRgQKGwCIxKiAGthtTBng=; b=YL8kR1EwzI3G06iT9OYj3Yed9m
	zwWRp8aepQkTuOC1LGHRG6Ab0+E6jxnTCQddRb3C8X80sn3VSOuajAJtflZxrWIfMTeVk3mXhdpnD
	Irt+dm9l5wIdj6/qIb3UkImpDS1N3K/ClGP568XP0nF+DKk2e7zl8CJS4jb9HuuB9wGVyNu1YImfs
	6EmQ5kTmQBQgNtpm9f/d1uVIhaq0iB7BjdfAIJHgNk08+p+tJrvmplIKjjarU1hFFyCmzPfGVf76J
	/mZrLqoqz6GeTyxeIt8XIvmRKe48tlMxVC/Fb8Fc6mh65pmsKyl6zmQyqczFKPIK7HOnVhMhKhJOe
	kj5aC96g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jg-00000005I9Q-0vPS;
	Tue, 05 May 2026 05:54:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 19/25] document dentry_kill()
Date: Tue,  5 May 2026 06:54:06 +0100
Message-ID: <20260505055412.1261144-20-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 125f280fe6ee..f283818095c0 100644
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

