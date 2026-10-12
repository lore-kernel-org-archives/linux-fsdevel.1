Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9785648F857;
	Mon, 12 Oct 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819571; cv=none; b=BDu7T0JOoMN01RWs3me1lNbfbzP681tagxHtTB6xVjJwkdx373LGFhbRs4oJUQicv1ncVd1iXvgFPWUJtQQ2PrhXw61hyYS8wkhlojsli1Cjulsis5NJnYMcohlJrRHXptPKjzkXb/XBOS7kpMVnux5RuRjch4egOjMCgxEtv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819571; c=relaxed/simple;
	bh=cgtkxMKY+2hOvlbMSZXp9Hll/ZIiWllXL77xtA32WFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAWjVs2JWY++VOjVhvXHetbUuKjJFwfYYYzwChMucy99GM9lIcQW/d3AoLKpOpsaSrh7Mu3jFW8L5lW7o0DBDmfy0DJHaXevsWnvIqB3fHS5YsC5o+Tlvj1yuTatQV+XzPRlXr9v0qTRx9iOkqkZpb2yN9hRX1w+TnrHcxGcYjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP4X6iRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP4X6iRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624091F0089E;
	Mon, 12 Oct 2026 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819570;
	bh=hUVsz616Zc/SR1FQzm/Ysgn0/MKqGByQTbBtNzdas3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aP4X6iRljQIPVvzRdpw7+usKBsLwHaEV+t01LlhwUx2HG/UyhrgDaPwwSfqwQIm5f
	 cUcz9nDdMU3cFzqpSoJlhg/Re2J+VQF25bypB27wGEqRvsMEoV9R2tQUcRoCoXoyyU
	 2nDtQdlook/GToNa2BZKkvm26RstahqlwS5VE6sx3jPk9i+EuPKea2GcfEfIyAFxAQ
	 HGtFLDZalkVrnkV0U9YwdibHTLi7thhZbt+wWYBiqsB95INq/mIBZVmiVPElCDDzAo
	 03V7/ZBt6WBnZ/JN9E8dtKOKpEIjiG8C3xkO17iLbBeTQ9CCCNLCMWFE6N7MCHQZzR
	 jSVUY6z/MZz1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:14 +0200
Subject: [PATCH 1/9] ovl: free the ovl_fs after a grace period
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-1-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cgtkxMKY+2hOvlbMSZXp9Hll/ZIiWllXL77xtA32WFk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a+toTv9dOaHki7N5a3XfsrwnXfbdb9q+Y8zVVNb3
 8jsXlxq2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnyoMv5hfxOpYM9uuX6vP
 uODZzsA8tmeps4NrVfL2bgi7pfPhVAvDf79a0xmTIt1tZtZdD78ds1LthdTBwONKXXcmHSuLfr6
 LiQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

During rcu lookup ovl_permission() accesses the underyling inode through
ovl_i_path_real(). It accesses lowerpath->layer->mnt out of
ofs->layers. It also accesses ofs->creator_cred to switch creds.
ovl_free_fs() ends up freeing ofs->layers, dropping the creds and
freeing ofs itself after kern_unmount_array().

Commit a535116d8033 ("ovl: make use of ->layers safe in rcu pathwalk")
made that safe by piggy-backing onto the grace period in
kern_unmount_array(). That ties overlayfs to an implementation detail
of kern_unmount_array() and we want to make that grace period optional
in follow-up patches.

So free ofs and everything rcu lookup needs from an rcu callback.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/overlayfs/ovl_entry.h |  2 ++
 fs/overlayfs/params.c    | 29 +++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 80cad4ea96a3..8ce962ed158e 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -92,6 +92,8 @@ struct ovl_fs {
 	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
 	errseq_t errseq;
 	bool casefold;
+	/* ->layers, ->fs and ->creator_cred are read by rcu pathwalks */
+	struct rcu_head rcu;
 };
 
 /* Number of lower layers, not including data-only layers */
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a..36fa3a3274a6 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -837,6 +837,26 @@ int ovl_init_fs_context(struct fs_context *fc)
 
 }
 
+/*
+ * ovl_permission() and ovl_dentry_revalidate_common() run in rcu pathwalk
+ * mode and read ->layers[].mnt, ->fs and ->creator_cred through the
+ * superblock, so those go only after a grace period. The mounts themselves
+ * are rcu-freed by kern_unmount_array().
+ */
+static void ovl_free_fs_rcu(struct rcu_head *head)
+{
+	struct ovl_fs *ofs = container_of(head, struct ovl_fs, rcu);
+
+	kfree(ofs->layers);
+	kfree(ofs->fs);
+	kfree(ofs->config.lowerdirs);
+	kfree(ofs->config.upperdir);
+	kfree(ofs->config.workdir);
+	if (ofs->creator_cred)
+		put_cred(ofs->creator_cred);
+	kfree(ofs);
+}
+
 void ovl_free_fs(struct ovl_fs *ofs)
 {
 	struct vfsmount **mounts;
@@ -860,17 +880,10 @@ void ovl_free_fs(struct ovl_fs *ofs)
 		mounts[i] = ofs->layers[i].mnt;
 	}
 	kern_unmount_array(mounts, ofs->numlayer);
-	kfree(ofs->layers);
 	for (i = 0; i < ofs->numfs; i++)
 		free_anon_bdev(ofs->fs[i].pseudo_dev);
-	kfree(ofs->fs);
 
-	kfree(ofs->config.lowerdirs);
-	kfree(ofs->config.upperdir);
-	kfree(ofs->config.workdir);
-	if (ofs->creator_cred)
-		put_cred(ofs->creator_cred);
-	kfree(ofs);
+	call_rcu(&ofs->rcu, ovl_free_fs_rcu);
 }
 
 int ovl_fs_params_verify(const struct ovl_fs_context *ctx,

-- 
2.53.0

