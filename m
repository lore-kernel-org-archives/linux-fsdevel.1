Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B1C22F767
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244438; cv=none; b=J4VueHVeJSx9OZXBgbB9waH1E0EIg269S/DzkfvbmzYGwIwDO617Yr474y1KPIVu9PbXfFgWveP2PJFKw3h+ipsVS0ENTwyJT3c76sPth1M9ABfiCHDxh1n+/kxiFbOs0Pp36PZI5Vs+Og7olGAg60I8okZFmsx5almXrxWIJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244438; c=relaxed/simple;
	bh=pwOQdieYZCRLGlhC7xNMLdBqVcBUb45jf4HriGAEWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YuZbgBAsG5nJ+WV0JXznGOrwq12zR9ZcOzyKgh/zwyi0zXSI1JbOIwLQarled57htnXvUFwd3FYPs7geHnLkMuHD65wtG0LUdXyz9hg5lpIME4Z6sd7bQZ4MHbUPVG4sAGXIJOaF7b5LCXineMKneVyEiO6MLGaomXGqMDuMpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ABeJJqlR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ptFogM1k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABeJJqlR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ptFogM1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
	b=ABeJJqlRvI1Bp22ajyUo2nFsmknNNBhFUpmafN6W/2vW1W0QmAwSWXns2GPF1f14TDgskz
	9w5NupksFd+vtrfdMJ/c6NGzUlwxkSRP7D4GfLYfbHJGf86illgc9cxYSzT7y/Q6K4KFGy
	y4prFkmceREmkkjgLRn9Ym+2fTeJM0w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-oIHMxnlkMXC-LirfpgF5CQ-1; Sat, 17 Oct 2026 13:40:27 +0000
X-MC-Unique: oIHMxnlkMXC-LirfpgF5CQ-1
X-Mimecast-MFC-AGG-ID: oIHMxnlkMXC-LirfpgF5CQ_1792244426
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a9b7e63963so890392a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792244426; x=1792849226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=ptFogM1kbiKYTR6g87alqOwaBtpCawMve+h84MP1EZ5sxruU0WWtXqc4X0U46K0Ugo
         rDRp54jXTNpHwnRD7JIdoO0ZhJT3Tf4y9iNf2Tj4dem1kTGQhxtOnxriV4DxMwiLxPkt
         GrrkXA4Whzoz3NmDfbLMAq3btkM4fZHIJy9ECgNnOd9GWN18SQtQO5MC3pzx0w2g9g2x
         T38U1vf1Rg5DVP+gHdwlexdcItM+v4VGDmekIgic946W+8P9AhD0AYCB+H2qmMBtuPQN
         hG2hIVAgKN4Ym/z/kMmOaLBeJjvXt9flUPVtQXTaj6FIorye292lHcFwI8bHNpxLRMR3
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792244426; x=1792849226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=l+VTcLKy9qn6jU2jZ1OJmKpDnkx8hLy+e0qJ7ks2riZLnvlox86m/A6wuUXaXoQltt
         A0bnpLFA+b/0i5B8AsPQMJmNz/DBzD4yeGHOR85a1MeCC6XqDX6cUM28r52bdfl8Bnwc
         fd63Ic6pcfB4tW1twWTeblmVcAMqSqlqxc1whD+UE0QWWWR1zRuA7Z2A2x2A4TfTuYiG
         Um+eFUzhKxYDzHxdRaH/d43tp7r8YdNecnG0ii3E4R/KvzP/Kcs0VrUNkIuvtky1eeOt
         awGIfGCd667cNa8sH+WANMjeYJwHqpv/e+LY0ywhPpVxzHNDrq3PmUxisbCoJqxEcoI2
         wQ+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxyVIMMIOiwjJEC4MNJNtRdZYAaRKFUQwZOPiQBfCsyIJ7xh9EXZLv1A4u4fMk7A9ElrEWWDzMeRRIjeySI@vger.kernel.org
X-Gm-Message-State: AFq9FYK64FebDNwx++mYITXwYe6D0oc1wROme45/RlFryIbITZPejzQv
	g8ZjQ4f2NYhQB9ZXQ2qaevMQPXZRJMPnNk/VRVle4TWq8JmTDMIZIp9OFuOmcIxu3L+63RQ2/MW
	ZksyMuMnwvYrTmT2e+SEvUsAJk1zKG0c51hw7BLtmRaOYC5KE/Lwv45QHiTD5WhiuKPA=
X-Gm-Gg: AYBFou3VzZUorvx/rhfKoH9Ht2X9sJwXPmcGSS0B7Os7I7wnv/sQaS72ZLPgHPIgmID
	8DzDoqYiZ9V8H9n2Va79JD6hPS2GA8dLojh2E8NBUdagrFdWb/oAG8fiizXJGxsSQTiLkQ9H9g+
	o9Som+ehIy8GudJm8mgvWfJ+y9yBXwrgh1+7TTca9MuAgUP8nPxrsvao9ueKqMU4AOUTUIJeiCs
	687VFkj+KNm7uDMdJhWeQgFMp8aPfNnSixHH4XliPK+OPbXF6+UdCprmL5IuEHno1JTftvjV2pA
	5lE1Lk1UPsp08G6+1bEXYFqUUVwMl8b+GxF0WphcVGy/uSitebTLbCTiBMr//cLXw+HT6sir7K0
	VPq/aMYjm+90XUWq6dKw6Zzp4BuE0PszKT4QOMtJZA5zut0DKU2Ph9rER9AHqoqIjkppIPugosM
	8/EpaKSl+IvMke3KLdMguMOYrqf8/ZmveRXAfKaXSXKQjn7Px4GOaQ1+0qKF5RiUro+n8zb8Fsq
	vk=
X-Received: by 2002:a05:6402:1ece:b0:6b3:bcb8:8afe with SMTP id 4fb4d7f45d1cf-6b3bcb88ed0mr314075a12.43.1792244425854;
        Sat, 17 Oct 2026 06:40:25 -0700 (PDT)
X-Received: by 2002:a05:6402:1ece:b0:6b3:bcb8:8afe with SMTP id 4fb4d7f45d1cf-6b3bcb88ed0mr314053a12.43.1792244425039;
        Sat, 17 Oct 2026 06:40:25 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm1913032a12.10.2026.10.17.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:40:23 -0700 (PDT)
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
Date: Sat, 17 Oct 2026 13:40:14 +0000
Message-Id: <cb850797b3efeb8f2a911779098bbaf0187e87a9.1792241577.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792241577.git.amarkuze@redhat.com>
References: <cover.1792074165.git.amarkuze@redhat.com> <cover.1792241577.git.amarkuze@redhat.com>
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

