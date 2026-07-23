Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3191D8E01
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806589; cv=none; b=tnIWjPk/D8WA1lE9cfeW2WkamAO3Unt8kxxzpvaPLG2MlgwjuIc59s8Yru9Bt3HzTF/l9SiJdUetPL/5RaVmj2LO6zCHiO0QRZHyTTbRgrqprjNKhIZQz5gJdfJ5yxa/kqd3R0fMwVp2+UBmbS7fPVpVqVTkQnjmiCsXot5yvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806589; c=relaxed/simple;
	bh=U1Sd+99WSB4HGWImCbvexprg90aTCPbIM9pB97HFuCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6ZQvlLEenXnz8sSUUv6ls4f1Ma2klEbBlC60JT6ibDxez/mZHoTOr0O7oxOOjn7j19q0AEqMTziELiR9m/DOIzN7XfyRrDtKCfqSTWLTstk/sToT1Hrh21ne+YECRU9b565UKr5Zc/aIR8S14ZS9NiXXj7Jg04DeweX1dlyUZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dwrs6sr5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwrs6sr5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5srYkeaqX/pMjLVXF6f/5B+lcd4/KDUAJaO0HyDaQnI=;
	b=Dwrs6sr5E+unhc1Na928JI8Ul3hS4ZY3SX8jiGOOBK1LjE3ylrV1uDchg4bqVuniYYVzZg
	U5onAYXMsOiIRtadM9FSVkLaEJiMFKdW1204sXnybxMnKUESv07G2YasKhYHPP3p8X5yRj
	9+fuSXzEceL+8oE7VcGT1x4w/pH0go8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-5wcKlkGXM4erwax3N54O0g-1; Thu,
 23 Jul 2026 07:35:15 -0400
X-MC-Unique: 5wcKlkGXM4erwax3N54O0g-1
X-Mimecast-MFC-AGG-ID: 5wcKlkGXM4erwax3N54O0g_1784806513
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35E8B1805F3A;
	Thu, 23 Jul 2026 11:35:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71214D76;
	Thu, 23 Jul 2026 11:35:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 3/3] afs: Fix UAF when sending a message
Date: Thu, 23 Jul 2026 12:34:48 +0100
Message-ID: <20260723113452.566619-4-dhowells@redhat.com>
In-Reply-To: <20260723113452.566619-1-dhowells@redhat.com>
References: <20260723113452.566619-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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

