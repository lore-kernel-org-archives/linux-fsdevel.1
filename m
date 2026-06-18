Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D255314D16
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797987; cv=none; b=QI0a6sPSwnr7HUFTdkdS2GR1CISwskq3PJu+aKAUBb7qeFSx6nUCKMEJ5t6z5RpeglOdf32YbkA64iLMVhqvALXE+QIBrIhLGFbCB5jiITSfuuB94NA/SkhTWnsXn0krK555oc6dTsyQf5YRE6CjvBUx9GVFGSodyf4zVk9rWnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797987; c=relaxed/simple;
	bh=skUiQ81DxeD6DK5F2Mwl7Txp/oiZYxpH3FYkDlALJo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bua7YntXDzSRxqi/3HkyyFzPshIcr1KKrRvkvIUm/K9L/1bqt/27qLhm5XeKxQdyaajo3DdX63bqwzIDMox5J/d4OgUd2/96X0OHC2L4yIXZWJSCUO9xCpSfYL2Ulls3C/Z3n8DCIDsuH5IAhalKyXDYBTcuKSfh/TmGr1ZQHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewi19sHJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewi19sHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Crj0Lde1I4vMeO4iU3NpceCwY2Wgw0cD44knyqdhq4g=;
	b=ewi19sHJt1OWfyw3v+0qmB0pT3lMTu0+ECDNw9mmtOvVb4InPYxS2oS7oKdNT8yBpoVXma
	m8JNawWv/nLAEKezhTkY77ak4momVg/xHQulKMAfT/NPnS6fPYyZIv3olj8Cn65xlwYkPM
	jNxD2pqbz/yPpgbOLiNCb1GCUU84VRI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-NYBqWfVkOL2BL1T4BBpcZg-1; Thu,
 18 Jun 2026 11:53:00 -0400
X-MC-Unique: NYBqWfVkOL2BL1T4BBpcZg-1
X-Mimecast-MFC-AGG-ID: NYBqWfVkOL2BL1T4BBpcZg_1781797979
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C4E018004BB;
	Thu, 18 Jun 2026 15:52:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 760441800675;
	Thu, 18 Jun 2026 15:52:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/20] afs: Fix lack of locking around modifications of net->cells_dyn_ino
Date: Thu, 18 Jun 2026 16:51:37 +0100
Message-ID: <20260618155141.2513212-19-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the lack of locking around modifications of net->cells_dyn_ino.

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c     | 8 +++++++-
 fs/afs/internal.h | 1 +
 fs/afs/main.c     | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index fbb8a43aa7cd..e95e96f8200c 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,8 +205,12 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
+	idr_preload(GFP_KERNEL);
+	spin_lock(&net->cells_dyn_ino_lock);
 	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
-			       2, INT_MAX / 2, GFP_KERNEL);
+			       2, INT_MAX / 2, GFP_ATOMIC);
+	spin_unlock(&net->cells_dyn_ino_lock);
+	idr_preload_end();
 	if (ret < 0)
 		goto error;
 	atomic_inc(&net->cells_outstanding);
@@ -579,7 +583,9 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
+	spin_lock(&net->cells_dyn_ino_lock);
 	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
+	spin_unlock(&net->cells_dyn_ino_lock);
 	kfree(cell->name - 1);
 	kfree(cell);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 785c646856d7..c42752608383 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -293,6 +293,7 @@ struct afs_net {
 	struct idr		cells_dyn_ino;	/* cell->dynroot_ino mapping */
 	struct afs_cell __rcu	*ws_cell;
 	atomic_t		cells_outstanding;
+	spinlock_t		cells_dyn_ino_lock;
 	struct rw_semaphore	cells_lock;
 	struct mutex		cells_alias_lock;
 
diff --git a/fs/afs/main.c b/fs/afs/main.c
index 7a883c59976f..0a4a606575d7 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -78,6 +78,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 
 	net->cells = RB_ROOT;
 	idr_init(&net->cells_dyn_ino);
+	spin_lock_init(&net->cells_dyn_ino_lock);
 	init_rwsem(&net->cells_lock);
 	mutex_init(&net->cells_alias_lock);
 	mutex_init(&net->proc_cells_lock);

