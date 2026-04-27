Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7F6342517
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304825; cv=none; b=h9HENISbRoSAGXjNJQGkaYsE60McMP3kPaQzE8qUAzRjM+Q4kOY6Jy2xUOXw5ZSqvJcHaVwOAB/WH2lllBO/4cm/A3u/3YVSGcz1rocC9+NsIOPd/I0l+ahyi7EwyCEWpXyPAYwW9r0lrGGtdRt8/GuMtlWhKs27Agg1GC99WB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304825; c=relaxed/simple;
	bh=TzKE7QcFZf39E2UkvuI1rxQbsvby4wW7m4gGjN+BIzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+W394ySe6VokB2Aw59LcQMhoZrIOMKwpzZYgXzmfNJPTYkmO2jhC+pEOK1MRaz0AAFV0mTPOPf6c3yrWA+I6JHoth2Gk3BZAeVYBR5CBnXU1tsrK9j2rO05Yx0XLgT6AtNtyZ0fKpqd/WWiGDry17TiOO8Qa9p79lysBR0JBOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjTZu/s5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjTZu/s5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777304823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REMGICrXXI7qiSN2rIwTeEeIpWS2D3QtA/yikvDYdpo=;
	b=WjTZu/s5Zio77KNJjlLYqvSPHDu2DAX+Q/KmlXIFkg5ogfpLiwBkf3CbF4h5blDC/7eX9y
	eElWyuaYZcmYED77Q9D+xmGLqJhnawWrxaHZmecutQSDTyJ+u+/YQlmw0bn0GVeohE5T5x
	NyUHVh/Wlk/p/lGV38liNf5WZ9aQTOM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-dTFzzbiiPRWoZ3I7QBqWfw-1; Mon,
 27 Apr 2026 11:46:59 -0400
X-MC-Unique: dTFzzbiiPRWoZ3I7QBqWfw-1
X-Mimecast-MFC-AGG-ID: dTFzzbiiPRWoZ3I7QBqWfw_1777304818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A43819560A7;
	Mon, 27 Apr 2026 15:46:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.126])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A457B1800348;
	Mon, 27 Apr 2026 15:46:55 +0000 (UTC)
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
Subject: [PATCH v4 03/22] netfs: Fix missing locking around retry adding new subreqs
Date: Mon, 27 Apr 2026 16:46:18 +0100
Message-ID: <20260427154639.180684-4-dhowells@redhat.com>
In-Reply-To: <20260427154639.180684-1-dhowells@redhat.com>
References: <20260427154639.180684-1-dhowells@redhat.com>
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
 fs/netfs/read_retry.c  | 2 ++
 fs/netfs/write_retry.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index cca9ac43c077..b34561e257f0 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -203,7 +203,9 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 					     refcount_read(&subreq->ref),
 					     netfs_sreq_trace_new);
 
+			spin_lock(&rreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
+			spin_unlock(&rreq->lock);
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 29489a23a220..db0f23708b2d 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -153,7 +153,9 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 					     netfs_sreq_trace_new);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_split);
 
+			spin_lock(&wreq->lock);
 			list_add(&subreq->rreq_link, &to->rreq_link);
+			spin_unlock(&wreq->lock);
 			to = list_next_entry(to, rreq_link);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 

