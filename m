Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644341CB4D
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489332; cv=none; b=l23a0jdp3cyrQ8tTxlw21cg0e7Gvu9dRPpUTtlOW3NL5J3IajHeuyGr+/6B4JJAvZn89htzFjtO8OIq722eZELpp0XxqtrMKz1Zcot1uvgXHvckV7jzH5oxqBuIgUzXtRCVN4dVovmaFcv3n5DydVCJeMja67nnAEJfe859fdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489332; c=relaxed/simple;
	bh=zUoHmxowTOoPQ2cy17B58MgmVupxgZDzShWKibnW/tU=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=hoYLNve3GSpR2UQjda7cGOx3LeHJHuHvX/JvxINt5voaPv24SPHwSVHhRZ6VshX3YVr2Y/kKvAGFaJuLyLWQ9hf4oViKcoMK29C4ih78R6lmxt6giS/AuwsoIkl+KwqGMVr9cuy32ndIcUKqTAvSc/E+h5fgCfxB1aVmfSS7UfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4YQMsw4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4YQMsw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789489329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k6lBh8pJhBpFKoIVnL+XIIXSywvf+aT6pBCJuoStQpg=;
	b=a4YQMsw4bRnowSi6JxQZI/L2qjTMRrSs/JykpyceIVBCaay7EOSzSNSQyxjHbBcve3Qb97
	lOAhNymP1cYAqY+fvXEsJYc1aQTbZfHeTpQB5+nJgZ3WmhxWc3QiKxgl0dBy2lU3X+y9lU
	yPXefkplDUJAYiHsrj4uiDiXNXPu7AE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-u3xgUX1QNwmOEvKVb1IIaQ-1; Tue,
 15 Sep 2026 12:22:05 -0400
X-MC-Unique: u3xgUX1QNwmOEvKVb1IIaQ-1
X-Mimecast-MFC-AGG-ID: u3xgUX1QNwmOEvKVb1IIaQ_1789489324
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 282DB195605E;
	Tue, 15 Sep 2026 16:22:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E1263003EFB;
	Tue, 15 Sep 2026 16:22:00 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfs, afs: Fix symlink reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3912794.1789489319.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 17:21:59 +0100
Message-ID: <3912795.1789489319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the reading of symlinks from the cache in afs by making netfslib trim
the amount read down to i_size.  The problem is that afs sets the size of
the iterator to the size of the buffer (PAGE_SIZE) so that the cache can
round the read size up to the cache's DIO size.

Note that this also impacts the reading of AFS mountpoints as they're just
stored as symlinks with an odd file mode.

Fixes: c0410adf3da6 ("afs: Fix the locking used by afs_get_link()")
cc: Paulo Alcantara <pc@manguebit.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_collect.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 5cf22087d243..a94197ef0181 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -435,6 +435,11 @@ static void netfs_rreq_assess_single(struct netfs_io_=
request *rreq)
 		netfs_single_mark_inode_dirty(rreq->inode);
 	}
 =

+	/* To do DIO, the cache has to round the size up, so we need to undo
+	 * the rounding.
+	 */
+	rreq->transferred =3D min(rreq->transferred, rreq->i_size);
+
 	if (rreq->iocb) {
 		rreq->iocb->ki_pos +=3D rreq->transferred;
 		if (rreq->iocb->ki_complete) {

