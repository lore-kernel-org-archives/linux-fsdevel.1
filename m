Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472085;
	b=BjPgxQzD17dHYD+ed/oIxRAr/WoLClAefblEhOZaA88U9MrucxgIVjk3GiIIn28NVqWj
	 oTYoye3/cnf2FJewyyUdjHi/OMnHUC6pQxTjSSNbK5WeCJn1tgLnvx9CkPvfKji3Zr6rw
	 PAji8rnfk+O8YjzIdMHmUewe0fUM/XV/FyR32z3takrQNbEIn7WkgELOlzPCGXgFQOWJA
	 04FQMdF6RlJB22FfDjia9Qb2J6ygGh6D9JElq+uIfTTi0okfS6dhHHBhIY4w21h28I0uG
	 5e5sCnFKQsnZWZrPyerLAqC5bIsxVpo32n7r9LyjgqFoWw+BnpZVYgSinNadLYSnSYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472085;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=2KorbPrUah8RbwGedcgSzMcw/+0VW+8ZxjtmU07ZFsk=;
	b=pCJ1VrfOmWoM3SoZ9zzWlkD0d6XkQPbd+Z/z7m0XfujQTZUn8J+AEcFPKs9m3C+S0kr6
	 u8W8g1Qwwasfp5ESCWnQpC44hfPi68PmHgAGN8tcdWMfdAgAybEjpfIASkKEpopsYHLC6
	 llL87U3JsMU2Ly7b/+Q0RHCFv00jfrtR7MQveXFyguk9hSwz/d0QnW6+ul+Y2OBmiA5nK
	 3CAOX0kCoM0CgXbLpa+R3bcPGCHat/Ti5FQzBVudnYMNiypef6BcsmKoSXV4CXY3ziCaK
	 HIfXL8KQBLjTowa9pUApoWG44J6vl3zKgFmRe/G+iwiKzDKKR2gFsg/AeFr8xOat96A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=RVxxq2yy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j8s6ci+X;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2282E606A334
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2282E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=RVxxq2yy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=j8s6ci+X
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54F151400334
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 17:14:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Nov 2026 17:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795472083;
	 x=1795558483; bh=2KorbPrUah8RbwGedcgSzMcw/+0VW+8ZxjtmU07ZFsk=; b=
	RVxxq2yy1eeyS15kxuc/e0C/fzk2Zo12vB0xtrjMMYFuT2IQSKAZ7SSIY5nFXXnE
	H0JRQSCFJ1d4UwGOZrGK6WbrhdejBIfltreem9Cm+EQf98ySZ5XoXTZiHXwDQu04
	TrvSSeq6/RIKLH1HlqQfAb6vNilG9pniu4NdCEbRtH3F3bD8Z7n3gtNpAskJaT8I
	Cyhk5dW/knSjWt9WHBng20XsDf9rI14ALtoSgkpgBQyLKUq/3nwCmza/Ney5W8Af
	GPqKZz9moXRn+T7Il7HXJVRiH1eWj/daAnxIn0pgENpsAnLnP/ryJ+KwW8c4e8ul
	CZnhueMeUWIhuP76ng9+pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795472083; x=1795558483; bh=2
	KorbPrUah8RbwGedcgSzMcw/+0VW+8ZxjtmU07ZFsk=; b=j8s6ci+XClZ23HQgS
	T1KvI/Q3l2oomdoKmDeyHmMoLiXr/XkjS7Y3Mps5/uv522xhM42GNB6TgYOQtiN9
	cJ1x8dkd96+zT4WFG72usmZ+Vjs09bpb394oW/KNgtvY/rT3UAUQRTTbvJiKyc2F
	iEXqNCFkTTBhPJE9WsQCxAYtELyWDLaU+pGBBiS/+7C0ZXZgRbsvJ9r8pb+LCNn5
	2CddwfjOtjBQGkvS1Mn/nS/e3Va441NIy3eooaffuATzYGOO+wfI2B6I67I26uVo
	yBx1DZw53m1g0+beoPIXBb6BdAPoiCK76OCH6GjXoxHDPg2hp4Osod59QsJcsDSb
	8PlCQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795472083; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:E3ZucFaPAKf5K9pgYAsLeAbzXRQQcMiDTUWxk15uV6bOsnL
	1+ezC6R9IFIRv3juLfrm6z5NQVEUfSQXvlLIwrDUcy7xz2ReMvQAHprjoi2tb7HS
	7QXOgp8U36PgUcZlQFVjsDJZhSvPihKry96WRkz6gsC24pUhWBFn+1MDGk7PTR2a
	b3YMM7s9v5A2yGsi4DNZH7CfUPiEa63NMui5rO9MVRsFexkcluMlEG1B1bbZlFs4
	DJaJ12XKPvVD+QnckHgPWCOnztwVlvri6AFxBGN/emts1WCVlmzNlXBOWHBIsViZ
	huQI2U+nru8yUBlBs69VdosuNhZqdktsYSY6F0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:k5t/tEMJcA0a3phvqSyWQJOoTbdsjgo0v3Ed+iujPyE=:n2pC3RB7RR2txF48UnUigeXXIPWmJ80sr0AP8LScpHs=;
X-ME-Sender: <xms:07oEa9almSD525UH91A3awsgmozYanZy_dwbnct19BW-SM4AbsbPyQ>
    <xme:07oEa2_AZZSk1bvxjGTYMAuvt5CoLLfVBCBNQ6tkFv445uF0_Df1G07r__IPAFQrO
    Ja8wHmR3vNBqIginBxCLOdc_oIVBtn3_mazqJDBBjVQxF88vxw>
X-ME-Received: <xmr:07oEazl-qMkE5a1OjBp_Y89CEwIzIXJscdllX6oLu3RZEnnBFlNtft2t6GvrYNaoOmbDD7UEGvDW7BvAojfknNwo98AhSKA>
X-ME-Proxy-Cause: dmFkZTFBs1P7heiK17/Uj12aRvG+Cuy5zdDsypAzLw8G4agsGJv2QL+Bw6CkhyDuueYha+
    Q7wTa/cRd5Ga0BCgN3LVyjdbL4txOewgW9uSW7p2FPBAkeZ7rJPRWeEpxFdhGezpnDLYKh
    kNYbJbcVF/RCyvl2DDtIESBU9E06iqRvMzSIXoJqG9m/N8nqymK/TCUDjK8p+1yL9at0Ta
    AE2zXwUfPl5+hCi++Rmh1s+66zmzO6RZcq88P8Tv9baExt/KEcy2HScYrAJVBci7xtx/qG
    0uqlvYF16yHmeWi1ZLjKUCNc5XzDFnQtLPD4OPHq79qeHKsuzqFOUK/BacJxHgyXUr0SCV
    CO0sj2r4w9ZRDyJ5YRYZLucfFKMb2wti11RyeMitHbS2fSBsgE2OWoB9KwYw6ysvTd2cOA
    Vo9ug8Z8Rpk76yxPZbI4Iiz/7a9rlemXzn8q1m8mMHsaH0rEXyEMQ0n9Jz0HWTXEpygE7b
    4nnDN3lD6l4QJ8ayE/8yY+wQn6NhcHuTv+RMEl1IQ/GnpzwXp4oPPtW2SSz8E60Jt2ZCta
    sFDfDBcAZcj8qxtoEBYboFQTcNmEi1JWAwTif6ZhzTAYus8wuJ6yVTr8GavIdHG/OW1BKb
    I30DO/em7x9z97ey1rm4k0MJoFekhEjNdGNdu7WcYxbhW7k2McnMhI5nGGvQ
X-ME-Proxy: <xmx:07oEa7ypPRZlCzmuPsuuWWvnBeBaHwSG0YFc6qATkHwHUAeoe5VBZw>
    <xmx:07oEa95ckOF4xLpIsotpIruyZZkZ0kbGcwj7rUMtG9RBXzEWdGOTCA>
    <xmx:07oEa7W0MPCc3fUSvjaaFjUsdQx_iqkR8H-iupoKIf8uZ0ldZYT8zQ>
    <xmx:07oEa1KL-lxeRtwVXr-5dttB53nY_szfKE49iX4_IxZLlsPizKyXkw>
    <xmx:07oEa9SAtJeWXynA2TCcZU_mpfHkSOOGML0moa9WTiLJ-fMj36yMdtti>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 17:14:40 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v6 4/5] Add d_for_each_positive_child family of iterators
Date: Tue, 24 Nov 2026 09:12:41 +1100
Message-ID: <20261123221410.3328780-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261123221410.3328780-1-neilb@ownmail.net>
References: <20261123221410.3328780-1-neilb@ownmail.net>
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
index b09988d01c55..269bc75fc300 100644
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
index fff8393ec06b..2762747aec6d 100644
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

