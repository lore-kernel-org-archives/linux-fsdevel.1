Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD731D372
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797968; cv=none; b=GStY/qeGNYUorT64lYA7xP5eVH+cZBVm26mSreB/SCylBKPF5OQe/ITlLYpyRWWDM3i6jA9IfuK3dVwAJiyEfEqf+dvvfdLZLUGHubDntFfn+BrUCoDsH6wugP6qNAtJa021w47mQQPd54Gw1q4AptSYYlVWBOqML4plLDFqWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797968; c=relaxed/simple;
	bh=7HWvW1/Gzg8CtTGgN9Xrd5C+91FhwGE8Ckgq3W/SNmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKbSmq7+Ac5BY46C/OBeoq4rKBlRRR856Ajw9pJ+AfoAdznI2vdZ+7MTjVgx4BM7MiyJazavqoVwPyZZ2ahMkI1u0JBbbmil+xLm2WqhcwkZTtygCnro9vohOiEYiIK7zLT1RZO3uLvgYXWMmrCPn/Q67exxiizKRzfrUzhK15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVpUY6ZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVpUY6ZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781797965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WpWGh2RkvMERtuFWMD+GKvljNRdbEH4YvY5+n+DOWRw=;
	b=YVpUY6ZPoOA9iqpfklMNCw2kX1dbqNEpzyVlJ6SsI4C3r9SbO9qJc312r+RFYsBp6H+KyQ
	Lo8rdfSwQV7KTqqpxIArH/dF3rU57jT/ZjOIIheWyzk9z59K8tg9f94sZMBZDN00bctPCr
	sinfDKjZynXnyagUfNZlw6bBmWWF24M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-Aqlkv4_7PcmyUZZiDT7BIg-1; Thu,
 18 Jun 2026 11:52:42 -0400
X-MC-Unique: Aqlkv4_7PcmyUZZiDT7BIg-1
X-Mimecast-MFC-AGG-ID: Aqlkv4_7PcmyUZZiDT7BIg_1781797960
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2BE71802667;
	Thu, 18 Jun 2026 15:52:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC4D71800675;
	Thu, 18 Jun 2026 15:52:38 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/20] afs: Fix callback service message parsers to pass through -EAGAIN
Date: Thu, 18 Jun 2026 16:51:32 +0100
Message-ID: <20260618155141.2513212-14-dhowells@redhat.com>
In-Reply-To: <20260618155141.2513212-1-dhowells@redhat.com>
References: <20260618155141.2513212-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The AFS filesystem client uses an rxrpc server to listen for callback
notifications.  Each callback call type handler has a delivery function
that parses the incoming request stream, and this should return -EAGAIN the
last packet hasn't yet been seen, but all currently queued received data is
consumed.  afs_extract_data() does this, but the -EAGAIN return is switched
to 0 inadvertantly

Fix callback service message parsers to pass through -EAGAIN

Fixes: d001648ec7cf ("rxrpc: Don't expose skbs to in-kernel users [ver #2]")
Closes: https://sashiko.dev/#/patchset/20260609081738.770127-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/cmservice.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 263c60c811a5..db394f101fc6 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -334,7 +334,6 @@ static int afs_deliver_cb_init_call_back_state3(struct afs_call *call)
 		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
-		case -EAGAIN:	return 0;
 		default:	return ret;
 		}
 
@@ -456,7 +455,6 @@ static int afs_deliver_cb_probe_uuid(struct afs_call *call)
 		ret = afs_extract_data(call, false);
 		switch (ret) {
 		case 0:		break;
-		case -EAGAIN:	return 0;
 		default:	return ret;
 		}
 

