Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50433146A66
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391679; cv=none; b=aNMmvrn/qBGn/o9aopJXll7W4ZZOgzbBHzSqawh6U4/dAT6jd7F20wLzWWZJwZJDJOBrQMskofy/drkZ3laRwI/D54AVNSkbkyIyx+7yzs1T/AK8t5IbGr6t797nRDjcMfNxBZzl+nWRHNok5lJ1rk7ehCQA2nlROmeakkZ2i1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391679; c=relaxed/simple;
	bh=fh2Cl2Iw4S0Hf7UuA3HblQDhm/sIRLH5DTHdr/Tknmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLm9pvd0/ZwyRLMXfHQ7jf6hzpCJ8EAaCoyeCCt1dAdPC6fV8vXShgNMAQm1uJZnJ0Tw3ppLGxwbmf2kKN/G/ds7kyJDuP185imAvtg4Dwjut6vdxgRBsQKNWBwP1f3vrHA+2ZoRdknsyI1ym60PMN2y0Q2hUxdMaDyZFfeSFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=O6DkDQc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MevH4qLG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="O6DkDQc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MevH4qLG"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 840CC1D000E5;
	Fri, 25 Sep 2026 23:01:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 25 Sep 2026 23:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790391677;
	 x=1790478077; bh=jkDLrWrCugP4zTTny4p9whBRstntRTRjSIvYWRNN5YI=; b=
	O6DkDQc9ohPm2NPXvCKZW9my54zW4zpxdFrwN2QaeYNQAIMRbAUVjKKfUVYZbSs+
	ulBe2sgrR6TBbpey0dfZwh0LParA8fHb7Oq44Qy7/pdtu6chpkQ3mzfFgnTbmUjM
	Zsj005gfuS3HznPn6bkeITiOloEgi8m8RSIwH5d6DzFug7VDH2k/UDuGffVU2W2e
	Gzq65r5qTJ/MB8E826QFIqkTbfdA8U2m/RR6hofSdm7O/MSlQeJ+Uoc6qjd08btU
	0JyMgIl4Pod3SeVmDTaJaW7NjK58EgEryO5CHihN6fdk4ypP8s2fjoeYD/GzGBww
	YB3c0ihhsJDGcZj1cdRE2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790391677; x=1790478077; bh=j
	kDLrWrCugP4zTTny4p9whBRstntRTRjSIvYWRNN5YI=; b=MevH4qLGbP5byalJF
	g4WXs7Bw+kFeVlKA/APdSXh1LTPlmRZaoBT+K3wm/6cbjuJHFl7EJSeqaXtP8fME
	9LtfJ8VJMs9JUCiPqUrNx2C/31T9IdqXRa8e6CLLRo9zPGmngDyEIy3Qa9tHAGRf
	YE8uYl74OpVpeF9ZsccY5wqlntIthvrBDa1vjLCnWwHq17n5nkRzY9BgUz1m+ncc
	U/lRPGh9686VdId2vFOmnRX4IPnbW+mDDJhJ450oMCPvAqn4Mjsx7qKDVd6B06UL
	yuoBuA3lyKmllGfgdXgfGhRBX+iL64EPmP9LFS5Qxdip71JqiztAG9gaivwwQZP4
	19TeA==
X-ME-Sender: <xms:fTW3akJeAQwqH6Vix5TXBdegZsO88PQ1tFRBONuT1Y2JxZNoZOx81w>
    <xme:fTW3amtO0Kowp68L3V2ygjNHsqFVXqVn2WjXT839OPq1Oz9dnkCfhcGwVrwIuWzdt
    kVWnBfQWlilBG7dhjm4kODAz1fbpGTxZvCP7CSdVuG9nOD7oMQ>
X-ME-Received: <xmr:fTW3aoVa53ySelDNnA6FPXYTbQ_4U9gkjeLL9XD-JsZNMiE3_2DYG9D8OFNmOufMziKUVQiIVhOyRbF9ghMTuwiX11g045w>
X-ME-Proxy-Cause: dmFkZTEZVU9841dNQ7cM9xl1KpoH+LPHRH7WbfBKZi5gdTDzBZxWcifldDSGIyfUqMc4AD
    W9CBAMQcFoZw5T2sxUWRO8/1WX2YMXQq8T3xR82T2mz3tS15UwrKA0MWOTy+vH3cR+nOWz
    qiuC+fXMxs5rTcJThndZvl+XhoMftHFgw0Xuli/EByT8h1By1tqeklqGfgRYN5ujvX+yWo
    HtzQzQRdj+EyAoqiWJDnCbOnjDDuFw3VD+cew5pnPigsdESeNeBeKoldUAUUe5pgH+vrh7
    Ub4+XaZL/ntpERLiwOZrnVD6YdSAQZ8rj2T5LIbGDl9RrcNUmRADNy1ZFzf7UnyeE6XCFY
    3mzQUxhNsSijgsG2yFEBZuWifYPhWrM7mS6sHgGNe8BDQllkDLhoMYYInQVW4Pi+6qOiSI
    6BNICbGik4F9jicfHv5xG1+RX1uXdBwaGjVCHwF7KEwlcBxYTvwJ/TmEIiDXhu65Oa/m6u
    c0oFBhSkqCz+nsl9AENXbyHa5QduIu8exKzLyHEgboKtCeVA1aV1Kds4goRgfNSL+wxDm1
    1436vG6jrdtzKkgQ4KyNFaqYZmtWSLUhgNYChghqJhAE1k7LRdY2tB1USQgX1/J6J+TnC9
    I7hf/9tKnVCjYy9JmOwlUIXJNI1+mJB7idwnCxvOcuGR6LXuJ+sv9pQOlqpA
X-ME-Proxy: <xmx:fTW3ahi-_d8zU5EXxYx0f4XoeRXV9QPkeD-W272L24O0uB-uuQJqIg>
    <xmx:fTW3agqwc-cQuatC8d28DKhwoQpkpQBhSGqXLK3KAQvfbqfyuifz_A>
    <xmx:fTW3anGmRIPZlEOPHLeisxyp6pQJ_B2RH_fUO5jmt2TaAokrqTlULg>
    <xmx:fTW3al5g98gEyfYanBCIPJAtIcqXB5iE6Ck7fz4PvsOXZYTg4FlMeg>
    <xmx:fTW3asIeWn-fRXfWZh6RzHVmRDl3MjX16893y0kTWi10B0j6U_whLikZ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:14 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
Date: Sat, 26 Sep 2026 12:57:21 +1000
Message-ID: <20260926030052.467448-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>
References: <20260926030052.467448-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

As afs supports the fhandle interfaces there is a theoretical possibility
that the inode created for mkdir could be found by open_by_handle_at()
and given a dentry before d_instantiate() is called.  This would result
in two dentries for the one directory inode, which is not permitted.

So this patch changes afs_mkdir() to use d_splice_alias() and to
return the alternate dentry from ->mkdir() if appropriate.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c      | 13 ++++++++-----
 fs/afs/internal.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8955ddb054fb..c790fa9432ab 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1253,7 +1253,7 @@ void afs_check_for_remote_deletion(struct afs_operation *op)
 /*
  * Create a new inode for create/mkdir/symlink
  */
-static void afs_vnode_new_inode(struct afs_operation *op)
+static struct dentry *afs_vnode_new_inode(struct afs_operation *op)
 {
 	struct afs_vnode_param *dvp = &op->file[0];
 	struct afs_vnode_param *vp = &op->file[1];
@@ -1270,7 +1270,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 		 * the new directory on the server.
 		 */
 		afs_op_accumulate_error(op, PTR_ERR(inode), 0);
-		return;
+		return NULL;
 	}
 
 	vnode = AFS_FS_I(inode);
@@ -1281,7 +1281,7 @@ static void afs_vnode_new_inode(struct afs_operation *op)
 		afs_init_new_symlink(vnode, op);
 	if (!afs_op_error(op))
 		afs_cache_permit(vnode, op->key, vnode->cb_break, &vp->scb);
-	d_instantiate(op->dentry, inode);
+	return d_splice_alias(inode, op->dentry);
 }
 
 static void afs_create_success(struct afs_operation *op)
@@ -1290,7 +1290,7 @@ static void afs_create_success(struct afs_operation *op)
 	op->ctime = op->file[0].scb.status.mtime_client;
 	afs_vnode_commit_status(op, &op->file[0]);
 	afs_update_dentry_version(op, &op->file[0], op->dentry);
-	afs_vnode_new_inode(op);
+	op->create.ret = afs_vnode_new_inode(op);
 }
 
 static void afs_create_edit_dir(struct afs_operation *op)
@@ -1361,7 +1361,10 @@ static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	op->ops		= &afs_mkdir_operation;
 	ret = afs_do_sync_operation(op);
 	afs_dir_unuse_cookie(dvnode, ret);
-	return ERR_PTR(ret);
+	if (ret)
+		return ERR_PTR(ret);
+	else
+		return op->create.ret;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 2026bf434c3e..5815ce1f1bfd 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -897,6 +897,7 @@ struct afs_operation {
 			int	reason;		/* enum afs_edit_dir_reason */
 			mode_t	mode;
 			struct afs_symlink *symlink;
+			struct dentry *ret;
 		} create;
 		struct {
 			struct dentry	*unblock;
-- 
2.50.0.107.gf914562f5916.dirty

