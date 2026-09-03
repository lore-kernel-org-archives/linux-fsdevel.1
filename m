Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7E314A65
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405920; cv=none; b=LMBmTGa7L7wq6Z2M36XM7aN1ppEqhHHydMNH0v+9dzGzeRxBwB4rS9tf8//Q45/fur5hduqHM8GQ8ELvV+M/nGuFIzGmgjLTh80Xlh9feoKYqiWmRrsLZWCw0wTNTNedMWpw1C6l6PD7bZXYNSnG3ypT30VVQgjF65DzB83BCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405920; c=relaxed/simple;
	bh=ZQvaC8dFecVpds878fbdcXZVKMpD3woowzwCpCb4u9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fr4UbKTEXbi6yFm0Xto2TfPI4cONnL4E/p0toj5dp6ebSvxiPhgq8Yf8gI2dmF/AtqcKAmVHtAD11AxHkWypcSI3pK/33AiIwmV9vkr7nIU8v6y/+njpO7PDQubUMsdvEUHupADcFkZPb8RkNV//lwyNBscAygoBv03A1+b8rWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W+9jx6HH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSaA2AvG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W+9jx6HH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSaA2AvG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F70DEC0183;
	Wed,  2 Sep 2026 23:25:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 23:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405918;
	 x=1788492318; bh=C5zeecdiXDFUM4KIYX///uvKg7YTspSiWbXqcfJhCrk=; b=
	W+9jx6HHJCgN6PVotc3cDy39vCPMynIcEfZq/QwqymENucuTScPb+HKY1Slq/lAN
	g7eKcwgG2TARwYiJ+rNg/Utbtnk0CqdkedlJGVt6Of0drRcDK1XcckxM32Gz17Gc
	Hcbf2QoMAMSQyvvjLAEuWS75U03qLp4Z5eGhwp5QWJ2UpuV9f8LoJTjuj9cyeZJW
	dMzpXQ1DriGtSkCuI1ILKXq3n5ASwAWOgLHe8Vah86C5EtPTPCM+jEiNH7xO7Vj4
	XbpGnz9UAgvWtLdMR4wP0reYFrXQUTKkeT9pIRjjrCDom2eHMZCkIKm+QOzdLYIs
	FjmhHXOHwHVzWJJQ8dqP6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405918; x=1788492318; bh=C
	5zeecdiXDFUM4KIYX///uvKg7YTspSiWbXqcfJhCrk=; b=CSaA2AvGD7poOUSuX
	8Lx4oao8iw+MqANHZQbLI1NE5F8td8CDc22P4vipxltjiMsM45iuhk1qg0LXE7QY
	Lp9ZcuEXbx3I4pMzlWsmJRt6zR+Wgu/OjqKzoxivLoc4qZrr0BEFusfJd+vcUE6C
	4tcpOgoLuFlftPlE3FalFJXof9/gajf+hdFRKhpXaZduigMWM70IobuXfv6Mi7C+
	9v1t6rXf9FDQb5xnDed3/dRJ7gUhzkKvzkcovVKpseaHbYVxG55i9Gb57wDovAQI
	pyrpvxO73Y8JZWfWbppQooi8KzzYjSi9uqvd+XevxEcc0UZVYZSisuAhFEYUtV+T
	Ebnfw==
X-ME-Sender: <xms:nuiYaqrXvGLFg_psb8hjyzTn34ilaRTjhEcHEXh9qbDhPMAUsrPwpg>
    <xme:nuiYaivvL0M50rvneK-INj99cQ8QSe1kWzyLyombbcgwzTJ74zsxy0AWZBltbXia8
    F6tNfa62Jp-8H45yQPrW5b5YG6aK8ntvh7cWrWeKRxFscr_eJI>
X-ME-Received: <xmr:nuiYavHSx-VvWyiAO_u5747qB6WsiYbMkTLckoMaAB2iaXzFnjCR8biwRghe8gty7RrEv_WPhA3Bx8BQ78O_02kab9HwM28>
X-ME-Proxy-Cause: dmFkZTFXt6cUefGPSewwwFqdKdDzyta/nNOStoIf8ygsd3d55Ylv2azk0WUcYGr/qWGe89
    /agY7xGpogS9PXkreI4nrnEfEmH4ukRCYLCLQ3ife4R0W6dMBF5Im/9SUb/nWmHvjbtfji
    C94zMCN8ZKwE6V7UAH/g5bDmuGJ60zEKAcm0MCk2H/yiC+xmz/8AzeGfH/ZAapoxNSHcuj
    2NAwOe/HPAaVDALEsfGdSX4FygHdBou8gRiZnt7cvbj+wi4KWShvSMjFP4ENhF65bJ2jDU
    hJYERCmXGNC3cGgAODpYVa2vdRDJp2cxqVzJcwEfZ6JwMc6xSMdbQ9cS0F1GoWnjdMdMAe
    GkiNkBg2G+XZRwVEyJdxALpjNZPWKlEQ7X7iy1ivP0Fd1faEwSzbdbkaS64VNSDKiO44LD
    2jLWpICWFadTrBXFgUptpmny+b7BJ/RSI/9IZpPcPeLVgsLX4/rNcdmh5kOpOKe21RqLfP
    tzpao+t7fJZ/yJA7flMVD5a4tRzbl+qDRNzJD82zIlKc2XptXwjGHei+x02qNi2GDkvjFF
    gwFztAzy9Fo0sxXxUxlQ17MQM5r58ASx/2Y1E9jebseS7G7ZMEabBatJemC/RIwVLpluAj
    JlG+NqX05HHhaAZBtrhpuPpyyWer1wL0pbzUAlzYG+KHvyFAVcgwQEAefCxQ
X-ME-Proxy: <xmx:nuiYarZRLmBUf3K7qL2YrlYWpZm7e1FLU3omgehtoF7TLzvrH3i-9A>
    <xmx:nuiYanUMd0ynqTVRrvSHdza7VkEhC2KOc_4LDU4OGgfnYldMh0gYIQ>
    <xmx:nuiYapmJpuoQBBjwCGtuXMXKf2sl41k8EBGlKpUgE5RHJgnL-jB73w>
    <xmx:nuiYaqCa0jfB8eBjJcFAId10UydEWVc4z6FeiJ3WVrB-Z9aNCW1PRg>
    <xmx:nuiYaj8EmEYTGaQC2j8OeXPMcHvemi_csaRKG527oUgXZdvcBniMzlMv>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:15 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 4/6] VFS: add d_duplicate()
Date: Thu,  3 Sep 2026 13:01:34 +1000
Message-ID: <20260903032431.142777-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260903032431.142777-1-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
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

