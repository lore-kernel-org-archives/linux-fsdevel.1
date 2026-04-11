Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB21EB1AA
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=kRf9gCXWPVNuuTmS8XkEutQza6tzVTC12Q2uCrKpdFVYkNymTYH6NLnpqsmrNFuih7xXXj1k/CrqsHou/1m+V+Kpi/lcQNQ1GvR2hgf84zARq7CnQJuY8J6jQhXYCyGBc1zZGKfmWDIrZlOSf+nm0JfjdfUQsM4pvh6ZzBli554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=nv4+BY2sknpAIU+gTXdyDwpEXQ3pVDLge4ai7n/Bu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czyuX7JfAPMtXMmzHWFESZ4ryBGtLRHMht65NzX2TSLocugdVuiipWG+72Cbj3wCQoHcPvQqBdzZrH6w0PNUYsRXY9Fbk8Z6K1WgUjSgcynW9t9FouiwHmBB9AWjjZdW0teTeUSHKTSreEe/fxGoe13Mt16Bb+ADSCALxK5d5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BU+TvyMI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BU+TvyMI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NwPvUvqUp5l9lI1zwjqzo1/4OE/bg/r5uVyNNKgq7cE=; b=BU+TvyMI9eB4IsEndaFNnvaeKi
	DlloSe5x8r868yazhc4SolglbdmYdLm3m3Dym/ipFiw79aTCs3ISb7gdPqKKwyziVFZRVnf9Tmc60
	fhkRXp3FYme3bgd1+n68WVcrqa9H1G3XrEqJwO3zJ3zoLFNeTc2FzxVShpWNDPMx4JPKd2Ow+HgCv
	ik7WjYxyUCt3GoWf6ligZaFVXFskZ6k0+E5++F9YQVf9hjAH/79OtWD4kCC09GIh0JQKsdFozsxW3
	u9JhXnSIlU6VIevuk7DaFa7WL5vQmN1x4YAOBZ4LwyYBI2gtzy4QU/7+6dS73WFbyggEqfH6VFrh7
	gWu59e5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98e-2lpT;
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
Subject: [RFC PATCH 05/11] reducing rcu_read_lock() scopes in dput and friends, step 2
Date: Sat, 11 Apr 2026 22:34:48 +0100
Message-ID: <20260411213454.2418381-5-viro@zeniv.linux.org.uk>
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

All calls of shrink_kill and finish_dput() are immediately preceded
by rcu_read_lock(); move it inside those functions.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2eaaf7b4de49..3ea46d1182c5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -931,8 +931,8 @@ static inline bool fast_dput(struct dentry *dentry)
 
 static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
-	__releases(RCU)
 {
+	rcu_read_lock();
 	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
@@ -979,7 +979,6 @@ void dput(struct dentry *dentry)
 		return;
 	}
 	rcu_read_unlock();
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -990,7 +989,6 @@ void d_make_discardable(struct dentry *dentry)
 	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(d_make_discardable);
@@ -1197,6 +1195,7 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
+	rcu_read_lock();
 	while ((victim = dentry_kill(victim)) != NULL)
 		rcu_read_lock();
 }
@@ -1213,7 +1212,6 @@ void shrink_dentry_list(struct list_head *list)
 			dentry_free(dentry);
 			spin_unlock(&dentry->d_lock);
 		}
-		rcu_read_lock();
 		shrink_kill(dentry);
 	}
 }
@@ -1672,7 +1670,6 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				continue;
 			}
 			rcu_read_unlock();
-			rcu_read_lock();
 			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
-- 
2.47.3

