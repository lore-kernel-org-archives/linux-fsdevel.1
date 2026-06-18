Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D6A3BED7F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769006; cv=none; b=ZB30ICC0N2WZXgg6nqxRhyAhPxuhW/LWzhWKyaCWkhMxGnx5Uk4nV7pRnvE+RcEgvRdgbDA4nvTAO0ykSUHta/Ct0yU/WANQ75YpWmB4H5zzCsrteRuXdv57YDHyaoh9LgS1NX/qoy4k0b4Fh0aRVIs0w9oNkNcsAkypR/dsjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769006; c=relaxed/simple;
	bh=O0eEWCbViTg60+w68G1iu3SlZ8AMj4FR/XLBMjrxFfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAytcVBXwmB2tgjglrNb2lAF5C5Fvhv8GBhUuXxUigwbfVhi9dgZvq1L7DDG6Ak0nGHgyXSvCmK7xkGSti7hv2cnH3+NTSp+9Bn0kqt+OxbVw4H+GKouSXOnEXxig5DMG7lP/WzvSRLb/tx98q/LGJtJ/1WeVcuHngdq5xVhD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewshpM9G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewshpM9G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781769004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/vFaPEvvt5XSDcmbW2NiGBsTKUERe7FcXecJMTy8fc=;
	b=ewshpM9GLyxBo1GZ0ZXTNfhLSJVL43M3OPQrwcyev+9zrvyyEq2pJqn084Dgc5XCHkQZcQ
	Z8EM6lQFdIIWpw3vv8ZGy5Wx3SOz7GmL3sH7xicZo6AGmgvHKRZ9rdicRIV1oJNBrQOKpv
	Rp+0s42FxwGXYdJ66nRndxxM93Y00jc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-WccTdviVOfOCeWde-GdFmw-1; Thu,
 18 Jun 2026 03:50:00 -0400
X-MC-Unique: WccTdviVOfOCeWde-GdFmw-1
X-Mimecast-MFC-AGG-ID: WccTdviVOfOCeWde-GdFmw_1781768999
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 787711956044;
	Thu, 18 Jun 2026 07:49:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78F8418005B8;
	Thu, 18 Jun 2026 07:49:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/17] afs: Fix double netfs initialisation in afs_root_iget()
Date: Thu, 18 Jun 2026 08:48:55 +0100
Message-ID: <20260618074903.2374756-13-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 21ac098d03ef..c8df1764d414 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -565,7 +565,6 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_check = atomic_read(&as->volume->cb_v_break);
-	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {

