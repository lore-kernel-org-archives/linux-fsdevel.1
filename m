Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECA3D6CCF
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781768966; cv=none; b=Ji+76vuafC9K0wENPZwDX/ikZ9rUC2HFtaVh1a1Gteu8GZEyc9LPpsqF9FeSvOixn5Wx1xzWNBA5JEYCMn02sb8YTZjna7l7WwIY6qgrgOq7Isxq90HOvojayeWFz94E1v3NUh2X++k4N/QKs09ZOEI1JQ1BLKCfRJkw0pv4fE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781768966; c=relaxed/simple;
	bh=5RJ6eiIgrQbHS3f0m3cyvgeCO0KVe9moitLn3vgds+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRvAfdxpvIHR/oYOpeLb8glaXvZrn6MIfUS738YRHtr9/XW8fwzpodphAAm+8UlJIg3ZK5qIGki39RFLXdkI+AwiHRhcou7/rMp0VQiyTavdbXbPVYXsf/cxf3qi0qlasImb/Gpjbdyds9IUejX67nhHbSm0HKbp7OZ9dCV8PX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b35dJv71; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b35dJv71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781768964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAsVS8agY9JmTA40Ge2IgO0QMtWkhH47Q/93WbUEoqc=;
	b=b35dJv71yDd1D4j7epIL5HfDCaxUJgG1N33kTWQTBc1qnR01Cc1pc8p77noDe2Ent3ImcS
	O5HLE/Px15hpGtwWif+cCX6pNPgzTU1MRreRQJ3nJcwOLeOqqdg10j31Enqgx03jmJWRNV
	9H0L7zSS5jzCOZdnE5yLbq7PdB3Ep6Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-MaJmAvmLN3WqAm-sV2o76Q-1; Thu,
 18 Jun 2026 03:49:20 -0400
X-MC-Unique: MaJmAvmLN3WqAm-sV2o76Q-1
X-Mimecast-MFC-AGG-ID: MaJmAvmLN3WqAm-sV2o76Q_1781768959
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 721B61801BDE;
	Thu, 18 Jun 2026 07:49:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3E69630000DB;
	Thu, 18 Jun 2026 07:49:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 02/17] afs: Fix error code in afs_extract_vl_addrs()
Date: Thu, 18 Jun 2026 08:48:45 +0100
Message-ID: <20260618074903.2374756-3-dhowells@redhat.com>
In-Reply-To: <20260618074903.2374756-1-dhowells@redhat.com>
References: <20260618074903.2374756-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Dan Carpenter <error27@gmail.com>

The error codes on these paths are only set on the first iteration
through the loop.  Set the correct error code on every iteration.

Fixes: 0a5143f2f89c ("afs: Implement VL server rotation")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/vl_list.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 3e4966915ea4..003889cf0f18 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -92,7 +92,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
 {
 	struct afs_addr_list *alist;
 	const u8 *b = *_b;
-	int ret = -EINVAL;
+	int ret;
 
 	alist = afs_alloc_addrlist(nr_addrs);
 	if (!alist)
@@ -110,6 +110,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
 		case DNS_ADDRESS_IS_IPV4:
 			if (end - b < 4) {
 				_leave(" = -EINVAL [short inet]");
+				ret = -EINVAL;
 				goto error;
 			}
 			memcpy(x, b, 4);
@@ -122,6 +123,7 @@ static struct afs_addr_list *afs_extract_vl_addrs(struct afs_net *net,
 		case DNS_ADDRESS_IS_IPV6:
 			if (end - b < 16) {
 				_leave(" = -EINVAL [short inet6]");
+				ret = -EINVAL;
 				goto error;
 			}
 			memcpy(x, b, 16);

