Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CF43C5523
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960450; cv=none; b=oIebr8389x3l0JnY7lVb6VzXYyhGaH8FJmqiu7HSFja7SmGszeMDJcS7tI8Wu6mFvRLF7UE8MZhX14Gwb0zagulb6ck8NxUwzeFWx1bsitTFKO2XFd1SYrtVNvRxraOX56lFCAxPYxbkBVYgF8yZD74N4JVbz82Ib4V5VenlRlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960450; c=relaxed/simple;
	bh=MJhwkPCIy6CLvUHlfu5C7o2OIITafdIMOvDCR5AX6uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A46xlrEUlwYq5kAWyvTcZqKM1iBte79EEs7IF51g0mGYZ61EKsbs9XrfPJZpRte23IcjniXQU8KiAVt9Ba1dLseGRZa6sq3HABFiAM5ETMRfNjUd+9V30/Gtiv1A/+QAGGNMOj2RRTmxdxPbhR1aVxtCAwvcAIq7D9JUrF8RpKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MbEmDYZA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MbEmDYZA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IkZeoO8wWZQkU4mYR+T+O2lkySEBWqYwJSsHk4UTOEI=; b=MbEmDYZAtlg4yBnXIp0Qx6XMYk
	mFWJdi0q2R6L+sw+QzP13HJrkH6+u5J5JmiHp7tObDwhJ89HUXxpEXozKa5JG7Y5wGDClDTFIsn7A
	bQcsTM3P/tgRJlhC5pj/XxdA8zJUz8s0vu51TsV2+Rr4bLC4u/FWpnRSEy7Orj5ALc1jW1HFL6t40
	ngOdpl3of2UKxNdZkx7dtRNSqbGoaq4fbPO1o/G14CO5lAmRMgLh8uvl1OOYnhapyiI8JYrdlMMwT
	SqOJMU5QLyWaxof4vuemzxVIPUyk3IvQK+BZKkM5cpVM2cMGsBKXlCq0AeYJ1rpZ8UMmhyjyxg7/K
	uehFCudg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jh-00000005I9w-1cXQ;
	Tue, 05 May 2026 05:54:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 22/25] shrink_dentry_tree(): unify the calls of shrink_dentry_list()
Date: Tue,  5 May 2026 06:54:09 +0100
Message-ID: <20260505055412.1261144-23-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f3c8d46867a9..9003b8cf7134 100644
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
@@ -1691,7 +1693,9 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 {
 	for (;;) {
-		struct select_data data = {.start = parent};
+		struct completion_list wait;
+		bool need_wait = false;
+		struct select_data data = { .start = parent };
 
 		INIT_LIST_HEAD(&data.dispose);
 		d_walk(parent, &data,
@@ -1723,22 +1727,18 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
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

