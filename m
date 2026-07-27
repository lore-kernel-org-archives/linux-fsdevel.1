Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E940E8FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157728; cv=none; b=l6FgtWYhbvpBeMWdmRIKWyEZSEcx8I9T27uhIe2B7iNVRdvQrILcYmIm854g7+30V6ngqi/KcfZjyK4AnNWszdsZ4NJpb/Gr5BDZR4jx69AhmfhmpqLmlH6e8/D5edgW3IKEO4EKA0bCsz7ETsMi2EYzamd5djCVKLkEMP2SSwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157728; c=relaxed/simple;
	bh=Y98FRonDwtqyBax9EbbJbMBQ68jO4Jj1sEWHJm/AHcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/zehG5yoigQxfdiRdh0AMUVfwcUgmchAc+pzLzCIHaV15gYfFKyEVwJbWfxH2FPo4yGrlFgJSz85XdpVc3Pk9YLQj2mHtrkNFDYpjYZWvbzx0WtREL8YdhSMYp1D7PJ2Z4MSeuXUAun/Gg60ZktJybjHGc68GwFqFjYbWMI+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfxErSuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfxErSuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785157725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Ex9r+YT74DUnp4VrXDusgsvFFSooUjJymiD3VFZuE=;
	b=bfxErSuc7/UsUAMiJ/wTK0ftjst+9jVZ9ZG9iPoAKLTLxFWU7u/noCoWkkjpVH5kBeiGKc
	mqUnYg94eRyae7dYmosNT2oQzQ8Yz6ug9eFKAWA7z6thdnoTq0dfaSausy3yoAnCeKvkPT
	Fd2WXNWQiIKuuhXD01M+iWQoAAIvvbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-NThMgAQPMfGc-BMPoG_t4Q-1; Mon,
 27 Jul 2026 09:08:42 -0400
X-MC-Unique: NThMgAQPMfGc-BMPoG_t4Q-1
X-Mimecast-MFC-AGG-ID: NThMgAQPMfGc-BMPoG_t4Q_1785157721
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03A7119560AE;
	Mon, 27 Jul 2026 13:08:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6074419560A3;
	Mon, 27 Jul 2026 13:08:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 2/8] afs: Fix afs_fs_fetch_data() to subtract transferred from len
Date: Mon, 27 Jul 2026 14:08:18 +0100
Message-ID: <20260727130827.1100080-3-dhowells@redhat.com>
In-Reply-To: <20260727130827.1100080-1-dhowells@redhat.com>
References: <20260727130827.1100080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix afs_fs_fetch_data() to subtract subreq->transferred from subreq->len
rather than adding it.

Fixes: f28fc2010d62 ("afs: Eliminate afs_read")
Link: https://sashiko.dev/#/patchset/20260713081022.2186481-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/fsclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 626e1d37b915..1a3f186a6a11 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -487,7 +487,7 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
 	bp[4] = htonl(lower_32_bits(subreq->start + subreq->transferred));
-	bp[5] = htonl(lower_32_bits(subreq->len   + subreq->transferred));
+	bp[5] = htonl(lower_32_bits(subreq->len   - subreq->transferred));
 
 	call->fid = vp->fid;
 	trace_afs_make_fs_call(call, &vp->fid);

