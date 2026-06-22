Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465603A3E7A
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119397; cv=none; b=pB9pBnNZZGBCkYsSRzbY7HQohwoHg54qK16k2dSHe5OrUTTH37zvChKciW+qCowWJ9qTDLU6/+Ad6dA6A1mJBdBr1t5R4K4Z5fXCvGYIYcyIlhw5dRLjm4a6hsd4NdfB9bX5gVSdBByCH9bp0JHLwWbkQrUYAeltpQu6D9MDikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119397; c=relaxed/simple;
	bh=/fsjfjNKtSfO4Vam4ufvsdasBcCg/2mdCnyqyUq+WvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpRAY6Hk62/0YYPkyu61W9MQKsd6Sa6amHu2mj/KWtSPL5MTJ+VzL+KW9ag04ukJrYijO7dnmayytmKdVOO3KVbmMhfIKMQueGhzNMOuP8Srht4QDM/i0hyGyW4nzZsyBnQSwyFa1aECXUJ03DhGQRr1YQkoivxITg8d9W3p5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNrTXfq+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNrTXfq+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxsEpgmRoMeDmx5HmC7wIc5r2HzgDTOugg9rSTYQcLY=;
	b=eNrTXfq+FbUjTswy81nSEvhTzVey5x9KWr2kLLmf93nrWTItdObCOzxuEtPOaxBDlzcc9v
	+RNn8F/Q/AaFgX4ozEBVXM4uvZc1JGc9TLLZ4Svq2BpBWqo38GYNzrpTqm6jHi5rOn/Dn0
	pL+Z+rP+uXV5M18M4AUvbkQaOg5V/eI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-8VuJoh2qOW6q0hKhG62iDQ-1; Mon,
 22 Jun 2026 05:09:53 -0400
X-MC-Unique: 8VuJoh2qOW6q0hKhG62iDQ-1
X-Mimecast-MFC-AGG-ID: 8VuJoh2qOW6q0hKhG62iDQ_1782119392
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 309D718001E6;
	Mon, 22 Jun 2026 09:09:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 691EF3001D84;
	Mon, 22 Jun 2026 09:09:49 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>
Subject: [PATCH v4 11/21] afs: Fix misplaced inc of net->cells_outstanding
Date: Mon, 22 Jun 2026 10:08:45 +0100
Message-ID: <20260622090856.2746629-12-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 

