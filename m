Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E603176EE
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943068; cv=none; b=csagFRlicfmmIB3ZpVQmxtgwgO3f6VBT6ujyH1Xr/InheJh57ielAFRxUqyEQd1iRB7PP8cAk3JvW4ZRPScxK0JELRn9Q8iZCThpkhB+nmzOj6+y+Bo2h7UIcvzx+1kdeWG4kiQiOBPG0lIqSXCYRfRRYMijD3poHc61VzI6zrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943068; c=relaxed/simple;
	bh=pytYp6kBFI1T8BdPifrllnrR2qWdVoRCEpO1+s77mUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppzeBmRUPIwmmir0liZreogOTZzGJLqHb19jAxtImUsVydEwXYP0wbHRdyyI9YqxXgmxgriN/cdqCWNaf86gX1fEKLdlly7dbnIwmcLVBCdofOlvMPs48Eo0zwjuqjhTBa8lfPjqAfdbPSZ98bkhdtev3m/nYR8/KStRzTZ6H3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aBLhYrOy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aBLhYrOy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xW1R9SVm4ZOoG51SOjZic3sJ3NDGsmzWT/F2b4vrC/c=; b=aBLhYrOyHiagaaQ+VLb9qG6CuZ
	TOO9Cw62VHeLOyajeU238tT8LR0qJ7pi0uak+W0wi8ne5dy8TYM/qZqXery9st3Ux8VZsBBqpWJ2k
	3bxXZdwhhzqIYzbKkVUUdkJFNLP7VopNb5ggQq4B2SBPy55Q9OYoi0ynfCwZeuGiGbBcfOWsGM2Pd
	T9dqm/i+oGL96oK7hx+w0NKM43T/eauOiXFq/wNuLIHb+PjCNUCe+YuvZ0/cuZphPM0F/ZgyWDqa/
	UJvFeX1v/YgV+6q3TGxGSj0Q9dMxYHzJvtxydOb2Ycr1aHlIIG9pCU1qqyPciwwlhdrx6hzMYLWsn
	xQ98nnXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A991-3tf8;
	Sat, 11 Apr 2026 21:34:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 08/11] reducing rcu_read_lock() scopes in dput and friends, step 5
Date: Sat, 11 Apr 2026 22:34:51 +0100
Message-ID: <20260411213454.2418381-8-viro@zeniv.linux.org.uk>
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

Shrink rcu_read_lock() scopes surrounding fast_dput() calls.
Both callers are immediately preceded and followed by
rcu_read_lock()/rcu_read_unlock() resp.  Shrink that down
into fast_dput() itself; in case when fast_dput() ends up
grabbing ->d_lock, we can pull rcu_read_unlock() up to
right after spin_lock().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4f38af6fabae..6c90039d0935 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -876,6 +876,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	/*
 	 * try to decrement the lockref optimistically.
 	 */
+	rcu_read_lock();
 	ret = lockref_put_return(&dentry->d_lockref);
 
 	/*
@@ -885,6 +886,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
 		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
@@ -896,8 +898,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	/*
 	 * If we weren't the last ref, we're done.
 	 */
-	if (ret)
+	if (ret) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Can we decide that decrement of refcount is all we needed without
@@ -905,8 +909,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * dentry looks like it ought to be retained and there's nothing else
 	 * to do.
 	 */
-	if (retain_dentry(dentry, false))
+	if (retain_dentry(dentry, false)) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Either not worth retaining or we can't tell without the lock.
@@ -914,6 +920,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * but we'll need to re-check the situation after getting the lock.
 	 */
 	spin_lock(&dentry->d_lock);
+	rcu_read_unlock();
 
 	/*
 	 * Did somebody else grab a reference to it in the meantime, and
@@ -971,12 +978,8 @@ void dput(struct dentry *dentry)
 	if (!dentry)
 		return;
 	might_sleep();
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -1003,12 +1006,8 @@ __must_hold(&dentry->d_lock)
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
 {
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
-- 
2.47.3

