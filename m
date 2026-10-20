Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528028;
	b=BrGFK+IIughnCAGfbZWayHGY6ATjaMeA4LxHDiG85J1rqinyR5WhqoAZ9ctmlNj2SNCq
	 BZqbibF0n3Bbsijyx5ZXMgnE6jOd74FMnNylUFERMxq8a4xuQN8wfzG/OgIIrCpgM4ycl
	 3mreH9cfdSJYlxVflbeW2fYzcWQFjN5u+NrYug2D7d8nJS06Nhr2JHfSHwHJRCN6I5h3i
	 CthPGcRolelWnvlBKfoGjEMHcCx6oeiS2xBk12qVkFCv6X35S6/JDwJUOPcpee00KK7rx
	 pJuCFGVsadif83C7Sp98m/8JaU4cVQhpRANo/O/JigbFv/orZHr9mFrRX8AfQkWmhuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528028;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=cu+42Da90Ef2p6ZoxjKe3CJjvCoNmtutwunZ5bfm0v3ViYfPv4DKR6EW4SdG+r4Xwdb/
	 oU9/YagwgNnY9pKiYaiI9CX7F2HqQckUhQLF3F8zZffh7w7+0t7l4g4tahJPgU2ZYhqo/
	 NPFm9gslQPH7KmBvU7qorrUqz7EB9OFtS7I63PVo+txEAdFby+l+1auSZkLP9FTLIvv5y
	 QMxSk+G8xGArWrI/vYLfXuU4dPihgbqSF51bd0X2uBxxueEjjHZXmdDY041UQijt00khF
	 BWgt9KXOKlqQSb4SuKUmuU4WKx7+lcw31ZwAkfNwz8Khan5xd+Kg3QG7r9yqwSQ3OUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KjBtcODc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="PL/TEgYt";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2B606A338
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 20:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CD2B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KjBtcODc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=PL/TEgYt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792528026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=KjBtcODcs3nJbggHw1XV/8ddKA0OuoR/A+XaWxIb2b6qan+KpyY9XPePiqE6kMhOW5t+vg
	R+jTM/uzSLYD7P3LvtPQeoukMHwKhvE28EyWQEcBwiL9p29FI5PIgQ8+JhPgXUWsbF3+qL
	pK/s/hNP7yWbjCDT0BIc+dg6742FV9Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-uOgSTrJrMJypy0P7vdBlrg-1; Tue, 20 Oct 2026 20:27:05 +0000
X-MC-Unique: uOgSTrJrMJypy0P7vdBlrg-1
X-Mimecast-MFC-AGG-ID: uOgSTrJrMJypy0P7vdBlrg_1792528024
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91b994cb09fso1742976d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 13:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792528024; x=1793132824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=PL/TEgYtsmpwVYabHp5Gzx43TyRxZDYQcCFL6E3+JWQ28BKDj+fcpOM2mbzp3c9iYI
         4A7nmVWVPyaFXCCjN64EhkEDJUPY8Y3+8UYX2oi0T138zJ+oJKTJ60oa+7G4gq+/gFv2
         w7t311vSmLUwyicxUw69U5Mdofu/zeGa7Zodynn7HZHSwn7hFGI5mrhBHMBpi3cfrU9P
         OiNSIJ6EZwO3COTcmZPWIeX9MYf0UE/Z5B4l7kCH2PNe20g5E3Wfixy51wt6VaP0eVSK
         Orka+uKEqSQHbDlPRJ8LDHc+gprL50vyYloeRSphPxAMwez3YXxzqJgqaoL/g6OydAxT
         rl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528024; x=1793132824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=k7LzqFgJCnJuTXhCNQY3nAxh1uvGsuBbNUOlLEBVmlAhgTteLj+/Fm5fQdeDZ38cVP
         v5qhhRSVrRQmOKTZFghUAihEXP8z6DVJNtTgsIW3QdsV2Pu9JpDy35HmNIeJ8A/07k5g
         PeUS0oYm+pb4vI682u8UbjZBCR7FkNjwg4qvoqo/KuAuC/NCoFMKGcjLy4DVu3BLMUP1
         cuHHAWTD8dHHGZYKgWTwDS+CD6t4OhT0ASaK7LEp6jCQtlIb8i2wDt1YuHkuRNwJ73XZ
         4vlY2iCYgSZbciwomYCKbKmoOvMYrtYWzuQvwHkzspF4PhAxHCytb4goF9EhBlsLiKuE
         Klcg==
X-Forwarded-Encrypted: i=1; AKwUvBxfRhiWP1rUgn9JGna6PVJTkz/gIDogRFXBN9uRwo7hIZxQ0P/+zYH131x0nufppHkuE1a7MbgHz6AUUcRP@vger.kernel.org
X-Gm-Message-State: AFq9FYJiaqxHiqzFAKrbLlYaAGth2i3AMUgWlmtmbZLwBCwB0MONBLpp
	S4H/ycSWRcNXJGppwD2A6q/iGfm7Lcm4Lq24oFJvpx1l4Y96vlT8bKUU2DywNtMbQVxLFmC7fsV
	SdgAXkxfLryG1fMg/xSgeLtKlFYLLJRhP8hGagvhI6sTKheVkNaYTpMionWyyqvQeuYQ=
X-Gm-Gg: AYBFou03W1HvxLKyqSg/a+z4R73GFeiBJ722/75fgy/pT7luRyduyo8yFvKdFIflyGe
	jh14/bZ26oxMo1hFIMcBa8sCfprs6f0uzG1nOxSd4WvldR1ntHyal5JsDTUJmbq5i1ZTWscQFk+
	zNntwsAsYrsJ2kUoo3N4TEI3kdWEaDHpkwcBBLsvY5FMFLz37fkkeZG6LQCfnV9pOnEk0jheG7W
	ScUePFChQvOCXzGVKS8FvFkSzQ4Dors6fbwy4SubOn3yZXOC9AUkHg6ME9D5Xomx3np5M+KuFXC
	vK4X4YuIpM+mdQM/WnqzGMSXnuIsRyYdXZaaP02DILljhBC9V3ppTO2t7UR+O/WHGmacfCgiCPg
	MZypxpg3V1NVoEa7qcL8DAbUZdnYUre8kcxARFzS2lYdtjW5LUzoulBKe8JW2aRreGHNL7I0oBW
	TCiGVtjfKWTCFTQbR9Yi2htEAYp6gAkieFrXecMKx4gEwHnNeo+UGG9fBJycfJDlbYyP3AgKYD9
	WA=
X-Received: by 2002:a05:6214:8414:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c0305a95bmr51463536d6.31.1792528024198;
        Tue, 20 Oct 2026 13:27:04 -0700 (PDT)
X-Received: by 2002:a05:6214:8414:b0:91c:305:a955 with SMTP id 6a1803df08f44-91c0305a95bmr51463206d6.31.1792528023567;
        Tue, 20 Oct 2026 13:27:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm7461436d6.3.2026.10.20.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:27:03 -0700 (PDT)
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
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/5] ceph: add subvolume quarantine wire definitions
Date: Tue, 20 Oct 2026 20:26:48 +0000
Message-Id: <774d53d774a44724c2ab8876a28cf51247bcd0c3.1792527529.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792527529.git.amarkuze@redhat.com>
References: <cover.1792527529.git.amarkuze@redhat.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
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

