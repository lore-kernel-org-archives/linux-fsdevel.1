Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565472;
	b=vjofOQJCo306SzgPpJl9Bi7aJKeR5cNkcPC3tZVSzRgCGXgA18rOmNqqEhBGtvTfQ7XP
	 l7grwboYBcfkzzGbD/F/FNbbcNopX1fcZYZU8utQqoAcobg8dQAwfjBHjoRzgnrY8d2bM
	 14JZWZzubAHdPcJAL8JkEUoIy9Lde5W5WTghrYo6bSIuENtuEnhjnXsODjANxW6bDnCzY
	 uNh8ciI9vCAkLqzpj/8oXKFc/IR7deYO5A4It0CzIYTn/N06tn9Za3Auwo1ekoga858rU
	 sX5MUS9Imo7f6gbTyaz1911EOpbdbtIsGVDrFmhat08WDMGkEKgdmEy3YltwN4FPEuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565472;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=FWsNHE8IDt5282fJs8mLTDoA+L7uIoHl/LsV7F05pnM=;
	b=AxcGCNcgLUQc7nrGInyMDZ9R1dQ6dDtuIQx3FowVa70/1hxiJoSzcavagwYURvf1vTX9
	 O39XCH3J1D3gt7Fa/pNZz6wWTpd2GkcIv1OdqhqxNozP8EmTWA6zqM065MXiEiWN+OuDb
	 hF8EKLnTaMd84Q8uTEMHL6ifQOpd8iIopluJwa7ckUMLIp94B2oAIwGWm5OE9ReoNQzEz
	 fwwZ3AQ7hnO8Pve7OhzFPyQmhcBG1FpWIBxUAgaaRHM2XfXXw3Rb3XJg0ZpZQG2N/f5yO
	 HB84YQx/M9WtdJQR+fUD3EM8bHOOOjqRXNSV4rj/3Gg4SfbRr+gleU4Y9YX/M61SnbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hVaDM50j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1w8TJyhu;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13B606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 00:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F13B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hVaDM50j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1w8TJyhu
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7A751400341
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:11:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 24 Nov 2026 19:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795565470;
	 x=1795651870; bh=FWsNHE8IDt5282fJs8mLTDoA+L7uIoHl/LsV7F05pnM=; b=
	hVaDM50juekno8uN2ZMG0HDtDNFxPo5/6aF7EDDTBO+8WF00z0fPTQXKWbAp+LtU
	33PlhXa/8JNdIPXoeuafNVJcpQQzll3hm56mi9an5MkMZUxpuNUmAPpUCXH6yFpH
	DhDQ9xD+qYFcnZEVo/hIQfi9Y+3xH9DibdaSEkmi/yeoZ3eo+5AY1cbkn4DWpnPn
	meSPaxjuvURSkh3nmc9Eu0WFC5d0kFbevdDlqRnjyTT4IEmh8K1cnZQCEpxoy7Wj
	sD2rC0uDKE8Nm4lw70iElr9wBxqKwHMJoKRNo/FXj2dW56REH3PfUf66dcsUuqg/
	Jy4apAbq38x9IXNaYlcUTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795565470; x=1795651870; bh=F
	WsNHE8IDt5282fJs8mLTDoA+L7uIoHl/LsV7F05pnM=; b=1w8TJyhu2kDKh67Xe
	r29Hj604au0wIQMzsPkBiPw+LOz/qrzcUvXxbsZ+cqf0DJ/CwJ/C1BQ0iSOxjmZ+
	gt8GNeHn5zy3gIeT+0Bl3/qqT92vBQqhUcNBcgs8kmKxG0zAhu2QEP3fmzmqfNZw
	K1Rc2IG0L+wQBAmzjocIdiYx7MV0jjzmZQDuN9qVOPEwad7NKU/BnfdxhnbGJuzq
	3wqQP1ibJtUHXg6i/lG1jcFdaXxXM19lyIahiSkGn7KSzKkAUUezDUoWQ4qrXuzX
	Aj1jTOBNav6e7LiZUmLYAkWKh8y9p4om9tiFH92O32paMjLvbGAE4fhWhoYoN3Dl
	55dgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795565470; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:OBiGEdG75WF1psV/oxTVJyoSJeqzDctcRhoKTtRcZorl8uA
	JSc8Bk7xR7fJtrhc/9O7kvsfuBkF9kiEc5wd/usOkXt10TVuNJ5cwnwHALzSrXpL
	9XucgtIgNIEsznYRQoH1iL9mpezuvSlYl82a+n//glIwwnyWGTUp5Srt/kdjhFtb
	6VIJ4MD+gY2t4oNzJ3DcYakPquoIKyAqz1CrJYaj7PMwkdXm49uZWX0ZBAT3ETYq
	gmit2unhmIFirITP4pznl38Fd1HH5Zstc1uEaUQKaBWmeDXJIoNO0AdNdK0bXJjo
	4XCrVMSJwmcLFhBwKTaqCOdbuVSLGv/Fd2kPZcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:HB2c5WXFttXR84/kRM1xc2YrsUmXLaHAkNm//89yMO8=:TX4tcJe7vXVM+RwD5ZAOYQl/2lYHzsV3r1kOi3lKJbk=;
X-ME-Sender: <xms:nicGa89Hnj5zOjD6JEU4wFmWfRKES2zwIiIP4u1GUpLjNQVpNxhXtw>
    <xme:nicGa3RtcMVG4U10BAYYj5t2eKOspY3ZYwoH5MPFEkQ69wbKEPfdJCeBfoZlxpA-j
    uskflKHZ99_mECtqBARooVONvNx8tGuTcVKWJfcxK3sTBDTng>
X-ME-Received: <xmr:nicGa1qnQhnMxOV0rykL-_aQesIiJPBDfeML16DfoP1HxWMXZ_5AdR4s4sHCLxSpScGVvWe5Km8pilRmGOBuoMFxxOWlQWg>
X-ME-Proxy-Cause: dmFkZTEWLT7VrCmqXFQ/3MlmFKwGsnI42jGU9wsAMLqZ91wz8mggV5m1msJjVSCHxeBUqJ
    t97+mptHMICXthawWKapABbbyhWq7+uuMmApmcH+Yba1WLWrkpVix7mPta4EAT8yMDamx0
    5loYd6jJqeFIrGsONkYYE6J9hbaumuKI+/Omki5Aa4Aq5KfhTiLPUl0BoveVjf5cOUWX5w
    4HMB7hKbpvsoA+vADp3tWal1VkBjpQ6AgmqI+ZRNztjqSQMs2MYuFzBsfnKESIRZVSoi1i
    NXRaNZOSkWUP3rzL/NZtKjvVOieVFii1RhBvtxr3qqxuVDS0tX4ZmqS3Hzxkk/+20l5gXC
    NJmBoPzTesz8b9suXzIs9Fu/nhgeW6vZgoY23EUkdu2x5C1d6HXLxcecOYG57d+cetYANu
    FOLJ85l93qYVgehMfkTAasyXOL4K7lDQ8Z6Cv5Cnu45FElwEYC3DcpzwZFrXgZvN60MqL+
    1eEkoYilLajfukSWjdZ8K3RfGC+V+qskPnHX/iwwppZWHKy5kjCg4xeENtAjgAiUf440q5
    5Sr+OOl0DMQjL1ZnyH/MZUoYjpt6TdfY23iVKN0iu++vs1D9ZIVX89UXYAzu61RiZ4i0CD
    y4dl33ABf/z42E0xt81fg92G4eMovOE1/RSVPdRgBHAZvQMRVO8WAQGCHwUQ
X-ME-Proxy: <xmx:nicGa8nSQATChHVqqfRc6Sq4nZbyqbjUppr2pYFdZhMgE_RJ51MGDA>
    <xmx:nicGa2eFxi3QIEDm-oOldvyGZtnRpVu3p4r54-jNkHDHmCIaoRXUHg>
    <xmx:nicGawoN9zcV6h13TXt8iME8gJY6NOe7jZ_UPnllt2p4YP32Yqc_jQ>
    <xmx:nicGa4OFJkQc0PnYhtSrZvkVpPB5UP8UEBVvgCDHNJRK_m5jDMdfxg>
    <xmx:nicGa-FTDVNynbm5EPtyX6ds8KSea-HdeInV2AmL-_lpx536lvU1YhgE>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 19:11:07 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v7 4/5] Add d_for_each_positive_child family of iterators
Date: Wed, 25 Nov 2026 11:03:41 +1100
Message-ID: <20261125000836.3984402-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125000836.3984402-1-neilb@ownmail.net>
References: <20261125000836.3984402-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Provide iterators for the d_children/d_sib lists.  These iterators only
report dentries that are positive (though they could be negative by the
time they are used).  As DCACHE_DENTRY_CURSOR dentries are never
positive they are never reported.

d_for_each_positive_child() takes the parent lock and sets the iterator
to each positive child in turn.

d_for_each_positive_child_continue() can continue after an existing
dentry, or (when initialised to NULL) behave like
d_for_each_positive_child().  This requires that something prevent the
start dentry from being moved before
d_for_each_positive_child_continue() can take the parent lock -
typically ->i_rwsem.

The use of scoped_guard() in these macros makes it safe to "break" or
"goto" out of the loop - the lock will be dropped in that case.

As there are reports that large numbers of negative dentries can lead to
soft lockups when walking the d_children/d_sib list, particularly in
fsnotify_set_children_dentry_flags(), we call cond_resched() as needed
during the walk.

To achieve this we use an on-stack dentry (about 330 bytes) to place a
cursor while calling cond_resched().  On-stack dentries are not standard
practice but should be safe since

Commit 3df5153c5f12 ("make cursors NORCU")

made cursors NORCU, confirming that they can safely be released without
waiting.  Also importantly nothing ever takes a reference on a cursor
that it doesn't own.

To facilitate this, a new __d_init() is split out of __d_alloc() and
used in d_init_cursor() which can be called on an on-stack dentry as is
done in the new d_next_sibling_sched().

Link https://lwn.net/Articles/1079407/
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 116 ++++++++++++++++++++++++++++++++++-------
 include/linux/dcache.h |  68 ++++++++++++++++++++++++
 2 files changed, 164 insertions(+), 20 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 8ddfddc31546..a8b453f2ae4e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1950,6 +1950,27 @@ void d_invalidate(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_invalidate);
 
+static void __d_init(struct dentry *dentry, struct super_block *sb)
+{
+	dentry->d_flags = 0;
+	lockref_init(&dentry->d_lockref);
+	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
+	dentry->d_inode = NULL;
+	dentry->d_parent = dentry;
+	dentry->d_sb = sb;
+	dentry->d_op = sb->__s_d_op;
+	dentry->d_flags = sb->s_d_flags;
+	dentry->d_fsdata = NULL;
+	INIT_HLIST_BL_NODE(&dentry->d_hash);
+	INIT_LIST_HEAD(&dentry->d_lru);
+	INIT_HLIST_HEAD(&dentry->d_children);
+	dentry->waiters = NULL;
+	INIT_HLIST_NODE(&dentry->d_sib);
+
+	lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
+			 &sb->s_type->d_lookup_key, 0);
+}
+
 /**
  * __d_alloc - allocate a dcache entry
  * @sb: filesystem it will belong to
@@ -1959,7 +1980,6 @@ EXPORT_SYMBOL(d_invalidate);
  * available. On a success the dentry is returned. The name passed in is
  * copied and the copy passed in may be reused after this call.
  */
- 
 static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 {
 	struct dentry *dentry;
@@ -1991,14 +2011,14 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		p = kmalloc_flex(*p, name, name->len + 1,
 				 GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
 		if (!p) {
-			kmem_cache_free(dentry_cache, dentry); 
+			kmem_cache_free(dentry_cache, dentry);
 			return NULL;
 		}
 		atomic_set(&p->count, 1);
 		dname = p->name;
 	} else  {
 		dname = dentry->d_shortname.string;
-	}	
+	}
 
 	dentry->__d_name.len = name->len;
 	dentry->__d_name.hash = name->hash;
@@ -2008,23 +2028,7 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	/* Make sure we always see the terminating NUL character */
 	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
 
-	dentry->d_flags = 0;
-	lockref_init(&dentry->d_lockref);
-	seqcount_spinlock_init(&dentry->d_seq, &dentry->d_lock);
-	dentry->d_inode = NULL;
-	dentry->d_parent = dentry;
-	dentry->d_sb = sb;
-	dentry->d_op = sb->__s_d_op;
-	dentry->d_flags = sb->s_d_flags;
-	dentry->d_fsdata = NULL;
-	INIT_HLIST_BL_NODE(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_lru);
-	INIT_HLIST_HEAD(&dentry->d_children);
-	dentry->waiters = NULL;
-	INIT_HLIST_NODE(&dentry->d_sib);
-
-	lockdep_init_map(&dentry->dep_map, "DCACHE_PAR_LOOKUP",
-			 &sb->s_type->d_lookup_key, 0);
+	__d_init(dentry, sb);
 
 	if (dentry->d_op && dentry->d_op->d_init) {
 		err = dentry->d_op->d_init(dentry);
@@ -2041,6 +2045,78 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	return dentry;
 }
 
+/**
+ * d_init_cursor - initialise an on-stack dentry cursor
+ * @dentry: the dentry to be initialised
+ * @parent: dentry of parent where cursor will be used.
+ *
+ * A DCACHE_DENTRY_CURSOR is initalised for use in marking
+ * a place in the d_children/d_sib list.  While sb-related
+ * fields are filled in, they should never be used.
+ * The filesystems d_init is not called and a final d_put()
+ * should not be called, else d_release would be called.
+ */
+static void d_init_cursor(struct dentry *dentry, struct dentry *parent)
+{
+	const struct qstr *name = &slash_name;
+	char *dname;
+
+	/*
+	 * We guarantee that the inline name is always NUL-terminated.
+	 * This way the memcpy() done by the name switching in rename
+	 * will still always have a NUL at the end, even if we might
+	 * be overwriting an internal NUL character
+	 */
+	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
+	name = &slash_name;
+	dname = dentry->d_shortname.string;
+
+	dentry->__d_name.len = name->len;
+	dentry->__d_name.hash = name->hash;
+	memcpy(dname, name->name, name->len);
+	dname[name->len] = 0;
+
+	/* Make sure we always see the terminating NUL character */
+	smp_store_release(&dentry->__d_name.name, dname); /* ^^^ */
+
+	__d_init(dentry, parent->d_sb);
+	dentry->d_parent = parent;
+	dentry->d_flags |= DCACHE_DENTRY_CURSOR | DCACHE_NORCU;
+}
+
+/**
+ * d_next_sibling_sched - return next sibling, but schedule() first
+ * @child:  current child
+ *
+ * This behaves like d_next_sibling(), but drops the parent d_lock
+ * and calls cond_resched() to avoid any soft-lockup.  A cursor
+ * is inserted as place holder.
+ *
+ * Caller must hold the parents d_lock, and must hold a counted
+ * reference on the parent.
+ *
+ * @child should not be a cursor, else two threads could potentially
+ * live-lock, each only stepping over each others cursors.
+ *
+ * Returns: the next sibling, or %NULL if there is none.
+ */
+struct dentry *d_next_sibling_sched(struct dentry *child)
+__must_hold(&child->d_parent->d_lock)
+{
+	struct dentry cursor;
+
+	d_init_cursor(&cursor, child->d_parent);
+	hlist_add_behind(&cursor.d_sib, &child->d_sib);
+	spin_unlock(&cursor.d_parent->d_lock);
+	cond_resched();
+	spin_lock(&cursor.d_parent->d_lock);
+	child = d_next_sibling(&cursor);
+	d_detach_cursor(&cursor);
+	WARN_ON(d_count(&cursor) != 1);
+	return child;
+}
+EXPORT_SYMBOL(d_next_sibling_sched);
+
 /**
  * d_alloc - allocate a dcache entry
  * @parent: parent of entry to allocate
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 83e8569a82e5..85ea270fba9b 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -692,6 +692,74 @@ static inline struct dentry *d_next_sibling(const struct dentry *dentry)
 	return hlist_entry_safe(dentry->d_sib.next, struct dentry, d_sib);
 }
 
+struct dentry *d_next_sibling_sched(struct dentry *child);
+
+static inline struct dentry *d_next_positive(struct dentry *child)
+{
+	do {
+		/* Don't schedule on cursors to ensure we make progress. */
+		if (need_resched() && !(child->d_flags & DCACHE_DENTRY_CURSOR))
+			child = d_next_sibling_sched(child);
+		else
+			child = d_next_sibling(child);
+	} while (child && !d_is_positive(child));
+	return child;
+}
+
+static inline struct dentry *d_first_positive(const struct dentry *parent,
+					      struct dentry *child)
+{
+	if (!child)
+		child = d_first_child(parent);
+	else
+		child = d_next_sibling(child);
+	if (child && !d_is_positive(child))
+		child = d_next_positive(child);
+	return child;
+}
+
+/**
+ * d_for_each_positive_child - iterate over positive children in the dcache
+ * @child: iterator dentry
+ * @parent: dentry of parent
+ *
+ * Iteratively set @child to each positive child of @parent.
+ * @parent->d_lock should NOT be held.
+ * @child may no longer be positive when the caller examines it
+ * so care is still needed which could involve locking the child
+ * or using d_inode_rcu() to access the inode.
+ *
+ * DCACHE_DENTRY_CURSOR dentries will never be returned, only true children
+ * which have at some point in the past been positive.
+ */
+#define d_for_each_positive_child(child, parent)			\
+	if (({might_sleep();0;})) ; else				\
+		scoped_guard(spinlock, &parent->d_lock)			\
+			for (child = d_first_positive(parent, NULL);	\
+			     child;					\
+			     child = d_next_positive(child))
+
+/**
+ * d_for_each_positive_child_continue - iterate over remaining positive children
+ * @child: iterator dentry and starting point.
+ * @parent: dentry of parent
+ *
+ * If @child is %NULL this behaves identically to d_for_each_positive_child().
+ * Otherwise @child must be an existing child of %parent and subsequent children
+ * in the d_children list of @parent are returned.
+ *
+ * Safely using this requires that something prevents @child from being
+ * renamed to a different directory before we get the lock.  Holding
+ * i_rwsem on the @parent is sufficient.
+ *
+ */
+#define d_for_each_positive_child_continue(child, parent)		\
+	if (({might_sleep();0;})) ; else				\
+		scoped_guard(spinlock, &parent->d_lock)			\
+			for (child = d_first_positive(parent, child);	\
+			     child;					\
+			     child = d_next_positive(child))
+
 void set_default_d_op(struct super_block *, const struct dentry_operations *);
 struct dentry *d_make_persistent(struct dentry *, struct inode *);
 void d_make_discardable(struct dentry *dentry);
-- 
2.50.0.107.gf914562f5916.dirty

