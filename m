Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C441C2F4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980593; cv=none; b=kWrnOXi3aulEtGrTAPK+yl06sI0KD3bwptJGYpqH/y9/q2ETVbHYk3ihJ8ikfyF0XZ/nSi47bNoO15xRDCeRzIAvUKWKNfY6jkbtJGKJUVCG64Bv5tX66Vmf8LADgT5jY2Pdhm/jGjbUrnRtQXYprjbxUYeN/BSomINnRUGoO9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980593; c=relaxed/simple;
	bh=6FLiQhR9apEcZHHkTSIJOA1/B8NuqA/h/bLdqEjvJz0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=a6fqcj5o3GEnN0ipV3CXMnZcZOGL1bva+nMYqlBKJruMWrvowx6LD2Oa9/g0luRM1RnY8HzT+vOAFL+NBVbabEyeAtJLOBZIwctLrTHXzo/xO0odgw2KGY5stqF4RBWdZEEDDT7YPXbkFGhC05BsO27VxZl1cCTtbAS/pMlIYbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrhztJ2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrhztJ2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782980590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rG6FsvMTpXDIz1UoDbo/KxKXu8DxNP7LA7+Lfa9Ypx8=;
	b=IrhztJ2tVfGOH5hcrNHYM/00MmDFja10azUoarm9xUSo9WPWuvjs7m+Xa7YsV0vN6rxwZ2
	2U8fd0097ZIh/UzKEn4PyWIGx7Xh35vpsNHnhY83p2Py+RmibmnG7WCoydZT0zEARk/NrI
	j4W85AHp1e5M1kRn1kKv+/2xjFaIfOs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-5KyXlEVEMMixFGHRK1eZAg-1; Thu,
 02 Jul 2026 04:23:07 -0400
X-MC-Unique: 5KyXlEVEMMixFGHRK1eZAg-1
X-Mimecast-MFC-AGG-ID: 5KyXlEVEMMixFGHRK1eZAg_1782980586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20EA71833388;
	Thu,  2 Jul 2026 08:23:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E7811971E67;
	Thu,  2 Jul 2026 08:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix barriering when walking subrequest list
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <138806.1782980582.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:23:02 +0100
Message-ID: <138807.1782980582@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix the barriering used when walking the subrequest list in retry as
there's a possibility of seeing a subreq that's just been added by the
application thread.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Link: https://sashiko.dev/#/patchset/20260608145432.681865-1-dhowells%40re=
dhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c  |    7 ++++++-
 fs/netfs/write_retry.c |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index f59a70f3a086..2b42758e01ec 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -98,7 +98,12 @@ static void netfs_retry_read_subrequests(struct netfs_i=
o_request *rreq)
 			goto abandon;
 		}
 =

-		list_for_each_continue(next, &stream->subrequests) {
+		for (;;) {
+			/* Read pointer to subreq before reading subreq state. */
+			next =3D smp_load_acquire(&next->next);
+			if (next =3D=3D &stream->subrequests)
+				break;
+
 			subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start + subreq->transferred !=3D start + len ||
 			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||
diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index 32735abfa03f..058bc7a166a5 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -72,7 +72,12 @@ static void netfs_retry_write_stream(struct netfs_io_re=
quest *wreq,
 		    !test_bit(NETFS_SREQ_NEED_RETRY, &from->flags))
 			return;
 =

-		list_for_each_continue(next, &stream->subrequests) {
+		for (;;) {
+			/* Read pointer to subreq before reading subreq state. */
+			next =3D smp_load_acquire(&next->next);
+			if (next =3D=3D &stream->subrequests)
+				break;
+
 			subreq =3D list_entry(next, struct netfs_io_subrequest, rreq_link);
 			if (subreq->start + subreq->transferred !=3D start + len ||
 			    test_bit(NETFS_SREQ_BOUNDARY, &subreq->flags) ||

