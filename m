Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1162F3A7839
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119428; cv=none; b=qA1I/T37lxzKf+BEsQejOcCo8PWCc/T/O7VCo2/36sQyGLx0uch0Hro2qspsfkwzvwShL9ed9tlRNGqZAEoWTvLP0PRoR6qV7tnaDGZkmxJup+eK5CXB3hFRFPVe5tSM9Mdznu/dJYXLIbJwmMbynSx5t1ZQICLp2lgaTVQefKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119428; c=relaxed/simple;
	bh=svxPEDSaFUJW1uCJX3VJjP5uyQ25iA0A76oqVEXg0hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MfuA4q/maApmj/O/Jys9lpOsPKf8meVREiMDBMeOZyf/9dEret6hJnD95wBsgaMhnmRtNG73hGX8LJ0893OMrcdA7z64HJ60tr84aJ/Ukub3Ncu7x2NuBSPT45PZW0NuE7ccO7x9DMtxkKDxf5XHjuUz9iHHTwVJFObVcDx1qlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4wuqN/d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4wuqN/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qc3AUaJBiNCkiBRvrTGrdtukzI4PlxpQ5/Yzj4K7t9M=;
	b=O4wuqN/dCw9atOJVPd7XGAj0cI3KwqFFM7ZqtLfaKfsdy6daBw6/gXjKAz3P6YtEvocv1m
	2T8jg+/syT6wIRyrs3pIXeb5ux68unBTHpy/rZ2kXvCt6RomskLXfZ4gQq7QHGSGROAOL0
	D8SB1nErdhwO2h7i0g3zkEctxBe4+Nk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-xO3PVpK8NES8cNOpfXoSwg-1; Mon,
 22 Jun 2026 05:10:23 -0400
X-MC-Unique: xO3PVpK8NES8cNOpfXoSwg-1
X-Mimecast-MFC-AGG-ID: xO3PVpK8NES8cNOpfXoSwg_1782119422
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E37711805C30;
	Mon, 22 Jun 2026 09:10:21 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0983D1953946;
	Mon, 22 Jun 2026 09:10:19 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/21] afs: Fix premature cell exposure through /afs
Date: Mon, 22 Jun 2026 10:08:53 +0100
Message-ID: <20260622090856.2746629-20-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

AFS cell records are prematurely exposured through the /afs dynamic root by
virtue of adding them immediately to the net->cells_dyn_ino IDR when the
cell is allocated rather than when it is added to the lookup tree.  This
allows a candidate record to be accessed, even if it's actually a duplicate
or not published yet.

Fix this by not adding the cell to cells_dyn_ino until it's confirmed
non-duplicate and is being published.  A flag is then used to record
whether it is added to the IDR to make removal from the IDR conditional.

Closes: https://sashiko.dev/#/patchset/20260618155141.2513212-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c     | 27 +++++++++++++++++----------
 fs/afs/internal.h |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9d8937ae24e2..47a2645768d7 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,14 +205,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
-	down_write(&net->cells_lock);
-	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
-			       2, INT_MAX / 2, GFP_KERNEL);
-	up_write(&net->cells_lock);
-	if (ret < 0)
-		goto error;
 	atomic_inc(&net->cells_outstanding);
-	cell->dynroot_ino = ret;
 	cell->debug_id = atomic_inc_return(&cell_debug_id);
 
 	trace_afs_cell(cell->debug_id, 1, 0, afs_cell_trace_alloc);
@@ -306,6 +299,13 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 			goto cell_already_exists;
 	}
 
+	ret = idr_alloc_cyclic(&net->cells_dyn_ino, candidate,
+			       2, INT_MAX / 2, GFP_KERNEL);
+	if (ret < 0)
+		goto cant_alloc_ino;
+	candidate->dynroot_ino = ret;
+	set_bit(AFS_CELL_FL_HAVE_INO, &candidate->flags);
+
 	cell = candidate;
 	candidate = NULL;
 	afs_use_cell(cell, trace);
@@ -380,6 +380,11 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	_leave(" = %p [cell]", cell);
 	return cell;
 
+cant_alloc_ino:
+	up_write(&net->cells_lock);
+	afs_put_cell(candidate, afs_cell_trace_put_candidate);
+	goto error_noput;
+
 cell_already_exists:
 	_debug("cell exists");
 	cell = cursor;
@@ -596,9 +601,11 @@ static void afs_destroy_cell_work(struct work_struct *work)
 	timer_delete_sync(&cell->management_timer);
 	cancel_work_sync(&cell->manager);
 
-	down_write(&cell->net->cells_lock);
-	idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
-	up_write(&cell->net->cells_lock);
+	if (test_bit(AFS_CELL_FL_HAVE_INO, &cell->flags)) {
+		down_write(&cell->net->cells_lock);
+		idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
+		up_write(&cell->net->cells_lock);
+	}
 
 	call_rcu(&cell->rcu, afs_cell_destroy);
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 785c646856d7..601f01e5c15f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -388,6 +388,7 @@ struct afs_cell {
 #define AFS_CELL_FL_NO_GC	0		/* The cell was added manually, don't auto-gc */
 #define AFS_CELL_FL_DO_LOOKUP	1		/* DNS lookup requested */
 #define AFS_CELL_FL_CHECK_ALIAS	2		/* Need to check for aliases */
+#define AFS_CELL_FL_HAVE_INO	3		/* Have dynroot_ino */
 	enum afs_cell_state	state;
 	short			error;
 	enum dns_record_source	dns_source:8;	/* Latest source of data from lookup */

