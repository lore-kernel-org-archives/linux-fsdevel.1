Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987071;
	b=qXJ1gIeGJfIcoLFX09rLdVoUw27iagG7q9M2CYFyPqkmsglNB0PYwC9oRCZdjGuefv/i
	 vT707OR+C5/sdrdJ/iuTs9Qc58FA5c1dxXWykMynJ3Db+mQRTjuaUc8YO/eKZ/gayYICS
	 dYxmTIBjue7H01ef1+yKFd0b5XHz9i59NzJdEwEDE5DGgXhmEv/RbWH/+NLOU2BL2LFlS
	 gICdbwESzAeHB51DndGc+7VdMzE9kA+9jViyFQ8UOxFOkEheIX7ZPeCgNAE9KqeGUQ77N
	 vd7emI+/sqbnpKQpnuyNO5gAihWx5CNq1uI4xq8frSjlDVXqz1dS4kTO13lFP+GYMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6lKW0ujd9UDNY4TAMk4udtdbjVtWDIVBiqP1Qlq7+s8=;
	b=wGxfFIvPzpZc0eoU2biVTzmoN9Y9bT7v/rpEQWB72fyRJKKeztrHGc0N05m445nybP46
	 sXCqaYgbUJuVRgr8osKwzQsgjRYaHtHjAfIZBMSdRlvkg2C/3jV3zagrBifqva27n5pBz
	 QBygbfG+22Wpvb2LT5DBzW4cIcQ/NNckQpk6JylQexQ+QgNV6uj90G3fLEW+vCeQ+PU6K
	 Z8sPdg9cyLtil5ngAe2zMylaoayTv+SpuIe0D7DpixikKTPi845y4mOCnARQv6TNT+rve
	 HSTqGi2gGDzsr7+2zIBnfuVE+865f78aS2lwWaWqSs+Bbcq/lzWp4s74/mARGavhFfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h6xHoLeX;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA8606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CAA8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h6xHoLeX
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so717419a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794987069; x=1795591869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lKW0ujd9UDNY4TAMk4udtdbjVtWDIVBiqP1Qlq7+s8=;
        b=h6xHoLeXt9A8vEZbPQ5YuZL5To3B9EpkJ8W1rInMtmUeDY0Skxf/A9EvEULifDTBEN
         k0brlUFnuN5puX1eiFIttTE5rvlvvs8ZrretRqBSAoaojIvRydefArfImBo3WRSxckjH
         bdP7Wp0TxMQLRv29NJmh1/7vAiEF3aFeZPOpsykGS4ggP0aGhJYpFOsQP6tyFiamnhE1
         tnbvbgdmKP/zMcLyU9HbxGul6jqC85KANfBsaY2pZhV2dt0aUHLloQ/lX0cajlILVjnd
         v0QUoRDlo2J33Jm8Ve4CbLysbM6GV3rptU6DBoyl8KtigVykWBA4PLvw5TTAOBvv8cBN
         N7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794987069; x=1795591869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lKW0ujd9UDNY4TAMk4udtdbjVtWDIVBiqP1Qlq7+s8=;
        b=HPozBecFflspdydXJb4SKKXVH3YHOtW55lWM1bJbSCpk1uO1nF/flO5yyMRze40her
         OuRp/eDKrMatGX6YuvNmd8btc4sJpS7PeWf8IXNQiEHY4prevtqdu6gbOs0Y/3/ez+Xq
         /pWBPgeJaIzBs/IHK2yGQWKbWvH4yYleKXc6wTyiNzPrlumbFfebMJBpDkikRtiz5bU8
         cmtfBXqDEKDR0SmEDlK8LgkOegWNaUSH34XaVvvFv2GQ0LufjTq4jhjGn+jTaAfOsCUZ
         JO7JYqWmMVa6wcxrov0H7Kt/A3qAPpuG/Fe8nQmiAX+85MZS5lfcdIvi4sxh9Zvj0vp7
         Ld8A==
X-Gm-Message-State: APuU4Z9u/s/z61KfNJnW/SjLm8HUQFkRxf8y1KqXRUdcVQs2AHo1O4E8
	GQZVLygChQA+Hi2CFxcCEQEGfkf6xeQz0At2/OJWeKRMurb48mXtQCih
X-Gm-Gg: AYBFou09rO6fUYFwch4qKfyH/ehTK8SFpzHJLfcvUyDfhxbfR3F7zGmr80CoEDUx9f+
	ZEMnyCGHJMgGNUHuYWLkrIjkK2ejOkD7sGd+oW5gUZLFLnPi1fRQdA7ia1O9YX++i3UOcFrfktr
	WQehkDO8cIsR/IXmJ0XihfnYO0g/9hBBK0hY3vh1KI9DlXlJcBBS3+6kJiGX4evapdY5Rf4/CUq
	JXpbvfmLJzi/pf4miySqJiUv36sV01ULfCKp69sNCN8SU4g3w2JIqJHkxjuXzMl8Jncf9rRhEv0
	WSu76Ys6xeXPOZMKqIn9RiTKHfn6OiuZFSh9C9/BVrsAFoFUd/Y9bHmstWOgkdJzx4kwP0RdjgD
	xjdc+mgVJkMGIs6x/VoZBJYzX2ItZ2bkukTiHIulbzBiZnTfhO8+40MHKMaRMKwwdW/sAZcILCz
	7vShYU+MppiVq1HD022mJzK9j2rKtTi0ytsDqhdTC4kNWch50zivMGtUWmIx15p+8Q1I+obvPc3
	JzWZV6zfu4J5kYJH6eQJ6g+8iGpYMa7lKlXwWS1U2qieDKPYchcnbo91FPVbep41tHkW/KF4ge7
	Ikj8GniZYh4yudlQO/uzEzrc9hv77fLHomSRwgIqN/VkMxccewNIPq1JQMipLc3BvHFUdzk76Xm
	qJu6FAAGksBw=
X-Received: by 2002:a05:6402:693:b0:6b5:6ba3:5860 with SMTP id 4fb4d7f45d1cf-6b887e9a474mr896151a12.17.1794987069209;
        Tue, 17 Nov 2026 23:31:09 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b88993e76bsm691684a12.12.2026.11.17.23.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:31:08 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 6/6] selftests/ovl: use legacy setups for pseudo lower layer tests
Date: Wed, 18 Nov 2026 08:31:02 +0100
Message-ID: <20261118073102.1216568-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118073102.1216568-1-amir73il@gmail.com>
References: <20261118073102.1216568-1-amir73il@gmail.com>
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

Pseudo filesystems are only allowed as overlayfs lower layers in legacy
setups, where offline changes to the lower layers are allowed.

Kernel config defaults such as CONFIG_OVERLAY_FS_REDIRECT_DIR=y or
CONFIG_OVERLAY_FS_METACOPY=y turn a lower-only mount into a non-legacy
setup, so mounts of sysfs or debugfs lower layers that are expected to
succeed would fail on such kernels.

Explicitly set redirect_dir=off,metacopy=off in the lowerdir_sysfs test
and in the automount_in_layer fixture, to make them independent of the
kernel config.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/filesystems/overlayfs/automount_in_layer.c  | 6 ++++--
 .../selftests/filesystems/overlayfs/pseudo_datadir.c      | 8 +++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c b/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
index 0476c4582bdfc..c5bb12d524e5a 100644
--- a/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
+++ b/tools/testing/selftests/filesystems/overlayfs/automount_in_layer.c
@@ -82,7 +82,7 @@ FIXTURE(layer) {
 
 FIXTURE_SETUP(layer)
 {
-	char lower[PATH_LEN], other[PATH_LEN], ovl[PATH_LEN], opts[2 * PATH_LEN + 16];
+	char lower[PATH_LEN], other[PATH_LEN], ovl[PATH_LEN], opts[2 * PATH_LEN + 64];
 	struct fanotify_event_metadata *ev;
 	struct pollfd pfd;
 	char buf[4096];
@@ -111,7 +111,9 @@ FIXTURE_SETUP(layer)
 	ASSERT_EQ(mkdir(other, 0755), 0);
 	ASSERT_EQ(mkdir(ovl, 0755), 0);
 	ASSERT_EQ(mount("debugfs", lower, "debugfs", 0, NULL), 0);
-	snprintf(opts, sizeof(opts), "lowerdir=%s:%s", lower, other);
+	/* Pseudo lower layers are only allowed in legacy setups */
+	snprintf(opts, sizeof(opts),
+		 "lowerdir=%s:%s,redirect_dir=off,metacopy=off", lower, other);
 	ASSERT_EQ(mount("overlay", ovl, "overlay", MS_RDONLY, opts), 0);
 
 	self->fan = fanotify_init(FAN_CLASS_NOTIF | FAN_NONBLOCK | FAN_CLOEXEC,
diff --git a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
index 954a9f25cd1c5..fbf32c3ea88c1 100644
--- a/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
+++ b/tools/testing/selftests/filesystems/overlayfs/pseudo_datadir.c
@@ -173,11 +173,17 @@ TEST(datadir_tmpfs)
 	EXPECT_EQ(fsmount_layers("/tmp/lower", "/tmp/data", true), 0);
 }
 
+/*
+ * Pseudo lower layers are only allowed in legacy setups.  Explicitly turn off
+ * the features that may be enabled by kernel config defaults.
+ */
+#define LEGACY_OPTS "redirect_dir=off,metacopy=off"
+
 TEST(lowerdir_sysfs)
 {
 	ASSERT_EQ(setup_tmp(), 0);
 
-	EXPECT_EQ(mount_lowerdir("/sys/kernel:/tmp/lower"), 0);
+	EXPECT_EQ(mount_lowerdir_opts("/sys/kernel:/tmp/lower", LEGACY_OPTS), 0);
 }
 
 TEST(lowerdir_sysfs_redirect_dir_on)
-- 
2.56.1

