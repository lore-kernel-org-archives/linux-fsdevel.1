Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328E3281525
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948726; cv=none; b=KtXGbpJyNki9KK7sX3DKUaCXEmUpTzo1hfAyaGOcGTj5KRkim/SwWJQyx81U1buAzobI5LlSwKjMLz89H3zRZhvu34UUqIWJr5A6Vn1zfbvUDq5gG39Zw+p6kaewKqsWfYVMR8By2UQ7zBohQd3VNKh4ux4rH5DRT4yPNMvMpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948726; c=relaxed/simple;
	bh=7LNRjOw/WhHMyAdElCY8oNfheDrOOD0jgF57/t6MIOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAnYgH2nsSy25tN8/+i4xujwtlYm+fFW+0m2+lqii5LmKUYNa7/NSaDUMJv5NFs9anwJVDwIPCkV9nV/FlgjVzSDO/SSL4OHK8zaSdOGAUWTHyBG2thd2Co7I5vcJbrmSm9PpXFAjzz96M8UMObT0GYNEDAnaWgnBAEZBMQ/piE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IIlPMuaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EiDxLiGd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IIlPMuaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EiDxLiGd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 735461D00072;
	Wed,  1 Jul 2026 19:32:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 19:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782948724;
	 x=1783035124; bh=uX3XpwuCZ0Qo0Thr27FQpcnq3nprZgNvZm7KEC3H47A=; b=
	IIlPMuaSkFrEZpQNSlNjmMyElyTNim3eCsukwVvHY4T2HUc/reVVarm3/AI6Poeu
	ktaUrnXNdg/VpX9BoSh7AZBkgoPaTye6d8EoVLo9JP2EIlSb9kMEft6ekFi1gdrh
	3SfKuIQ++Hvo62g0pX/tZUpVgmfix+RRLuFPgMsZWuXiVe72A/IrUGW5G88gnMSF
	Q0jqW53NuIzoHcV20Ans6AjjRXh3w5CXk4Tp6SZrXeVTSuYJJurOwcVsn9rjugOi
	avHXbfGJ6Wd5epZ0JeXkz6p4egh9sF/C28/MMwIgXL5Cixmf0AE3po1fr2KpgBj+
	fAzeut0PAadfmYAn8czB1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782948724; x=1783035124; bh=u
	X3XpwuCZ0Qo0Thr27FQpcnq3nprZgNvZm7KEC3H47A=; b=EiDxLiGdvYGClJf5G
	GM9vnj06wxK3R9kvSwUorTw+Wn2ZCUjLCUacShr6SYwSsM4j3UiBC2Do4J+Sfv/2
	AMojQQBhouoF+eBbRte1KddDnBZad5xrunxsM/s2kb95NqF66cM7BXhv1VsS29hx
	aSFIxSP2gZxviKcSmvUAQCYC4wZzT91T3WZ+IZ65tPSH6o7s+qhl99tk+S5uxWde
	N5jFzH9GnAAL/6a+1rQ2qj9+uhn+CsIaUGorI/4g+oOsAxsDKXH7OrrvpEfcYEbs
	Pp1npIPsl7MuJzW7yzVQ1YYXAVW8ztGXmegaPe2WfyVyuGdmwBn2b3F8WHNnsFJd
	qq59A==
X-ME-Sender: <xms:dKNFasQoCy1N7RZRTdql7V5pA0HTi-swDaSKHK6Sq2WKOO2vDG5Emg>
    <xme:dKNFalPBpg8DzZ7lKpNTsjj0JUjpkcJvwpVFPURquCV0HRr49Bn-_dPYRRgn5nWWw
    4TbZo03ovlWs1hcrOrc-HC-coQ_eh6xJ-GySTzuAVZP4RnvCw>
X-ME-Received: <xmr:dKNFatX1HzapiM2X3o5TuGpahstemmXNZM3n2xStO4oCFCTERtJCNIWh_tadZillvM8gLXhMpjk0QoohF9wYW4hssFJ0vXY>
X-ME-Proxy-Cause: dmFkZTEjI1mlCApiRQ3VLq7e9ItHzLy/V7/zx8qkGCdOc/FUZlYAFVYWZl/JguCEvsEC7F
    xeOtFgwh/mld/yflBWQXshgR3EaavLl/FVRrIgdW4yDXR1i6Mtghko5MxWOcPeaB9oP+O3
    tGAXRTWMPA3kH+ZAQpQPLSLJvno5bSMtSw+y9nC/KmVvcVMwg3r3EPKwmMWDhC+dc0J3mB
    h1Tom7J/ijeJgmW2dLlmEFhXDF4kFXIKzQ57Za6jlItHX9Rd6hZOyGcuX3myx7c+V9/3Uh
    pmg7DgoC+2A2Tc2gtOP11c4L2HAwKdgVe/iZ/AVGEDFMpYsR41RRkjqhUsGo8LF9q5Zqg0
    5P21HU9phQuBq3w6q0KMo+2bOgmpndsNwJgH45Fs5qKHMNABjHUHoJC/NW3GhXlk7xgThW
    r2PHSVq5NyUvTo01SGDve8ETLnrCRL93Nm7oOuk48Yel3ph/xqlMUHSukYeBK45zxgdEQo
    XtcVH8aV+AESHYfqMhHAC8FY5wTQXy1Hguc4/jrmcSisue2fhXwxZWrEqiMHEFUpvjxMF6
    7c28Ew8D6SVyudLuZ94cQUVRhANeOytMWaKVQ5qsWLwyC8YBhRANh06jZc5C6aLthKIuQB
    VMsinsDAOKE7LPabEfNE4ycQYVmhfAFKneDwLknftzitsAo6Mmwveq5E0MiQ
X-ME-Proxy: <xmx:dKNFakfwATTxTNO1wuBhTQLyFQ8EYLCDaTzyk7EANYBMdkJWM5Hv-Q>
    <xmx:dKNFahurOZkg-2AcgN7WYH7npwJ4_68WdcUOSOJGDqOMji2CosubWg>
    <xmx:dKNFar9GzblNS8RRsgB8dS-DL6F3clQE2gJcwnhTr5yG0JZa65FuCw>
    <xmx:dKNFak12IJl4M_TGN5XBehfoVwnkbtUDqcD5FDhbfIRSN8yT_wegcw>
    <xmx:dKNFaoCGkyiUIxOeUAWvLM6gzWo6D_UcixKVU5ZzjC6o-iFt6BouXwE_>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 19:32:02 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] VFS: add d_duplicate()
Date: Thu,  2 Jul 2026 09:29:04 +1000
Message-ID: <20260701233128.3356519-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260701233128.3356519-1-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
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
index c6f45b6846a5..81ba24dd9527 100644
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

