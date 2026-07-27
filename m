Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B04041379C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157734; cv=none; b=SgzRkQtaeytyrkyYbyFv2j6vOf03/P3yN3nRIgl8OjRn3xIckA08ZHH4fCW/JJGOyqv6FujrWMZGDqGYDWGwvNsLHhonhefbraVMhSgyEep6YffaIpmJa5Gjz2an1S95oqQUER+KogYp4ClKWBqQHXeXnXyVI9W3f0DE+1QcfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157734; c=relaxed/simple;
	bh=U1Sd+99WSB4HGWImCbvexprg90aTCPbIM9pB97HFuCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CArkXgu2mJs94rh2O/FZoCQllriNIEk+NKNu3Q6mLEzIi1sFWpW8IxMiy4TQKzuiMJGkcScU2OpNA9JhG5m5Ky0OuadHHDLVfqgKBmhh/W7tyvmD/S+WcyHpzksheZDryXrX81TSPlArX+bF6OuB4ecAwb2tfUz7eDnQe0aK/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/OhFMXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/OhFMXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785157732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5srYkeaqX/pMjLVXF6f/5B+lcd4/KDUAJaO0HyDaQnI=;
	b=T/OhFMXcIpy/toiTo4pkX9kODi52Z3/qiAvP9klQyJoXHQBJdPgSVxIpXnArsGrv7b51W4
	8ZT+93/6a/J0HYyh85TrkSzn4vOOr+MhJ5wlT7SQ9RPgS1GnLPN7ZSxNiau+lSZ9uwbuAv
	YF52UaUhF3jSKT+sLWx+Gkb1vOxKRv8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-d7MNix_gNV2x-pJdNjk1NA-1; Mon,
 27 Jul 2026 09:08:46 -0400
X-MC-Unique: d7MNix_gNV2x-pJdNjk1NA-1
X-Mimecast-MFC-AGG-ID: d7MNix_gNV2x-pJdNjk1NA_1785157725
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 038001955F1F;
	Mon, 27 Jul 2026 13:08:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C3F3180034F;
	Mon, 27 Jul 2026 13:08:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 3/8] afs: Fix UAF when sending a message
Date: Mon, 27 Jul 2026 14:08:19 +0100
Message-ID: <20260727130827.1100080-4-dhowells@redhat.com>
In-Reply-To: <20260727130827.1100080-1-dhowells@redhat.com>
References: <20260727130827.1100080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

In afs_make_call(), there's a race with async call reception and
destruction.  If a call is dispatched that doesn't have call->write_iter
set (used to specify the data content for FS.StoreData), then the first
rxrpc_kernel_send_data() will not set MSG_MORE in the msghdr.

Once rxrpc_send_data() queues the last request packet, the response could
come in at any time and cause the call to be completed and put.  However,
afs_make_call() will look at the call again to see it ->write_iter should
be handled - something it's only allowed to do if it has its own ref on the
call.  Whilst this is the case for synchronous calls, it isn't true for
async calls such as FS.FetchData.

There's also a potential UAF in afs_make_call() in the event that an
asynchronous call is being sent, but the call fails in some way (e.g. it
gets aborted from the server).  The problem there is that afs_make_call()
tries to abort a call if the rxrpc send fails, but the asynchronous
notification from rxrpc may have caused the afs_call to be torn down.

generic/650 plays games with randomly taking CPUs offline, and can
interject a significant delay such that the call is deallocated before
afs_make_call() gets to check call->write_iter - and a UAF ensues (caught
by KASAN).

   BUG: KASAN: slab-use-after-free in afs_make_call+0x1c90/0x2210 [kafs]
   Read of size 8 at addr ffff888035e050e8 by task fsstress/1409

Fix this by making afs_make_op_call() give the op->call its own ref rather
than transferring the caller's ref to it and then dropping the ref when
afs_make_call() returns.

This also means that the afs_make_call() func never loses its ref on the
call now.

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 601f01e5c15f..290873bac89b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1421,7 +1421,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 {
 	struct afs_addr_list *alist = op->estate->addresses;
 
-	op->call	= call;
+	op->call	= afs_get_call(call, afs_call_trace_get);
 	op->type	= call->type;
 	call->op	= op;
 	call->key	= op->key;
@@ -1429,6 +1429,7 @@ static inline void afs_make_op_call(struct afs_operation *op, struct afs_call *c
 	call->peer	= rxrpc_kernel_get_peer(alist->addrs[op->addr_index].peer);
 	call->service_id = op->server->service_id;
 	afs_make_call(call, gfp);
+	afs_put_call(call);
 }
 
 static inline void afs_extract_begin(struct afs_call *call, void *buf, size_t size)

