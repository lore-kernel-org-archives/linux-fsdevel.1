Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3343B3CE;
	Fri,  4 Sep 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558823; cv=none; b=u/VLMKd6qiy/EqFoXgNNcXW+zgLL2e9TagPRlKLUEHLg4bh0lyZOwcwdj0AvhHFoxnbgfk5sDUps0gQYHuUCqv8FwmOd1tI3Sgom076WZjsI6Z8QEb2P1tG2ZQvbDQNhXit1lJ7LiCUHE9J/1fIr03fxsJp8/07krA69xb9ww/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558823; c=relaxed/simple;
	bh=ZQvaC8dFecVpds878fbdcXZVKMpD3woowzwCpCb4u9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwAVz8sAStEiVOwkeIJkpa2nt3fL0vQ+aS/ChVBOtxGVnPDSzl7Dr9Z+bbf/TLXwpB0NdheOLFwpFREu0NVgV8a6G8xfkI965K5XbUG2wluTbj0Rhiy1YKFuBtCipErtsFvzW2EFf5Td5z43BqyrR02XuvFiJ2IsFZAAVkCCeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UyLQL+cW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2RuxB6F; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UyLQL+cW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2RuxB6F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5FE11400012;
	Fri,  4 Sep 2026 17:53:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 04 Sep 2026 17:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558820;
	 x=1788645220; bh=C5zeecdiXDFUM4KIYX///uvKg7YTspSiWbXqcfJhCrk=; b=
	UyLQL+cWCZwggjN5YaZkyHdTzwikg4JPPRHAMJUpNPx2YJFfcrqLL6w28LHDoGD5
	BUmfkVQK9IZ2RjXkyQ6uHE704A9lbt0RxAtTgHGkGtIZF8ApqGcgN6kyzw9MC1uX
	ON8kCkoKdbx0WLKIs59rc/bBhfwMh4di2+dvX57r3bH6eWGxHU3X07u7FATNLywL
	1U6AMTkh/Vufh0OdTvAprIxscLzwqmCAEItPfMxNAY+K09ldMo9KCRuK8OmtjuPk
	PdqAM7nEYYGMbm4MzyxvQunhSTDzXibBqcCrNeLkY6yG8uSyCjkyRHKuIHCHMYlY
	B+f9umkkT7Qih+ocViOazA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558820; x=1788645220; bh=C
	5zeecdiXDFUM4KIYX///uvKg7YTspSiWbXqcfJhCrk=; b=Q2RuxB6FISo63kPx/
	wGgxNxhjwQMn3zmPNyf8ZjJ6+YNncPuB1yy9zQABjYWsuOlmRYfEuT35Q6xMljUs
	tqv8cesRTxMOxPiPdAaW8RiE8/ZrTj/ChliIDEDdceR7STNz1GNuHg4PKW95pdsA
	O5Z/843OaxYtBXyoRaiB4cvPA0mnikZN5exvM0tWhyFLBP8WV0YGruOCfwLToHw7
	b0eJPOhmwXqLMLwXQAfOYGV+UStI3WHdP63yhkXx+I1Dpm0JqVz2UYdh4gD6zkik
	8BotGvRQx5/H0Yn/WCA4JqQOLjhB1fkFXcM98p6Z0bU3tUPLVcMOcBpeBQBAt+f4
	ooWvw==
X-ME-Sender: <xms:5D2bam1jUp25mZ5ozs4kmw7pW5YDBabiAcRkTW0NrdzOPBxfVdr2mQ>
    <xme:5D2barojmGKjx2G_rjtNB8iJPBeceKTtiLFmgOxQqgw9CD9SmyMoQfuXp2P06XqMp
    Ze3A29oTMKLz5wVLCNssBwmpFW9YZ3JcBCjsKUig6qeFMT_Qa8>
X-ME-Received: <xmr:5D2baigndm2kWHXS7hqmj4xqJNqxcAH1S2JPBclVPx6qPFHsTQRfdpVEiPzHmtdqjAkiQXN4zbD-LdoE-pXkcuntxaDmhCk>
X-ME-Proxy-Cause: dmFkZTFiAOSj3LUvbMyTizwFG8S0Z77/oyH2J2g/uycK/oy+xjfWiF27uJMr9H7g3QAOe/
    XYsAVApeSvodxh0nJXqm+2ih0Zs0UFQnZPCwAsQgYJh4bKlGJCxAFvJ28DiVFZcSJ1v4SN
    eyofj/RHn+C6wmmzYsHzdQWXaMLzQ5qjTmyCk6u6FNaJzHTyX3mRZJWbQlLecUBL+8R9uF
    oXPgTkabZ8M+0wwMRuzFqlmpEXjU77OKNTiGAEqZPKyJRGqwLIf4volXBc3DcquHRoaijA
    Ked+eKVy/8jzE5J4p8iliYop7ExvhRi8QZDkpUnJW3mwzA4SzmVm5+ia17mBgI6SpbQsZZ
    ROG3vVGdz0eExPr9nwP/a7Ac0MWGotd3LzCIrgaWYQDZ9HkQXPh8G59X6mtm0OB3ydRSVW
    N981RvJoaUo0wpIiZXWImf9hmQFGbQJMzSLaVAGz6TmWtZ3xQCQzd12YZ9uhO53HRUO+SV
    iTeCjsFuybjku9EIoMb5UbnsUaBJCkoho+ubDlYisJGK5azdcTIvPpXTVqf1RBePcLLjX6
    nJnLuMD8gNiGPk/RkiaDefEmzTXgUBLaWHyLXsOhwKZaXyYg6FW2aw9qQxs/A6n7/f1X9y
    X472xqcA63bM7259sZ3ZhH+SiY2m08WudF2gmzaID02FTrg9CtByjRjymkWg
X-ME-Proxy: <xmx:5D2ban9R6ZiNAhrhXUUgh5JGPLkW-D7zbIhHdLDPYhJ7UFHpYdVZwA>
    <xmx:5D2bauX8I39o362fquZll2ZKdnURzRB9Us0sYDE_Z9oTiHyWYgUmBw>
    <xmx:5D2barAhRkIGpnFxDuyflODt981vmOUT51nH62ijJLY2TbRP5g7zRg>
    <xmx:5D2bajF0Z7Hr3wq_R0ER5pm0TbSoWk2BwN8HL4ZRNiONqjE01TSeOw>
    <xmx:5D2bagf4tMb9KPm9Ld0sxnpACkofXm-Dq0Ph-AoQM8wBQ_eoHmODmpG3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:38 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] VFS: add d_duplicate()
Date: Sat,  5 Sep 2026 07:48:13 +1000
Message-ID: <20260904215142.1060510-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
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
index 43149c7849d9..cbd5738de168 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2000,6 +2000,57 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
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
+ * dentry.  If the new is instantiated then the old MUST either be moved
+ * or dropped.
+ *
+ * Parent must be locked.
+ *
+ * Returns: an in-lookup dentry, or -ENOMEM.
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
+	spin_unlock(&parent->d_lock);
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
index 7afe16d4664d..2b7d99ec9306 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -259,6 +259,7 @@ extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_trylock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
+struct dentry *d_duplicate(struct dentry *dentry);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
 					  const struct dentry_operations *);
-- 
2.50.0.107.gf914562f5916.dirty

