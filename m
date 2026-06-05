Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6963FF88A
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636159; cv=none; b=mNiYeCq4afl+4zximcbci1ENfJZJuYY2ctHn3A0cgE8okOUBRnsZDxkLQJyxk4mKGlo46koo/Q+P4j2pku2V0DwPEw6leGEvJ9Scp1skWFel5WzHoxM9ie/8/CkDHUIAPhUBL6dwi/flEYrkni9H5GnuoQgADfVBPQA2mWfNH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636159; c=relaxed/simple;
	bh=UUCSmGR+x/9ltXeoua2BvU75fDotq+9pYYUMGSeta44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDj/SxsJebeAf6Wx4HQr/oAAYShIfKT+xnYHOucCddGWioRemNTdSjet2b3ykEC6bU+1vs1YjL6ESbXYOG0hiEBmac7xQMvpq0Fadrn3+tP9DkPhFXbqPTUhnXnAp/ylbVe4mg8fBAmWfc/RUhol21yUC1vlGPiTc2NHll8cgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IyCkgfpa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IyCkgfpa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ReYrtqckrBY0tprh0E5WUiklJ2T0abXPeuAEfxYH5tw=; b=IyCkgfpakfkhKOp1oH9Ud9ABKK
	TFwEHXHJZee34N3BxzuYyA3T6H/IqVVMKXAQvUa6h84iIUWfE+dJ9b1pfxvn0x8UlTKY5IjTSw09+
	Ye7dINszVJPUx8u+fzbME/GdDUZsc+yUFG6UWxhqFEPFr+rp0MdJByYD9AAug2o2gG5FT5kMdbY4G
	9+xgCcvJe/BD64P7QMVxcPJjWF7RIP/QCeXFm5nayVdVwcblgtR2psaRnQzlJWB/o8/nWGPmB489h
	FHo23FJC4ak6rkz4/yEPidi6O654yX08AkC/qKQnZuYOLmUehMSK8w2hiLl8ljhLI6EKbflRKXE5x
	Y04iW7IA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMo0-00000005TvR-1qiw;
	Fri, 05 Jun 2026 05:09:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 19/22] shrink_dentry_tree(): unify the calls of shrink_dentry_list()
Date: Fri,  5 Jun 2026 06:09:07 +0100
Message-ID: <20260605050910.1306432-20-viro@zeniv.linux.org.uk>
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
 fs/dcache.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index beb0523c3304..1f4435b7f9ce 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -630,12 +630,14 @@ struct completion_list {
  *  Use ->waiters for a single-linked list of struct completion_list of
  *  waiters.
  */
-static inline void d_add_waiter(struct dentry *dentry, struct completion_list *p)
+static inline bool d_add_waiter(struct dentry *dentry, struct completion_list *p)
 {
-	struct completion_list *v = dentry->waiters;
+	if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED))
+		return false;
 	init_completion(&p->completion);
-	p->next = v;
+	p->next = dentry->waiters;
 	dentry->waiters = p;
+	return true;
 }
 
 static inline void d_complete_waiters(struct dentry *dentry)
@@ -1705,7 +1707,9 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 {
 	for (;;) {
-		struct select_data data = {.start = parent};
+		struct completion_list wait;
+		bool need_wait = false;
+		struct select_data data = { .start = parent };
 
 		INIT_LIST_HEAD(&data.dispose);
 		d_walk(parent, &data,
@@ -1737,22 +1741,18 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 			spin_lock(&v->d_lock);
 			rcu_read_unlock();
 
-			if (v->d_lockref.count < 0 &&
-			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
-				struct completion_list wait;
-				// It's busy dying; have it notify us once
-				// it becomes invisible to d_walk().
-				d_add_waiter(v, &wait);
+			if (unlikely(v->d_lockref.count < 0)) {
+				// It's doomed; if it isn't dead yet, notify us
+				// once it becomes invisible to d_walk().
+				need_wait = d_add_waiter(v, &wait);
 				spin_unlock(&v->d_lock);
-				if (!list_empty(&data.dispose))
-					shrink_dentry_list(&data.dispose);
-				wait_for_completion(&wait.completion);
-				continue;
+			} else {
+				shrink_kill(v);
 			}
-			shrink_kill(v);
 		}
-		if (!list_empty(&data.dispose))
-			shrink_dentry_list(&data.dispose);
+		shrink_dentry_list(&data.dispose);
+		if (unlikely(need_wait))
+			wait_for_completion(&wait.completion);
 	}
 }
 
-- 
2.47.3

