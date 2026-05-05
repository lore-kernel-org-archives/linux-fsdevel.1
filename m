Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA633C3452
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960443; cv=none; b=d13KfBL+cZTrR5Zko7bZZ7n79783lu9Lk9NAp8Z7g35JfvnGbeqgkVJ4r9UnXvEq506Q7GRqmiLehKZVNzyGq0P9CySHJG6F3gB1ZbW+R9vN2hddFlYKu7t4SfNBldJkRP8ypgHeaoeXYEM85qZun0UtpKaJwlmDaotLP/83PlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960443; c=relaxed/simple;
	bh=VBL3n2gy/FtPv/Su5uhH2aNvu2MQ5lwRwgdLDYhsDdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJPWdW/jVPNv6zfinpq29iaArBGfL3cjB2P8zSlioIvZboWmJbeF6/FDuCUA/b4bbN7DMoyBU1YG6gcsaD3fQbHl6hLEWqM3JkwcLDQsM8HQhjUnFmQXPp6tKRxPyGuGULhqBL5/w++zA5rxTgyzV9ajhUd4fhS9mvLPB7ALjyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ReeAsBeb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ReeAsBeb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=L8SjwvYRZSsuMJ5oYo4ci+Ts6mtp7HNCufWTIunsHIk=; b=ReeAsBeb9NjFtzCVbAuxHzCL0f
	fwYhO/nVbPJYriIEQCHewTrh7M4yarYGO8C8zwgcsMTA1LY9QNcxf7IAXp0rAOBHdY+Tj59dAxoix
	VXsIU7S2Pu6li2Up/kbpKHiK3o1cAKc8Rgk9a8D9F2w/sLrBJViU3sFKgZBM9SeaxcxClE/xx+D3d
	hkB816Yld1Gsn1VXMapzE2tGHuyYa0eb9NLnteyKOCYNE5YNrGfe171y8+wl6JxO95Oh97voS2fnc
	BUyu2xJBC0Xm5OuAi3QUluXDkkBuojwAppysncKMuuNPohaaDszP/3G0nsz8PzRnf2nkkKSvCcEhi
	aTvCS97w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jZ-00000005I6c-3DgA;
	Tue, 05 May 2026 05:54:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 11/25] fold lock_for_kill() and __dentry_kill() into common helper
Date: Tue,  5 May 2026 06:53:58 +0100
Message-ID: <20260505055412.1261144-12-viro@zeniv.linux.org.uk>
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
index 8fb0d924ecac..7cf965f9fb29 100644
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

