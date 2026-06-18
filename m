Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53B2F8EBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797962; cv=none; b=BxCUmsreRSFt+z9VjUqKa09WIMv3KKx4+IOrhNi8909tzcsJlpuS0STcSbkNoA7AfyA8+U5v/4+Yn22B2bLsDnvFyPpuFv+2N+qg2ro65i9ERBvRgAGvHdpwnp7POQgxLcPqrTp0H2LQG5I+6stfcbepjYISnhcMWeabmGSDuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797962; c=relaxed/simple;
	bh=/fsjfjNKtSfO4Vam4ufvsdasBcCg/2mdCnyqyUq+WvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4ti5FfXjOfsS33S5sIrbGqpQqQyPgtA3VRSHo/eS34QXWQYgUPGPP4eusb83pGgXGxRqs7fBbV1iWODkITFlCwKuj65TmQkVFij5Vyj4CmUleKjDRUQHG5AEtsOGbuoCQcXLSikrwotbr2/jVAxtzkZ7fJTyEpcBdlUhGe+vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O5ktK1pj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5ktK1pj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxsEpgmRoMeDmx5HmC7wIc5r2HzgDTOugg9rSTYQcLY=;
	b=O5ktK1pjY7gDEK8mbWVg6qD4MjaNnTqy30uIw39BBmZbacs3H0Dy0QR3DNet/ax4QjTPoL
	r5aZq2oCdfRzo50iD8jl3qXSXp0fLPDWXx3Z3ry+R1a8C4pnKVnvJNxBydbYGKExxi8eBA
	tr4G4FJP+HMsCtKs8mJ0kQTxDRlbsUA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-9Q1dHzMYNkyiP1vQ65SJHA-1; Thu,
 18 Jun 2026 11:52:35 -0400
X-MC-Unique: 9Q1dHzMYNkyiP1vQ65SJHA-1
X-Mimecast-MFC-AGG-ID: 9Q1dHzMYNkyiP1vQ65SJHA_1781797953
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 908981956049;
	Thu, 18 Jun 2026 15:52:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2077E1800675;
	Thu, 18 Jun 2026 15:52:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH v3 11/20] afs: Fix misplaced inc of net->cells_outstanding
Date: Thu, 18 Jun 2026 16:51:30 +0100
Message-ID: <20260618155141.2513212-12-dhowells@redhat.com>
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

Fix net->cells_outstanding being incremented before the check for failure
of idr_alloc_cyclic(), leaving the count incremented on error.

Fixes: 88c853c3f5c0 ("afs: Fix cell refcounting by splitting the usage counter")
Reported-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9738684dbdd2..e0fab1609f27 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,11 +205,11 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
-	atomic_inc(&net->cells_outstanding);
 	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
 			       2, INT_MAX / 2, GFP_KERNEL);
 	if (ret < 0)
 		goto error;
+	atomic_inc(&net->cells_outstanding);
 	cell->dynroot_ino = ret;
 	cell->debug_id = atomic_inc_return(&cell_debug_id);
 

