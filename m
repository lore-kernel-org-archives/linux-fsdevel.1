Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AD3E40F5
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342216; cv=none; b=jm8JI7B/ASHOoCCEtFREvdpY2sA3ZA8cSl3RCDUtJOoUE1c/aH31BsDge5wIIZuad4aKaXWTloW8N5h5Ctg2PA6KvNrCq/+rutkwzEQmacfYEOUtdXI/4vqj6IPZABieN5FtUCXcHaGBL69rhFunRH0qdSnfIuKjoJmetVPfsRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342216; c=relaxed/simple;
	bh=7h/r53sko0vSWudiFtojFrTuAikIUnp9ZdZ+WcOFHN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VWXuZwGWhuFkGgAwBP4YBCXoWqUQTlSskt2Ysze5ODvXmHPviy2mmPwaG7GUEbZFaSRHq0VaRQmjpuGaTF+in4NomXfHu1D8laAq3IuNwLv0fMkmkJVAvzZ/JK77FRkrRKyPVQr5L1fUMbkdP2UvhFYb3aNkEuh6WFEcLcZhZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muWVtLgL; arc=none smtp.client-ip=74.125.230.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muWVtLgL"
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-934956d1044so116648785a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342213; x=1792947013; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mf2HSPqnvA1xqXGaunmqORu34n5mJLaiCiNFi8iI+e4=;
        b=muWVtLgLgbDXCSWB9xP6TsM2bbYdm3UFxT6ZUOj3Yvy2burKZufhfrk6YvhDKJjMsj
         Qia5eIJPkBC2/Y3+spnsi03k3jz5VX0accQ/Prp1dIucDGskvGXJpDLVgVbaf+mxPwms
         K3Pd7seF/l8CjLNfHtOtai2G8HmbrHvQxm+tNjtaW8C1xDGn7CFRj16/emSplWkNl3Fp
         V+o6+UVJ18KUI454IsYT3nz/SyVjGu5HGHGUBzTT4+vljyeMyVzGANnIvukgmIC9mO6m
         KDetqa3+vg3X81hhD4S52fJEMP/Xxl2OPrx45kP/PdRzXB/9iXCQqG2Bu7NoT4CG3IAo
         QsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342213; x=1792947013;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mf2HSPqnvA1xqXGaunmqORu34n5mJLaiCiNFi8iI+e4=;
        b=hd7xwnVDukhcnVuIudQnA98hTSYpynM24JktlOPnUBPWvEa/xpoJ86no8GgBiwgRlJ
         vCns3IbBcecKnxRNVHGoY4gpLvKTuTCP69G+d7eryMB+qltSevvpjPvU2QyFKPbxhxtQ
         f+vQR5lf09h81GNZf2I19rfQcurL77w9sOjwtgIyTR8biXGqDI7eI9KzWmJElut48BD7
         IbJwIB4hBpeSgmsa4gjvcv+6GVkN9g5EisOhzBtQn4Dfk4p0KJgiiy4VmRzGzqIjsH85
         RvBc4lw5UR2V+8kt5Z9qk46SeE9BJOe03T2xDyCqDTnaOBqCY0jgM83BA/NBq1zOpFQQ
         GtVg==
X-Gm-Message-State: AFq9FYKc2kO4REtXqIQHV9bJ/5RwQBo/O1QHVXIUNTh7QngweGs2p9EI
	0oUBN7fBSV1d0qSCauIN+nzLa1WGWcmwmlVfCS6FM4JkPyKTSz/8yMX6uEbqSZHE
X-Gm-Gg: AYBFou1kpP33SxTNk7ZYtVDTiG8bQi0EShXqt3qp69sO2mJyY0ZY1LuocqLOBWV1YtS
	/bbhDT3AQc5aWuuYw0F9doQFzHD5hdVlJEfU67f8Kgm9PdK+LtZDuIbwgmDmquzjDTOIO5kcZSn
	Uq0vUGpjkkH57TTI/n1189liSzu1+GcrVoeYkNkFGFe3sItl33aKDScE/wiWoJsqBO3qVACMOwX
	thyQXCadNx6xfKIlyroJfepyIi2fSA0lHr0NBUZMd3hs5L9rwcT9bbkLQCFdejBqoseGuraoj7d
	LX1h1dNhj9/rZiTAzdzXJmj4cppsMlQR9TJk+7JYtO17gktnx6thtfJNDrnX6E4VywgKLkvIhoA
	hkfBMqOoz9gr5wSeeCp+EzCX5V3I+9kS4q4nzrniHlY6CMmk0+/OMdUiBzS5ssLsmuBaivi3uQg
	nnlgcOOen00SEOzWNBp3va+PqxQYgWR1tQBLIImp/PH61HQnTtzX79aoeJM6VGCUuXvWZeOJlDL
	duxNfU=
X-Received: by 2002:a05:620a:3903:b0:93e:fa30:f1dc with SMTP id af79cd13be357-93f29db40ccmr780679285a.72.1792342212904;
        Sun, 18 Oct 2026 09:50:12 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1688aesm740116685a.8.2026.10.18.09.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 09:50:11 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/pidfd: wait for POLLHUP before reading exit info
Date: Sun, 18 Oct 2026 12:48:50 -0400
Message-ID: <179234213014.649.6368924662349703640@gmail.com>
In-Reply-To: <atTy6LziL5fdGTkn@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
 <179226499044.847.17334319321039510150@gmail.com>
 <atTy6LziL5fdGTkn@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The CLONE_AUTOREAP tests poll for POLLIN and then immediately call
PIDFD_GET_INFO with PIDFD_INFO_EXIT.  PIDFD_INFO_EXIT is only published
from release_task() -> pidfs_exit(), which runs after the pidfd already
reported POLLIN for the exited task.  A poller woken by
do_notify_pidfd() can therefore read a mask without PIDFD_INFO_EXIT;
under KASAN the autoreap_multithreaded case fails this way.

POLLHUP is returned once the task linkage has been removed from
struct pid, which happens after pidfs_exit() has published the exit
information.  Wait for POLLHUP and check it in revents.

The zero-timeout liveness check in autokill_pidfd_open_no_effect keeps
POLLIN; it verifies that the child has not exited yet.

With this change all tests pass ten consecutive runs on an unpatched
kernel.

Signed-off-by: fujo <hooyan2024@gmail.com>
---
 .../selftests/pidfd/pidfd_autoreap_test.c     | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
index 1c586482f..b4f3699ef 100644
--- a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
@@ -149,7 +149,7 @@ TEST(autoreap_rejects_thread)
 
 /*
  * Basic test: create an autoreap child, let it exit, verify:
- * - pidfd becomes readable (poll returns POLLIN)
+ * - pidfd becomes readable (poll returns POLLHUP)
  * - PIDFD_GET_INFO returns the correct exit code
  * - waitpid() returns -1/ECHILD (no zombie)
  */
@@ -172,10 +172,10 @@ TEST(autoreap_basic)
 
 	/* Wait for the child to exit via pidfd poll. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/* Verify exit info via PIDFD_GET_INFO. */
 	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
@@ -225,10 +225,10 @@ TEST(autoreap_signaled)
 
 	/* Wait for exit via pidfd. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/* Verify signal info. */
 	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
@@ -334,10 +334,10 @@ TEST(autoreap_reparent)
 
 	/* Wait for it to exit via pidfd poll. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/*
 	 * The grandchild should have been autoreaped even though
@@ -421,10 +421,10 @@ TEST(autoreap_multithreaded)
 
 	/* Wait for the process to fully exit via pidfd poll. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/* Verify exit info. */
 	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
@@ -512,7 +512,7 @@ TEST(autoreap_no_inherit)
 
 	/* Wait for the autoreap child to exit. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
 
@@ -571,7 +571,7 @@ TEST(nnp_sets_no_new_privs)
 
 	/* Wait for child to exit. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
 
@@ -631,7 +631,7 @@ TEST(autoreap_no_new_privs_unset)
 	ASSERT_GE(pidfd, 0);
 
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
 
@@ -695,10 +695,10 @@ TEST(autokill_basic)
 
 	/* Wait for the child to die via the pidfd_open'd fd. */
 	pfd.fd = pollfd_fd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/* Child should be autoreaped — no zombie. */
 	usleep(100000);
@@ -799,7 +799,7 @@ TEST(autokill_pidfd_open_no_effect)
 
 	/* Verify child is still alive by polling the clone3 pidfd. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 0);
 	ASSERT_EQ(ret, 0) {
 		TH_LOG("Child died after closing pidfd_open fd — should still be alive");
@@ -813,10 +813,10 @@ TEST(autokill_pidfd_open_no_effect)
 	close(pidfd);
 
 	pfd.fd = open_fd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
-	ASSERT_TRUE(pfd.revents & POLLIN);
+	ASSERT_TRUE(pfd.revents & POLLHUP);
 
 	/* Child should be autoreaped — no zombie. */
 	usleep(100000);
@@ -884,7 +884,7 @@ TEST(autokill_without_nnp_with_cap)
 
 	/* Wait for child to exit. */
 	pfd.fd = pidfd;
-	pfd.events = POLLIN;
+	pfd.events = POLLHUP;
 	ret = poll(&pfd, 1, 5000);
 	ASSERT_EQ(ret, 1);
 
-- 
2.53.0

