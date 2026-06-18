Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F52E736A
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797964; cv=none; b=W5XvZPpdXmI++qxwfI6W/AW3qa01NuHKwDgRZ1CJbBQ1PemQnNYswn9d6J/jcs6a7qVkCIO1EsuRt3078R7yXH7cU1HTRpvHV16F1LcSjIdgXaIqVerxL4p8/8fuWJHU4JyvpToB/tiOD02s6+bqn4JnUFnoliGVg+gc79/m9rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797964; c=relaxed/simple;
	bh=GMV1hdmoLC3L6lmOCH7vr6X6rbMxY/dM9l3QrU8iWh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozGtxL5+OFEwOOgr0HrbkLhZk6Xr/bbPAslK6Ytn3I/WspM8ttb7e/HDFRN4KGdrGDJc0cbhWgLTRIfHj4tcjqoPk4T63RnE1hGFTQMUjCSVTNab+kv4CssklUYstX/GhQtNPIsXdRdYTlZDXgEtQXhKaFx/CoLbNq54QbiF9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbRxnSn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbRxnSn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1d+piwZQ3ibpiXXf29Tyf3HGnNohEDRji+q7FdFyYRo=;
	b=hbRxnSn8DahIdcVNFiHw6l3hL6soNwxgeZAl22T2HQaomswHBW7aA71mMjHixdp3nln3Z/
	OZX7B/rLlD8ywlpS2IG7jNXGACDDsc9OLPj8mcZrzlsyGifyV7g5vF2Ijla5y4aGyOEwIT
	Td9iR9jHbjOC4e9jAr7Z3BfLIBzLZnc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-jiMowoX0PdK80LvWSou6Dg-1; Thu,
 18 Jun 2026 11:52:38 -0400
X-MC-Unique: jiMowoX0PdK80LvWSou6Dg-1
X-Mimecast-MFC-AGG-ID: jiMowoX0PdK80LvWSou6Dg_1781797957
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 528601801BE1;
	Thu, 18 Jun 2026 15:52:37 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33CBD3691E;
	Thu, 18 Jun 2026 15:52:34 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v3 12/20] afs: Fix reinitialisation of the inode, in particular ->lock_work
Date: Thu, 18 Jun 2026 16:51:31 +0100
Message-ID: <20260618155141.2513212-13-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

It seems that initalising afs_vnode::lock_work a single time in the slab's
init function isn't sufficient for work_structs.  This results in the
DEBUG_OBJECTS debugging stuff producing a warning occasionally when running
the generic/131 xfstest:

 ODEBUG: activate not available (active state 0) object: 0000000016d8760f object type: work_struct hint: afs_lock_work+0x0/0x220
 WARNING: lib/debugobjects.c:629 at debug_print_object+0x4b/0x90, CPU#3: locktest/7695
 ...
 CPU: 3 UID: 0 PID: 7695 Comm: locktest Tainted: G S                  7.1.0-build3+ #2771 PREEMPT
 ...
 RIP: 0010:debug_print_object+0x65/0x90
 ...
 Call Trace:
  <TASK>
  ? __pfx_afs_lock_work+0x10/0x10
  debug_object_activate+0x122/0x170
  insert_work+0x25/0x60
  __queue_work+0x2e0/0x340
  queue_delayed_work_on+0x48/0x70
  afs_fl_release_private+0x57/0x70
  locks_release_private+0x5c/0xa0
  locks_free_lock+0xe/0x20
  posix_lock_inode+0x55f/0x5b0
  locks_lock_inode_wait+0x81/0x140
  ? file_write_and_wait_range+0x50/0x70
  afs_lock+0xcd/0x110
  fcntl_setlk+0x10d/0x260
  do_fcntl+0x24e/0x5b0
  __do_sys_fcntl+0x6a/0x90
  do_syscall_64+0x11e/0x310
  entry_SYSCALL_64_after_hwframe+0x71/0x79

Fix this by reinitialising ->lock_work after allocating an inode.

Also, flush ->lock_work when the inode is being evicted to make sure it's
not still running.

Fixes: e8d6c554126b ("AFS: implement file locking")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Thomas Gleixner <tglx@kernel.org>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c | 1 +
 fs/afs/super.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 51c28f148845..14f39a9bea6c 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -680,6 +680,7 @@ void afs_evict_inode(struct inode *inode)
 		inode->i_mapping->a_ops->writepages(inode->i_mapping, &wbc);
 	}
 
+	flush_delayed_work(&vnode->lock_work);
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	netfs_free_folioq_buffer(vnode->directory);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dec091e569c4..82bb713825a0 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -660,7 +660,6 @@ static void afs_i_init_once(void *_vnode)
 	INIT_LIST_HEAD(&vnode->wb_keys);
 	INIT_LIST_HEAD(&vnode->pending_locks);
 	INIT_LIST_HEAD(&vnode->granted_locks);
-	INIT_DELAYED_WORK(&vnode->lock_work, afs_lock_work);
 	INIT_LIST_HEAD(&vnode->cb_mmap_link);
 	seqlock_init(&vnode->cb_lock);
 }
@@ -694,6 +693,7 @@ static struct inode *afs_alloc_inode(struct super_block *sb)
 
 	init_rwsem(&vnode->rmdir_lock);
 	INIT_WORK(&vnode->cb_work, afs_invalidate_mmap_work);
+	INIT_DELAYED_WORK(&vnode->lock_work, afs_lock_work);
 
 	_leave(" = %p", &vnode->netfs.inode);
 	return &vnode->netfs.inode;

