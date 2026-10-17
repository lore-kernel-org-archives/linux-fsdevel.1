Received: from mail-qk2-f9.google.com (mail-qk2-f9.google.com [74.125.230.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C04B3E0725
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265211; cv=none; b=RTHuY6dS6hL0/o6hyAxtrAHbGMsdeW4FOOdR+zmax1hE3eZhyd9FI4d3RU/4F0jBknTUdMh0jrPKODLgB8WOJXnRs6Rb/UxIakOQKZYaGPuIM9mLvFV/ZPXTztBL80m3TdjxEMlVpF9io5OKGwp1BHfxCkOcomxGYJ4BKlOP9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265211; c=relaxed/simple;
	bh=ovgvca2sTQCkuo0abjJMCBhGt+FjMIENdXX+PywFOSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wwif9NCYHNbue+E5wsGNiXL2LXIQy6S2tzaUFrU7IXDNAXIM0ed7Nozk5+gIEyldVjevj33mIlTgf5N5DXFbFskDl1QfNz1U9qgF35FhEotpiv02tsAuRioh8ifmStNr3S4aoo5wEBDe61NGwOccnc4V4w8L6xW1nq1hxMwaeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkJQqIko; arc=none smtp.client-ip=74.125.230.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkJQqIko"
Received: by mail-qk2-f9.google.com with SMTP id af79cd13be357-930f7b1eb68so110521785a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792265207; x=1792870007; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BMLx5qM62vWoOfAtAwn7HgXvltiKKbuv9z/3ifjwheI=;
        b=XkJQqIkoJttVjlzxdSKXNhVyfRpeRmuSBme19MXlVm88+ZZkE9iiO6AOgTlYDnd15E
         0oI5xLbLa8OSW46w/5ADarbGpN+o87ySEs3fNurOAqCWB0s5uUzY5PEGTu7q3KueNjZG
         whkUJPO7r1azDdHI2FJ0fYAx4MUvxYpl+19qpV295tOThfUa4UCEzLqE6mvUrnSu6OGP
         hf9cTaSvT4aMkp8tSlbp/ffPJpQycWk92UeqJSQ5TujUv8m6jTU2CC2/iM+PQldIxID2
         Q+8deHTaRftXXm7Fld0NAiQtuLQa+DH+VBqR6da3qmnxYv3QpEAMAktFY2UCblfNbkeV
         2CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792265207; x=1792870007;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BMLx5qM62vWoOfAtAwn7HgXvltiKKbuv9z/3ifjwheI=;
        b=RPIzw3WUIass0msalrmd9kliWj3qkE75Ye061DQjp83B0i1+QmUKN6ZtdLvbPKoIZk
         8ZWXPqT1U7TzkUe8mHw2xccjSvRAmiGZRZQ+/XBPUZLQ3xltbpAjSF4GN7eCgrNtBm8M
         oeuwF7lE8G4p/nz4x49DmtZAZqbTkpmxJZJyKOmq6eRTJdrg34hdyxZPJmsnC8Sneyii
         A/3+6P8MPyQUkRIIyoFcjjHoFP8jPOcPia28fNq+HmWmWzHzd1QNH4PWG8NBmkolUAPY
         8cUqCBEEuMQf3GHJyW3ONvimAzJ9TwcWJ6pAVvXNvWYPlzmKVvFrht7XvbodSARcP8Jo
         2t4Q==
X-Gm-Message-State: AFq9FYIJ5cWDQ7kWDY4XTr9hCHa4Igjc7uJhEYhE9Jv1rJFQwR8e87aL
	CnPgMm6E9WUtMUNgNrBcSQecbUIk1bRRNOqh0I5Z2drf/7sgcL0AbEExF9bCdUsR
X-Gm-Gg: AYBFou00zfGmG4nson6phRif+C+fRO04tBU9erXjO6K0ATFTEvUli1j7NNW+eU3aBC9
	R0EPlcj9nUeEB7kds5Quu4cvYmfaB6DVLbqBHkEQx4GmAfTXevqev614UJKvUKE0PYIZoe7mjDe
	zjwJOKNkv1ohfv4xej6aE4h0lOYouaL/ENGWWDmP20NlRA2MWY248Gz+dzBwieLlh35Kuc/nTn+
	QLJAEZPgc2U5Nz+bvP6H6Lg5UHb/4hTx2fZINskr5WggDM3axxdCJwtDGSyxmQMgQ0bNQgNlTog
	tHJ1r/jL+NrlmD8QF0+FEZ293/no0/OUnarU1lcb3+qR4puZAlRzw+f6jmc1h/iHB5Arz9/CdkY
	0iW8YD5IihX+6cnnQj/6IrQq8VBr7uEb/WbhqMRqjpGccGaU7LpKV/Dp97xPowCWnmIG/IUcnKT
	wsyc666WKdeNcPJwudPAkyILcJAPngwcV6jt0Ny6Au2fP5R3YRM0TM45GV3RwKLFVZWRp+prqE7
	nNYyNs=
X-Received: by 2002:a05:620a:4448:b0:93f:22c4:e92f with SMTP id af79cd13be357-93f29d6744cmr621836085a.54.1792265206703;
        Sat, 17 Oct 2026 12:26:46 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f29c5ae3fsm308636885a.40.2026.10.17.12.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 12:26:46 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/pidfd: wait for POLLHUP before reading exit info
Date: Sat, 17 Oct 2026 15:23:10 -0400
Message-ID: <179226499044.847.17334319321039510150@gmail.com>
In-Reply-To: <20261017054356.7874-1-hooyan2024@gmail.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
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

