Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BB28C874
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782957848; cv=none; b=sniWz2W+eucSEF9KnDMng+8xRONFaqWDulddWa8RNPwHRPPUwgIJjcHiSNCfA+nyNMdHt09qhbTgybpZYybqM+YPfqVDCYPue8Bqp/ndioPXBiwEGvhKeEvwgx2gQuOnpv99puHl7y8GdXLmjA52rPkfvAmbU7tnOAyenh76Ngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782957848; c=relaxed/simple;
	bh=hZ6IBu0TW0eIRybNAy1yNENH/syej04PuK+eBeksZCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW1hKRfCth4qQ2H4VKeLhbLHY4I+FtLSqsssTIaBr1SuLwFlV76RSGgaRud48gSlq49YEeH5ZgGOhvQLcRhZ5lUKyIqAJKDS5zgpW6EW8qE37PMYdHSTwFaGpRy6HT9CMnCg5my8SHhsTfFk36Z+GHZXuwTyQ1o4tgWETgKWwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FxFjLegk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uwn8pUyl; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="FxFjLegk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uwn8pUyl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8AC98EC00AB;
	Wed,  1 Jul 2026 22:04:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 22:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1782957846;
	 x=1783044246; bh=Ko3IpsxnNBdCXLNbNlYHykBauiyeH8iRf7GrViRMiSY=; b=
	FxFjLegkt+T2o3PYco9LcxOIEzeV4M3mhSVcXp7aObPbP6tr9OIC9j5rLe86+ijU
	QzSm+puh96hKiF6v/IlphbGRJQFIz9BrRLtzlQo5Zn++9oiyeMUugbbyXJuQGNI1
	wUOojlEoxWQcowVXC33U6mw1s2Jtcc+8MzAzlIDhPFhOC6ESvL6+EfxMy2AvY8Vg
	zQyfPjMsLXEKXqz4n/++VFPmJ0NgloNcZ+ANf6ogu9nGwD5A2N0/uz2jrE+gIA7Z
	WIfWRzQkwfWt/IPdqlXLGGS5sSjg5TNXDGBg9P7+xQGsxRbFd5qDpMv00F7xZ7Zk
	uh2wpP5aMZd8a/Ml/sBPag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782957846; x=1783044246; bh=K
	o3IpsxnNBdCXLNbNlYHykBauiyeH8iRf7GrViRMiSY=; b=Uwn8pUyl66ztdUxyO
	GfWgFxiTX1BUUMY55JsBhzOh517wwy/PgGbUfJI1NpVP9oxVf59nCnGYTj4zgDtD
	3uwX/vEaehojoz5dN5pi6+oca5YtTB1sDXQL0ZbcyKlmiEW+SaPIk0MB3fs00zzi
	kM01voGYi4mhJAP7tMIjnFJP3tkd5nhqVCu0Af8oiylhN7bMUdmA7daQeNC7n9v9
	1+qws3+F3zYqq9hPnSm606ejSOWh7ejE9IChx0qSMA9W6ux7/lqC7R/WFGXQUDUM
	MwAbXunvp0siyX+R0k+8p12KsTPE0ILT2cA60raIeoIjaFIL8WthkTS7qEf2NpfJ
	KLTjA==
X-ME-Sender: <xms:FsdFahoKcRngsvhRDIcvDgY0X0KGJARZVmDhcUTLP_pblgLPXMuyCA>
    <xme:FsdFahe3TBnDwHSy4LcvJKaCsW7ILa5s4zzbHSIr4no7vX0hsOJL6rlxVzgjfMr5B
    C9mHuHErF31hViy7lw7LaaOwSrh0A_7T8ZMsDu8vOS16qof4g>
X-ME-Received: <xmr:FsdFaorUnRrSr9Z_iMct-k40o3TI7o0tdBEWiis5GSw4GAZaD9FMoj8wp_X5z_Ef55ZoUkOvPVAvWeYeMi9g8rdwtfLi80A>
X-ME-Proxy-Cause: dmFkZTFBlC2s1yYlVvupIM97BEnZO/7OPbr+acxX4nRSYzIQeXoAQeDKsD4er4hbKJRbPH
    vFaZqGpBs4JhS/UEEk5fxY8Ihon6bczjILRRW7Cb4ZJYjHVE90TRCAK29TxNKAXYEjdFh4
    NXS+G7znjgWr5jEYCvzwPSPa/VALm+JOuDcfRFJiRU+fH+nT6zJVb++ZvCAYFx32pyp19B
    7N++n3JGVmGW4HgE2UUMBDNCIWZFa27ShL+xPFt4/oB9mq+gqnwzpAm4HSacQPYyMvjiy9
    vlXjSc/jXXYYwLmX1wjS3WMu/iurO943Hjm1+m7BT17nwi6fxAf7e5WryDbL7Kox2LEpP3
    bQ54KW8PHaAC7RTlc5M+ua9wrhwJWNR37tM7rHvMBAdGFowxKmyEduJQiM5v4qvJjo2tU+
    nG1ybnnCHk9uXIAMXiQzcF0ChscNmmCeycC6x4AE1gBGUA/6VuW5wsvz5r/Z2wtAqdjok1
    BQzkUKj5/kLr5maTBdGVrnbufYR8BJzxEZA/D8zpGs4aP8sMHhPxoV0Nsmj8KFmXcVUcbm
    O5Z7LzwKoFEVLqntrOgvNO9kpU6kYa9K/poFeEN3wb0L8zjOXkouZuSAQkKovAEbjfMhXm
    bQAADKA3XNxdWP+M98PLZiR5Q+sCzvw3P/OPCvsodfrdq1V0nd3Mcp47LrSw
X-ME-Proxy: <xmx:FsdFaqHI9QsrZFaWG8DHtwbgvAVUBo5-7GKP8yG5ieXoqAW-sxVUzw>
    <xmx:FsdFagsmPgTASXWYLrEOvIn9TYmp96n3lXcViiWCmklweTRE0LK-Qw>
    <xmx:FsdFakX79FsXJPgX_ZiDLCAPWcA5lj386wdnphY0S4uZCGpS5caEEw>
    <xmx:FsdFakGNvV3xWIjdm2kPtubkpmQX974fNOgcg7thJkIqVxXb83hzuA>
    <xmx:FsdFatRDckJ4ffM9xcgr7wdvGr_NRyc5G6mcf1epZe0NIy506P81y--v>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 22:04:04 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] afs: use d_time instead of d_fsdata
Date: Thu,  2 Jul 2026 11:58:29 +1000
Message-ID: <20260702020350.3403907-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702020350.3403907-1-neilb@ownmail.net>
References: <20260702020350.3403907-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

afs uses ->d_fsdata to store version information for the parent
directory.  ->d_time is arguably a better field to store this
information as the version is like a time stamp, and ->d_time is an
unsigned long, while ->d_fsdata is a void *.

This will leave ->d_fsdata free for a different use ...  which
admittedly is also not a void*, but is certainly not at all a time.

Interestingly the value stored in ->d_time or d_fsdata is u64 which does
not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
doesn't matter.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 18 +++++++++---------
 fs/afs/internal.h |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..7ff84b410097 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -795,7 +795,7 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 		afs_dir_iterate(dir, &cookie->ctx, NULL, &data_version);
 	}
 
-	dentry->d_fsdata = (void *)(unsigned long)data_version;
+	dentry->d_time = (unsigned long)data_version;
 
 	/* Check to see if we already have an inode for the primary fid. */
 	inode = ilookup5(dir->i_sb, cookie->fids[1].vnode,
@@ -882,9 +882,9 @@ static struct inode *afs_do_lookup(struct inode *dir, struct dentry *dentry)
 	}
 
 	if (op->file[0].scb.have_status)
-		dentry->d_fsdata = (void *)(unsigned long)op->file[0].scb.status.data_version;
+		dentry->d_time = (unsigned long)op->file[0].scb.status.data_version;
 	else
-		dentry->d_fsdata = (void *)(unsigned long)op->file[0].dv_before;
+		dentry->d_time = (unsigned long)op->file[0].dv_before;
 	ret = afs_put_operation(op);
 out:
 	kfree(cookie);
@@ -997,7 +997,7 @@ static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
 	_debug("splice %p", dentry->d_inode);
 	d = d_splice_alias(inode, dentry);
 	if (!IS_ERR_OR_NULL(d)) {
-		d->d_fsdata = dentry->d_fsdata;
+		d->d_time = dentry->d_time;
 		trace_afs_lookup(dvnode, &d->d_name, &fid);
 	} else {
 		trace_afs_lookup(dvnode, &dentry->d_name, &fid);
@@ -1027,7 +1027,7 @@ static int afs_d_revalidate_rcu(struct afs_vnode *dvnode, struct dentry *dentry)
 	 * version.
 	 */
 	dir_version = (long)READ_ONCE(dvnode->status.data_version);
-	de_version = (long)READ_ONCE(dentry->d_fsdata);
+	de_version = (long)READ_ONCE(dentry->d_time);
 	if (de_version != dir_version) {
 		dir_version = (long)READ_ONCE(dvnode->invalid_before);
 		if (de_version - dir_version < 0)
@@ -1087,7 +1087,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	 * version.
 	 */
 	dir_version = dir->status.data_version;
-	de_version = (long)dentry->d_fsdata;
+	de_version = (long)dentry->d_time;
 	if (de_version == (long)dir_version)
 		goto out_valid_noupdate;
 
@@ -1148,7 +1148,7 @@ static int afs_d_revalidate(struct inode *parent_dir, const struct qstr *name,
 	}
 
 out_valid:
-	dentry->d_fsdata = (void *)(unsigned long)dir_version;
+	dentry->d_time = (unsigned long)dir_version;
 out_valid_noupdate:
 	key_put(key);
 	_leave(" = 1 [valid]");
@@ -1935,7 +1935,7 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 		spin_unlock(&new_inode->i_lock);
 	}
 
-	/* Now we can update d_fsdata on the dentries to reflect their
+	/* Now we can update d_time on the dentries to reflect their
 	 * new parent's data_version.
 	 */
 	afs_update_dentry_version(op, new_dvp, op->dentry);
@@ -2171,7 +2171,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	/* This bit is potentially nasty as there's a potential race with
-	 * afs_d_revalidate{,_rcu}().  We have to change d_fsdata on the dentry
+	 * afs_d_revalidate{,_rcu}().  We have to change d_time_ on the dentry
 	 * to reflect it's new parent's new data_version after the op, but
 	 * d_revalidate may see old_dentry between the op having taken place
 	 * and the version being updated.
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b72a8566299..a22027935482 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1764,17 +1764,17 @@ static inline struct inode *AFS_VNODE_TO_I(struct afs_vnode *vnode)
 }
 
 /*
- * Note that a dentry got changed.  We need to set d_fsdata to the data version
+ * Note that a dentry got changed.  We need to set d_time to the data version
  * number derived from the result of the operation.  It doesn't matter if
- * d_fsdata goes backwards as we'll just revalidate.
+ * d_time goes backwards as we'll just revalidate.
  */
 static inline void afs_update_dentry_version(struct afs_operation *op,
 					     struct afs_vnode_param *dir_vp,
 					     struct dentry *dentry)
 {
 	if (!op->cumul_error.error)
-		dentry->d_fsdata =
-			(void *)(unsigned long)dir_vp->scb.status.data_version;
+		dentry->d_time =
+			(unsigned long)dir_vp->scb.status.data_version;
 }
 
 /*
-- 
2.50.0.107.gf914562f5916.dirty

