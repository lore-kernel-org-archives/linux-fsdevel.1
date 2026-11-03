Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721311;
	b=o4i0hDZFcpXTG4dTnjzA0b6+87ZmHdAXJq5pavsqUoGDtJ0COqtTxOCYRWLghD0i9kb8
	 JwXzt5iquj5Tcx+rOIjhR+zNlfaxvjnW5qKXyUYvs+onrP88QlQPaWleH/5SU3R4UXD91
	 RRyz5YM9XiUPrsjcfgHuuKijhqfO+y/Jhv/IlWkaH2aQltR2Q6/LoTuxfA5IjZydvMoaK
	 PTk/P+uLRyxUJiT1Eg7C8j6UrIE6Uo52pCVg/VOjhCYxJ5wNzjanbLkWGxzAjSNgYKz4e
	 iZlVbo+3f9sAbO0hi/yN3DILcmN0p68RL4OGd9BRV7EYUfLMjHk/XrWV39UMTdMguNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721311;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5RPT6/oxC1p+cSsny4MKa2BwstuyUVmMMVpai1GPqa8=;
	b=25IPkQ+7TeuFoWv+43uMzjd/53CysKbM/UUL/8qtNAx81j8/bsFzTl5hMF/Nhm1COiZ3
	 +LLZFe2AGzVIVavqymvhwa2jJCVVjSVm0L1u4bO9qoKGYjx1WTUB9hl11qzc76Pe+EwSk
	 Gno3FrB0R9NCEcR/AJw6E1+p7HKyVrymxS/VIjsTsrz1wot3UfhJxz5+sTMKZjv/NKheV
	 SKT7XIOmUMYU8kXwDlcCkZluwYYahqsJv6zrtr9ZSxc4X6XK5fPc05DnBAgWLVUYpqPlg
	 Jk6c99ubVYd9ITdM5GzdYACDAjcXxlo/ZkUcAWYN93LaYaPoIhKZ8oQWaVBxyPSTxAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkyWAosN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B187B6082BCC;
	Tue,  3 Nov 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mkyWAosN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A941F00A1F;
	Tue,  3 Nov 2026 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721310;
	bh=5RPT6/oxC1p+cSsny4MKa2BwstuyUVmMMVpai1GPqa8=;
	h=From:To:Cc:Subject:Date;
	b=mkyWAosNrSq5Q0xsNe3pAkiiVcoegpwy7SLO1e32mRYJ5wro7eiFiI58a9s/Yp/XC
	 /u+YH1yulfMjyzOJNCySnblyNIpqOKf/GYoIPz4/fVIhrU7Z4HaM8CNVviiDDHy0ot
	 QTWHE+H9ulHxNFbSWSMbwS5HabZxKZHnmhDOIqeHY4lSzAp9zbxXioG4tuvTMX3OrC
	 TKpmZljTK+/hrodG3hMGO0phD2AhJ77IZffuF8d0KM674jiW4xC00HSMsIc9RfKamy
	 oBFUmQRmKD1pPUcp8UVKqfhYqOxKHnl76m34dKlJ8NbI2VtmO30M2m3Tq7wpSNLzas
	 7hYvM+pOXMJMw==
From: Sasha Levin <sashal@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/statmount: fix format warnings on 32-bit and s390
Date: Tue,  3 Nov 2026 10:55:08 -0500
Message-ID: <20261103155508.535010-1-sashal@kernel.org>
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

The f_type field of struct statfs is an int on i386 and armhf and an
unsigned int on s390x, and the listmount() results are uint64_t, so
printing them with %lx and %zi warns:

  statmount_test_ns.c:243:56: warning: format '%zi' expects argument of type 'signed size_t', but argument 2 has type 'uint64_t' {aka 'long long unsigned int'} [-Wformat=]

Cast f_type to unsigned long, and print the listmount() results as
unsigned long long.

On i386 and armhf the comparison next to it also sign-extends f_type to
the 64-bit sb_magic, so a file system with the top bit set in its magic,
such as btrfs, fails the test. Compare against the same cast.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm and s390 builds show the same warnings. The
changed files build without format warnings in the 32-bit builds now,
and the x86_64 builds don't change. The other selftests get the same
kind of fix in separate patches.

 .../testing/selftests/filesystems/statmount/statmount_test.c | 4 ++--
 .../selftests/filesystems/statmount/statmount_test_ns.c      | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index b237a95ec9fb3..8133a5841ac08 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -335,10 +335,10 @@ static void test_statmount_sb_basic(void)
 		return;
 	}
 
-	if (sm.sb_magic != sf.f_type) {
+	if (sm.sb_magic != (unsigned long)sf.f_type) {
 		ksft_test_result_fail("unexpected sb magic: 0x%llx != 0x%lx\n",
 				      (unsigned long long) sm.sb_magic,
-				      sf.f_type);
+				      (unsigned long) sf.f_type);
 		return;
 	}
 
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index e500905e4c078..c9ef755ffaa72 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -240,8 +240,9 @@ static int validate_external_listmount(pid_t pid, uint64_t child_nr_mounts)
 	}
 
 	if (nr_mounts != child_nr_mounts) {
-		ksft_print_msg("listmount results is %zi != %zi\n", nr_mounts,
-			       child_nr_mounts);
+		ksft_print_msg("listmount results is %llu != %llu\n",
+			       (unsigned long long)nr_mounts,
+			       (unsigned long long)child_nr_mounts);
 		return NSID_FAIL;
 	}
 
-- 
2.53.0

