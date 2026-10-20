Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500775;
	b=s/krAMHmDaSI5yC1tPaBwnDvkUY7TF91zLLVlynCnZz2EKU2c7+rA7jxlIy/aIu+MsUe
	 jMH2J6nxNFVRd2Wr4bEVkNbjBrkClMY1HCMX/ePudwgn30W3vehJq2O5azv/B7y5O0IGj
	 r8iOEhUNDI0FgzkpjDrroJLK+YyP/KLWzPe17lrhwDrV4u00EreieOkgWrzBWcXF02eg8
	 6NWNDA8GZUHxRCx33xhXWuoeRlCiltMX+Z+3L5hugukgJ/uvPm3MlNk6FULDOn/H3QAoK
	 R2HiCImhNATthKIybhBnp8xe3Nd8/rIj1n8un9qVrtsoDdw0XssDS+x9a+5bWO4poow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500775;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=IlkUkrZo+Y2T6zODlAPXlJvD7NHb1Iu/EUdWj+v+xadMM2VKzyUhdE6RN7vPWaXiomFi
	 dgNHlsTXsFqkTuIjUtvcU/htKqRamGvEo6lQeQ0eY41KxP7XDtDjvxMc9+NwZ+8UuwNS/
	 wob7PYAM2K8bvQJGmnLInrx4VL6LDmaUzn4huyTgtkYvAdvBQnHGXwk4Xns0gz9HjMqE5
	 FwwDukaN0XZGfFJxD1sALr2/nza3UPyBzyrFxXvSdR3ocO0l4y7KdLjRVyTdjN3QvprEJ
	 J3yGtSIGSQgLHSFscQzSbXWOhmKMthxwWvWijs2k5ct+ZztnnnFD1VbsIDh6WV22blA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AIRbyDMg;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sxz25ht1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACD60A4AE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7ACD60A4AE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AIRbyDMg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Sxz25ht1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
	b=AIRbyDMgFs8gQUI1dozxPyp69PxHzHOHoR4kPICAHPEzPCcuqtMojb3dK9Qsyb0f6ReKWn
	rSzLdpcYTZh2u4hmEzKeI/ZgrcbiKcqCW/Hfoke4sRlP0uZERP/ssVfKCs4oc4N//epb9k
	rLSzRF+8gQc5+RbnTNC0nMDB4FBoXt8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-4_3SHmgRNMGmy7WGaE0kmg-1; Tue, 20 Oct 2026 12:52:46 +0000
X-MC-Unique: 4_3SHmgRNMGmy7WGaE0kmg-1
X-Mimecast-MFC-AGG-ID: 4_3SHmgRNMGmy7WGaE0kmg_1792500765
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1d818b501so3604372a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500765; x=1793105565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=Sxz25ht1Di0z0S0fBCiVHyEB+3U8FDm7nOw6Dp2jL7y/hbR6XGpeZLHl4bYl0D43KI
         tAnRtDQYY3auDzClqzE28MPikFSPaYWUMQJENFSFBcmqt4Fhe+mx0Uolc2+nhLW6B81g
         fiTiHFeYs74ZT+tYm6/6pV9vJE6yKouKnm/NSZlkDlQhDL98LqrfbRc1GQ3kjcoBvbPh
         9hskZZD396IG0fWkb1cp9u+MCrQCWMPmQou0fj6lr5WcyTaWCWShgY3fZk60RxbPZULd
         OFdrcP1TBpDVJZNLjDFkgykxyQ1Cit41kDMdhVr9mvia6KqPTGUy+wFQygToifbBaTAt
         I/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500765; x=1793105565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/eb/I1d03/gtpLIJJSwv9VD8j2S7RruxMe6k1xmmguU=;
        b=RLOrRMyDWdQT7asK4kbsJhn7F9K3NrFw7/j/KmZddcasiSvKino95Xhm7TUSlXN1yM
         WfZjYxOXxox7QKXQom73k3UeyEjZ6X0n9DQWr0Rij9ah4BrcsWP6FCMKo2VVpAnucSr6
         MS3hcuV/9d+kcWrmUld3F+CT7tT1AofA0xswoSTBsrAs7eTAK+6ULxrbx9OLDrAwBfbI
         qD27x8Cz7iLc2q0oXthXk3pLEBUNw5Oq79nXFP7rBpsasn0w9fim8XpWaakD1cpzcZ7F
         3vGWRCfTAFVTNHdPNIofN+OteK/dS/TFeAJCQQF8A5yr1AYL+2F9iGkpzCd08dFkgizM
         NIGw==
X-Forwarded-Encrypted: i=1; AKwUvBzVnPFm2VJ+X7F9oYOUS73MsUuPB0fs9x93+1mV3ppEymS6s93k5A/uoYkmKJRg2dbxPPMM7Zap0lVDMy2m@vger.kernel.org
X-Gm-Message-State: AFq9FYIN27sqZfC4DrOqpLOYd0BOJgEdZzEYSVw+RNT7lt041G8pahji
	C7+BH+2xlfMgHW9tiTf4Frfi+4p/Nj2lIJzC4u196xMpqy7o+eFsL6ldpYg7gYeU04BpSB2tftM
	dmoNZrmC6Mm3md6mr8LahR2Lwv1sLZLIWyRbXW7CDIed6BMdOx/a0H0qJI8O80REqX7Y=
X-Gm-Gg: AYBFou0bdXXC3ofDIdWsH/km0qDZFxO4gBIOnfB/mfcvv3HEwbIAYgE+X4oQcuEfuMS
	a2Haw1CjXV6k36J2zcQWhNLOyQLZWHHlfPxqACJnYqLr4cNB5XR5bBhvY9dxDW2aA5lwLyaNofu
	IcbtOBsmzfEpHED3Z+2bH2U5BIxWEvrKnhJrqN7y8nhVenF5AtNv24I9fdfnRh/LABedyc0tgxp
	yYvoR+wga7x6nkPHl5zIF2It9hD5o8OlX8uW7zTOhOqYnZlJy5ppWOdumd5o9vIErxS3K0PRK6n
	h0Hp04weNERd2Aqk2F/zC20eWI4JJ5HK6uGVG7FHxVqyrB5CFcmEPGzUuN2eA3kfIc4r82wiIWw
	dQdbjtgKaTvy8DpndnLQxSgeRiovuT/9Dnpb0f3tEGpuqJzbAWv9n9qmGCv16/ZLl00O+t7AO3J
	FcLI5mpgMMMKE9JARzAdxLZf40wREZqe9giS0TVUDd+3LgIpen2hv/icqmowH7kPbUCh0HCw/w7
	80=
X-Received: by 2002:a05:6402:1ed3:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6b3a81d9dadmr7485386a12.43.1792500765108;
        Tue, 20 Oct 2026 05:52:45 -0700 (PDT)
X-Received: by 2002:a05:6402:1ed3:b0:6a9:9766:59ad with SMTP id 4fb4d7f45d1cf-6b3a81d9dadmr7485370a12.43.1792500764752;
        Tue, 20 Oct 2026 05:52:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:44 -0700 (PDT)
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
Subject: [PATCH v4 3/5] ceph: add subvolume quarantine wire definitions
Date: Tue, 20 Oct 2026 12:52:35 +0000
Message-Id: <774d53d774a44724c2ab8876a28cf51247bcd0c3.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792498351.git.amarkuze@redhat.com>
References: <cover.1792498351.git.amarkuze@redhat.com>
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

