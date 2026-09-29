Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8739B94D
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649488; cv=none; b=QIcwTYTCbESFZkVVJOKT4le9VgM+MWrxE3Cr9dShvmZTfFR2tuBRwBiglR7J908Lz/7W4+C60ku456KKgpnF6wMbJ3JdVqZzTVjKLRJ8X6WtnlgEg/8VTJNv+bQ4px3/T+zjpsE9xwZYHoSBT8CoeUsIQuMJzEwq2gQG6YChtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649488; c=relaxed/simple;
	bh=LNXNCh0HpANA/77j0U3Z6T29aQXQEhpr5SDmxgWn3/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaZe7PIWe+V49Y1CK4JPITqqsIeGV3FItu4vWyf7u6ZNAKS8R0fqYXeE9MWyLvZDq/lNp7feo3G/COy/4MGDZFuv23gfAO3w9KcUOxqunnx90zGE5FZvrWciPMVxrj0zhzusa1PCigm4K5AJnmR5NmgAIBib9NmrmPPjmLbdSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=lhNU9Bza; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0ZQnqZJ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="lhNU9Bza";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0ZQnqZJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A1847A0159;
	Mon, 28 Sep 2026 22:38:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 22:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790649485;
	 x=1790735885; bh=xWncb5czij1yOLamTe5+TvFwSj2ad7j1nS+YqGFl7+s=; b=
	lhNU9Bza3ipDfVJqxgmueotpkbtN0C6JLUBXF3LiBAGgPM/RiNokRDDi4HuNDD+K
	TDlkkjkek8YOHEfJ1yh+kxZGaYfyHT812wQhPduKrG9zpPP968ecXMVdaBmpZjGz
	xBK7s9r+ovClvINMQuXy0btcPnalpwUfQYeQou9jqPjDQRr16YwDIVb3CAoNW8/9
	SlYl6cbQI55LiIO4Xb59JAyCUsq/PwzUTpOwA3xIA4p5wssgIKVWa9pnZdNdw8od
	KOaZQPdja/UWPlbGrgQIeLkp/j5Dp0hwbE7lGqgbOCXjXz4W0JrCM25KcV56u77V
	lTUrXly9NwM+aE5NPeZZ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649485; x=1790735885; bh=x
	Wncb5czij1yOLamTe5+TvFwSj2ad7j1nS+YqGFl7+s=; b=I0ZQnqZJ1j2ogE1MK
	q3ITxXLiy7Oii6LuGwZVcUHecajCVZvCIvXfnbDUQ6rn6ue6lLKvf9s3Fk8A3UFi
	Sd7WS56oRBR5lA1Uc3eo04DLznTIYxQigELpCIPWy1aTGofnylUB6ffACH9eZrgW
	KX3t4St73ybkx4aRX+xvuSis3QxNXK7xRDFjFXEMCEbE9ZovbuONimxy3mk6xx3c
	umThTiFc6OkFD86L36dK1CKnwHZZLq8/evoO97AFMZC8iLNbop+NdlRVfwQEl1HA
	60gr83yxiyKOLNk0G/w1rOwjQdik3dNadBBOoZnwcJQEC18Qm8YnbB5kmWD9Zc3W
	rxYhw==
X-ME-Sender: <xms:jCS7ahoFbfkXVoOeiQc_x2JpexAnQo0NNPxDZGp6PNEQ_4DLDxODkA>
    <xme:jCS7amuJbZYqx8wo8kptqPvi-8oMGKypeQC4cg-4MFBrTLMAb4Kto0KtzLCKNl1qO
    mWDs1VYiVi35UcyBuZr_3WsSw6Bciml57pNH2izMoMVYN84bSU>
X-ME-Received: <xmr:jCS7ao1820rBe9gpHYmMhkmmkYuVYYys3gFXHQTsSXKY7wcN7Nf10UyWc3ET5Xl3dg0dW5t85LdYkQndaQ98chDAvFN82yc>
X-ME-Proxy-Cause: dmFkZTGWqbnmI8/n4qvCotPb7BBmoUH0aBQ5WcJI9+Mnj2pcS7qFuOb/LM6GkieOZda24Y
    vYFOBr5Ca4t3MzL+KOro5zy+3wBaOzkHacz0D7wxco336zEnEW4q7tqPFa1DAGKCtqeMa5
    3qffhkHCJ8FV4BlRY+/5S3TZV4anDcVMOsMbl3gL0Rs27sChroA1dk2PqpvBV6dlXkqtCe
    Q6BIPhoaYRm9hbeQ3xRqL27M9QWbzPH9djD5YfEn3qH3/46727VCx2pLcRBE7QooVwJ/76
    s/Rk7bxUUf/2ST2Plv7aX/x89o82U1CxpELwOnOufR+Yk0vVYzzZ7JEimKbJaGYrQqYQcF
    j0B+UKrXFMx+862dKhQ2QeJ9sXbANY0KQIzbe5zt3h4/CpmFqklEK+289e2FV0czoctfie
    Hh/f/xl1lKnexBTEFwjyYIgkkmlB4dmFICMJPpSgs/SKYawve5FpfiI+Cw2fGpFP1Ij7hO
    gmeWhaTJ9dlZnrM8CqcTGB5exgTqC1DE3eabZYBRcCQGqGWY36H2ZaCEL05tkLVDH+YNsj
    n78YceindM3CwlJ4Z75JFbm09FN5hFjkWruMG6hT3QHI8eVMwzK6TzHiGBf+RRvNO2N+1J
    E+d0G0DlTPkIRJHMVEKCzkBzqz/vWDTqtUxQXiryHa+Rl3dGqeQliMR5d+ng
X-ME-Proxy: <xmx:jCS7apEtWQK2BGruDzcxzzsSoYxop_2MvjlH1bvqoRdJkTSC6NE3NA>
    <xmx:jCS7arsVVXKhGKpssl3Ug96qSDL6lPjoGqM_xZzm__zyd3H1r8z3zA>
    <xmx:jCS7akpTlhTIQ3Kcn7FCaO60L3wEkZCJDR3_Lq0Rt7IiNT3jqtTIoA>
    <xmx:jCS7aqW0iFD0R2T6TptFlVz2ulv6k4Ej7sN90BRPn8M8bEU2IZL66Q>
    <xmx:jSS7aiy7RDUji3eJvUpXrq6GiSxJzD90cqfZFMVHbECKGceaJTNZw7pc>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:38:01 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org
Subject: [PATCH v2 3/5] afs: use d_alloc_trylock in afs_sillyrename()
Date: Tue, 29 Sep 2026 12:29:29 +1000
Message-ID: <20260929023223.1429201-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929023223.1429201-1-neilb@ownmail.net>
References: <20260929023223.1429201-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with future
locking changes) use d_alloc_trylock() to find a dentry for an
unused name, and use an open-coded lookup_slow() to see if it is free on
the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c       |  6 ++----
 fs/afs/dir_silly.c | 54 +++++++++++++++++++++++++++++++---------------
 fs/afs/internal.h  |  2 ++
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c790fa9432ab..1edaa7323428 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -19,8 +19,6 @@
 #include "afs_fs.h"
 #include "xdr_fs.h"
 
-static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
-				 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct inode *dir, const struct qstr *name,
@@ -967,8 +965,8 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 /*
  * look up an entry in a directory
  */
-static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
-				 unsigned int flags)
+struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
+			  unsigned int flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct afs_fid fid = {};
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 982bb6ec15f0..12cd2b340392 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -112,7 +112,8 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 		    struct dentry *dentry, struct key *key)
 {
 	static unsigned int sillycounter;
-	struct dentry *sdentry = NULL;
+	struct dentry *sdentry = NULL, *old;
+	struct inode *dir = dentry->d_parent->d_inode;
 	unsigned char silly[16];
 	int ret = -EBUSY;
 
@@ -122,23 +123,42 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
 		return -EBUSY;
 
-	sdentry = NULL;
-	do {
-		dput(sdentry);
-		sillycounter++;
-
-		/* Create a silly name.  Note that the ".__afs" prefix is
-		 * understood by the salvager and must not be changed.
-		 */
-		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
-		sdentry = lookup_noperm(&QSTR(silly), dentry->d_parent);
+newname:
+	sillycounter++;
 
-		/* N.B. Better to return EBUSY here ... it could be dangerous
-		 * to delete the file while it's in use.
-		 */
-		if (IS_ERR(sdentry))
-			goto out;
-	} while (!d_is_negative(sdentry));
+	/*
+	 * Create a silly name.  Note that the ".__afs" prefix is
+	 * understood by the salvager and must not be changed.
+	 */
+	scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
+	sdentry = d_alloc_trylock(dentry->d_parent, &QSTR(silly));
+	if (sdentry == ERR_PTR(-EWOULDBLOCK))
+		/* try another name */
+		goto newname;
+	/* N.B. Better to return EBUSY here ... it could be dangerous
+	 * to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
+	if (!d_in_lookup(sdentry)) {
+		if (d_really_is_negative(sdentry)) {
+			/* try to get an in-lookup dentry */
+			d_drop(sdentry);
+			sillycounter--;
+		}
+		dput(sdentry);
+		goto newname;
+	}
+	/* This name isn't known locally - check on server */
+	old = afs_lookup(dir, sdentry, 0);
+	d_lookup_done(sdentry);
+	if (IS_ERR(old))
+		goto out;
+	if (old || d_is_positive(sdentry)) {
+		dput(old);
+		dput(sdentry);
+		goto newname;
+	}
 
 	ihold(&vnode->netfs.inode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5815ce1f1bfd..d3fd108041cf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1109,6 +1109,8 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock);
 extern void afs_d_release(struct dentry *);
 extern void afs_check_for_remote_deletion(struct afs_operation *);
+extern struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
+				 unsigned int flags);
 
 /*
  * dir_edit.c
-- 
2.50.0.107.gf914562f5916.dirty

