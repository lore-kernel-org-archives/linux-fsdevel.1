Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543D3D7D89
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769014; cv=none; b=tQGoCtITlDIWaM28oeSGQQUb7rJNIosnSmQUJ6iMvnkIB7803d/279mHRroBivKZaR0CEPeROlZyT+xE0SrKNuZMtlEBWZChdIgw928CjH6hiXUy6o9bCzG386RNCeT2ISt9NdKckn3XmqGAGPtaV0upbsHcADW2FezJJLjIwL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769014; c=relaxed/simple;
	bh=BiJRRubsO0w/uRu3udeuC5BO3k3wRwU17n3uj3/68b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4oWZ14sc2QsJ8XPIfiCsGqoYsucGCpmpV8GSJPImk7VuOOYxYNbh/DMr4Qn4TAePSrhrb3mfeRGW918tfXPEr/Mwm39DqDS7l1KlMVODOmVrzj4woDaKV/MV7yPoAG7D1ZyjwABCNWXA3VSgtQ1RrBz3n3Nk+vphECKLz4MrcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zp5KI16F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp5KI16F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781769012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=es+sCX45OlvMDZAJIsG9z3SxvsySqs6wukNU0OPTdCs=;
	b=Zp5KI16FCwYW+Q/TXOIeKOzM6Yz7kiGqlEG4ROw/JbkDBG2yS0JTkyml/KPskFkktzvjDh
	/mR4S/Jhotm9sUDsiqwAdyXRk+YYDFO8LFWPO9fVJAPvPh1EeD7+ZrDxxm/Ci+hgdZSzdm
	FwUytRpyu2lKJM8cKRCd9Zkk6jzBhU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-d-ZM9FswPcC_lvnJd-jVSQ-1; Thu,
 18 Jun 2026 03:50:09 -0400
X-MC-Unique: d-ZM9FswPcC_lvnJd-jVSQ-1
X-Mimecast-MFC-AGG-ID: d-ZM9FswPcC_lvnJd-jVSQ_1781769008
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB50B1956096;
	Thu, 18 Jun 2026 07:50:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2BE8D1956086;
	Thu, 18 Jun 2026 07:50:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume lookup loop
Date: Thu, 18 Jun 2026 08:48:57 +0100
Message-ID: <20260618074903.2374756-15-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is an addendum to the patch to remove the erroneous seq |= 1 in volume
lookup loop.

Switch to using scoped_seqlock_read() as suggested by Oleg Nesterov[1].

Fixes: 32222f09782f ("afs: Apply server breaks to mmap'd files in the call processor")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Oleg Nesterov <oleg@redhat.com>
cc: Li RongQing <lirongqing@baidu.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/aifaeKvz3KemfzaS@redhat.com/ [1]
---
 fs/afs/callback.c | 9 +--------
 fs/afs/internal.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 833ac3178ddc..dd7a407ea368 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -113,16 +113,12 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 {
 	struct afs_volume *volume = NULL;
 	struct rb_node *p;
-	int seq = 1;
 
-	for (;;) {
+	scoped_seqlock_read(&cell->volume_lock, ss_lock) {
 		/* Unfortunately, rbtree walking doesn't give reliable results
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		seq++; /* 2 on the 1st/lockless path, otherwise odd */
-		read_seqbegin_or_lock(&cell->volume_lock, &seq);
-
 		p = rcu_dereference_raw(cell->volumes.rb_node);
 		while (p) {
 			volume = rb_entry(p, struct afs_volume, cell_node);
@@ -138,11 +134,8 @@ static struct afs_volume *afs_lookup_volume_rcu(struct afs_cell *cell,
 
 		if (volume && afs_try_get_volume(volume, afs_volume_trace_get_callback))
 			break;
-		if (!need_seqretry(&cell->volume_lock, seq))
-			break;
 	}
 
-	done_seqretry(&cell->volume_lock, seq);
 	return volume;
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0b72a8566299..785c646856d7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -750,8 +750,6 @@ static inline void afs_vnode_set_cache(struct afs_vnode *vnode,
 {
 #ifdef CONFIG_AFS_FSCACHE
 	vnode->netfs.cache = cookie;
-	if (cookie)
-		mapping_set_release_always(vnode->netfs.inode.i_mapping);
 #endif
 }
 

