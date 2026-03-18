Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE33368B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848350; cv=none; b=FDxs9ypzia1wgASsyqAJvprDLFCqQcJByq7vDU+giGsEPd4RS2Ze0sPGgbijPEDd6ipg+hsXUq8RpdGmu4LvQ6T4LYSjbidYOgIbVxF6PTp4+zLWiFlcKd4fBdP7Q6TZgEcrfRf3UwOQxegwXitpBcWdegnkXAfDiesN7CI3uSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848350; c=relaxed/simple;
	bh=SvBAiqT4Zi0BJ9dVfQrDUKAuryhvrwr60SnwKtTIXEc=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=JIS1MpTnpALI4vbdUYksdh1+LhfVhsX/6iivcbfXxWnCACvGwavyHFNqSXABowQ8Laawx5LpyzSYAiYp2dJ+STXh2Yyw7rNMdGwUSzrSMnxKVbvk6MtrYr7zTvMNHlj8a0LycTXUSzQzOE4iufhzZnC0M/XfnGrXXgcqQ9KSzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3m9c0Qa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3m9c0Qa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773848346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/ufqFGB4g0xDHMWmeGig7QKYbA5a0mXiMB/47NNgvj8=;
	b=J3m9c0QaA3AkyJWV7SygADtBufjHBUL0sGBJzBPSrn0e/bvmC9PhWXAZDokzsQYRrhk2ff
	JimcJzCkr6wVv36bEAGAveHktzws+yP2Ck2SdKalcZS2Eh8GoBRv/dqDOginGRKpKSYYsF
	Xqjia84anstW+y/vVzM8qHY9BB1/scY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-NU3tWpoQNM-MqZ28sFRZvQ-1; Wed,
 18 Mar 2026 11:39:02 -0400
X-MC-Unique: NU3tWpoQNM-MqZ28sFRZvQ-1
X-Mimecast-MFC-AGG-ID: NU3tWpoQNM-MqZ28sFRZvQ_1773848341
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EF1F195609F;
	Wed, 18 Mar 2026 15:39:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 810161800107;
	Wed, 18 Mar 2026 15:38:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix read abandonment during retry
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3775285.1773848338.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 15:38:58 +0000
Message-ID: <3775287.1773848338@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Under certain circumstances, all the remaining subrequests from a read
request will get abandoned during retry.  The abandonment process expects
the 'subreq' variable to be set to the place to start abandonment from, bu=
t
it doesn't always have a useful value (it will be uninitialised on the
first pass through the loop and it may point to a deleted subrequest on
later passes).

Fix the first jump to "abandon:" to set subreq to the start of the first
subrequest expected to need retry (which, in this abandonment case, turned
out unexpectedly to no longer have NEED_RETRY set).

Also clear the subreq pointer after discarding superfluous retryable
subrequests to cause an oops if we do try to access it.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 71a0c7ed163a..68fc869513ef 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -93,8 +93,10 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
 		       from->start, from->transferred, from->len);
 =

 		if (test_bit(NETFS_SREQ_FAILED, &from->flags) ||
-		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
+		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags)) {
+			subreq =3D from;
 			goto abandon;
+		}
 =

 		list_for_each_continue(next, &stream->subrequests) {
 			subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link);
@@ -178,6 +180,7 @@ static void netfs_retry_read_subrequests(struct netfs_=
io_request *rreq)
 				if (subreq =3D=3D to)
 					break;
 			}
+			subreq =3D NULL;
 			continue;
 		}
 =

