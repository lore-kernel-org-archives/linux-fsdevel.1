Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1833346A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782119360; cv=none; b=jqGMa2ZHyhQjy609KvQQbuR/wrRjlxTnYX3PsUwKCIHcYbqX5IlOlK+bijSVyGo7vkeqP2p+OaTMFY+ShcKuCq5SlE0WUlS/isLc8pfUDwxMeiqjOksnAseG0r2PQK60eWjrx5rONb5ueDe7dbt6zJEifWJ05LTcgcd+UotWPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782119360; c=relaxed/simple;
	bh=Qot/PJkxpbE9FxlSLjM1IYuTW1mM4PdPtQlpfM51lxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcnfruyA+gEF0locmdK97S6TjIbrTnPBaq62c/ChbO37S9r2+iVMBUa0u4czYjSSEILtzJziDAZGsdPAAIogffuy15pf8X+DiQLKEeJxysXJQqjw82hV0dX/kRTRlgwl/Znvmu44MvdFVY1MZpn9tRuYrGFVqxW/f0D00TOI+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTmYxpsk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTmYxpsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782119358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXYfuW0iimSyufRjo4SpIMOrUHwhtivd5e9rju7+Kzw=;
	b=GTmYxpsknnRz0C3oqGTnga0oidou5O/31b/BzkUf7OVrzVBAthyxWW5/lPY41E9+eDzkN7
	JN/vfRmNhvq8fUZsGA54ojgRjCu+o7NTYpjZ0Wg3hqXxZ3dH6x0WdY/h5Hkbpvt+H+g6VI
	fSDYCoimV1F6TPc5zsdL69BrTsCmq5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-FCvniTrtOaqsREI815yq3g-1; Mon,
 22 Jun 2026 05:09:12 -0400
X-MC-Unique: FCvniTrtOaqsREI815yq3g-1
X-Mimecast-MFC-AGG-ID: FCvniTrtOaqsREI815yq3g_1782119350
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E79DD1955F11;
	Mon, 22 Jun 2026 09:09:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.242])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AC593001D84;
	Mon, 22 Jun 2026 09:09:04 +0000 (UTC)
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
Subject: [PATCH v4 01/21] afs: handle CB.InitCallBackState3 requests without a server record
Date: Mon, 22 Jun 2026 10:08:35 +0100
Message-ID: <20260622090856.2746629-2-dhowells@redhat.com>
In-Reply-To: <20260622090856.2746629-1-dhowells@redhat.com>
References: <20260622090856.2746629-1-dhowells@redhat.com>
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

