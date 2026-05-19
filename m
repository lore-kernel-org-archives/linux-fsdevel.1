Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28F3A9D8B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186170; cv=none; b=JJczEZY1eRFMONBrxqkNnTPhjpThp0mHe8qkZmZW0uXR6jfWBeOWhGkcftq57Ipojr9JPSTR3qBlRTwDsDas7STrqCSLd9Qzf2QSBxHx1+bqkpZvJIHhBlu348JIIY+PntAsoGUFT7mtsR4oNgWCjbdQZVyR3V3Vnf2ArOowNJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186170; c=relaxed/simple;
	bh=6843LSSseiWRO/YvWwqFfuLv8LRbTBdUlgClovCTzwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opmQgpP1tmkDA2WDTH0tdXAd+aOXVq+vTlI8RG6A/Tu45Jt3V/KD5M+S4/NRn9ANBUQzyUCoJwD8OnsMATRBUN8DTFGiu/dDaba/W2YjbuuNT5CvOuMPWUjgKpbzqjUC5ddsd3+rAlp0QlMdGjnCyv8JssR/+zSZfKeXwM2Bt/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAt2hheA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAt2hheA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779186168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sk/NPIZ4bepOiAna+HLp59qWh7ey7IGZ52zhJvITmmk=;
	b=LAt2hheA1/P4Y8aXcCYb1Q7AdvZ3OAPSdDtBhiVzaMUYK6xbV+aYAsszDeCHt04M6NT+Ma
	VaHOpWQdWA94u1LvfeejRVTp8hauShH2jBwzzlYf0AP3BNo7a+WnpE8Tw2jA3HJC7WhYvS
	DoHXXwZPJ9Hp0XPH5zC0aw9/19zJ3lE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-8ZLrb77vOyydf7DKO_Y6gg-1; Tue,
 19 May 2026 06:22:42 -0400
X-MC-Unique: 8ZLrb77vOyydf7DKO_Y6gg-1
X-Mimecast-MFC-AGG-ID: 8ZLrb77vOyydf7DKO_Y6gg_1779186160
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3B7518005B8;
	Tue, 19 May 2026 10:22:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71D9D1956053;
	Tue, 19 May 2026 10:22:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 07/36] cifs: Add "Has dynamic part" flag form SMB2/3 StructureSize LSB
Date: Tue, 19 May 2026 11:21:25 +0100
Message-ID: <20260519102158.592165-8-dhowells@redhat.com>
In-Reply-To: <20260519102158.592165-1-dhowells@redhat.com>
References: <20260519102158.592165-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The LSB in the StructureSize that follows the smb2/3_hdr struct isn't
really part of the length, but is rather a flag indicating that the
operation structure is dynamic in size, so define a symbol for it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/common/smb2pdu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index aeb0a245c532..dc5ec2643669 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -185,6 +185,7 @@ struct smb3_hdr_req {
 struct smb2_pdu {
 	struct smb2_hdr hdr;
 	__le16 StructureSize2; /* size of wct area (varies, request specific) */
+#define SMB2_STRUCT_HAS_DYNAMIC_PART   0x01
 } __packed;
 
 #define SMB2_ERROR_STRUCTURE_SIZE2	9

