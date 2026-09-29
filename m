Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341E38A70B
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649493; cv=none; b=pauR1BEF1AMWHtN45/0i4x97vLDEVeQHNQdq0RaZ6O3R9CXznSRPlrFHBmXvwNFlaWcIMrGJAosVXFAsngD8HiEZuVlMflUW8rRYRg/BCI2/RBvq+kxv0PtLvdEofjLEjKZHq3W3NBXDAet0OytIrsI/n3IIcp+pwhovjnPDI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649493; c=relaxed/simple;
	bh=WR9lz8YOkg7neTra0Dv7h3KM4YHvzfKaeIixikFKPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kw7wVhSh+AdtO6ATGN5CbJWLMM2kDUsD013WqTCRsm2CAq3iS9jAs99jkXoGbLUBh64ukh7mg8lgc4zNjv5DYvnXkPGG/M1JxCrVWq2tMrsDgpPW2j40T2nUvIwJjcV0sa2lR2XI/TKnOjQKdODbBZZ28iA7WZDXDKB012nXsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PNtAPvQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKLMNVq0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PNtAPvQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKLMNVq0"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EA7621D00126;
	Mon, 28 Sep 2026 22:38:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 22:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790649490;
	 x=1790735890; bh=9Mlyi2A6aSMHAhjwjs/Q/Wl9lPPTlz5/DF8O2g17GMk=; b=
	PNtAPvQGR4NkrodXRYfbhKfB4iwj4UknaXwRUViiuEMMjJfbmfeF+7U7IiinVavF
	XJTX5ypS3Bep9HAekef0nCjRzEn3yqfT+6xhgDBSdYlQwBSB40FyLAVIvEQ/5BS/
	bcLCIhNVGiKTMT6Q5sufAvueDURt10yPWMRWzvWgxBSz4uqyLC1MjxNsvY8nHMKB
	xEFlnkoUIfgUaRDqjT0dQL3jHQlvJjWYY/vMJkoP6q7UlAk7LJYdfuKO57/Lt/ci
	oFPWMiq0ZcOffrWeBndmgufPKdfatHhD/Rf2KjLuHsxTjpXo2uPVY4phLE6B1mw5
	ZB+bWdfK930+RcET61Qxew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649490; x=1790735890; bh=9
	Mlyi2A6aSMHAhjwjs/Q/Wl9lPPTlz5/DF8O2g17GMk=; b=EKLMNVq0sJ2ceitgV
	5eFLHRLSL+sO9+hvyM/Aha/aHSAfm+czX+zK7O+WWyxfvfw04di9dLPZjNirswkk
	MH+N6lIYZAilB0MrkRjbflwq2eYCEVXakmZVXWHmERvYOHaXCUAOcA1wIYP6CeUJ
	ahHQDwvK2hIj4sXtF5pEo72+brIlZSabmp3TlkkkpE0dcd0VIGlN5j7cPzkBc+ng
	/ExXAt3ilYZW4imPj+b0M4yaALI8FpCpFNAmiDYfsVdTb+324Mwnn1NOAbG0AeBj
	xU+CqcstTPpeFnD08GrdLl8aPadXzoXzLYLmf5HL/Q7mOP5y8Fb3hE4dAEIwGW9h
	AvVJA==
X-ME-Sender: <xms:kiS7aioMxJ_Q94IIqs6e1iIINAdzOs9rhzgafm7OTLaGJ0LLU4IrHw>
    <xme:kiS7ajvrk_xlMUKg_T2X8V8FLPM4jwRCDelGEKXYftFqn5YsTVw11SYfyQ09pCAZE
    yABitiSxWLwVIAom-tlkYi_1Jw7i0wr3rtyIFujsGnX-ZrbTz5m>
X-ME-Received: <xmr:kiS7ah0C1NBPVHCeQpQMFRkiRxjgpvIaqbHr29QLotcbD_6FfmWOouHahd6umPnaNofDyegO1Oo2wSGMoIcNppisPYN8Tn0>
X-ME-Proxy-Cause: dmFkZTED42B6O0ikvpHyX11SdplSdF/MKlznI4RgKdNjrNL5OSHo2WAcel1uvOrQb7HKwN
    iUSoZ/dHU0XnkIgMPrlBDoc/dz/Roc6hCH2CkDY47bupdQoZGM+EfriuQu2xxLpulembG2
    oXegZ95JiFhef3KVY5GC9jdm7moyUTMlo9n7SmD+KbxiCecjgwVmD5WDXZpVvAJ156brZo
    u3m1JCHRrQapBIcMO9nnIjAFne4J/9x2Vz94GABPj7LGIOsvIud9s++Mtys2kaWrW3C/9G
    MXBaRyk80dDsoK1z+b/SVQmT3q1VdWzavyNnMwZxqjbK/FK3Een8o42JjE1CLP6MCZAUl8
    dW2xAaF1goK+CKzEh7jFhEH2Gf+CiUahTKVP/ZEuGewbJMYkRW8FM2SnzlileMUU/U7Tga
    W92B9kgkbRZC1SFGg4vzjrAAmwRUl+fnlongoRCy/iYXUTb1XkFBhaAmdftcFslLTpKXI+
    aA2j6ZMWpW7WtlYKUBNMpyEArQ/HHaZu0y8r1otSSyp5XtM/c1gi/Oizw/MhY9OkulcOFa
    Pl+gBA9EiYYtYBbSKLNOKJMFCbO/u6T/lXD/tAwZZj6UN4ph98+nVh3x4O9sGjMHF/pIl9
    3Fo2P60w5d2SxF48+NddaqIa6tUKQzFEKPj8YJ56k8wIJ3tdEvenYHnuQebQ
X-ME-Proxy: <xmx:kiS7auFr6VVc8IfHQs9954HFTtXOP2q_K0iEWPCUoIZ-buw071hGpQ>
    <xmx:kiS7ast9e3CfQt0c7gKFjIObrfP5nhipzBGLM25q9hDTQGheogLsGA>
    <xmx:kiS7ahoCL5vTBw3gVDQSh8w5_KZAJg87O2yJnTKtmZMKry0jJWcSbg>
    <xmx:kiS7ajUDWlSyaR48YK_3wswdoXlQFraY-2PMGlwqwxPYxjN_ASR41g>
    <xmx:kiS7ahLEhW1UzMOkQwflWJ8X0hOtRlUItPQYGDMLJ_9mlEof_MVT2qSY>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:38:07 -0400 (EDT)
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
Subject: [PATCH v2 4/5] afs: lookup_atsys to drop and reclaim lock.
Date: Tue, 29 Sep 2026 12:29:30 +1000
Message-ID: <20260929023223.1429201-5-neilb@ownmail.net>
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

If afs is asked to lookup a name ending with @sys, it needs to look up
a different name for which it might need to allocate a dentry with
d_alloc_parallel().
This is done while the parent lock is held which will be a problem in
a future patch where the ordering of the parent lock and
d_alloc_parallel() locking is reversed.

There is no actual need to hold the lock during this nested lookup, so
with this patch we drop the lock and reclaim it, and use
lookup_noperm_unlocked().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1edaa7323428..b8773adc4e3e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -911,7 +911,8 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 /*
  * Look up an entry in a directory with @sys substitution.
  */
-static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
+static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
+				       unsigned int flags)
 {
 	struct afs_sysnames *subs;
 	struct afs_net *net = afs_i2net(dir);
@@ -936,6 +937,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	refcount_inc(&subs->usage);
 	read_unlock(&net->sysnames_lock);
 
+	/*
+	 * We need the directory to be unlocked so we can perform other lookups.
+	 * We don't really need the lock any more. The in-lookup status of
+	 * dentry gives us sufficient exclusion.
+	 */
+	if (flags & LOOKUP_SHARED)
+		inode_unlock_shared(dir);
+	else
+		inode_unlock(dir);
 	for (i = 0; i < subs->nr; i++) {
 		name = subs->subs[i];
 		len = dentry->d_name.len - 4 + strlen(name);
@@ -945,7 +955,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 		}
 
 		strcpy(p, name);
-		ret = lookup_noperm(&QSTR(buf), dentry->d_parent);
+		ret = lookup_noperm_unlocked(&QSTR(buf), dentry->d_parent);
 		if (IS_ERR(ret) || d_is_positive(ret))
 			goto out_s;
 		dput(ret);
@@ -956,6 +966,15 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 	 */
 	ret = NULL;
 out_s:
+	/*
+	 * Cannot take parent lock while we hold an in-lookup dentry so
+	 * must make sure that lookup is done.
+	 */
+	d_lookup_done(dentry);
+	if (flags & LOOKUP_SHARED)
+		inode_lock_shared(dir);
+	else
+		inode_lock_nested(dir, I_MUTEX_PARENT);
 	afs_put_sysnames(subs);
 	kfree(buf);
 out_p:
@@ -1001,7 +1020,7 @@ struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	    dentry->d_name.name[dentry->d_name.len - 3] == 's' &&
 	    dentry->d_name.name[dentry->d_name.len - 2] == 'y' &&
 	    dentry->d_name.name[dentry->d_name.len - 1] == 's')
-		return afs_lookup_atsys(dir, dentry);
+		return afs_lookup_atsys(dir, dentry, flags);
 
 	afs_stat_v(dvnode, n_lookup);
 	inode = afs_do_lookup(dir, dentry);
-- 
2.50.0.107.gf914562f5916.dirty

