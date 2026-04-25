Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871BD3612CF
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777102347; cv=none; b=BmeglIW7y/WxQaJ7L0INE8Ip9+fhXxzAuDfmHZgqc3pjWEAfPpq+ZFJ3FFreCj+8Xmu3iRqzekZX0vaq672j0c9mWFB6ROwCMwsH4gnMbZU4JbPq9wN8vPqxh4wKraxsnlXQ9u3a9h8L1P3HWM2Iyg5WWnzm8hRFMSmu/0Eo4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777102347; c=relaxed/simple;
	bh=aOTyKsmr6DcOmHXEMYDU1eBTVka0Z6SoSEFZjKZKKJQ=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ExXiVXUjpzTRiX+6hFNET1wuqAn9SjnDxQv/uF26ZAd0FjXVLXVO/FPf/7t1GEo0yCkDaWUGX+zt++sSjlQLXD93pEzp54CRdWVLKXk3Z2BOA+FZydzTF6M64ci/73/jYMiVznEBGvML+JcCFaGKbAlyjP9TqG7hZUk5DCR/THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jm1zHTcy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jm1zHTcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777102345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5gzWVQIG73AjHJc00itzUJCP5782HlmTHOQaoGTzA2M=;
	b=Jm1zHTcyVnHr8dvO2z8LQ83h0EkCoifUzaqAt9iwEsX/LUtG6+yiV2jSRim71Gp90AFV0l
	USAgVg8vUUYJjEWru7y62qwI5WahdOfssA4yzDBYOVr4dR0htuFrvcX37riaTrHP6vYfNQ
	WXg71cQyGREfkNETldmAlhYfn6KejoA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Y-xCKVZrPAimNIw5vkrq9Q-1; Sat,
 25 Apr 2026 03:32:21 -0400
X-MC-Unique: Y-xCKVZrPAimNIw5vkrq9Q-1
X-Mimecast-MFC-AGG-ID: Y-xCKVZrPAimNIw5vkrq9Q_1777102340
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB57B1800451;
	Sat, 25 Apr 2026 07:32:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90AEE180047F;
	Sat, 25 Apr 2026 07:32:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix wrong sort of request put in error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3643631.1777102335.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 08:32:15 +0100
Message-ID: <3643632.1777102335@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

    =

Fix netfs_write_begin() to call netfs_put_request(), not
netfs_put_failed_request(), if it has already tried to dispatch the
request.

Fixes: 453f1cc34a8f ("netfs: Fix leak of request in netfs_write_begin() er=
ror handling")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 5c78ec14e46b..7e7dacded8f7 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -693,9 +693,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
 =

 	netfs_read_to_pagecache(rreq, NULL);
 	ret =3D netfs_wait_for_read(rreq);
-	if (ret < 0)
-		goto error_put;
 	netfs_put_request(rreq, netfs_rreq_trace_put_return);
+	if (ret < 0)
+		goto error;
 =

 have_folio:
 	ret =3D folio_wait_private_2_killable(folio);

