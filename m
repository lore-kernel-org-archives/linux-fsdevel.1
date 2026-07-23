Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D280471269
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806516; cv=none; b=LUAgmHIrsEikqkZ6kHBMGXqnseVNf0RHB+xXcezIjX2+MKS9jsNkwTmub+dwJExyDWfIxkUyKqTmV4scVD4GnpMHUyBdaGFbfh4X6LssHDGi+YgOxU/U6G+3pxfc5yAHjMxsAcKTVKAQWlPDmJkz0Nm1YBAEBrQYDXMeM9+EL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806516; c=relaxed/simple;
	bh=Y98FRonDwtqyBax9EbbJbMBQ68jO4Jj1sEWHJm/AHcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHLUMkTUJMv2lIeCD3OjH2P1jMcdfpq5yVipOW4GhusQbNLr12UvqyitNmAhV2XkAwb8A2zIY4Ln1TzfTqSGbeyvQSgEd0aT5zrhqol6HhgoV5Uz35mB2xjKZtxCNAMG2dl/XG2hfZyTGBso2sUs7jbAv+/KkFkdbpnaM9SP4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rn+nsj+f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rn+nsj+f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Ex9r+YT74DUnp4VrXDusgsvFFSooUjJymiD3VFZuE=;
	b=Rn+nsj+fMXisJ69e/+IlbRubuu7hqiuHuYZSl07hfzY8mfOwwSbflVvF8bCLHKIWQBwnK1
	seO4Ia3wFOMl+0vkz3e1d2qazFNMldAFcaUH6CDgj74lQOleQHNDmBK3F8UnWPpKxkk8yp
	YvAnLZUwYABiB/d6Y+XdEjQZkUa4vdg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-Tu_C1I-3NCqJFxwpMfkAMw-1; Thu,
 23 Jul 2026 07:35:10 -0400
X-MC-Unique: Tu_C1I-3NCqJFxwpMfkAMw-1
X-Mimecast-MFC-AGG-ID: Tu_C1I-3NCqJFxwpMfkAMw_1784806508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 590091977529;
	Thu, 23 Jul 2026 11:35:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DAD33000218;
	Thu, 23 Jul 2026 11:35:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 2/3] afs: Fix afs_fs_fetch_data() to subtract transferred from len
Date: Thu, 23 Jul 2026 12:34:47 +0100
Message-ID: <20260723113452.566619-3-dhowells@redhat.com>
In-Reply-To: <20260723113452.566619-1-dhowells@redhat.com>
References: <20260723113452.566619-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

