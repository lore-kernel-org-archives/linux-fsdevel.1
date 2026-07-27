Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17013F484B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146627; cv=none; b=T7l6bFvYADoONZNXFiMV+UWUamF6FpNuxXe2oS/zRmCmXG7ddZDra26FY6ZSdKoFPuxq8/3EU/0MQ8KX5qHmrWS7YjKS2Ka9Rvxyg8NFzsBQYjYQPbiLOxDv5CSwDdJrA/Xi2plkv9Qo9OTP3gdEHSeRcDls20tgU64ZSvNXpVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146627; c=relaxed/simple;
	bh=hMEjJOWmGhgMgGJ3UzU+fBFzg8E3MfbShZ6/xXqPfro=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=mFCwgMWcBLvOq7uAeJZPqoCg4A4m2nYzt7R3B1C1Jsx5DQbYjtHcSwuk8Fy741gm8Y65HqUsZY98Dz62XknpXhSb2BmJqk9HDthXGVNDSFYVeDQRSigSMLvI2mJhpoBALMZ3I9bXxm1GSG11LZga7Hv8k796teXy3cnEf12Fp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnmHljdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnmHljdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785146623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2KVF0x40jcMGPbMsxhpsAwga6/JTIN12HdYAMw5XI+g=;
	b=KnmHljdSUme7DMdsbM8O0UZlvspX1qBNUq/cy42eBMLpQyDTlxWKrQohCMlrqKJmu6rOKo
	sj9rPDzmTPe8KB+x992rUQibonHc8Vm/vesX+j0YfmHTOJ4TXALz9FO0gdcf2eplSWebNs
	wPVCu8X8ZekT9LoVBPh2+LA2r5hu1+M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ExsrUMMLOF-x-nHkKmOaDQ-1; Mon,
 27 Jul 2026 06:03:38 -0400
X-MC-Unique: ExsrUMMLOF-x-nHkKmOaDQ-1
X-Mimecast-MFC-AGG-ID: ExsrUMMLOF-x-nHkKmOaDQ_1785146617
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E6921800745;
	Mon, 27 Jul 2026 10:03:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B93B71955F74;
	Mon, 27 Jul 2026 10:03:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260724073044.3400217-1-yun.zhou@windriver.com>
References: <20260724073044.3400217-1-yun.zhou@windriver.com>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    hch@infradead.org
Subject: Re: [PATCH v2] netfs: fix writeback ENOMEM by using __GFP_NOFAIL for rolling buffer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <974341.1785146612.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 11:03:32 +0100
Message-ID: <974342.1785146612@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Yun Zhou <yun.zhou@windriver.com> wrote:

> rolling_buffer_init() uses plain GFP_NOFS for its folio_queue allocation=
.
> In the writeback path this can fail and trigger WARN_ON_ONCE(folio !=3D =
NULL)
> in netfs_writepages() when writeback_iter() returns additional dirty fol=
ios
> left unhandled.
> =

> Writeback must not fail with -ENOMEM. Fix this by adding a gfp_t paramet=
er
> to rolling_buffer_init() and passing GFP_NOFS | __GFP_NOFAIL from the
> writeback path, ensuring the allocation always succeeds. Read paths
> continue to use plain GFP_NOFS.

I don't think this is the correct solution.  I think you're right that a g=
fp_t
needs to be passed into rolling_buffer*(), but I think we need a mempool a=
s
well.

I have most of the patch for that, but I think I need adjust things so tha=
t
the read path uses GFP_KERNEL, not GFP_NOFS.

David
---
commit 3cc9160c12645c38c860e748845cb63b15115078
Author: David Howells <dhowells@redhat.com>
Date:   Fri Jul 24 10:24:30 2026 +0100

    netfs: Fix folio_queue ENOMEM in writeback by adding a mempool
    =

    Fix the handling of folio_queue allocation failure in writeback by add=
ing a
    mempool.  The failure caused:
    =

        folio !=3D NULL
        WARNING: fs/netfs/write_issue.c:603 at netfs_writepages+0x883/0xa1=
0 fs/netfs/write_issue.c:603, CPU#3: syz.0.17/5919
    =

    Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterato=
r instead of xarray iter")
    Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D0da43efa72f88bd3a8af
    Signed-off-by: David Howells <dhowells@redhat.com>
    Tested-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    cc: Paulo Alcantara <pc@manguebit.org>
    cc: Yun Zhou <yun.zhou@windriver.com>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: Christoph Hellwig <hch@infradead.org>
    cc: netfs@lists.linux.dev
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d889caa401dc..420ee7b26580 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -43,6 +43,7 @@ extern struct list_head netfs_io_requests;
 extern spinlock_t netfs_proc_lock;
 extern mempool_t netfs_request_pool;
 extern mempool_t netfs_subrequest_pool;
+extern mempool_t netfs_folioq_pool;
 =

 #ifdef CONFIG_PROC_FS
 static inline void netfs_proc_add_rreq(struct netfs_io_request *rreq)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 73da6c9f5777..927badf3989d 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -28,6 +28,7 @@ static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
 mempool_t netfs_request_pool;
 mempool_t netfs_subrequest_pool;
+mempool_t netfs_folioq_pool;
 =

 #ifdef CONFIG_PROC_FS
 LIST_HEAD(netfs_io_requests);
@@ -108,6 +109,9 @@ static int __init netfs_init(void)
 {
 	int ret =3D -ENOMEM;
 =

+	if (mempool_init_kmalloc_pool(&netfs_folioq_pool, 100, sizeof(struct fol=
io_queue)) < 0)
+		goto error_folioq_pool;
+
 	netfs_request_slab =3D kmem_cache_create("netfs_request",
 					       sizeof(struct netfs_io_request), 0,
 					       SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
@@ -160,6 +164,8 @@ static int __init netfs_init(void)
 error_reqpool:
 	kmem_cache_destroy(netfs_request_slab);
 error_req:
+	mempool_exit(&netfs_folioq_pool);
+error_folioq_pool:
 	return ret;
 }
 fs_initcall(netfs_init);
@@ -172,5 +178,6 @@ static void __exit netfs_exit(void)
 	kmem_cache_destroy(netfs_subrequest_slab);
 	mempool_exit(&netfs_request_pool);
 	kmem_cache_destroy(netfs_request_slab);
+	mempool_exit(&netfs_folioq_pool);
 }
 module_exit(netfs_exit);
diff --git a/fs/netfs/rolling_buffer.c b/fs/netfs/rolling_buffer.c
index a17fbf9853a4..48052d77567b 100644
--- a/fs/netfs/rolling_buffer.c
+++ b/fs/netfs/rolling_buffer.c
@@ -27,7 +27,7 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq=
_id, gfp_t gfp,
 {
 	struct folio_queue *fq;
 =

-	fq =3D kmalloc_obj(*fq, gfp);
+	fq =3D mempool_alloc(&netfs_folioq_pool, gfp);
 	if (fq) {
 		netfs_stat(&netfs_n_folioq);
 		folioq_init(fq, rreq_id);
@@ -50,7 +50,7 @@ void netfs_folioq_free(struct folio_queue *folioq,
 {
 	trace_netfs_folioq(folioq, trace);
 	netfs_stat_d(&netfs_n_folioq);
-	kfree(folioq);
+	mempool_free(folioq, &netfs_folioq_pool);
 }
 EXPORT_SYMBOL(netfs_folioq_free);
 =

