Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6993B2FF2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=s9C1dHJWT0zpgYFzrQhQFRWHV083ONU0kMF/wuCXzLPdYtloCkWmaMEG8EhaWb7SLTFCk/D+eurgWD7uudgdaLdBabzVpd2s4FgiWBoN7KaNfGkJzD9Vyo9F/Nt+Ou/UHK8WsvyUWlELF91ilYcHwl/iA2PuQexMMWYckhZAXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=subj1RhICbGOxNx3KFBvv0eULgG0I4RWQjJb1tL/rHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiogpZ2B+npvq+ULfd7W2sJpz6fwJfG12Kic1GJOGDdyETmc02U59uKczFGjULtJ2Xp4YY7zhVB7zR1wxUvHkbU0sOlNSjlhzitbW507g6eRUmK8ins9Xdyjt5pnSGcRP2zTFSAPilCorDKS3i2GmcCYfDtgy0XaYl6Y1woRdPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f0q5At5s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f0q5At5s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YtM05dhqMBPRNUWcZC193koEjcweWK4MzlUcyts0PEM=; b=f0q5At5s8oKSKAApc4QchUB7tB
	EYtNS7cw+NGjp6NYbE2wCcS1ukrk3aLaO8K54Z0L+iKR67y8Pb/EqtGpJN/+z/RJy/+jISqnCsb9A
	XVO/0VIB1pK/MyGsI+u8zeAh5EDQkyWT2pcD4fQlojnnFlKSPdzr/g9vNwvbWlUe1iXHi/belHfCf
	a4z8qDDVwyLqHLg2Q4luA1gR03R5kbdoMmf1dDd5lu6EkfWMYfGQZjetj02w1piIhO7/uJ8H6OrDp
	hhKgcP6p5B4U0gU8PpcqV6VJimIYKj+wwG9MrnAofnfHU+hYRow9nu6bhbPBPRUVc+hUf7tWvPBWo
	BqnkgdIQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005Ttc-43yZ;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 11/22] fold lock_for_kill() and __dentry_kill() into common helper
Date: Fri,  5 Jun 2026 06:08:59 +0100
Message-ID: <20260605050910.1306432-12-viro@zeniv.linux.org.uk>
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
index 3325ca535bf6..1dfe37e57447 100644
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
@@ -1211,15 +1216,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 
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

