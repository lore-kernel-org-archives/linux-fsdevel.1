Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7B2F9D89
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943067; cv=none; b=BMTmHuPQ5NuXAPlWYW8IGKSixkTLZI4n9c0DVuJdvVgF3NDQeI5lsAjI1BotIaEegIQhIRqYLtfw5aSL7r5DN/WBx0gFDiehmnSlZ0JOjPlVp7aAX6ruXVlnSySvNnkUX1FuJLRCy8zE/MldO6yT0Us1lBdPTSvjmBOedJVQEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943067; c=relaxed/simple;
	bh=V/bRI2yPgCzXRCv35OVWRmOmt5Fxtz1+NCKE+7gejiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry29FNAsaLE6NzP7ayTcBihEQIJRFts+LvifpBAEAnm85u0nH9qUhxzDfajMeuYbMQeTgV/yUg+AjAOGGYuSXnBO70uS756Um6rjkVoVDPCdTQCTTaXyzX2qFeYzpnAqu2VgYl/LT2snAfaFAofV37PbpErkH47q6KgiJO2YlZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WwG60p6W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WwG60p6W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=375H8ruMiT1c13Plr9XtiJzTgscoXONjw1AOCzdJTPQ=; b=WwG60p6WTo5SNnVpvHPNFr8ak/
	opU77bM/OabEgv4PZguxKHAaR8jVYhQbzsYF4lbBBXJqzTCh/4LV8mdFdiJyX1jHhSivtgmDPxH8R
	CB4qc06Aj/TlyRIdhnh0igpOY4gRDybkPRP5iOat7sMVc1W/YkJvalY1vQYg4mSuEqx974ZQBQCPt
	sbPrRXg3dFQbOvK2oE4FLEniOFN56Wg1KDECje1TpZtS14XVTVtuqVpvAt1kkqKPJMAO6hLwj7eun
	fRGiDLlvODAtVYw5m7wZg2RQktSKQVTjIgphKPxj/ypnMPvOCaaqdTbji4j62KCUY8ve2bxX9Ig5R
	4B95J5tQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyi-0000000A99A-0Lby;
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
Subject: [RFC PATCH 09/11] reducing rcu_read_lock() scopes in dput and friends, step 6
Date: Sat, 11 Apr 2026 22:34:52 +0100
Message-ID: <20260411213454.2418381-9-viro@zeniv.linux.org.uk>
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

In the "got a victim" case in shrink_dcache_tree() we can
pull the rcu_read_unlock() call up to right after grabbing
->d_lock.

Document the resulting rcu_read_lock() scope - it spans from
unbalanced rcu_read_lock() in select_collect2() to unbalanced
rcu_read_unlock() in shrink_dcache_tree(), bridging two
->d_lock scopes into single RCU read-side critical area.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 6c90039d0935..12786b54fd78 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1601,12 +1601,22 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 
 	if (!dentry->d_lockref.count) {
 		if (dentry->d_flags & DCACHE_SHRINK_LIST) {
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
 		}
 		to_shrink_list(dentry, &data->dispose);
 	} else if (dentry->d_lockref.count < 0) {
+		// See above re purpose of unbalanced rcu_read_lock() here.
 		rcu_read_lock();
 		data->victim = dentry;
 		return D_WALK_QUIT;
@@ -1650,8 +1660,20 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
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
@@ -1659,13 +1681,11 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
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

