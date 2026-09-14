Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A8529DB64
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354048; cv=none; b=EgxD3vh0vU1DY0aBRBAA2qPcaRKSru/KZRIYVKs13czAYuAOe/YhIijeHgII9jbteAlvT8byRVI5aa0lDpxHp8sGxA0Km53FKvacSDEiskjML2Xs6Kgrrpjhop/CvjVsRrE0N9Uvb/gc/qp/vz6e/h9M2WMmd1UL8mMCmB6mQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354048; c=relaxed/simple;
	bh=7zxqK1EC2u8mu/Y0yATQjVwM0lENPnbrRovA/y8nR4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g430b2iu4rC0nrR8EFBd84geX5PNu6x0ooKi5QyXS59W0eO7JpUsanKhTW932XWNoE2cxwE8TEH8Fd9IkhsJRxd1q12wXym6x7qja4POcebQWLN60CW9ASx3+cMoXvSP5ORI4fcp8Frk2XzzafIkTpmYfVlxYjH4PuSqVBseFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngQMs7uc; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngQMs7uc"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc1cebad4aeso1399107a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 19:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789354045; x=1789958845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Z6OvrHx3LTUPgb6h5n2rsH+g5fMXj4Vyw5P9qxQEbA=;
        b=ngQMs7uc0sF1Ex1vSTL4NTeugBuqw+sNqKQlxf9IHJsRxFfDPkBJWTrLqLHEX7SAiO
         HHyd7KKcUnLQvaOrBwrX985rzkcdIpvvI3PgwAO1ZzCBsvq2BLi6hpsRIBf4rGd8TtjR
         99uqM613ioIEMvuqnVW5VKu87vAwsR6toPvY7WV9e9EmesDeLfq1Dap7Fh4dn2nOpVTK
         /ql837N/oVcFJAoUp55JYLtuJlzoPHJxcDxwCEvuUO8WAhrtur9papfU3jcPuS7nXAhP
         vAnYNml4+BMKbgqLz3GJ87hS4G5rqBpXfksOkSwHQoZXoSzrtS/aGncnsukUDbXeWCQP
         1OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789354045; x=1789958845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Z6OvrHx3LTUPgb6h5n2rsH+g5fMXj4Vyw5P9qxQEbA=;
        b=kADUJIYuirHuOytFd3ubbsZ3GDu8BSFe/cHiy97DifV0Yw5dUKQvx6m9HnUdRX8foJ
         rWn5wzw00BUUGP1QD27/jDyC5GjbiwJkb3hToh/H6bEDmNF74mANRxiKX/ap03hn1YUD
         1Vl8njzFyCdMsyvnIw7uicLHl91I3MjrSSCSmMiES0CV4ZHh4g2R9ZkYwNLBZbolVEtb
         UvhSE/QahDvl8bA1AyKGtV+YO1er3grV5aUzOKqAJNWJZtfLaPjPq1MA0VUnnrAnuM6y
         /B/Xud7hsS7ibIZUJ8yzL3oREI9gOtijUKtHupj88Gh0WSyTpqnoLnLvVihm6GLlKtxX
         LMZw==
X-Forwarded-Encrypted: i=1; AKwUvBxDwS3WjEWlGyo8yQcFLfkptYu6eS7majwWV4Dmy1qC8F7pTY7kChlaD24Bhd37hUDAxDFZocTkNSPgIUl1@vger.kernel.org
X-Gm-Message-State: AFuF++loh6krU1Hav89YUdVQou8x+Zw0E6G6AdyCjDqJV/wkTya5+/he
	CMlFrESf/MJ3s8o7zLmfROuyKyoZErceBBrUL7Y408/mg2dy7X+bVKqo
X-Gm-Gg: AYBFou1P//t7R0icAfRYcbTssZEj7VmmGsEaAiAQNFlSEe0mq1LIVr4pmYs6YgRO2W+
	xTsV0NXxd4faUnNpSHTMYnpwQQ2PDoub+lRtotkA67LdpjqlVGjD0gEwXzHoeMr3ocCb8/J37Jy
	fX/xEmxTV0xbcFENb34oXG2BhlEYwCV0Klw+w9J7Sbyp42fDOnAO1jRLD1UkOvB39qZB+pmlVLN
	yU7QubEJblv75uXoku+wSEgTcqcG8mBFVYNlIGJPwNWmpptx8alNKVMJ1ff5c0GJR2V/GCtgiSd
	KAcnLL77qRonS8gOjo9jkHQZJYJYIzqXCTAKdlSJK9rJA2xeW8yUvrgTmji4r3xP3jLc2f/ot2E
	n/AzwJpXJiEJ7X2kkTMPpvnwvg0WmoAL5gqwJ30pcy5vH8j9ZEW99iDTGZvWof6BQ8CfZOGZl8m
	RlnbsGazpe4xemDdijRiPn29A3z6r1UBUB8ZFhsR8n+IpaA6npqrCeK99GtRWB5ybIE4kR/g+Ei
	cc9skDbLR+l7fhdBxVSR75p+/l+5SkSjA==
X-Received: by 2002:a17:90b:1343:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39debfb227cmr1756193a91.11.1789354044855;
        Sun, 13 Sep 2026 19:47:24 -0700 (PDT)
Received: from Alone ([2407:1400:aa0f:8050:5aba:c339:8cc7:e5f5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dbca4c9a5sm3718447a91.0.2026.09.13.19.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:47:24 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH] selftests/proc: Skip setns-dcache without UNIX sockets
Date: Mon, 14 Sep 2026 08:32:05 +0545
Message-ID: <20260914024705.706372-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setns-dcache uses an AF_UNIX socket to distinguish network namespaces.
When CONFIG_UNIX is disabled, socket(AF_UNIX, ...) returns
-EAFNOSUPPORT, but the test reports the unsupported configuration as a
failure.

Treat EAFNOSUPPORT as a skip instead.

The change was verified with CONFIG_UNIX=n under QEMU, where the test
now exits with KSFT_SKIP, and with CONFIG_UNIX=y on the host, where the
test continues to pass.

Fixes: 1fde6f21d90f ("proc: fix /proc/net/* after setns(2)")
Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 tools/testing/selftests/proc/setns-dcache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/setns-dcache.c b/tools/testing/selftests/proc/setns-dcache.c
index 60ab197a7..f4e958068 100644
--- a/tools/testing/selftests/proc/setns-dcache.c
+++ b/tools/testing/selftests/proc/setns-dcache.c
@@ -17,7 +17,7 @@
  * Test that setns(CLONE_NEWNET) points to new /proc/net content even
  * if old one is in dcache.
  *
- * FIXME /proc/net/unix is under CONFIG_UNIX which can be disabled.
+ * Skip if CONFIG_UNIX is disabled.
  */
 #undef NDEBUG
 #include <assert.h>
@@ -59,6 +59,8 @@ int main(void)
 	}
 	/* Distinguisher between two otherwise empty net namespaces. */
 	if (socket(AF_UNIX, SOCK_STREAM, 0) == -1) {
+		if (errno == EAFNOSUPPORT)
+			return 4;
 		return 1;
 	}
 
-- 
2.55.0

