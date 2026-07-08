Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13B3FB7FC;
	Wed,  8 Jul 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497771; cv=none; b=elhB8uugBrYPCMkYFd4R6I+XzM6uMe6zz8a7goykTlbedzCx26aKUzo7YnK2qqgLh2UOlX4CxXNlttkU2iQBlHzf6XqPAoWaMMnCjhoSk4Kf59Lvt2+MLAzZ6GHZbMlVGRQqMqn+a3nnTV+ZGkqg4O9LceS5fzHpa1hScrEeszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497771; c=relaxed/simple;
	bh=usyy9FIlSpQhWm2k1Y1syZMYcpjiQ1eLU9iHP03o4SU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTSb7NkfUyFeVuVB4AR1hfObkcvooPEiZyAPmDF//9MHKpvy7zWVeW6kCLUDYV71VNwcW6UGSEgceyDwzCxOa5b9H/4gJKrOKEYZVqmIrK33aBzcIV2o3xtd1sbJ5qPYxdfOGNXUu7oLXvfrVQhNWd/lRYQjv1bf10V5UaUid+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 615a006a7aa311f1aa26b74ffac11d73-20260708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:0a41f5d8-7160-4a4a-8d25-278bcb9c2e7f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:16dda3e366d02e952caa80fa29d8ca2a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 615a006a7aa311f1aa26b74ffac11d73-20260708
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 984897434; Wed, 08 Jul 2026 16:02:35 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>,
	syzbot+8b3bd9f8a06658479d4a@syzkaller.appspotmail.com
Subject: [PATCH] fs: annotate inode timestamp accessors
Date: Wed,  8 Jul 2026 16:02:32 +0800
Message-Id: <20260708080232.2564807-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a KCSAN race between fill_mg_cmtime() and
inode_set_ctime_to_ts() on inode->i_ctime_{sec,nsec}.

stat/getattr can sample inode timestamps while update paths store new
values concurrently, so KCSAN can report benign races on these fields.

Annotate the timestamp accessors with READ_ONCE()/WRITE_ONCE(), and use
the ctime accessor for the remaining ctime loads.  This avoids the KCSAN
reports without changing timestamp semantics.

Fixes: 4e40eff0b573 ("fs: add infrastructure for multigrain timestamps")
Reported-by: syzbot+8b3bd9f8a06658479d4a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8b3bd9f8a06658479d4a
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 fs/inode.c         | 18 +++++++++---------
 fs/stat.c          |  2 +-
 include/linux/fs.h | 20 ++++++++++----------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 31c5b9ee3a81..95e981b4e19c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2833,8 +2833,8 @@ struct timespec64 inode_set_ctime_to_ts(struct inode *inode, struct timespec64 t
 {
 	trace_inode_set_ctime_to_ts(inode, &ts);
 	set_normalized_timespec64(&ts, ts.tv_sec, ts.tv_nsec);
-	inode->i_ctime_sec = ts.tv_sec;
-	inode->i_ctime_nsec = ts.tv_nsec;
+	WRITE_ONCE(inode->i_ctime_sec, ts.tv_sec);
+	WRITE_ONCE(inode->i_ctime_nsec, ts.tv_nsec);
 	return ts;
 }
 EXPORT_SYMBOL(inode_set_ctime_to_ts);
@@ -2908,7 +2908,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	 */
 	cns = smp_load_acquire(&inode->i_ctime_nsec);
 	if (cns & I_CTIME_QUERIED) {
-		struct timespec64 ctime = { .tv_sec = inode->i_ctime_sec,
+		struct timespec64 ctime = { .tv_sec = inode_get_ctime_sec(inode),
 					    .tv_nsec = cns & ~I_CTIME_QUERIED };
 
 		if (timespec64_compare(&now, &ctime) <= 0) {
@@ -2920,7 +2920,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	mgtime_counter_inc(mg_ctime_updates);
 
 	/* No need to cmpxchg if it's exactly the same */
-	if (cns == now.tv_nsec && inode->i_ctime_sec == now.tv_sec) {
+	if (cns == now.tv_nsec && inode_get_ctime_sec(inode) == now.tv_sec) {
 		trace_ctime_xchg_skip(inode, &now);
 		goto out;
 	}
@@ -2929,7 +2929,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 	/* Try to swap the nsec value into place. */
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, now.tv_nsec)) {
 		/* If swap occurred, then we're (mostly) done */
-		inode->i_ctime_sec = now.tv_sec;
+		WRITE_ONCE(inode->i_ctime_sec, now.tv_sec);
 		trace_ctime_ns_xchg(inode, cns, now.tv_nsec, cur);
 		mgtime_counter_inc(mg_ctime_swaps);
 	} else {
@@ -2944,7 +2944,7 @@ struct timespec64 inode_set_ctime_current(struct inode *inode)
 			goto retry;
 		}
 		/* Otherwise, keep the existing ctime */
-		now.tv_sec = inode->i_ctime_sec;
+		now.tv_sec = inode_get_ctime_sec(inode);
 		now.tv_nsec = cur & ~I_CTIME_QUERIED;
 	}
 out:
@@ -2977,7 +2977,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 	/* pairs with try_cmpxchg below */
 	cur = smp_load_acquire(&inode->i_ctime_nsec);
 	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
-	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_sec = inode_get_ctime_sec(inode);
 
 	/* If the update is older than the existing value, skip it. */
 	if (timespec64_compare(&update, &cur_ts) <= 0)
@@ -3003,7 +3003,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 retry:
 	old = cur;
 	if (try_cmpxchg(&inode->i_ctime_nsec, &cur, update.tv_nsec)) {
-		inode->i_ctime_sec = update.tv_sec;
+		WRITE_ONCE(inode->i_ctime_sec, update.tv_sec);
 		mgtime_counter_inc(mg_ctime_swaps);
 		return update;
 	}
@@ -3019,7 +3019,7 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
 		goto retry;
 
 	/* Otherwise, it was a new timestamp. */
-	cur_ts.tv_sec = inode->i_ctime_sec;
+	cur_ts.tv_sec = inode_get_ctime_sec(inode);
 	cur_ts.tv_nsec = cur & ~I_CTIME_QUERIED;
 	return cur_ts;
 }
diff --git a/fs/stat.c b/fs/stat.c
index 89909746bed1..c461c3054234 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -53,7 +53,7 @@ void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode)
 	}
 
 	stat->mtime = inode_get_mtime(inode);
-	stat->ctime.tv_sec = inode->i_ctime_sec;
+	stat->ctime.tv_sec = inode_get_ctime_sec(inode);
 	stat->ctime.tv_nsec = (u32)atomic_read(pcn);
 	if (!(stat->ctime.tv_nsec & I_CTIME_QUERIED))
 		stat->ctime.tv_nsec = ((u32)atomic_fetch_or(I_CTIME_QUERIED, pcn));
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..e5b97e324db1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1598,12 +1598,12 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode,
 
 static inline time64_t inode_get_atime_sec(const struct inode *inode)
 {
-	return inode->i_atime_sec;
+	return READ_ONCE(inode->i_atime_sec);
 }
 
 static inline long inode_get_atime_nsec(const struct inode *inode)
 {
-	return inode->i_atime_nsec;
+	return READ_ONCE(inode->i_atime_nsec);
 }
 
 static inline struct timespec64 inode_get_atime(const struct inode *inode)
@@ -1617,8 +1617,8 @@ static inline struct timespec64 inode_get_atime(const struct inode *inode)
 static inline struct timespec64 inode_set_atime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_atime_sec = ts.tv_sec;
-	inode->i_atime_nsec = ts.tv_nsec;
+	WRITE_ONCE(inode->i_atime_sec, ts.tv_sec);
+	WRITE_ONCE(inode->i_atime_nsec, ts.tv_nsec);
 	return ts;
 }
 
@@ -1633,12 +1633,12 @@ static inline struct timespec64 inode_set_atime(struct inode *inode,
 
 static inline time64_t inode_get_mtime_sec(const struct inode *inode)
 {
-	return inode->i_mtime_sec;
+	return READ_ONCE(inode->i_mtime_sec);
 }
 
 static inline long inode_get_mtime_nsec(const struct inode *inode)
 {
-	return inode->i_mtime_nsec;
+	return READ_ONCE(inode->i_mtime_nsec);
 }
 
 static inline struct timespec64 inode_get_mtime(const struct inode *inode)
@@ -1651,8 +1651,8 @@ static inline struct timespec64 inode_get_mtime(const struct inode *inode)
 static inline struct timespec64 inode_set_mtime_to_ts(struct inode *inode,
 						      struct timespec64 ts)
 {
-	inode->i_mtime_sec = ts.tv_sec;
-	inode->i_mtime_nsec = ts.tv_nsec;
+	WRITE_ONCE(inode->i_mtime_sec, ts.tv_sec);
+	WRITE_ONCE(inode->i_mtime_nsec, ts.tv_nsec);
 	return ts;
 }
 
@@ -1677,12 +1677,12 @@ static inline struct timespec64 inode_set_mtime(struct inode *inode,
 
 static inline time64_t inode_get_ctime_sec(const struct inode *inode)
 {
-	return inode->i_ctime_sec;
+	return READ_ONCE(inode->i_ctime_sec);
 }
 
 static inline long inode_get_ctime_nsec(const struct inode *inode)
 {
-	return inode->i_ctime_nsec & ~I_CTIME_QUERIED;
+	return READ_ONCE(inode->i_ctime_nsec) & ~I_CTIME_QUERIED;
 }
 
 static inline struct timespec64 inode_get_ctime(const struct inode *inode)
-- 
2.43.0
