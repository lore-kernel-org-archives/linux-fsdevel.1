Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08125579828
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194183; cv=none; b=tiCQwkry2RJXLMTjA0rw9Ksd6fClcPUTqilW7TTC0qoqf0cBD0MJm0mp5U/OCmt8cR3bKoX7Z11vlcH3w65jCNkSWQr1rM7u/QWEypNucSP5uZXnujFUMvBt1R7X2qz0kw/0g60rNNmZ1ptImIxcUBkNp3/4y+iFwFiFUhafP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194183; c=relaxed/simple;
	bh=7TGgLhFn6sXSEm/2G5qIL1iaxjjvxIquORtA234bFQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvtYphhZIb/MixS9EQvDFoE8tWQNp90imNNTyvSSF4VUdULnJpP7a3OwA0KjJVnBzqAsMbfHhSdxYURx5BP86cGaG04brghQ71coZzmIC/eXTmzR2FG1zzN2MQ4LEIMttaAoVelXJCG2zZKux54nS8iVjttRkCj9Aw+EF4LdYiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQmHLwSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQmHLwSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790194176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bP7fGq0D9N6et9vLtHh3ggTZ3WPfdjkQHIKkyIDF3Y=;
	b=GQmHLwSJsQsiTy1n4jXA2uimQEPSb72BP9t+5vIJwPwhYjPwxJAWY4HjbLolEPvvONg5z1
	M1KGbEwh2/1do5uDcqjdLM3X5K/qtmvQHBMvWTtLdSh50FNIT4ouQ+17LvEXNQdYr4j+Xp
	gJQqfRthDa9Qy++qliXtMt+bx0ClNWQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-3bUbSWLjMwaswqP8KKIuJA-1; Wed,
 23 Sep 2026 16:09:35 -0400
X-MC-Unique: 3bUbSWLjMwaswqP8KKIuJA-1
X-Mimecast-MFC-AGG-ID: 3bUbSWLjMwaswqP8KKIuJA_1790194174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37B9218011FC;
	Wed, 23 Sep 2026 20:09:33 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.44.48.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A7591956087;
	Wed, 23 Sep 2026 20:09:28 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH v2 3/5] fs: Basic infrastructure for offloading inode reclaim
Date: Wed, 23 Sep 2026 22:09:26 +0200
Message-ID: <20260923200927.1834507-1-agruenba@redhat.com>
In-Reply-To: 20260911085142.1774803-8-jack@suse.cz
References: 20260911085142.1774803-8-jack@suse.cz
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Jan,

it seems that we don't really need struct inodes_to_prune; see below.

diff --git a/fs/inode.c b/fs/inode.c
index 7c69ef44619a..f8303af66fcd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -938,12 +938,6 @@ void evict_inodes(struct super_block *sb)
 }
 EXPORT_SYMBOL_GPL(evict_inodes);
 
-struct inodes_to_prune {
-	struct list_head freeable;
-	struct list_head deferred;
-	unsigned int deferred_count;
-};
-
 /*
  * Isolate the inode from the LRU in preparation for freeing it.
  *
@@ -958,7 +952,7 @@ struct inodes_to_prune {
 static enum lru_status inode_lru_isolate(struct list_head *item,
 		struct list_lru_one *lru, void *arg)
 {
-	struct inodes_to_prune *lists = arg;
+	struct list_head *freeable = arg;
 	struct inode	*inode = container_of(item, struct inode, i_lru);
 
 	/*
@@ -1013,13 +1007,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
 
 	WARN_ON(inode_state_read(inode) & I_NEW);
 	inode_state_set(inode, I_FREEING);
-	/* Inode will take long time to cleanup. Offload that to worker. */
-	if (inode_state_read(inode) & I_DEFER_RECLAIM) {
-		list_lru_isolate_move(lru, &inode->i_lru, &lists->deferred);
-		lists->deferred_count++;
-	} else {
-		list_lru_isolate_move(lru, &inode->i_lru, &lists->freeable);
-	}
+	list_lru_isolate_move(lru, &inode->i_lru, freeable);
 	spin_unlock(&inode->i_lock);
 
 	this_cpu_dec(nr_unused);
@@ -1042,27 +1030,34 @@ static int get_deferred_sb_id(struct super_block *sb)
  */
 long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
 {
-	struct inodes_to_prune lists = {
-		.freeable = LIST_HEAD_INIT(lists.freeable),
-		.deferred = LIST_HEAD_INIT(lists.deferred),
-	};
-	long freed;
+	struct inode *inode, *tmp;
+	long freed, deferred = 0;
+	LIST_HEAD(freeable);
 
 	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
-				     inode_lru_isolate, &lists);
-	dispose_list(&lists.freeable);
-	if (!list_empty(&lists.deferred)) {
+				     inode_lru_isolate, &freeable);
+
+	list_for_each_entry_safe(inode, tmp, &freeable, i_lru) {
+		if (inode_state_read(inode) & I_DEFER_RECLAIM) {
+			deferred++;
+			continue;
+		}
+		list_del_init(&inode->i_lru);
+		evict(inode);
+		cond_resched();
+	}
+
+	if (!list_empty(&freeable)) {
 		int id = get_deferred_sb_id(sb);
 		int i, wake_count;
 
 		spin_lock(&deferred_reclaim.queues[id].lock);
-		list_splice_tail(&lists.deferred,
-				 &deferred_reclaim.queues[id].list);
-		atomic_add(lists.deferred_count, &sb->s_deferred_reclaim_count);
+		list_splice_tail(&freeable, &deferred_reclaim.queues[id].list);
+		atomic_add(deferred, &sb->s_deferred_reclaim_count);
 		spin_unlock(&deferred_reclaim.queues[id].lock);
 
 		/* Queue works to process inodes we've added to the list */
-		wake_count = (lists.deferred_count + INODE_RECLAIM_BATCH_SIZE)
+		wake_count = (deferred + INODE_RECLAIM_BATCH_SIZE)
 						/ INODE_RECLAIM_BATCH_SIZE;
 		if (wake_count > deferred_reclaim.workers)
 			wake_count = deferred_reclaim.workers;
-- 
2.55.0

Thanks,
Andreas

