Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875842CB01
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276297; cv=none; b=QqN6/eMIF8uFxhEceOgrPmJ30MAbpbaQk4GsYxnDuL4zFZOEIOkM2SEs9mlyTosKkQyVqkNqZfejbKEQizmqfyIii8FLqBkofnmYelRCQF3txRBmh3jL8JDeOE9AdZFWjJlBYnRh7Xc8/IZBxUwxPDY2uoSpJq8vdZkEDDkX7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276297; c=relaxed/simple;
	bh=GKThMWTwWxTeH93wYlWHaH7u/FUIOBf+Ga6s/V6t7oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fm5UO+jTfceALs0PO85ewagxbO4SsIlM+YaXmIV6MqwK4MZPewIRvyB5msqdciT53qWrQcXvmDzvehuv3wEVPju53TiXayzc5SN5OhHDSkloauADKEIqhCvnoWTmfeSR1JZQO6rHiAJKR6zdy99Bf7CvpHEXDlTvtDq8a7CB20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=YqTY3/uH; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="YqTY3/uH"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530de452c33so1624851cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1790276288; x=1790881088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/w5+KtuCRMHj/pwYDlYF9rdD54o6xbJzMayckXvPZxY=;
        b=YqTY3/uH3fVv7C8OBYcFeU57m6O0KZETJbW7JOAgUOCS5f8M9iBFevKaA/9nB9P4tQ
         6oA5cDVm9h7NU6dPEJwJbOf1q8pa7mjveXFP0NpPw+wzKLc+z0MoI0qyX52oueO3UXR0
         nltjpFiW5OG+eA8hTBYUpb1s0IC8nQOs4B4csgDGYtXbnJV3y8DpNvqAWahjKYeH0PDa
         kUpp2j49hstd6Y5K3i7qVklhUand7yrP6epreon4etsSiHeBnVztB3LIpaAe1VdbRJ9I
         QjdrLnfjVZDq3G55d4iXW8gQ5BST/aW+Ci16/aIt5Bi8Qf67GmKNx58bM2/RvtkYimtM
         qybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790276288; x=1790881088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/w5+KtuCRMHj/pwYDlYF9rdD54o6xbJzMayckXvPZxY=;
        b=jWhANBDuGgOifHC5zzodKU3+vSidHwbl6MDRuFGCCAC5H9EP8tOQQrtzwuDjP8S26O
         LOcpwO9St0HuOn1A+zMhvxrU7VBhUtD4CkiophwtFs0GbQqYHLHK+LDNin9OoYQo4YQa
         LdTtomdt4pmXkr+h7p5woegd/YR5lMgUujA/2KzcotmbvJ6NpNZZDursgLYJZydoS2V5
         lCQeX85mgswp9rH4XXVsG8gmXDV0X4KIgYVG+i+JYgPD6ZS58C4uLXRckSBJ7+jCn/qY
         8kB+CErvRt22o9bMaTKd7U80jsls18vR2LcybF4+pm4jKHzhvC0cGLIakw8MMTvjW6/S
         kIGA==
X-Forwarded-Encrypted: i=1; AKwUvByW8lqrj1oWQYNOHrZatj2rKRO7Ig33THEeBDOaS6egqPpSsdH3mmtpjHI80nW30ziXvAorUHOgmBGIlRW+@vger.kernel.org
X-Gm-Message-State: AFuF++nFRI0GB/ujRwYZmMUTtZQ8cI34fPKUQVbVbgNwa+U9dbro9X5f
	Qrgq3N56D4JatK3FjjuBs2txBsCXzFMj/xxGaFp2BDP4R88UPUI3mWJ8B5wVFXvvZA==
X-Gm-Gg: AYBFou13pPESk5c/uG2BGF8w4j1DZ/OXo57Oy6SY1XZhU9/2D+r6Jk47TgwbP93ViyC
	0Zs9qcp1ladTKQA8f8GWFYWEtVi3zzJWLmHKo5Vu1Bllb6zEaPuWbJsK0F9TW/Fb1ifp5+SA9EK
	ikxQ2u2pQGfIwdxiDfPm+PQk1vskXQ4bzWZoTNd10Axje/d0Knf6MRwUngxLu4QBarnQvjCSLOQ
	0bWS2L6PSCRJudoozIrk3uKaYbqMV1hQmfCaODS05i1lJGI3gpVH2xS0dDXcd7Y9IQnEDkYS8y4
	/gv/5Wv2YgG6P5JbS2iqh7+DypX8FmBaNjb0hugZ/dsx3vw/1lHqteY9/LaUsoJicNN0G0kOZy8
	jkCPMX+XSdiW05Gn14dGIzMuSGoz2oDl76SDrA9VzqSGN0+SRaQ46ZXoSuej5ZtmFFNY1WIMV0s
	X6kFjNmA1NcR8mo3dnsGUXmDxtIiVzUcv9gRQo/SbQFbAOwRJqinNB2b5jw/Z5wzEB7kV4/eWDM
	3Y1MZGyE126iNsONRttTg==
X-Received: by 2002:ac8:5f13:0:b0:532:c2f5:85b8 with SMTP id d75a77b69052e-5330b5be39cmr3736111cf.19.1790276287595;
        Thu, 24 Sep 2026 11:58:07 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9142ff8d51asm633036d6.0.2026.09.24.11.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:58:07 -0700 (PDT)
From: hengyul@cs.unc.edu
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	joe@dama.to,
	jirislaby@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hengyu Liang <hengyul@cs.unc.edu>
Subject: [PATCH] eventpoll: return -ENOIOCTLCMD for unknown ioctl commands
Date: Thu, 24 Sep 2026 14:57:47 -0400
Message-ID: <20260924185747.2166326-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengyu Liang <hengyul@cs.unc.edu>

Before commit 18e2bf0edf4d ("eventpoll: Add epoll ioctl for
epoll_params"), epoll files had no ioctl handler, so ioctl() on an epoll
file descriptor failed with ENOTTY. That commit introduced the
EPIOCSPARAMS and EPIOCGPARAMS commands, but ep_eventpoll_ioctl() returns
-EINVAL for any other command, so since v6.9 every other ioctl() on an
epoll file descriptor fails with EINVAL instead of ENOTTY.

Documentation/driver-api/ioctl.rst says that an ioctl handler must
return -ENOTTY or -ENOIOCTLCMD for an unknown command, and that
returning -EINVAL there is wrong. Returning -ENOIOCTLCMD was also the
intent of the original series, whose changelog since v3 [1] says "when
an unknown ioctl is received, -ENOIOCTLCMD is returned instead of
-EINVAL as the ioctl documentation requires", and ep_eventpoll_bp_ioctl()
does return -ENOIOCTLCMD for unknown commands. However,
ep_eventpoll_ioctl() only passes EPIOCSPARAMS and EPIOCGPARAMS to it and
handles all other commands in its own default case, which returns
-EINVAL, so that path is never reached.

This is visible to userspace. For example, isatty(), ttyname() and
tcgetattr() on an epoll file descriptor set errno to EINVAL, while they
set ENOTTY for any other file descriptor that does not refer to a
terminal, as they also did for epoll file descriptors before v6.9.

Return -ENOIOCTLCMD from the default case, which the VFS turns into
-ENOTTY, and update the epoll_busy_poll selftest, which expected EINVAL
for an unknown command.

[1] https://lore.kernel.org/r/20240125225704.12781-1-jdamato@fastly.com

Fixes: 18e2bf0edf4d ("eventpoll: Add epoll ioctl for epoll_params")
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
 fs/eventpoll.c                                | 2 +-
 tools/testing/selftests/net/epoll_busy_poll.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0c4bf88a838..adf30b720b13 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1264,7 +1264,7 @@ static long ep_eventpoll_ioctl(struct file *file, unsigned int cmd,
 		ret = ep_eventpoll_bp_ioctl(file, cmd, arg);
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -ENOIOCTLCMD;
 		break;
 	}
 
diff --git a/tools/testing/selftests/net/epoll_busy_poll.c b/tools/testing/selftests/net/epoll_busy_poll.c
index adf8dd0b5e0b..6b0b3213ffad 100644
--- a/tools/testing/selftests/net/epoll_busy_poll.c
+++ b/tools/testing/selftests/net/epoll_busy_poll.c
@@ -313,8 +313,8 @@ TEST_F(epoll_busy_poll, test_invalid_ioctl)
 	EXPECT_EQ(-1, ret)
 		TH_LOG("invalid ioctl should return error");
 
-	EXPECT_EQ(EINVAL, errno)
-		TH_LOG("invalid ioctl should set errno to EINVAL");
+	EXPECT_EQ(ENOTTY, errno)
+		TH_LOG("invalid ioctl should set errno to ENOTTY");
 }
 
 TEST_HARNESS_MAIN
-- 
2.53.0

