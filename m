Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792953776;
	b=mjN/eEI4saOteBhlHnYAomKsYmq18JuzWXdiZucJVnTVKEq8IX843X8Kje1PtfeZ3ILr
	 ieHaNgvI3QQ1LaXpSIttNZ3n6o4cXptWk4ZZALIAvSeMWDeg0XkPbn0Iy4pyWVo4K/8W6
	 ybxs2nviob5NJNWZPiN4vBK3YPw0LmXyGpX+M9cRf2Z8lfCTmG4FQFlaDf3XZNvx86maO
	 cL39BrTVg5GBLIRO7TUJls0kQVasXx56GitGs6HvTfZbE2RyyJJJ99a99sEIXQJ8v6g9t
	 1/eOx0euDnAfoXshpu9zmDJ3evFMRl7YANEcM+5/9qEEa0MUQzMdFayc+sQRW7nyeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792953776;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6DaWHhYgIwuBxobGINB7MVgdVFMWECs1oxNBivuWWWY=;
	b=u7m8IaKlKduS6ATzEU7jx1r/GIEsAPEEJf3F1ipKlJXCiLZiISFVE6dHx6/Rzb+FvB6b
	 8SsEOnpqInroZm0xDfyR5x9TYw6FzteGp1vKb4SSfqN5UeYVUiuLPtLpQOIahBIZIX+kT
	 zFF1TcXqi9fJNZ7sjNXY1n2oma3FhfB/lUTe337Itk3dyAItxTG1E4UORG2jwCah7fmWd
	 AJZwueNQMlHnjUkyvW0a+jeFxiAWOAgpf+5OjepYBRDrxJU6JE2VFgfTqu//8z/ioHeBW
	 MBsAVjwxBSQSUAbLbCHnw1O9USWdeh0BhIzm9xXzeAIpCJcY6Z6ByQm6QcwYSqN0nzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PWzM30nI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tVnVpHje;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC8606A328
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 18:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFC8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PWzM30nI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tVnVpHje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792953774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DaWHhYgIwuBxobGINB7MVgdVFMWECs1oxNBivuWWWY=;
	b=PWzM30nImfpG/iYmlCpzvUYdOQQmJ4iNaTraeXXtwlzsG1pjPIdrAxO09o0kTImphRedTA
	+RNYSqx2r7jmA5NuCp6P0VCvtbk2BfTsltESCVfx3xwbfifSTUJ36shfqsjJ6tI1w8SAZ/
	dGg+wEtemjMOCf3+6mrmKe6S1hXJPQ0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-_xtqv7o_NNSEx4XwcKK1ug-1; Sun, 25 Oct 2026 14:42:53 -0400
X-MC-Unique: _xtqv7o_NNSEx4XwcKK1ug-1
X-Mimecast-MFC-AGG-ID: _xtqv7o_NNSEx4XwcKK1ug_1792953772
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6ae18a3adaeso2040505a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792953772; x=1793558572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6DaWHhYgIwuBxobGINB7MVgdVFMWECs1oxNBivuWWWY=;
        b=tVnVpHjeJHWyc+4qBdBCZFpyXKtQY4eAqsiMZ32EjZFUTevWDLdNiNvMwSwpfIZGg7
         0wQb9lkF24BqwSHlNZfpqN0jPnNfPUnVpvB08ltclv2mxaLFcvMtqHP1dhyaU9eX9sAX
         7O4z1F26ZAtUPBq+TgPQT+X7YLevSZcHfr94BeZzxkJ9pKMxS2ErMgN9pEbE++DZK2nz
         aGwWuJch/RvcmHsf17XC9mKCzkVMcsphXS64TpmJajUWE04Jl6gN8Vq8Zo6b6VChSUBK
         ooaxB/hv9P4UaA0mY3TzMUiozKiJR2gvM5B3VkkQ3i7Sm6JWmmDwmzP4b6/VcPfRA+Q2
         xxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792953772; x=1793558572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6DaWHhYgIwuBxobGINB7MVgdVFMWECs1oxNBivuWWWY=;
        b=ixWNVmKTHaW8OUigsvJdznYiWER70BzcL7LN0AU4u021tLPvkzFUIUhLvLkjYf6vDX
         vldtK79TOiDKITYFQN3CghxZRlSftgJy3JtdhVDcZF9mNaRILDIaFXlgbppWh5F5MBee
         kVq7Q+CwcULKap+4pvmQB9ahj7EbCf7wsOOT756Is2c7mKKumtcPTNZcrFoWORqkKqRN
         4qZQf/6oiP3js7ZcN7dj8xLkBeLMf7kYmtf55mdZ7T7RGt/HUIgZs/YV0apQs3JCmIyw
         BORLDhxvUX+V14fnY7ytdOCm13r1cXkoQzGceopZKhoLxDAkDoaD3DKRppAaWbA+dsq3
         Qhyw==
X-Forwarded-Encrypted: i=1; AKwUvByIReMqJRDxluKzXtSPObD1rxzBi9S1LQfbahlnbfUNzUeXVojpX0C7ip49QcndrAxHOAzby+oRgPyspgi4@vger.kernel.org
X-Gm-Message-State: AFq9FYIGyaTOTRmQpGAL9nuFhTsyZLiRvCmUDVw/mzV0ezrPu1h0kE/U
	V8ugjsUySKgTjAy5emXbaOwbO/sl+6tu7Auy6zAOuLLMMwiugYfqbGcOy0+ogLfgQqVQlAqm7QT
	hsIy5fOKQ1UMy5mZNsqQTmRAXt1QIVjY+LzwJhwiDEwM1R3R8rVKuTbg1RbCOCymSOjQ=
X-Gm-Gg: AYBFou22s5EIkyleCIlQgkY4uyDeNi9Knct34txRMflwJalC7+ZJdRoZ90k3DmD/Jh6
	5V39w0kpdWUbQKxO2xrxnJQkJScSIuCxy09JKL/g1MMrQAJueeTli8rti9+NZsc98vggXjsonOh
	gYVoctUtWWepzTSx94c3+HJwwWi0MrB3/eshj65piuhk5/26vzqYFE0oUmIfW7EACzFumc9sfiV
	PdCDkW3UKW+oplOCOKeHxdbEeTtbCeS8BnldUrODcp6fBvry9AvzvuabiYYbdAM2IEp4sg8H6kD
	gmHyfNIyzwWQFvDv32HXyBEebvz6eujPoGeEvUjS84r6Dv5a/634bQtcO+h6HnphLV2wPxwOg8i
	+MPFnSLQ0KdiepKgb+G0KpqWKqQUflHFxYsoY0jr4ESYWStyRCQUaNoWMfbVbQVsOM5ycfT4xJ5
	JLXLKGTR2lHi/I0jZ4SaS47gfTfrCpzHYfJWzeE5Xob9QTpuqdQamjXnnsuymdfAwKcEDgm/vip
	O8=
X-Received: by 2002:a17:907:3f8d:b0:c3e:d0ca:d30a with SMTP id a640c23a62f3a-c46be3866c9mr565911266b.4.1792953771991;
        Sun, 25 Oct 2026 11:42:51 -0700 (PDT)
X-Received: by 2002:a17:907:3f8d:b0:c3e:d0ca:d30a with SMTP id a640c23a62f3a-c46be3866c9mr565908566b.4.1792953771631;
        Sun, 25 Oct 2026 11:42:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd66e51fsm230750866b.64.2026.10.25.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:42:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
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
Subject: [PATCH v6 3/5] ceph: add subvolume quarantine wire definitions
Date: Sun, 25 Oct 2026 18:42:43 +0000
Message-Id: <63fbc27fc8339ee0744d4488016d76cc2cc73e08.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
References: <cover.20261025T182649Z.ca9ae7a18449.git.amarkuze@redhat.com>
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

The MDS reports -CEPH_EQUARANTINED in MClientCaps v14 when quarantine
denies a client's access, and restricts that client's caps to PIN. The
wire errno is 1000; the client must return EACCES to applications.
MQuarantineDisable identifies the inode whose quarantine mark can be
cleared when access is restored.

Define the errno, message type and packed disable payload, and add the
message name to ceph_msg_type_name(). The quarantine state and access
patches consume these definitions; support is advertised after the
cached-access checks are installed.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_fs.h | 13 +++++++++++++
 net/ceph/ceph_common.c       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d70bbce1a1b2b4ffffebe896ef46eb6853ab354b..5afccfa891cb045e9784eda1cc4741749aac4c06 100644
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
index 67e88f30409dd3ffba9dadb6fda529f4101d830f..cc3d21fd7d5bf251bd58ce19f8c7d8a5b02fa1d7 100644
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

