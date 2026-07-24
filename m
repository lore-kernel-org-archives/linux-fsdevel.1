Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221333B4EBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889115; cv=none; b=AeCOyAwZE3KOrL61Ax5WXGfoI0vfT9csAQ/ljaSNmq15WBsQsu7IUsmxsKo7NSYDzGU9U02oghIJZj9OsQJPLk3dNK8WtCcgbNgr3K7QlhoTv6wcWf1Z0ACzg6Io2Zm9LY8FG5Oe/aElYxPZvJ3hqWwPyGZleV3qckf+QUEwgjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889115; c=relaxed/simple;
	bh=0bfjwv3OeOIMucNcqlk423lCkbo4bhbyJENTxuXmtTA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=G0d4YqLJkIvESnIZ0QRgtL6oOuJCVbtfH62bnofwt1YIYL73DftKsdCBxDSNv1ftJrPQbtjw9q9+GUCbAxn9ixGkGji5OtJwnqlDyQbYhpdvNwstdlWSF7FrO5u7pV6Es927kjG0k5sdSezv+1TFaZMHqziPL8LdVipkzha3V/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hedxfnv+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hedxfnv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784889112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NE6J1IsdO9P932UnR0+0KPISkxZALoCpW6EB7GcxBX4=;
	b=Hedxfnv+KMBBLbcmm59aHkxmjXNJrZH/ia/rGzr1LNg4ezWCK7y0qJRrY96jGxVY9kKQLT
	Q6VmjAv7GjU1VBAmk795tA3jGWdj8g1ALKUP2InAbsCVseXD+8WTFC53Sx65WzqjkGzJf5
	YEvFNHmnvT7cHjjyglSf7Tiar9X1RVw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-u6t9AAAmNNSSSFGeoiYWxg-1; Fri,
 24 Jul 2026 06:31:49 -0400
X-MC-Unique: u6t9AAAmNNSSSFGeoiYWxg-1
X-Mimecast-MFC-AGG-ID: u6t9AAAmNNSSSFGeoiYWxg_1784889107
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 422C6195DBA2;
	Fri, 24 Jul 2026 10:31:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14435158A;
	Fri, 24 Jul 2026 10:31:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
References: <6a4c21b3.c76b52dc.34afef.0002.GAE@google.com>
To: syzbot <syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] WARNING in netfs_writepages (3)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <831910.1784889103.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 11:31:43 +0100
Message-ID: <831911.1784889103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master

    netfs: Fix folio_queue ENOMEM in writeback by adding a mempool

    Fix the handling of folio_queue allocation failure in writeback by add=
ing a
    mempool.  The failure caused:

        folio !=3D NULL
        WARNING: fs/netfs/write_issue.c:603 at netfs_writepages+0x883/0xa1=
0 fs/netfs/write_issue.c:603, CPU#3: syz.0.17/5919
    =

    Fixes: cd0277ed0c18 ("netfs: Use new folio_queue data type and iterato=
r instead of xarray iter")
    Reported-by: syzbot+0da43efa72f88bd3a8af@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3D0da43efa72f88bd3a8af
    Signed-off-by: David Howells <dhowells@redhat.com>
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

