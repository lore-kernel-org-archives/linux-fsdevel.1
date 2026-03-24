Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB1314D35
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774391747; cv=none; b=sZJprCCUan9cBthgq8GilgbQACG+tbQnnOq7pAAvbfJi444P1xwTJnPpwsxKb2h+EP/VtgBsbsphTyuz6JQnsi8vCZ21PO75U799lWLePhx4GRHuIswl7SJoNQGg9v191Y4U3aoAU0Q3S763c7Yv7zu3EeqV+4PHy09HwPcmvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774391747; c=relaxed/simple;
	bh=JjMdmUS091k30GcCvh/dJr0R0Xpa+sAqIVPOMLEwWiY=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=NdU4R2oF1A4QYauFAQnaB6H7onTptVdGsPJJs8BGbDPil4tjbgoHZiLxPok/zdqGbfI37jRKu/1eRAVSA6G2Xe2a0+vc7vpa5yOwFpKa5OHfHHQyKIX88Q8+NdQiqNnEZbO4+NTTQNeWbIXexedUCZN0/nRehRt9F9bb54+Ltq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQhrj9O7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQhrj9O7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774391744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IZxsEK5okqRInCWT1RBifNs1wN/gy/ohKX4q7FRogpY=;
	b=CQhrj9O76ZAPLDjMtq2Y9ZGh+XMPVl2abv0PJPd0Q/rcWjBqNb0LDgjpT8sn24U58eK9nI
	oXQe8CKOG57+lEzjHrzZHcBySyB24ZAAWKji++U6Jxvst8lC15r9N7ayqPuvVzt4bo0tNk
	ei1o/PoFSqVVU3XUr6SPLcGBn1QH0xg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-ag2Lx6GnPvqaE9ND_lyU9A-1; Tue,
 24 Mar 2026 18:35:41 -0400
X-MC-Unique: ag2Lx6GnPvqaE9ND_lyU9A-1
X-Mimecast-MFC-AGG-ID: ag2Lx6GnPvqaE9ND_lyU9A_1774391740
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E8C619560AF;
	Tue, 24 Mar 2026 22:35:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3DF51955D71;
	Tue, 24 Mar 2026 22:35:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: NeilBrown <neil@brown.name>
cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4001607.1774391727.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2026 22:35:29 +0000
Message-ID: <4001609.1774391729@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
former's ref on the victim dentry that it obtained from
cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
of the victim in place, resulting in occasional:

  WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/1=
1831
  cachefiles_cull+0x8c/0xe0 [cachefiles]
  cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
  cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
  vfs_write+0xc3/0x480
  ...

reports.

Fix this by removing the dput().

Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: NeilBrown <neil@brown.name>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index bdac2f33edf3..e2023e78e4df 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -795,7 +795,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, st=
ruct dentry *dir,
 =

 	ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
-	dput(victim);
 	if (ret < 0)
 		goto error;
 =

