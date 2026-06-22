Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCE43A7590
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119425; cv=none; b=iafZ5oO7n+wu9GnAA0NqP3dm4ZXiDHf3ZaRFOxIo7dgTvxqJ3R5CTEK2Wsz34KH/0goB9SrvG/EVoYxrHuoxmCRgy169MfEp/q0pGOtJeQ4EumfFqeasuGWMnk5qOG03Yzt5k4kSkCaFSrvzskJ0S1nu7cnke/jjxF2QCZcrDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119425; c=relaxed/simple;
	bh=Zb3uzmxuliah1WLkHf3aISWbottq6Pz73CvyrjhnDJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaDjAer2iNxNmm54SbN5bb6XbvvSvjZHq9YIgr9bNknJAL4KA9y1kXwy4s58LWaJUSou3FqUx3rSsScp3EgHCbEfNMAADeRWoBqMqKeJvOuoEyPv+ixg61r61ChrK20Lhmb6sirYZZYiqZWYkJFDLYh3z+0Vi7RWtpLUM66g7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+pgq66P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+pgq66P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyyQwlxIuAX3COzyoSlpJ5w5gYTJ6EubEwvoUtFL6K4=;
	b=e+pgq66PEz/XCmFBh1cNuKva1UzONmJTJNuQ42WzZcGhxSjZspu5ivhN6YbVQer7ixsL3Q
	u9AkgX8WADRXiHjs4udgES+JpES21bRSFp+Zyod0eA2iUMJ/YpmiCThmo1by52wZnPuqJQ
	wWoR+qH1ExbkL1/AUVzl2GvIaY18UM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-m11h2FGHMUCLSsaDk5Pp9w-1; Mon,
 22 Jun 2026 05:10:19 -0400
X-MC-Unique: m11h2FGHMUCLSsaDk5Pp9w-1
X-Mimecast-MFC-AGG-ID: m11h2FGHMUCLSsaDk5Pp9w_1782119418
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 621801806C99;
	Mon, 22 Jun 2026 09:10:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8691800480;
	Mon, 22 Jun 2026 09:10:16 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 18/21] afs: Fix lack of locking around modifications of net->cells_dyn_ino
Date: Mon, 22 Jun 2026 10:08:52 +0100
Message-ID: <20260622090856.2746629-19-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix the lack of locking around modifications of net->cells_dyn_ino by
taking net->cells_lock exclusively.  This also requires to cell to be
removed from net->cells_dyn_ino in afs_destroy_cell_work() rather than in
afs_cell_destroy() as the latter runs in RCU cleanup context and sleeping
locks cannot be taken there.

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c    | 8 +++++++-
 fs/afs/dynroot.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index fbb8a43aa7cd..9d8937ae24e2 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,8 +205,10 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
+	down_write(&net->cells_lock);
 	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
 			       2, INT_MAX / 2, GFP_KERNEL);
+	up_write(&net->cells_lock);
 	if (ret < 0)
 		goto error;
 	atomic_inc(&net->cells_outstanding);
@@ -579,7 +581,6 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
-	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
 	kfree(cell);
 
@@ -594,6 +595,11 @@ static void afs_destroy_cell_work(struct work_struct *work)
 	afs_see_cell(cell, afs_cell_trace_destroy);
 	timer_delete_sync(&cell->management_timer);
 	cancel_work_sync(&cell->manager);
+
+	down_write(&cell->net->cells_lock);
+	idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
+	up_write(&cell->net->cells_lock);
+
 	call_rcu(&cell->rcu, afs_cell_destroy);
 }
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 1d5e33bc7502..6e3c8c691ba9 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -278,7 +278,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 }
 
 /*
- * Transcribe the cell database into readdir content under the RCU read lock.
+ * Transcribe the cell database into readdir content under net->cells_lock.
  * Each cell produces two entries, one prefixed with a dot and one not.
  */
 static int afs_dynroot_readdir_cells(struct afs_net *net, struct dir_context *ctx)

