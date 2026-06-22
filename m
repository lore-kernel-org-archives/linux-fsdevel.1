Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EE1392836
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119369; cv=none; b=jHpPeAQ/r4LroTUeEZ2uyfNSVOsrZiHGnmITFV3V9GjVAyfvJz23pRUpM90PvRO4j1Gf3LV3zVQgpQ6Q/+fTyp4REsO7NOdRM/u2f32Bq29rR+S8ZkbB2p+ASCDQPLbBUxe61AE19Cmtt1NlMDmf/JinpIhTa/PndybphjYWKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119369; c=relaxed/simple;
	bh=4LZrYHCv8Z8tYJatoibL0nKnnCTtLNyEQNO8TuA4qRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmUEzMhZtxIpzk7l2MWB3kWiaRmiKUO+yoJydquJG6WD4qVCyaFcG6ui2aWBP/Rt4K/4NtRHSJWXxURT6i+PfGgEv/rvgBRtAMzVOiF0x6r6FANJ1r87f/TY1VOd8yrwPx+QwkD+i5DdpmxxylB6DWKJl8M6djnZbdmdAqZL/Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxduzIgr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxduzIgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqJX4I5D9uTmO8hOkb2ZiaXwu5L4z4jELuMPRRLbbgo=;
	b=SxduzIgr+8R4VWXOTZVm9CkXtgTIgeTDPLd/jtVOH1XrwtASKRe8eY0m1oCEdAF21k6+kN
	Wd5B+alCjI/yWI2wQTqgm95fcK3fb83ojAX3dyN3hYDCm2jl5ct3pe4ESAsUYKpp4r8sgB
	/b9zJ3HntL2pBdvqAroac5bHgUzC4j4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-oTjnp6dsOb-Go14F1iAJWg-1; Mon,
 22 Jun 2026 05:09:23 -0400
X-MC-Unique: oTjnp6dsOb-Go14F1iAJWg-1
X-Mimecast-MFC-AGG-ID: oTjnp6dsOb-Go14F1iAJWg_1782119362
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 71CFF1805A35;
	Mon, 22 Jun 2026 09:09:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 83D3F1956096;
	Mon, 22 Jun 2026 09:09:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 04/21] afs: Fix double netfs initialisation in afs_root_iget()
Date: Mon, 22 Jun 2026 10:08:38 +0100
Message-ID: <20260622090856.2746629-5-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

