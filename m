Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517C3FD97A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636158; cv=none; b=Tf0Z1HY5gUHPIxdA91ydWuwxV05LctD8e1wxdmAX3c6IJpSv5qKaEAwcqHxMB7y/tv4b+SoU6c+DXxoiouf6AhjH/T/c8FyzQsIGxNVQ3IvAZp3Gm0Iww8yPK184ocgEVJDrwAH/w9sqUXkg9x9BmChTs32X52Udt6j15lvCTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636158; c=relaxed/simple;
	bh=dO2p+tbGy/Q8rtSEg0iDEms+z7iHIeg9XBHK2vX4HJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ua9o6IkcXigQW7WfPU4lj+aQju+iknD0puIEI/B3QIgNB0153yor+QywAgd/C9iQ0oRBGK+e+UZzy5A8pU6dNGyV2yHUMIZS32ImMjlgI4UNo8+HiR1L4+QqvOKc/xsshIoY7jDXfuyz+mAGGCmD56v/16aWkGc8qLeBXcAneCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gyZ2BVBb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gyZ2BVBb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WweowW378rngJnorTclGLFdKSQJ3t9kd0LLnzcEuE8E=; b=gyZ2BVBbn9F/u/M49SWKaYtVNd
	HX14+lcjTd/YoQ3l7fJPgBG4PHrR+f1NXgTefYFSst+B6JDy2jC28qQVxKJd0esh6o4dPzYomP1MC
	+7CJGxxkn/ebrvhLHqoUslg4G3Nw8i6RlSC82kW8jDAwx/vEHqrnfC1+2LNv5VsSO6t2leTQxSuUv
	aQxYUE5h9dTHBfScVxwKmCwoTOdCpT0EQgJjYG1w77VSZgQIwYtXDvAwbXQaTkmhB9LE1eSz/WJ/I
	CU1+M6pYatbV8z32wt4rKuQq+xSD/2jgbGdcSAfQMiOaD3liiqwUa6k2w75CX4jnp07+iu+wfszrV
	0X8xCl8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnz-00000005Tum-0DwG;
	Fri, 05 Jun 2026 05:09:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 16/22] document dentry_kill()
Date: Fri,  5 Jun 2026 06:09:04 +0100
Message-ID: <20260605050910.1306432-17-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3887d8b5f81a..cf4bd6c37d04 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -752,6 +752,44 @@ static bool lock_for_kill(struct dentry *dentry)
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

