Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD22477989
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 13:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382351; cv=none; b=F8GIvYXB3Zb4ezL8M6AmThefwm6+mhFrnrPGsRkUDgeEyuhjgX3f9YFn2Un2bElbiV8z2/ZF14OdR2DE0thTJfr0eUI2fwABDjpFmcArB8RRM4yCgNQ/HGkjD6ELoPSMZBt68Fz+Zbaif3EGtW6Nu83VNekxEqeZzbNV6i3rsHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382351; c=relaxed/simple;
	bh=xKMwK6XyTR2S1NYi1ll51KBolxqfDxdt7e/1pyWESn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+6cUGZaF13nI4oXpxCz9A1xy0tJ0M8Ohk4EVJNkU1nxztLN3qd7fJhIRaUd/9RSfYuWd2wZ8oJiGOlfemM+i9pDhVCI9wnmQotiMEzyijbI/EczjJLqS/1iGRLPwKrnm+94YUf5m/zV79vd4WsY9iXNvVrvR4HO7Agsaj/Q4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw8QePfe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw8QePfe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9C1Tq0bWPjxQKHy18dUxRo+Gdg144k5WV4DnkH5buY=;
	b=Rw8QePfesTfhsWQuEXy7zoEb5MpJcUPzdszfpHIEafTfI4td4NwU6wK2hRNAtKOuvq4F/E
	8Aayb9IYwKjkVjic2RC8n3JvRRKXDO009RsOQ8SVzOWdqvje10cZmDyZw6BfLVBVt4ylwz
	1Q78mHCFaPpqBIaZ4UpM3VXhVLW4ds0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-53Ejn19wPNSPVfWSlsUvmQ-1; Tue,
 28 Apr 2026 09:19:03 -0400
X-MC-Unique: 53Ejn19wPNSPVfWSlsUvmQ-1
X-Mimecast-MFC-AGG-ID: 53Ejn19wPNSPVfWSlsUvmQ_1777382341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC63E18B7CE3;
	Tue, 28 Apr 2026 13:18:12 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E3771800348;
	Tue, 28 Apr 2026 13:18:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/24] netfs: Fix missing locking around retry adding new subreqs
Date: Tue, 28 Apr 2026 14:17:32 +0100
Message-ID: <20260428131756.922303-3-dhowells@redhat.com>
In-Reply-To: <20260428131756.922303-1-dhowells@redhat.com>
References: <20260428131756.922303-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix netfs_retry_read_subrequests() and netfs_retry_write_stream() to take
the appropriate lock when adding extra subrequests into
stream->subrequests.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Closes: https://sashiko.dev/#/patchset/20260425125426.3855807-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c  | 6 +++++-
 fs/netfs/write_retry.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index cca9ac43c077..5ec548b996d6 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -175,7 +175,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			list_for_each_entry_safe_from(subreq, tmp,
 						      &stream->subrequests, rreq_link) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_superfluous);
+				spin_lock(&rreq->lock);
 				list_del(&subreq->rreq_link);
+				spin_unlock(&rreq->lock);
 				netfs_put_subrequest(subreq, netfs_sreq_trace_put_done);
 				if (subreq == to)
 					break;
@@ -203,8 +205,10 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
 
+			spin_lock(&rreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
-			to = list_next_entry(to, rreq_link);
+			spin_unlock(&rreq->lock);
+			to = subreq;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			stream->sreq_max_len	= umin(len, rreq->rsize);
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 29489a23a220..32735abfa03f 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -130,7 +130,9 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			list_for_each_entry_safe_from(subreq, tmp,
 						      &stream->subrequests, rreq_link) {
 				trace_netfs_sreq(subreq, netfs_sreq_trace_discard);
+				spin_lock(&wreq->lock);
 				list_del(&subreq->rreq_link);
+				spin_unlock(&wreq->lock);
 				netfs_put_subrequest(subreq, netfs_sreq_trace_put_done);
 				if (subreq == to)
 					break;
@@ -153,8 +155,10 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 					     netfs_sreq_trace_new);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
+			spin_lock(&wreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
-			to = list_next_entry(to, rreq_link);
+			spin_unlock(&wreq->lock);
+			to = subreq;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			stream->sreq_max_len	= len;

