Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B80345752;
	Thu, 30 Apr 2026 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518622; cv=none; b=qcnbIRNsYMztTq80ygylYG3H8NW040TFEG/xSSYmcoDS4iX1RSrpdIPM1JZLaW/9S/rzIeSrNVeXhJQZxaq/DrJ8VCq9RAkzmwiUp33SbWp8W/73DVXyUuwzxrZ61qjSMgrqmOnJlTVQgucAisLM9r+v+mQn8toxPk0NGfFmgI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518622; c=relaxed/simple;
	bh=aI/7LxQasa/WMqtdcaEEHsmvZknfOqE36vo7BSVAHxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qM++kdE11+LqQd4VsmVvy9neFP7Ji8h3NROd8zNwAU4TybuoYyhUkDyeIn4SB29FFNnDNgJzetvGRzLvC6BfRHM693eCflxwdng80GUFR0pIs7bNZE3ShwybpcpNqD/3JOVxwm804X7LlIHDYJhrFRu1mP8tI0L/YKGPShHiYLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=dKxEgeKa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZPZo2uqk; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="dKxEgeKa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZPZo2uqk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A9D741D00090;
	Wed, 29 Apr 2026 23:10:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 23:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518620;
	 x=1777605020; bh=NvBayTPXi0DVU1I5ML5QY0CEm4bJY9EzhHJqYyVRowQ=; b=
	dKxEgeKakhYp7/fbDosK8vA9PeXqmwho/81YnYfxSgzTCPpIjoUb7qfuB4yhLEa7
	O+jTMx9OfLH4Kq2vM73nPXbhcBHftVFmfDClF+Ok9bqYk9ifKmap/fI4G29x7XS6
	tNR80t8IPd0+5lGMMLliP8F5J/1BbUnEcOOOuR9oDiMmeXuYo266rN1fyZAXew9e
	/q6IfbIUa1A8G4G7Ww3s1V16fZRzg2+8aBKDna9tSNME/rP1YQIn3r7UBJmIsc2v
	uGw+M/AaTbkysU8Y14zHAz8szI4pI3fwo6mlecVjv+EhzIkmeKRQ3OgxZIfCYaHT
	QlW0IvuvtIU23t4FZXBAFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518620; x=1777605020; bh=N
	vBayTPXi0DVU1I5ML5QY0CEm4bJY9EzhHJqYyVRowQ=; b=ZPZo2uqktIuLweium
	QcQHSdifyCILI/8pdvYFCg7JWZYE/80kT5DzwDZFhggBKLZJUbr2XxcGdwk3AXir
	I0GjHcsVB5XxGfdGMXuDVBKQtV7zAYu44ReGxYafgm+99XOUlMMjCEAr1K8SCJuh
	ZEvUnnwvO9eeiWtfmrCMk6xJ0l06Zqrl0WOukrP1QZBplRm+ZkEhl7WO4mqED+aF
	FOpl0QuFJ8ucidZgT8fVkxq41LZ3Oq/yKy50kvpuDuSn0itBYY4djF5ZfxbSOeLl
	FvFxaBSBGFeAjSucbQ76cGcLq6zWgKYDiqdQP6rIVr0UWu54H6PxilFUKPAqiF84
	V+B0w==
X-ME-Sender: <xms:HMjyaQk8IERVHWjSBTMZRq96hmsTxQiftaSMq3AhMdeF9GlYGHFIyw>
    <xme:HMjyaSaGqVD5VblpLpwH8a6ifIlbtNahNlxmV9DEerGSl5Sz0CPJELmzs5STQ1nZw
    tPxSKcSVgWEwPd65ywtV9zzR1lAKqw7ujsgsHdhh0uM7i1S>
X-ME-Received: <xmr:HMjyaSQX2sw_YxF2rum1TtQO6xyPgOX7Jq2nyHZKa_zRWYlHfyUNdxaCy8e-bSITnt8-I2c1HRLGRM8kX-crI7TS7X49ocA>
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
X-ME-Proxy: <xmx:HMjyacvnYsQfrtnCsO-sbdPh5t3WZptrbIlT_AfBItf3tMsG6G0OOQ>
    <xmx:HMjyaUFDAbUY365XX1fiHMfq2r-8IqzdsNSWAq8t2izQ-bkCX-XGAw>
    <xmx:HMjyady-g6OpqD4eT0PaUzMXTz8qPWghF4U_TNGyrJ5S4nCTxeFJzA>
    <xmx:HMjyae3naIB3IQouGZvtFtTrJi80ZSaSP2fyUj3JzAZlHmpuHvW7iw>
    <xmx:HMjyaVsxeK2QchYQx24Zzlr4cuAa0RaxR5bVDbpkdl22QyGpcwXmGroT>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:10:17 -0400 (EDT)
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
Date: Thu, 30 Apr 2026 12:03:26 +1000
Message-ID: <20260430020505.3308841-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020505.3308841-1-neilb@ownmail.net>
References: <20260430020505.3308841-1-neilb@ownmail.net>
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

