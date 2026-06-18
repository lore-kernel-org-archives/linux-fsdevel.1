Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DC2E5B1B
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797937; cv=none; b=IkBeKXYooOTjCfNmRkK6q0krTvzZX7ZWX7i+dERkRhfweewFBtivbCOxn+Os24pCTkYVF5JfxneK0lnQc1Id1/sAi3Ue1z1un90G/TtfGasckmi5++wzHEchWzu6XiKGEdxc9l/5WMsM323bEM5cVdQpEDJUWkf5JytToOAUaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797937; c=relaxed/simple;
	bh=4LZrYHCv8Z8tYJatoibL0nKnnCTtLNyEQNO8TuA4qRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GS40tXLb0A9OB0WSTRSprXFriOa1J53Oy+YBrV1V/cDPlYBWGpMX6QjVwWGnrA5SalpXB+FtwxGCYP6gnu3Qf4NzsNLBBMXZzRYneskK4Fb2VUzl7DiyYzmkVSbGiOMnbJJYXOykcpaOKcPG2FQAZJ+WTcokigCRUiuC30IHLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZOkrFS3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZOkrFS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJX4I5D9uTmO8hOkb2ZiaXwu5L4z4jELuMPRRLbbgo=;
	b=IZOkrFS38/DRqZTZmHgDe6caoluwfxWlySo1N+Fe8vtk8uziaZEsNcrUCZoXcYe3t4rNTM
	JKR79TjVfjk6bGeHKnmKPyS4CMtKA3L5OqJ5QEFqGJhRYWRZ3Q5eQOGdO7R77t24TKEwHI
	oJ3ig+GbsV8urpttFkO3XFrAYBdAPd8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-_iHHTOBIPeu2isHueY97gA-1; Thu,
 18 Jun 2026 11:52:06 -0400
X-MC-Unique: _iHHTOBIPeu2isHueY97gA-1
X-Mimecast-MFC-AGG-ID: _iHHTOBIPeu2isHueY97gA_1781797925
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B069180060C;
	Thu, 18 Jun 2026 15:52:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EFA5180056E;
	Thu, 18 Jun 2026 15:52:03 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/20] afs: Fix double netfs initialisation in afs_root_iget()
Date: Thu, 18 Jun 2026 16:51:23 +0100
Message-ID: <20260618155141.2513212-5-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix afs_root_iget() to leave initialisation of the netfs_inode part of the
afs_vnode to afs_inode_init_from_status().

Fixes: bc899ee1c898 ("netfs: Add a netfs inode context")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3f48458694ba..a88995629d72 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -566,7 +566,6 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
-	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {

