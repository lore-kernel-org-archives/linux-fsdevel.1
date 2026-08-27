Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068E4279F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787823538; cv=none; b=M8Gx9oMdMmEqnIXVGiP14S9hJTZ0gQDLDI4JFfjWWb4RihotCOPi6kkDZzeI0JCVtmswsTcm72DzC6Q+jT3wKaPLOwjOsv9yUJxbMtf46zi70qv0/t79e+mbfVfZGiAqeZSmnGWfeJHEKYAe34v6Og5yPgzJueFCh8hcL55t2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787823538; c=relaxed/simple;
	bh=gZJj56dXZ3m5mpuWg5Y32mLuivOuA0n2jQSSKK4Lf/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arQ1Nv4A3ga26XQQmXSYJYEzhjPAo/7IG1mX8pVMFKy5vhnjsTYcoLO3lX3iS++Ap/dhFzvJc9Xqsmfz2kgN+Ljirj0ybHH+IhqEHx4/Zd0sYRSXqS3pNREJUTMKR/4P33KYII9GyAuGguVKK/9eddh7aaiJ046VR6psqUR+NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QBiBGFAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBiBGFAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787823532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b4i/vAlF7TVRLwxgQcCoqCNsYOQic8KZ0Txwd6Khtt8=;
	b=QBiBGFAPVercVlbmAVZh8BBXjYAk6ZSD/GE+DRlMWHDRh3udpG3NjR+ce9ic0VfxSnu63J
	+ZbKji0O/FMaOc5jh6UyITRjSVPlHS7YVPSPn2em77ADMSfxCPoo0Rvn01PgWlp+QArfkB
	VAIhntwZLp6pesWQM0iNKmiK8wBoHuQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-29C6pAf6M6KyBp40UdNyVQ-1; Thu,
 27 Aug 2026 05:38:49 -0400
X-MC-Unique: 29C6pAf6M6KyBp40UdNyVQ-1
X-Mimecast-MFC-AGG-ID: 29C6pAf6M6KyBp40UdNyVQ_1787823526
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F6D2195423A;
	Thu, 27 Aug 2026 09:38:46 +0000 (UTC)
Received: from warthog.com (unknown [10.22.88.47])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3072E423;
	Thu, 27 Aug 2026 09:38:42 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 01/10] netfs: Fix uninitialized return value in netfs_unbuffered_write()
Date: Thu, 27 Aug 2026 10:38:16 +0100
Message-ID: <20260827093828.1956211-2-dhowells@redhat.com>
In-Reply-To: <20260827093828.1956211-1-dhowells@redhat.com>
References: <20260827093828.1956211-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

From: Karl Mehltretter <kmehltretter@gmail.com>

If preparation of the first subrequest fails,
netfs_unbuffered_write() exits its loop before ret is initialized. The
empty-iterator check can do the same.

For synchronous writes, netfs_unbuffered_write_iter_locked() may then
return an unrelated error instead of wreq->error. This is reachable
through CIFS if cifs_prepare_write() fails to reopen the file or obtain
credits.

Initialize ret to 0 so the caller returns wreq->error if no data was
written, or the number of bytes already written otherwise.

Found with Clang's -Wconditional-uninitialized.

Fixes: a0b4c7a49137e ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/netfs/direct_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index c16fbad286a1..b04019097ab8 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -95,7 +95,7 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
 {
 	struct netfs_io_subrequest *subreq = NULL;
 	struct netfs_io_stream *stream = &wreq->io_streams[0];
-	int ret;
+	int ret = 0;
 
 	_enter("%llx", wreq->len);
 

