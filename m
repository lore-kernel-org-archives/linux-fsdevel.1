Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732E18050
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=o3J+F0ZsDsTjGGdx1rEJWz1NG0EAGeeMMY67ZZQ0Bv4UT3pbl8J8YMkSkLTSqZjJjqFTuFIs3pLgmuxbsYotL0UgUvsoFEH5A3IKfynEKLgW30A6veXc8KEbWgdJJm3DqYGKK6frt8VGjqQNJngiGYEQvRpeDDBHZ/c3P5f6ifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=RKrZoWIBWSzGgHRcbbVnwoYH90ma2Cr77dw1Iz1XCDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3FIRkDQlt23CjsnnWbabSb0+og7pLXTSgFpqIOAyUA9UKmdA2zgpQr8XndG1Teq2fQUKT8mBsoKpNTiHBRyRjOKsIWSAePiTVetx0FW9TTXlReYcJHWKgzrdi1Fvx3Xi94jUoWTUduF65uP/+2ia343vZ0EJYcWEEUFX9Aaatc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UZPlqZk7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UZPlqZk7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b93HwWhXiwd7OkYTUasIm7vQVNwHbb/Oaz7VeiGGifQ=; b=UZPlqZk7/0TRwkiYlM2QSLDWAq
	1v7hQHUMI4HjiyQs0gGRorL0Y4iqPfrDuO4WnlSQaAOIZFWAThY5DrgwrMb+YKD06OGWnqfMCJhUC
	kFTksva2cv86riZGgE/YGmajsIpLRnOkk3EftvPjOKun8CaBJsEdSJxZ3+71vQ53kunr8865/G9wZ
	oc8tFUx/T5kvpuYt47ft2zk5EfVblGb2nTZti6foYadwYS6MOFNpicWytLHQtB4qUF4PWcIwaBcfk
	VVEIfPE9FxwTt/cSQASDzxVh43yv3Zpz5CE3NG2ufovNR+nrEzxW61/+DGLFw8CSHmS1ULgcJqjvv
	2X/tLoCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98J-0wxL;
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
Subject: [RFC PATCH 02/11] fold lock_for_kill() into shrink_kill()
Date: Sat, 11 Apr 2026 22:34:45 +0100
Message-ID: <20260411213454.2418381-2-viro@zeniv.linux.org.uk>
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

Both callers have exact same shape.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 6492120ea060..d75c3b379573 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1190,14 +1190,15 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
-	do {
+	while (lock_for_kill(victim)) {
 		rcu_read_unlock();
 		victim = __dentry_kill(victim);
+		if (!victim)
+			return;
 		rcu_read_lock();
-	} while (victim && lock_for_kill(victim));
+	}
+	spin_unlock(&victim->d_lock);
 	rcu_read_unlock();
-	if (victim)
-		spin_unlock(&victim->d_lock);
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1213,12 +1214,7 @@ void shrink_dentry_list(struct list_head *list)
 			spin_unlock(&dentry->d_lock);
 		}
 		rcu_read_lock();
-		if (!lock_for_kill(dentry)) {
-			spin_unlock(&dentry->d_lock);
-			rcu_read_unlock();
-		} else {
-			shrink_kill(dentry);
-		}
+		shrink_kill(dentry);
 	}
 }
 EXPORT_SYMBOL(shrink_dentry_list);
@@ -1675,12 +1671,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				wait_for_completion(&wait.completion);
 				continue;
 			}
-			if (!lock_for_kill(v)) {
-				spin_unlock(&v->d_lock);
-				rcu_read_unlock();
-			} else {
-				shrink_kill(v);
-			}
+			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
 			shrink_dentry_list(&data.dispose);
-- 
2.47.3

