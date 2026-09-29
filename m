Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084F3515D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649481; cv=none; b=Ngypywdxq7q7WeITxkVxJepN1DtPO1q2bQ98rhy9OmYK+uBFqsSDD719Np9yxicZZqIooijP/8NCYIO3yXbmHmrh8v1LQzyLsFo//00Qh373z2zDeTPoEvpvLQfSc2Xpf40bFFBOX3YqJAHQjaupUQoEyqTWyuWswH0GSdI9rZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649481; c=relaxed/simple;
	bh=fh2Cl2Iw4S0Hf7UuA3HblQDhm/sIRLH5DTHdr/Tknmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVYGNrYOfgCPBERLN2gbk5Xlv/It6I4H+ezd4y8/0TM7kPY20i/wMBA+z+5mV8MEC/xsd3+AfGvoW6GF71MJnKsBWYjqIYsUVromKuL0OeehDti+N1nC0wl+OecsWbLVEC2pUJI7RbaggHz45pfIfpmsgnAZxCtRgDA3bm7BN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=I15WLA0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KitbIlFY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="I15WLA0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KitbIlFY"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CAB67A0150;
	Mon, 28 Sep 2026 22:37:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 22:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790649479;
	 x=1790735879; bh=jkDLrWrCugP4zTTny4p9whBRstntRTRjSIvYWRNN5YI=; b=
	I15WLA0vJkkaaPte1M8tjUMWPUb82F5/VEArZ2AcrtUoInOxRaLQXkTxOUsRPAuo
	Wi7fzep+Bv+YruQG3Sz6v+rt84eT8IStxSbbIXdL/xMUl8rpHH7/q9MN+JxQws45
	tvEd1Vy6N7+NX9np05rDsajz696T5LdlzfEFRcXmHKv1iqsbg4V5Dsg4TB6SBy+s
	ORfdZG/+yGb6x90F//6eGJUvfp187FCY9SZVUjdPEppaiDsg0J2heGhkpzUNRwrT
	dGmiPtO1vQX+RrGVxmo5qvGvRr7NNUTkGKx4VwiO3rfjNqUGARKnXwO5t7AVjfkL
	dLfUTrohYgJ5eV5/jKdXNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649479; x=1790735879; bh=j
	kDLrWrCugP4zTTny4p9whBRstntRTRjSIvYWRNN5YI=; b=KitbIlFYd47BCn1XX
	1IRyRIRoAlou36YVqtmt/ErPTGWxYGLZMaG9CitYQ4LtxkCfyV8Toorrop0jU2Ej
	4hRayfqjRE+ptsCjxEvsAwXlIy9ctu6DnaKn/Tk5j/3UaMVqngjWuSujOt7loi5R
	3w5LGRxYHdhN0ViumjVQXRkDWjcia2ftFrwrMOM/qBzu+f6qstyR7y6eI82Z24mJ
	0+cZId6hmp05pcqNM0YFfjo3j76f/x2M7cX6Jx76OojzEzGA6iBxVfxlOD8LUKqX
	U/py/BvpBAloUAYg2XDCJkEdfCEUF62Kk73szEMyrRVzDqq7+WsRCPtPsQ0r1hUX
	qdN4w==
X-ME-Sender: <xms:hiS7ap3xKbixkdsalGC0Z7phWMh8ZirRVMjqz0RRYkLmGAcGNaTAKg>
    <xme:hiS7ajLvHyyFDObrTjQiaQ09JiHKr-IsuF1w4hiuWi2yMqydiQAbTEJnjgw8JSuEg
    eugoIlizUcrN_2iBM3hdWwNx9N1PTYy0K7JzvD1Sjg8Dbp3SdL3>
X-ME-Received: <xmr:hiS7akictbRzJTAfYBIhN3AdTCRj8FLp6ojAZv8YXEqwomJjyZ_b1aUBMXnRa8kwYREjBEjmQuwWvCY23NBYxvh0Y6_bWeU>
X-ME-Proxy-Cause: dmFkZTGWqbnmI8/n4qvCotPb7BBmoUH0aBQ5WcJI9+Mnj2pcS7qFuOb/LM6GkieOZda24Y
    vYFOBr5Ca4t3MzL+KOro5zy+3wBaOzkHacz0D7wxco336zEnEW4q7tqPFa1DAGKCtqeMa5
    3qffhkHCJ8FV4BlRY+/5S3TZV4anDcVMOsMbl3gL0Rs27sChroA1dk2PqpvBV6dlXkqtCe
    Q6BIPhoaYRm9hbeQ3xRqL27M9QWbzPH9djD5YfEn3qH3/46727VCx2pLcRBE7QooVwJ/76
    s/Rk7bxUUf/2ST2Plv7aX/x89o82U1CxpELwOnOufR+Yk0vVYzzZ7JEimKbJaGYrQqYQWd
    ibpPLnkBOLpSH6/IB008UyXCSCO2tQbHOdnDrSsBlIH40sucowe4z3lx+YzAPQDTaqeT4L
    VBnKy9PPI5EzmGxkTsOiZFAGdybE/B/zY+i4uvM/JqAb8frvUtAcHsciK/3gq7xmYZZhXx
    +StyXGlXkKBxmD2FoRgFJ1GhhGu2AYQzEZ48l417ApJTxiLAX54spVMvUJp5GYqN1omVmB
    9bcLFMfPgVQ829pX5cFSQSyHAOWYB354VJAQsEqsm0zwNhk+dTIHdfL0c8C4rwpUsl2uWG
    jhO3Rcj8YX5+etMUiOR8szDK35iH2+YjHplXVqUnUR+1w68reIBnkxH9aPoA
X-ME-Proxy: <xmx:hiS7ajCyHneksIX5CQHvLpuJY2uP6jy5FKgjh6iJ_JxtJv5DsF_kzA>
    <xmx:hiS7am5nKcT2YawyootOECHeCRyhOIBSXHUk4ORwmSoZDM-wMeXoOw>
    <xmx:hiS7aoHuZzgpyQpZaVuemHge3TsfIO9nZysX8e_LOGmNRaMlI7qtBA>
    <xmx:hiS7ahA176rLWupxcvtuixZ73vWDgWCFGA05qiSK5rGGDwURX1cMGg>
    <xmx:hyS7aivXoMZ4KUQmWfCNvbX5KIHHM0vk1Lcjh1qK-rI5vT1_xHLT_2X8>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:37:56 -0400 (EDT)
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
Subject: [PATCH v2 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
Date: Tue, 29 Sep 2026 12:29:28 +1000
Message-ID: <20260929023223.1429201-3-neilb@ownmail.net>
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

