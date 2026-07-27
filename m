Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26ED40B366
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 13:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157721; cv=none; b=ur8doN38cahOtKtoV6TCBy4WQH/QesDYJfyV9HuquJYFx4uNVfHLMdXu1lN+l4wYY6YqO0PfUripRis6l2vBXAv/mJm8SJtwVc/keumq7r6scWiDvhmyMYvAg8zQASgRUvR3f4cNq2D9Ir8y4HIvtTREDVRwytoTt3FlT1BYgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157721; c=relaxed/simple;
	bh=6pGa3CUiGPa/PX5Q17AMEDrXh5WP6t9peUYIpdX/mTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egFTeGJxByt/OsIAxdFtFD23SteNJZX2tss8afG9fxGILBrk9mnuiDPhT5xUCaSl2edfLXY5iKbQsv5x02eOJq9rh5bUHEcmLl4Ve0WbNLa6rYPAdWEeKyRCvyMTr0GvLWRIezxyAlgaFyncvDwBEeMuTvgwZubJZF7zmFdnNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tyr1j2yj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyr1j2yj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785157719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjnMqWJMAGWNSzQbg/QBfRE6SuYjFpBzou99xBDPdy4=;
	b=Tyr1j2yjPNVUsgnS1SWAVT+AJlgbMrWf2huBdqdGXzQdnrAaJk1ngFRzFbpNPYKNP1Vn4u
	IBsFz2RrBJuwMA9PZjN9R8PmtWnGK/LBINFm4hLvqZZR1CBWAGGOO4iutvpB8winFQUGb5
	a9sOx2HHBACSX0s4ixgUmcQFDnEF6Pw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-uvhBr9ZBNZmfIxOZsjqlPA-1; Mon,
 27 Jul 2026 09:08:38 -0400
X-MC-Unique: uvhBr9ZBNZmfIxOZsjqlPA-1
X-Mimecast-MFC-AGG-ID: uvhBr9ZBNZmfIxOZsjqlPA_1785157717
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE2319540EF;
	Mon, 27 Jul 2026 13:08:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC53E18001E3;
	Mon, 27 Jul 2026 13:08:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH 1/8] afs: Fix afs_fs_fetch_data() to set call->async
Date: Mon, 27 Jul 2026 14:08:17 +0100
Message-ID: <20260727130827.1100080-2-dhowells@redhat.com>
In-Reply-To: <20260727130827.1100080-1-dhowells@redhat.com>
References: <20260727130827.1100080-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

