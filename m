Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723966;
	b=LojKSHHkrk7Sd3yfu/JEpTZSw6FiyyzZ86vEtR5Lsw/lZJuJY0UkWjt4F2IrYyVZlQ/k
	 IVfpWZZ8q2bR3ULKqiN0VKBuqQKa7x0fVRtoetlwbU9spq7BBCT0Zmix6HrYYC1tJdJGK
	 IlB5WUZ1ZLrIBsGmnbGgv8rMR9uz81pL6BnWX0z3lThlmwnXMCtXQ7CtvB3vDKuNKhXW8
	 t2gIbf4/D8Hat21YTUOiCbzdVuFpYARr1/OH75OMPYA1zjerjmYSnzVD5In2zk37IHzyE
	 9t122K7pgX8fnquIogQ9W4K6OrE/Fl0TRVVMgLJVP/JCJDT6u1QlYv81jPQZXAnzZpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B+ddZLNMVY/L0iNuiWwG7zaT3u2ikp7F4nNGAgSTECs=;
	b=NSgY6Yl3w/xiLKC0wsn5mY+h6MWlC9+VsiJe3EvU+0AzhJyQ48Xpg1NB4JOMtWWezGeU
	 KUs0LXG1deKFdR2Hfzm+8AtnYlWvXAeeuN0YbX59N2uCIH+CgKWa9DOAuU/GotloHAT9M
	 GqGeq2rk5819oU0MlIuHe3D8V81nxT5E8E36Mwb6d0u3Ac9cxDI5G96dM4iLPFHHiFaVc
	 khTKC3YsvnulcSSJqhTgOMurqyNl8vpQ9n5Zv6k4/48V77AwutBHUVZ15tGjgS9Oit3Em
	 pqLbtyY3DPAQOQ2Sb/qSqIb3kBoScC/1aeO3Q2pGzVk+B4c316gKFlIVvzVibGOVzCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ss3+GY6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C6606EE9E;
	Tue,  3 Nov 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ss3+GY6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF51F00A1D;
	Tue,  3 Nov 2026 16:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723965;
	bh=B+ddZLNMVY/L0iNuiWwG7zaT3u2ikp7F4nNGAgSTECs=;
	h=From:To:Cc:Subject:Date;
	b=Ss3+GY6rH5vn0benxmUJ4l5aSSLOWHMsQWWsZaXYESYVK9YmxlijwX3gziGauy1JQ
	 4hMsqsIURdej2v4jJe87Wm48r2cOJ8aseTXAVMjgrU2ghGsMOMbr8nIonjjM58vkIA
	 FzCG0j27nObIiiLa89J9a2/zpUt+tEcX4ZKa2H3gJ/PsSNDSK3tGlGzBQpHDK9vTfy
	 r4khdGOe3mkfEyRyB8aCsq2bLy6XOcDYYx89XXgJFBgVltMYT0jRrwyVLqGVkr61XG
	 EsWXTukVf340GwEQmzsYe8sib1jqKHP6MbCmerE899mEQwC2TxErTsvyGo2gPU9r+d
	 OGJWKx50JG+7A==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mount_setattr: build with a 64-bit off_t
Date: Tue,  3 Nov 2026 11:39:23 -0500
Message-ID: <20261103163924.641377-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

With glibc on 32-bit architectures, off_t is 32 bits unless
_FILE_OFFSET_BITS=64 is defined, so the 2 GB ftruncate() of the ext4
image gets a negative length and the test fails:

  mount_setattr_test.c:1048:30: warning: implicit conversion from 'long long' to '__off_t' (aka 'long') changes value from 2147483648 to -2147483648 [-Wconstant-conversion]

Build the test with -D_FILE_OFFSET_BITS=64.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 tools/testing/selftests/mount_setattr/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 4d4f810cdf2c1..2e5b16fcdf10c 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
+CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread -D_FILE_OFFSET_BITS=64
 
 LOCAL_HDRS += ../filesystems/wrappers.h
 
-- 
2.53.0

