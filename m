Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E03451C1;
	Thu, 30 Apr 2026 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518579; cv=none; b=gjg4jYb1rtIUJNQ5Rv9YfuuB4I5eU1QxIwoCieM87qOJMJFVYc1GIuArY4m2iv0eSDl4v8yp4KhvdZ3zslqMTQ2NBU+tyK2gp0Vn0JU9+GOI58x7d9GhvSaooaacD3HjzyiaeKboRGmgZMikeXDQvcwKaxXIUhcLhYYFO75fIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518579; c=relaxed/simple;
	bh=aI/7LxQasa/WMqtdcaEEHsmvZknfOqE36vo7BSVAHxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9usimgavFeJSts7ePwW6BGVFgjzA68dDSKG9+pMbHBUH2STbqL9BWuvY/UbqnrCWumwE8nK6zH64wW4t+XEwCDhNkDTAQE7T5naZ+2LImb8CUVdo6pPrV6h1BDA2n+6/gqnwSwbJL3b5BXWDvMbWFAweUP5xmGCT9KrTUhd0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jiFKN5H6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIHFdhxp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jiFKN5H6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIHFdhxp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 529C81D00113;
	Wed, 29 Apr 2026 23:09:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 29 Apr 2026 23:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518577;
	 x=1777604977; bh=NvBayTPXi0DVU1I5ML5QY0CEm4bJY9EzhHJqYyVRowQ=; b=
	jiFKN5H6lMe21XIRD5gxVqYnUexildLkn+nn77y2172uxtAJkftIPBJkpSnU/Bnb
	qPbUxEtrnV3U1Afxc64o10VFDLAlxREpp3uvF0SaZiYWeJeUMutViCUzn9Y/ZA79
	mZ2ubLD5DOwuI8xnfccYBw5/E1jEXsXepwc4ZGK54cmVj+3Hwrb3q1wIAcZ9ruNz
	IJN6va1f5NPPsfxVF3QRSF+d8VBy+eaN+mpq7y3RO0V96kxbDhk/P7tcaKxD8DPc
	o2EHZseWL5Z7nT9DD9X2a3KkdP8f/8953jMQULmeivRDWDMPc0LZZ4trbZkQEdKW
	YXi8exxHJ+kAzHf/NU5apg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518577; x=1777604977; bh=N
	vBayTPXi0DVU1I5ML5QY0CEm4bJY9EzhHJqYyVRowQ=; b=WIHFdhxpuK8pVZ88X
	r+XSaTC8kpZv89AXB56QmwnRIWdKd63b2n8obrEMCXVuz0FxoXzSQiPV+Jr34X8u
	Olpx/nXRtHjGowxlP0ek1q3JIaOBQzApSLy0ayyG3g3m9fdRNcZsbHydr0JOuGR+
	tPQAzMg0ndhHYKRJ+dewMrs9fDxwLquHjJ+fmxSzz+tO8iCP5rPi8waerXb6Q9Mh
	UdfwKAQxegZLxYK+VnOwqxWBE5eQGjFvJIMP1LC+UETIAzHpZ0aoaXe9gusNwfs3
	HAqnoN0RiLm7MKXZyLcggUxMaFLMMRc3X7kUcGH0EUYba7E/IPVgrF/E4Uj8irrP
	FgWEw==
X-ME-Sender: <xms:8cfyaY3HLz3wf6rM1-8eaVY_WTp7VRBTpKRbezbR-yd7RbY86PCW1g>
    <xme:8cfyaVqFUGmnGixMx7KPmJlhXURJ6rh83-qea_TDkk-m17PGMP5LBVPOqmxnUGxzz
    iPT4vIh6Hyj0AO-DNtl2K6OCa5XWrvTrX_KR21ro2jpyMbpXA>
X-ME-Received: <xmr:8cfyaUh4LbHVPdO7ilZ10X8zFGogcqWBrh8WCjesxrd0kGsGVp6KOqk_7ElrE7ItQny3ybnOPwbIMaa_2063VnpssjcCFp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8cfyaR-cWap5URbR9_fnYf1UQmF2DZ5rbHaeFWZB7BqnK37gtvsQiA>
    <xmx:8cfyaQWDf1qoD3SKk2OqPiXvr96ZH14QTZORtH2iOmA063eOEtPiPA>
    <xmx:8cfyaVD9PkjmmHCOn_C84TCRoEbBQ01s-DIgg8Z63CVU2rSnVsqIjg>
    <xmx:8cfyaVG3LglzohApiYW1cDeEqHEzVjGBPLmHY0j8HOuDUeN50gxNOg>
    <xmx:8cfyad8WUsXCn89ixD6D1VCVxE2rgKT6vqYw26L_3OTVRl-vrrwMXg4R>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:34 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] VFS: add d_duplicate()
Date: Thu, 30 Apr 2026 11:56:58 +1000
Message-ID: <20260430020137.3305302-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020137.3305302-1-neilb@ownmail.net>
References: <20260430020137.3305302-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Occasionally a single operation can require two sub-operations on the
same name, and it is important that a d_alloc_parallel() (once that can
be run unlocked) does not create another dentry with the same name
between the operations.

Two examples:
1/ rename where the target name (a positive dentry) needs to be
  "silly-renamed" to a temporary name so it will remain available on the
  server (NFS and AFS).  Here the same name needs to be the subject
  of one rename, and the target of another.
2/ rename where the subject needs to be replaced with a white-out
  (shmemfs).  Here the same name need to be the subject of a rename
  and the target of a mknod()

In both cases the original dentry is renamed to something else, and a
replacement is instantiated, possibly as the target of d_move(), possibly
by d_instantiate().

Currently d_alloc() is used to create the dentry and the exclusive lock
on the parent ensures no other dentry is created.  When
d_alloc_parallel() is moved out of the parent lock, this will no longer
be sufficient.  In particular if the original is renamed away before the
new is instantiated, there is a window where d_alloc_parallel() could
create another name.  "silly-rename" does work in this order.  shmemfs
whiteout doesn't open this hole but is essentially the same pattern and
should use the same approach.

The new d_duplicate() creates an in-lookup dentry with the same name as
the original dentry, which must be hashed.  There is no need to check if
an in-lookup dentry exists with the same name as d_alloc_parallel() will
never try add one while the hashed dentry exists.  Once the new
in-lookup is created, d_alloc_parallel() will find it and wait for it to
complete, then use it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index a0096ac02790..1943607f7547 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1900,6 +1900,57 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 }
 EXPORT_SYMBOL(d_alloc);
 
+/**
+ * d_duplicate - duplicate a dentry for combined atomic operation
+ * @dentry: the dentry to duplicate
+ *
+ * Some rename operations need to be combined with another operation
+ * inside the filesystem.
+ * 1/ A cluster filesystem when renaming to an in-use file might need to
+ *   first "silly-rename" that target out of the way before the main rename
+ * 2/ A filesystem that supports white-out might want to create a whiteout
+ *   in place of the file being moved.
+ *
+ * For this they need two dentries which temporarily have the same name,
+ * before one is renamed.  d_duplicate() provides for this.  Given a
+ * positive hashed dentry, it creates a second in-lookup dentry.
+ * Because the original dentry exists, no other thread will try to
+ * create an in-lookup dentry, so there can be no race in this create.
+ *
+ * The caller should d_move() the original to a new name, often via a
+ * rename request, and should call d_lookup_done() on the newly created
+ * dentry.  If the new is instantiated then old MUST either be moved
+ * or dropped.
+ *
+ * Parent must be locked.
+ *
+ * Returns: an in-lookup dentry, or an error.
+ */
+struct dentry *d_duplicate(struct dentry *dentry)
+{
+	unsigned int hash = dentry->d_name.hash;
+	struct dentry *parent = dentry->d_parent;
+	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
+	struct dentry *new = __d_alloc(parent->d_sb, &dentry->d_name);
+
+	if (unlikely(!new))
+		return ERR_PTR(-ENOMEM);
+
+	new->d_flags |= DCACHE_PAR_LOOKUP;
+	spin_lock(&parent->d_lock);
+	new->d_parent = dget_dlock(parent);
+	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
+	spin_unlock(&dentry->d_parent->d_lock);
+
+	hlist_bl_lock(b);
+	hlist_bl_add_head(&new->d_in_lookup_hash, b);
+	hlist_bl_unlock(b);
+	return new;
+}
+EXPORT_SYMBOL(d_duplicate);
+
 struct dentry *d_alloc_anon(struct super_block *sb)
 {
 	return __d_alloc(sb, NULL);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index d22c308043bb..b4663a1a0636 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -259,6 +259,7 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_noblock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-- 
2.50.0.107.gf914562f5916.dirty

