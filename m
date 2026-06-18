Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102DB7083C
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797921; cv=none; b=qFue1DXLmLq8Fd8sCf04h4RHEcSSQVVzYJmOFmYEQcqUfxvYA7SPKhIeXmB4ZPhlLMlLFsBXUDQnR1R4YaK+IiUP+XsTX4sbSjHzfsF4FjxRB4y932Mj4lIJWWbVlcBQMskpxU9kw9ml6JzhCjG34YieLgExl8WF6m8bFodK/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797921; c=relaxed/simple;
	bh=Qot/PJkxpbE9FxlSLjM1IYuTW1mM4PdPtQlpfM51lxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6Q/YIjWBZvkOxsbuEF8erlySUFwFGIhxyzsfR8GbwaPUCyTYcsJ7rKWzGF4AbmdBZDDr5P4IFyCG7dYV6z1t1QgRbNs3ocX6fJQyiF37ZyBwdKoCX7cO2bOHFVCoIjtTnUgm1dE0HMOoGzqQ11kJpkgMh00TSpEC3f2JDQugko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BN0Ra3Us; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN0Ra3Us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXYfuW0iimSyufRjo4SpIMOrUHwhtivd5e9rju7+Kzw=;
	b=BN0Ra3UsxutQh3dobkH5pgR6lrJuLt33h+r/IyH0OM4jKGhOns633PGnUZ10MHegW7Pl3g
	/8iouioysHhfAlZfehJPdnQklmfTCRvldZc1sxPjoz9BncWLGh92V69bAvj8YxeUTpRBFF
	J667VDhaOwBGv+loBKySZhtqiw0fRDk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-WXH1B5voOieD93BTc0t8PA-1; Thu,
 18 Jun 2026 11:51:55 -0400
X-MC-Unique: WXH1B5voOieD93BTc0t8PA-1
X-Mimecast-MFC-AGG-ID: WXH1B5voOieD93BTc0t8PA_1781797914
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCE1918001F9;
	Thu, 18 Jun 2026 15:51:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79CAA3000232;
	Thu, 18 Jun 2026 15:51:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nan Li <tonanli66@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>
Subject: [PATCH v3 01/20] afs: handle CB.InitCallBackState3 requests without a server record
Date: Thu, 18 Jun 2026 16:51:20 +0100
Message-ID: <20260618155141.2513212-2-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Nan Li <tonanli66@gmail.com>

The cache manager callback path now attaches the server record to an
incoming call through the rxrpc peer's app data.  That association is
not guaranteed to exist for every callback request, and most callback
handlers already tolerate that case.

Make CB.InitCallBackState3 follow the same pattern by checking whether a
server record was attached before using it.  If the peer is not mapped
to a server record, trace the request and ignore it, matching the
existing behaviour for other unmatched callback requests.

This keeps the callback handler consistent with the rest of the cache
manager service and avoids depending on peer state that may not be
available for a given request.

Fixes: 40e8b52fe8c8 ("afs: Use the per-peer app data provided by rxrpc")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Nan Li <tonanli66@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cmservice.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 5540ae1cad59..263c60c811a5 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -364,6 +364,11 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 	if (!afs_check_call_state(call, AFS_CALL_SV_REPLYING))
 		return afs_io_error(call, afs_io_error_cm_reply);
 
+	if (!call->server) {
+		trace_afs_cm_no_server_u(call, call->request);
+		return 0;
+	}
+
 	if (memcmp(call->request, &call->server->_uuid, sizeof(call->server->_uuid)) != 0) {
 		pr_notice("Callback UUID does not match fileserver UUID\n");
 		trace_afs_cm_no_server_u(call, call->request);

