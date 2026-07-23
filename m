Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCA47127C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806509; cv=none; b=fCSUfzfZRK6XUEy6SWZOmduit1HNhRaPNbBFUJPR4epu3lCfQlh3kAVhic5YWew0YHvcnMNd14dmhRYe7504trPvjQKQTGu2iPV4J2bPb+ap0u5ZyJ89Ofko62W7JI93gKpgTJQIIqTKns1oaAIf0uAOb7eR3H+6J8gq5HzmSok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806509; c=relaxed/simple;
	bh=6pGa3CUiGPa/PX5Q17AMEDrXh5WP6t9peUYIpdX/mTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3lOy4aAsuXKwl/+8dEZr93IlHntlE2pa1GMxBfWhLV9u+cPsLjurMwdkBen4Zvvs3aE7yGna6B4d1Ks84saP/D1bsVNOYdGKffxlbNHz7Y4jAUd4Twpz8VGuaPcRhcYK+Lh1QKgQNRMkYo2co6hud+mv3WdlLkYXAhFPepsSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoZ/A3eD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoZ/A3eD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjnMqWJMAGWNSzQbg/QBfRE6SuYjFpBzou99xBDPdy4=;
	b=IoZ/A3eDDnvApIYuIJyImoEkwZRaupszNsmeVlFRhaD/49joSufR8wgHiWHQ2K4Knc51al
	0c237jHkond+0hVCKij3tStrMDd2CRssVIEhxEr1z0INUuxDQlBLQmvCdX06K0XmUgI48d
	41KEQ0fJioJ9jNpYiiMQukpT/N59714=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-zUVhtm6TMQ6pfsVFyvvaog-1; Thu,
 23 Jul 2026 07:35:05 -0400
X-MC-Unique: zUVhtm6TMQ6pfsVFyvvaog-1
X-Mimecast-MFC-AGG-ID: zUVhtm6TMQ6pfsVFyvvaog_1784806504
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B17F195FE31;
	Thu, 23 Jul 2026 11:35:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C8481800259;
	Thu, 23 Jul 2026 11:35:00 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 1/3] afs: Fix afs_fs_fetch_data() to set call->async
Date: Thu, 23 Jul 2026 12:34:46 +0100
Message-ID: <20260723113452.566619-2-dhowells@redhat.com>
In-Reply-To: <20260723113452.566619-1-dhowells@redhat.com>
References: <20260723113452.566619-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix afs_fs_fetch_data() to set call->async on an async operation as does
afs_fs_fetch_data64().

Fixes: eddf51f2bb2c ("afs: Make {Y,}FS.FetchData an asynchronous operation")
Link: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/fsclient.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index a2ffd60889f8..626e1d37b915 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -477,6 +477,9 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	if (!call)
 		return afs_op_nomem(op);
 
+	if (op->flags & AFS_OPERATION_ASYNC)
+		call->async = true;
+
 	/* marshall the parameters */
 	bp = call->request;
 	bp[0] = htonl(FSFETCHDATA);

