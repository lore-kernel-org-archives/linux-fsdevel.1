Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D03C5553
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960443; cv=none; b=VcMbeu45b+NicKCdoDXrk2CHYlXi7MT73l0rVfVjcIwnU7M4vYTpKJ71U00MAXk2NAOr37lhqY9yHYgHW29DkWcd+Z94MUOMWiVsLgMHzv/IFtnaIJGjh7XlkxagNNxNwsL/er1dnmxqrZg17zGIg/O8UTdC1re2YiZd7jmr5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960443; c=relaxed/simple;
	bh=7noVwY/rHjMyFBwaWs1F+lmGXyenoy2R6Rsaxi0pqL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAHqBkBLrbVGUTgxBOS/XM2GT5zTIn30p9G81wyfAmtW2X2nSiLwbab86cs9M3MBV34hB2gCbd7jMemzIksO8VJJ8+oSUZT90KgGqo9ctMy1e2C8GtfVeXqt3l6I4QCprlHzqhOyeBr5QFuP7v6mVia6Sjqt/7/qCU6HnHkLsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MKZmuA7V; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MKZmuA7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9VqtO/wjEFgRcMDYorV8K4v8vfdAiN572X+eiFEfYpY=; b=MKZmuA7VC+Yr6sr2fdfopeh4E3
	CYG7Bo6nFjmRXYuITcfY4/7WMcmaXKc1UfUcmsSfp0+0evTk5oNnCxVCJlSI0LWfRqM+WGZUGSCIQ
	KopS7vOdcfEzEQZcVqrFM/S9vMBFp2FDuBLgH1jCmN0ED/+d7A/TYzgZsQmM2I1HhrqU7E00wY6+v
	LHXDP+qInW71y3UWSJczGfP53CjaSIt+YSTNEudkcIGz4qcIO9JfKS9kTAo108XrfJ1fsGRDx3tIl
	/Afwr5UrvNxcs+t9oZzqG1rMDOVwiC3iAT6cdfrfjcB8F315fqqBSQvDYCzmwTwcBzf7/xgQlokyL
	nfmhvG8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jY-00000005I5x-2YDP;
	Tue, 05 May 2026 05:54:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 10/25] fold lock_for_kill() into shrink_kill()
Date: Tue,  5 May 2026 06:53:57 +0100
Message-ID: <20260505055412.1261144-11-viro@zeniv.linux.org.uk>
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

Both callers have exact same shape.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ee11171a75e6..8fb0d924ecac 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1211,14 +1211,15 @@ EXPORT_SYMBOL(d_prune_aliases);
 
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
@@ -1235,12 +1236,7 @@ void shrink_dentry_list(struct list_head *list)
 			continue;
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
@@ -1688,12 +1684,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
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

