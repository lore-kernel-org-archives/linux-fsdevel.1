Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71C3890E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074992; cv=none; b=HrSZrJeEKCoQkPUyqBVUIJZeA1df5kWcCB9dy10OZt/2/Aet4PGDs0uBWzI4OIEqGMCdbUfypWbxG83zFPEZi9JrGHyCr/eTqtKwp3jD/XeSfrlHRYDp8dggoI/x7PrvAq1tyNWx/4haYK1ZKa4FV6oPn32qCKGXXzpIrQMpuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074992; c=relaxed/simple;
	bh=gVGupXecJG7jf/P2cs727EkyMXBg2c+X15dtcpFuFUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1KYUfjr3zbPVWYEciHbwKNnuS80032IDPJpXtB79/Cq9VSXHoi0UQrXUOLGxH6f05dXQIgN4V3HxzWQhsjsvZYmXm4bHR9GgrhAckhNfZmToPCI30YvIZjzQnV5wrM+z+yEuEt19sUVtITLpsDHLuVjX8rbg0PS9o7QcVnzwHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZ3QDxeC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZ3QDxeC"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2819288a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792074979; x=1792679779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=laBSnZ0bi6LZ4M0aaWZnf2FmRVd+v496bz833/sazV0=;
        b=nZ3QDxeCx0/74vgXNsT+WbR9yz/VUBnaTloEHIPaUAG2zWztU0gkE3vU0XcbuS6j+b
         CTWF1f5oJHvLwv2/U6VqjrbZKKQe9q6VtxzWvkBmo1Feo1eSBnHIkMg735F+ys/efAfn
         QNoe3tDJs6K3AI/oaLfV2pliLFbSSjuSMDYVzPmS8Uhsw76laPVu5imlgjoh81HHU5uX
         CE14ooJd6/nR+m91ryZx5HVp6csS6seyGOab7Ue/qKfrDHQvzC3OEzqYlCDLaGtxm4ba
         E6FxVsRxX6CFaVELDxgmnkmS6Ge5yDBncZxRJL4+QEuXnsRjKEYnDWLQ+1gG/WdjlntL
         zsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792074979; x=1792679779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=laBSnZ0bi6LZ4M0aaWZnf2FmRVd+v496bz833/sazV0=;
        b=bFGyA6FknTeArTmRs7DPhvBwXroZRv/OMW4m87xls7RsNUp6LkJC32vt/Ncs+XuljO
         6YpdXuwKOl//rdZJ3qyg7n8zgdkIjEVMDrktSlsB7lrin53x/q6za8fIvq3qgZHbbD3C
         h1lEMoDu1Kza+GYwyxxn4FE17tleHDxZiMUtzEAcmP+UQDj/8QRq06bjZWXXYc4P926p
         WcF5XJNFa7e8DvMd7qFm8GnO0tXEFlU3fH93vK6aTS/xxCrnxZuknPmo5LjWQgCV0aYc
         0ja/RjDEChsQx5eTlpNMnNoFC0c4QUmrgFt+s8tCDD3h50CXGp+LIFfzKDhxQ1VD1Cq0
         G2ig==
X-Forwarded-Encrypted: i=1; AKwUvBypTxxAMG+HqHrOjSrebKDpkm3BCPZFI9I3QY/uxVkLGIfxw/dI/qmcWx/jcWqrjFQw9WrG1T/fRrJGebtv@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2GpGBAp1Xa2v2mG38Tvsku+X0VBVhXanboAINPYIZhcjWZDkQ
	ozmS3hmznLCg69q3GUlG3jckLZh3hQTusDh4T91qiJJExoHDBoE/4Wvz
X-Gm-Gg: AYBFou18c1KBHeePK5FJzK2b0cWCWp0VmRpgc0dJHjTjhuiVYDv45nzW4FBiNoONofD
	tTok5Z/F4K4jmJxA6g5JD0b6WpbP4WPTDW5PULDTryxwMJPoCL0+HPmTfytpYdq+2WAyV+T5zH6
	BgtV1iJrMp8+iTLkULFW+Bj/e4QdeA1vSPE0Xh41Qlbd33+8PrPAxdSlo2PLgksSDooEJ2OObwg
	QmTr7FZkVH5Xhv5uyTyJlFoa3QYXU835DCXFpFyn5POeVP6RuuJKxkpnNW08n8zh7CkzEGmCC3/
	9EqxAbcjMNMgFbB4EigiV0jkvtwr7zL47SgPY7R4BI9HOClu5lAwvT7axL1O/zU7+mKaoXku9XS
	23y3qxB2G8hAVF/LznO9+e3s2BIsp2uiAQmFmhvCAUy1JfI2gCgPQPNKj5e6RGW9CZK6c683/tq
	WQoLijyTaTo2vBwSj7xHTtjaFJXTfrI8Sw6ULJY2zv31DhT2UXWUQdHHuW+Ls6VyOOKZ3QpFb3n
	q3Oz8RYs3q4EBpLYn198qysDg==
X-Received: by 2002:a05:6402:4606:b0:6ac:8730:71e with SMTP id 4fb4d7f45d1cf-6b17c27aa0fmr13334549a12.29.1792074979090;
        Thu, 15 Oct 2026 07:36:19 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388a77dsm2502243a12.25.2026.10.15.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:36:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 14/14] selftests/fanotify: test the FAN_REPORT_MNTID mode
Date: Thu, 15 Oct 2026 16:36:00 +0200
Message-ID: <20261015143601.2095784-15-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015143601.2095784-1-amir73il@gmail.com>
References: <20261015143601.2095784-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mode accepts the FAN_NS_MNT_* events in mask and reports these
events in event->mask.

Verify that FAN_REPORT_MNTID mode rejects legacy FAN_MNT_* events and
verify that FAN_REPORT_MNT mode rejects FAN_NS_MNT_* events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/fanotify/mount-notify_test.c  | 51 +++++++++++++++---
 .../fanotify/mount-notify_test_ns.c           | 54 +++++++++++++++----
 2 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
index 6381af6a40e30..db8b355d057d4 100644
--- a/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/fanotify/mount-notify_test.c
@@ -42,12 +42,36 @@ FIXTURE(fanotify) {
 	int orig_root;
 	int ns_fd;
 	uint64_t root_id;
+	uint64_t events_mask;
+};
+
+FIXTURE_VARIANT(fanotify) {
+	uint64_t events_mask;
+};
+
+FIXTURE_VARIANT_ADD(fanotify, mnt) {
+	.events_mask = FAN_MNT_ATTACH | FAN_MNT_DETACH,
+};
+
+FIXTURE_VARIANT_ADD(fanotify, mntid) {
+	.events_mask = FAN_NS_MNT_ATTACH | FAN_NS_MNT_DETACH,
 };
 
 FIXTURE_SETUP(fanotify)
 {
 	int i, ret;
 
+	if (variant->events_mask & FAN_EVENT_TYPE_MASK) {
+		int fd;
+
+		fd = fanotify_init(FAN_REPORT_MNTID | FAN_NONBLOCK, 0);
+		if (fd < 0) {
+			ASSERT_EQ(errno, EINVAL);
+			SKIP(return, "FAN_REPORT_MNTID not supported");
+		}
+		close(fd);
+	}
+
 	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
 
 	self->ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
@@ -74,22 +98,33 @@ FIXTURE_SETUP(fanotify)
 	self->root_id = get_unique_mnt_id("/");
 	ASSERT_NE(self->root_id, 0);
 
+	uint64_t ns_event_type = FAN_NS_MNT_ATTACH & FAN_EVENT_TYPE_MASK;
+
+	self->events_mask = variant->events_mask;
+
 	for (i = 0; i < NUM_FAN_FDS; i++) {
-		self->fan_fd[i] = fanotify_init(FAN_REPORT_MNT | FAN_NONBLOCK,
-						0);
+		self->fan_fd[i] = fanotify_init(FAN_NONBLOCK |
+						(self->events_mask &
+						 FAN_EVENT_TYPE_MASK ?
+						 FAN_REPORT_MNTID :
+						 FAN_REPORT_MNT), 0);
 		ASSERT_GE(self->fan_fd[i], 0);
 		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
-				    FAN_MARK_MNTNS,
-				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    FAN_MARK_MNTNS, self->events_mask,
 				    self->ns_fd, NULL);
 		ASSERT_EQ(ret, 0);
 		// On fd[0] we do an extra ADD that changes nothing.
 		// On fd[1]/fd[2] we REMOVE/FLUSH which removes the mark.
 		ret = fanotify_mark(self->fan_fd[i], mark_cmds[i] |
-				    FAN_MARK_MNTNS,
-				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    FAN_MARK_MNTNS, self->events_mask,
 				    self->ns_fd, NULL);
 		ASSERT_EQ(ret, 0);
+		/* The other watcher type is not allowed on this group */
+		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
+				    FAN_MARK_MNTNS,
+				    self->events_mask ^ ns_event_type,
+				    self->ns_fd, NULL);
+		ASSERT_NE(ret, 0);
 	}
 
 	self->rem = 0;
@@ -149,7 +184,9 @@ static uint64_t expect_notify(struct __test_metadata *const _metadata,
 	self->rem -= thislen;
 	self->next += thislen;
 
-	*mask = meta->mask;
+	ASSERT_EQ(meta->mask & FAN_EVENT_TYPE_MASK,
+		  self->events_mask & FAN_EVENT_TYPE_MASK);
+	*mask = meta->mask & ~FAN_EVENT_TYPE_MASK;
 	thislen -= sizeof(*meta);
 
 	mnt = ((void *) meta) + meta->event_len - thislen;
diff --git a/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
index 320ee25dc8a58..a3d38f0456377 100644
--- a/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/fanotify/mount-notify_test_ns.c
@@ -49,12 +49,36 @@ FIXTURE(fanotify) {
 	int orig_ns_fd;
 	int ns_fd;
 	uint64_t root_id;
+	uint64_t events_mask;
+};
+
+FIXTURE_VARIANT(fanotify) {
+	uint64_t events_mask;
+};
+
+FIXTURE_VARIANT_ADD(fanotify, mnt) {
+	.events_mask = FAN_MNT_ATTACH | FAN_MNT_DETACH,
+};
+
+FIXTURE_VARIANT_ADD(fanotify, mntid) {
+	.events_mask = FAN_NS_MNT_ATTACH | FAN_NS_MNT_DETACH,
 };
 
 FIXTURE_SETUP(fanotify)
 {
 	int i, ret;
 
+	if (variant->events_mask & FAN_EVENT_TYPE_MASK) {
+		int fd;
+
+		fd = fanotify_init(FAN_REPORT_MNTID | FAN_NONBLOCK, 0);
+		if (fd < 0) {
+			ASSERT_EQ(errno, EINVAL);
+			SKIP(return, "FAN_REPORT_MNTID not supported");
+		}
+		close(fd);
+	}
+
 	self->orig_ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
 	ASSERT_GE(self->orig_ns_fd, 0);
 
@@ -83,6 +107,10 @@ FIXTURE_SETUP(fanotify)
 	self->root_id = get_unique_mnt_id("/");
 	ASSERT_NE(self->root_id, 0);
 
+	uint64_t ns_event_type = FAN_NS_MNT_ATTACH & FAN_EVENT_TYPE_MASK;
+
+	self->events_mask = variant->events_mask;
+
 	for (i = 0; i < NUM_FAN_FDS; i++) {
 		int fan_fd = fanotify_init(FAN_REPORT_FID, 0);
 		// Verify that watching tmpfs mounted inside userns is allowed
@@ -95,28 +123,34 @@ FIXTURE_SETUP(fanotify)
 		ASSERT_NE(ret, 0);
 		close(fan_fd);
 
-		self->fan_fd[i] = fanotify_init(FAN_REPORT_MNT | FAN_NONBLOCK,
-						0);
+		self->fan_fd[i] = fanotify_init(FAN_NONBLOCK |
+						(self->events_mask &
+						 FAN_EVENT_TYPE_MASK ?
+						 FAN_REPORT_MNTID :
+						 FAN_REPORT_MNT), 0);
 		ASSERT_GE(self->fan_fd[i], 0);
 		// Verify that watching mntns where group was created is allowed
 		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
-				    FAN_MARK_MNTNS,
-				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    FAN_MARK_MNTNS, self->events_mask,
 				    self->ns_fd, NULL);
 		ASSERT_EQ(ret, 0);
 		// ...but watching orig mntns is not allowed
 		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
-				    FAN_MARK_MNTNS,
-				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    FAN_MARK_MNTNS, self->events_mask,
 				    self->orig_ns_fd, NULL);
 		ASSERT_NE(ret, 0);
 		// On fd[0] we do an extra ADD that changes nothing.
 		// On fd[1]/fd[2] we REMOVE/FLUSH which removes the mark.
 		ret = fanotify_mark(self->fan_fd[i], mark_cmds[i] |
-				    FAN_MARK_MNTNS,
-				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    FAN_MARK_MNTNS, self->events_mask,
 				    self->ns_fd, NULL);
 		ASSERT_EQ(ret, 0);
+		/* The other watcher type is not allowed on this group */
+		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
+				    FAN_MARK_MNTNS,
+				    self->events_mask ^ ns_event_type,
+				    self->ns_fd, NULL);
+		ASSERT_NE(ret, 0);
 	}
 
 	self->rem = 0;
@@ -176,7 +210,9 @@ static uint64_t expect_notify(struct __test_metadata *const _metadata,
 	self->rem -= thislen;
 	self->next += thislen;
 
-	*mask = meta->mask;
+	ASSERT_EQ(meta->mask & FAN_EVENT_TYPE_MASK,
+		  self->events_mask & FAN_EVENT_TYPE_MASK);
+	*mask = meta->mask & ~FAN_EVENT_TYPE_MASK;
 	thislen -= sizeof(*meta);
 
 	mnt = ((void *) meta) + meta->event_len - thislen;
-- 
2.55.0

