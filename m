Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814E30C63B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771644; cv=none; b=Y08Oncfa0TLJSlcLmVqO5eVXPkYh0yNnk9yoVPp6Fh1nOCcKXPmFDRzzFWuzVrvOa0ONqSHvInx2zmXEGAPOOOhMcm5pCIWczSbLZWfpiLES641dhJrpo34PrOCbqemrh7sRpneDlrS3CDEd4QzffxqOgH4tpo27wfNeLH8cx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771644; c=relaxed/simple;
	bh=V4WCRiLGN0Fzq6ugoqq8Z/pknGXVtzEAPt3qTtCkbWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYhUuKSOzw6CyTehzxoprDc2kZ6wLrwI7WTXHc87BF4nQ6eZt6y2gWoBtvHujB0Ej99iT8m17sdLjwMbinjTH7HnCBwLazFoVkIKSdu8x+iCT4hk3LdWXr9AK7SGI+lBIU3xPWUTdv0oPIcmi4XNhs1yXcSGsmy/yKA82PbBbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EskCyh4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d33oVg+9; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EskCyh4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d33oVg+9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D21B7A012F;
	Wed, 22 Jul 2026 21:54:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jul 2026 21:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784771640;
	 x=1784858040; bh=4rRKGmDMbfB34DZRLYRdHrPKTvH1PEZH9j2lVd9FUBM=; b=
	EskCyh4pEvXVXcUESP8iam949Jdiyq4xxQ3L0c/nRdxzwFGSZpvLg7Dk2h+Er3Zy
	zmgz/sMXXWMxyxCxgH1FcolE3I8aGI+4t1XfLbo0sgCxHrTxgCO29x0tHd9AHQ/E
	dG8uv/AaTbR/WqbNkB36nYHCvU3EhdKYh0qRyhuIJZmeuCgRjQ97HWFXOQNN/a58
	MCIsjhPVd4z0RctDB3BFcQbhes10pTNnf34mp7QRmvM71dt7OdVsAMPPFfP+XSoX
	5Nu4H6eS0rS/SXAcTwzJvyu220de6t7E7sxnsVmw/lxgxJi9/+S2Cr2sqXwj3RhU
	TOtVN3KtCRo0TyIUgYzhEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784771640; x=1784858040; bh=4
	rRKGmDMbfB34DZRLYRdHrPKTvH1PEZH9j2lVd9FUBM=; b=d33oVg+9kuTgr1sN5
	FV3y0LUjcAjdz/0/0SsnFmtwyeCwyy0VqV84JAK3N5G3bxaACRYd50RMUwHv8xim
	nrBt7By8EhO9gRhXxj7V4kbCQbHek/E5KaiQ6+eV+0fKYHtcarrwHfY8sIwcV9p+
	2bYDL4uTv5rtKjKIwmb1AOloZAbRk1gddEdGnsV9KmFUl3y5Kemt725kS+s8q3v6
	i+4GiPxX0urZjDG8VXhqNjUvzoCiS00q1yw54gkkuMw7GJZ5/QshohoiiD9tYrTL
	gfhtNxmUQYx28loHpQfWZF2eisAPoiyYAEVhD74X0sYRhwS4wBxoq6DcoWQ6ZT2s
	mCycw==
X-ME-Sender: <xms:N3RhalO6JhjKKaIYJpSHlvDrGoiH0kkivg3-8TAcxTTJYl7FWYprxQ>
    <xme:N3RhajY1_iDYSp2gkIVEIlkHzctSfyG4xOlTYmPI_eADGYDWt61hQP3yOCsVutT9R
    x_2TETPMCn-sIWYe2UyfoRYT7JsBNjbYZ_F-sYg-mQovN2GXo0>
X-ME-Received: <xmr:N3Rhanw_vtnKHqz-2uq1Ii9nnOeQ3D4X3Qnp3X0GKHxnGq4cCAsTdJPuakU6B19AIHUapHv8DcXHrhXRKc9JLgza9xriewM>
X-ME-Proxy-Cause: dmFkZTGA+a7oFH+eKnjwbhHC/8v4r6fQL2b4aUZ+ZIYz4ZbCd2lTQejYwSUR06DWEzL5WL
    mc+PFbP+CvpAtlPr/kFV4jcB2l0r1/JNZGQtYZLaw6BBrlXqe0A1A4agnK4oqn4aAvafTN
    JwQ2EkfozeCy/xauhvbDqLKITCSDGZS8GqckoC/D/+VNosrNC3AUpjToiM4vMbncdpKcBV
    MkOeKq0fYayK0sMiAV14VpvYYRXZWHvcYtrbk4lBJqS9anY5zygmmiN4IuSNtCZL3Jfyvi
    c0NALS5YBVgvjS0ItZCuBk9AIOKmu0HK1C5Wy2CtwmatMHULuQizIO5dlfalvpsigF2zUm
    ueg/EV76wQS5JDeZgtJBMnUwOIHZe6gk6Dr/4LbXhuEPKEw1wxWodpjXAP6fD/Ki2oYE+L
    Sq5ov25whF+v0MDaTaKM12LG6XrK3f35w0290iRUUH9YkPzvQkjtQxhTFpJ/QlpdxQIPru
    Tnsu/z+0KS+MI+CwEIn4Whd+uZNSoaUzCiGEHJqzypJwkDOVVoZVdaZAkuGSePluL/k/w1
    f/Wk5Y2lfXpbDRjISm+/EUAiHmBn+hTl6Djdjs/SwkrXwmarElE5iM/OJ3IEXIXgNkU4GM
    BVbkSEQ9cWnK9N2hIBuq0XdsGK72+nCOWWGYLchnjmDX4k2dNofpre8nhtmA
X-ME-Proxy: <xmx:N3RhamJWh8zKHecpoOs0_5rx0Yo9p5eidm2DdY_Y19NlcmSUOjFbaw>
    <xmx:OHRhappmpu6GS_C93ApfxKM0kelLMXc5gN6Vdqy6Kf3ScdQzTIJnRQ>
    <xmx:OHRhatI1ocT95Y1-qhslydc2gYGuCa_Vr0uhh1rohi_6L_WhaIwiuw>
    <xmx:OHRhamRTrH3Og-kYMjVM-Iq3nvKATsue9CTgUNf8p9m7UqBHeeAp8A>
    <xmx:OHRhah_kHEiaSK8bFYo886aeKGHlTBAI8-XeuZMJiNcot-pS4O6syb_3>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:53:58 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/4] VFS: add d_duplicate()
Date: Thu, 23 Jul 2026 11:49:49 +1000
Message-ID: <20260723015330.3093207-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260723015330.3093207-1-neilb@ownmail.net>
References: <20260723015330.3093207-1-neilb@ownmail.net>
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
index 0f6f9c4681f6..0f48c8c8de44 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1995,6 +1995,57 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
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

