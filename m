Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CD2770A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943067; cv=none; b=rQwkQSCkKHiDlDQPDu7+Pf8WkrqD3+qyH3TO3osTFToU1k0oEp723mZDSLl2nBFLODtnH5b7i40BDD8kHN2Za0LsrJwr+AncZXgmWTZoQDDl+VYFQNGDJzbefSVHxgtyqjnjWmZl88DY/Jx6ly1q7W1WTHw9mR3k3Zk1Y619MhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943067; c=relaxed/simple;
	bh=BPKPZXggID4UQ133I98j7ipQrifHTvui+9/fTYzxiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuedUFw0DL3P1AE9Qihv11wS177H3439Qad90bPQe03RNUjneSBMQx5d35CfYBLWsmLSbhxMe3Zg5lLRRQzxdMNeEm73v8whS4FBeXqppdBecdVfEp9FMLKiBzqBa7piYPIeRhvXAifkvMv23X2cTiOrLoTOdb0JzNhf3APe6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=v2IFITTM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="v2IFITTM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oHuF+FQE5AdCToLnX3aY9GakKJNGjGWcnGkAY+eKik0=; b=v2IFITTM0I+/ENHUP+mY6Pz5jI
	lvSmsps6K9YeDMZPuxCf3T7AIfkE6sNFDvg6ZFXpQePnFnvrS0dzlfaq+rxx4VqXrWGqeRzLERoV2
	cgJlzhEfWpNNflQpLYS0zkPNRFsYgdej78d0lrH87gNBtqKYPzPeS0EcjZppesOrSN5fLCePI2BZa
	C/sMCZV61dkLskFXQNArXTZ2DKhIL2Y+3qiunCVEAd8dLW5VH2Mh82YLAI6GXRD49UtTs6YxqiM7L
	zC4QLkIKZHOxMPsTvJwreM0+cF+C6gXM8AYxtAny6cMLM4LYTvGAyKnQ2V4lpZIKDKw7KM2JvBzD9
	qQf1xJcw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98P-1tf0;
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
Subject: [RFC PATCH 03/11] fold lock_for_kill() and __dentry_kill() into common helper
Date: Sat, 11 Apr 2026 22:34:46 +0100
Message-ID: <20260411213454.2418381-3-viro@zeniv.linux.org.uk>
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

There are two callers of lock_for_kill() and both are followed
by the same sequence of actions:
	* in case of failure, drop ->d_lock, do rcu_read_unlock() and
go away
	* in case of success, do rcu_read_unlock() followed by
passing dentry to __dentry_kill(); if the latter returns NULL, go away.

All calls of __dentry_kill() are paired with lock_for_kill() now;
let's turn that sequence into a new helper (dentry_kill()) and switch
to using it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d75c3b379573..c363faebfae4 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -779,6 +779,17 @@ static bool lock_for_kill(struct dentry *dentry)
 	return false;
 }
 
+static struct dentry *dentry_kill(struct dentry *dentry)
+{
+	if (unlikely(!lock_for_kill(dentry))) {
+		spin_unlock(&dentry->d_lock);
+		rcu_read_unlock();
+		return NULL;
+	}
+	rcu_read_unlock();
+	return __dentry_kill(dentry);
+}
+
 /*
  * Decide if dentry is worth retaining.  Usually this is called with dentry
  * locked; if not locked, we are more limited and might not be able to tell
@@ -922,19 +933,13 @@ static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
 	__releases(RCU)
 {
-	while (lock_for_kill(dentry)) {
-		rcu_read_unlock();
-		dentry = __dentry_kill(dentry);
-		if (!dentry)
-			return;
+	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
 		rcu_read_lock();
 	}
-	rcu_read_unlock();
-	spin_unlock(&dentry->d_lock);
 }
 
 /* 
@@ -1190,15 +1195,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
-	while (lock_for_kill(victim)) {
-		rcu_read_unlock();
-		victim = __dentry_kill(victim);
-		if (!victim)
-			return;
+	while ((victim = dentry_kill(victim)) != NULL)
 		rcu_read_lock();
-	}
-	spin_unlock(&victim->d_lock);
-	rcu_read_unlock();
 }
 
 void shrink_dentry_list(struct list_head *list)
-- 
2.47.3

