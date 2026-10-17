Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C37D4915B1
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248531; cv=none; b=tf8MzRUxTyADpdaY5bO094CxhN1QT5G9YZT4btl8lqCTP/j7hVvbI1Ns4p2EdLli0VA07wDiXLJwOLwVeiTmKxcNZwuNp4Hmz77dmf6eDQ48uyb46FBFdnzeDpLZLNiCzvY7GK4MViKfwtOdpu0xcqnbYT09nsXTDT8gqa6RoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248531; c=relaxed/simple;
	bh=pwOQdieYZCRLGlhC7xNMLdBqVcBUb45jf4HriGAEWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZjZXC5RzK4NwoQE0k5YIHO0QcszKcwL7tUpKY3NrovUdxwM7k1UyvCn7dC2z+KH+wfNAOE+D2+M8IittsQ70h5GGxemG46J6BqSaMl4Hp+rzV+vLyhTKCYtnbBvPGIoiuPOGiang44CqDCIpghOuAe3251F30O0Ws+j0RFiio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8MF7gx1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tqPUZBsm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8MF7gx1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tqPUZBsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792248528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
	b=F8MF7gx15OuvnNoLhhflFfDFfxRYZ82e+28hhKMb+J6ATwFWHIjK4Rn8knf4JfOXuJtQof
	7iVgUntpnruzPeORioHQ8nnCVgNyhuII5x2feQQN9m98Wpjqq8CaRTt2xJgD9CKiwqwqkC
	AA4YtA7ClmIIWo8DUUSN4lAglm0qJok=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-MUwngyugMlK7iopKGI3OkQ-1; Sat, 17 Oct 2026 14:48:47 +0000
X-MC-Unique: MUwngyugMlK7iopKGI3OkQ-1
X-Mimecast-MFC-AGG-ID: MUwngyugMlK7iopKGI3OkQ_1792248526
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c40aa03ded8so83055166b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792248526; x=1792853326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=tqPUZBsmTg7aJJM6/5CjWQmiC251vJXik6dXD5PdGMhJPNmeid4yIA4EyuhKceyPBf
         WnCCPYT3Fn2rS1zFRORKUp/+WEirMLtRGcI1z37Io8bQHpL8B47OoPRhoaEFO/+yTLgZ
         sPjIBKoxW+8qpOm2aUkzrrldoMA55LK5M23yuwPkZ5iPpFEpfOoYQCXOczcL6qG94CsS
         EIObTig8uBesGxWy4yrQBEm4LC9/wt6lm3Rg+W/gjQMpFFddOX71LOEzog5VKFZf6TRs
         Pe0fStoRI43jzQpOZNCtJF/ndxYnmhFohA+MBVOJSflm+Jrh7EzD2a/uha13Fr32lvbH
         Vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248526; x=1792853326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=lVBK9XuHxTjKB5l/uh2xRbHYn9RNoFetGZVFlSX31L2iS6wnH7IM/Riy3DsXKsUvdM
         buHUam78K5SxjS/5QTNfYFDTH489OS+boPc2DtRCa3ckL2XWgkRmQlMAxSVpgXFcvzqd
         RZQW0fXgct9Iq3kZ43A9GT4JWVz8WCu3AVv2/c57Grl5QoPkzXwBbJZPBOWG0M+2DP0X
         f/gGJE9hENdiK7DOjPCyBGmu11Osj7gm9D828lzfcKzVE0PqIVM2hYpKLQJq2rmf/BIq
         Lhgo3ng5svpfoYT05AR70ZaJpPip7Kf1dxlTAsBaqpZ23awYX4AMD4WxpLCZ4nGfne1/
         sujA==
X-Forwarded-Encrypted: i=1; AKwUvBzFymHaK92o/xlDYW1JBbY1YyUB9nybpsMFlz/wWmRrZmgon5qT4RTbnJEPF3dKn15Dn8Ra1/7eVIkXH18s@vger.kernel.org
X-Gm-Message-State: AFq9FYK3P5ysBmRBm7kDk/LPTM1SxD3NE/c71Hgp6l02DG+9MDZoBbl+
	xtT1NMJ8QmhA3NTvPHSY7WS9Bh+s+DK2Qvtj7iUAn7j6CLNS9KYga4HqedDAXsoibQ/kZ3eQQeC
	mep6snHAZn7Z1L1OZIulxhrZNQoTHHo2eHvs0vaTX/97ZtBTM36ccuSzOdKDryJuWlXk=
X-Gm-Gg: AYBFou0k3FLscVTntRJrR+Izb+k9wier+BiaMh0J80orkm905a1/bQ+q83hNbY+09XF
	a5pUbxYcewgkK/n4hjtCP/EV8pnWx4mf13M4al46ZLqTywQYogqz8ag7lq5yum7hqjhqqijUco5
	2sYzYuKokPpHFZctjhxu3wv76LONkiOl/lP+jbHL2q6ByufyUWrjE/2oO1dwm0zbfH4DYGr9bM9
	VUPj3Og898xnpaYF0NIRj+FKyOxNRvSHluNuExkaTyBKk1SLb3l2PYpTryKBnzsnFapEXAPgHe7
	/VpTLv1LRhlG/uQvOgrKecXk+fRn/v5ty8us7YcPgrq3DIHyj0wWUoEpEnKAvtJJBQdXXRil9/+
	tCS1TQG5berglKSX5+DdqEj8ERRARbiitRdNUuwsjJ0RXnAP4Wlpf7WuvRwGLMQOpJkuGb87ft4
	jJ/UGYb/rCn9GBnscdgQ797zP9Sd8PnTORK5SO65wGWaf2UKd+9bh1+G5yCrtR8S0cPHtQ4gnww
	yc=
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c419e0372e5mr222274366b.23.1792248526257;
        Sat, 17 Oct 2026 07:48:46 -0700 (PDT)
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c419e0372e5mr222272566b.23.1792248525896;
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32878bsm181645366b.12.2026.10.17.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ceph: add subvolume quarantine wire definitions
Date: Sat, 17 Oct 2026 14:48:37 +0000
Message-Id: <cb850797b3efeb8f2a911779098bbaf0187e87a9.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
References: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDS revokes a quarantined subvolume's caps to PIN and reports
-CEPH_EQUARANTINED in MClientCaps v14. This wire errno is 1000 and
must be translated to EACCES before returning it to applications.
When quarantine is lifted, MQuarantineDisable identifies the inode
whose local mark can be cleared.

Add the errno, message type and packed disable payload, and teach
ceph_msg_type_name() the message name. Advertise the session feature
only after the client can enforce quarantine on cached access.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_fs.h | 13 +++++++++++++
 net/ceph/ceph_common.c       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d70bbce1a1b2..5afccfa891cb 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -154,6 +154,7 @@ const char *ceph_con_mode_name(int mode);
 #define CEPH_MSG_CLIENT_SNAP            0x312
 #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
 #define CEPH_MSG_CLIENT_QUOTA           0x314
+#define CEPH_MSG_CLIENT_QUARANTINE_DISABLE 0x315
 
 /* pool ops */
 #define CEPH_MSG_POOLOP_REPLY           48
@@ -921,4 +922,16 @@ struct ceph_mds_quota {
 	__le64 max_files;	/* quota max. files */
 } __attribute__ ((packed));
 
+/*
+ * Cap oserrno used by the MDS when a subvolume is quarantined.
+ * This is not a VFS errno; applications see -EACCES.
+ */
+#define CEPH_EQUARANTINED	1000
+
+/* MDS -> client: quarantine lifted for one inode (ino, oserrno). */
+struct ceph_mds_quarantine_disable {
+	__le64 ino;
+	__le32 oserrno;
+} __packed;
+
 #endif
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..cc3d21fd7d5b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -83,6 +83,8 @@ const char *ceph_msg_type_name(int type)
 	case CEPH_MSG_CLIENT_CAPS: return "client_caps";
 	case CEPH_MSG_CLIENT_CAPRELEASE: return "client_cap_release";
 	case CEPH_MSG_CLIENT_QUOTA: return "client_quota";
+	case CEPH_MSG_CLIENT_QUARANTINE_DISABLE:
+		return "client_quarantine_disable";
 	case CEPH_MSG_CLIENT_SNAP: return "client_snap";
 	case CEPH_MSG_CLIENT_LEASE: return "client_lease";
 	case CEPH_MSG_POOLOP_REPLY: return "poolop_reply";
-- 
2.34.1

