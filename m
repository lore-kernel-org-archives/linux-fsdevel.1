Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9288646C4A2;
	Sun, 11 Oct 2026 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758063; cv=none; b=ovXrE9NxUCp81hS9Pte6zsfQAtAynDhErzSDtEpPrNzN7WBxkpu3HY80bjqax7JFmjouKkLyhLSWiB3XWiaRlXWnlMs9NBb2jqf/Ih1JCyLmKSbnkd242DxvuUh1ZCW4Zqpay6Q6wLrzS7VvACInrdqniPQ5pyvGI+/gHer7+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758063; c=relaxed/simple;
	bh=Bnh6jO1Xy13ftmcJF+1Vf1MnXObyd75cssr4x2hIiLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKjVjHxM6FFY9qFsbHcy4EQojeTC5PfHgDT9ljWLnceHtyyCuWFzE3ARMBI/U/weYPfh/gceBSICh2vIWQRs8VhfgFNrMhbzEGxIo11hhsFDB5j51oW89FvoDnwqrc2zrHB4FrVGzZBUuYvWTwMnzEX7BiNLqoHNNMG0t8QI2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX5ZKMF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX5ZKMF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE1E1F0089C;
	Sun, 11 Oct 2026 22:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758062;
	bh=V+K6SCziu8rlRGETQFMTQ2KDLDmxQbugZoBZRFEAaCQ=;
	h=From:To:Cc:Subject:Date;
	b=oX5ZKMF/XDzzrSWPqrLme86juYDxqOq/oxn0QVdFxvPQY/ekJGHhV7sN82oIQQLyc
	 afoYkfaBWMUPuCfyV1W40bgeNjz3DKDzOTjokK9Az+t529PFhicL1sGckPlzMNqVPj
	 /75K7OugMYZynzdihT+QxQc0G+zsT/jLlJ8B5aDL4qYgBwqVW9OG8SQu9/3Y34/i+x
	 DvM+5eJqFzVh8OM9bGBSB3HwaW8ePZuTz5YXzxf6SfPAh6xuedUbYlUggXK+IU/2Nt
	 FduUi0WI/6GvbGKwoQXOzEp/1zeD7OM2M4SXaLgmggfQKhurbrZgZLPSEWxO3c/79n
	 SvH5iJStuVjsw==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/proc: proc-pid-vm: fix unused variable warning on non-x86
Date: Sun, 11 Oct 2026 18:33:39 -0400
Message-ID: <20261011223358.2327625-11-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

g_vsyscall is only used by the x86_64 test, so other architectures get:

  proc-pid-vm.c:224:21: warning: unused variable 'g_vsyscall' [-Wunused-variable]

Mark it __maybe_unused, like str_vsyscall next to it.

Fixes: 17415606f9d8b ("tools/testing/selftests/proc/proc-pid-vm.c: test with vsyscall in mind")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/proc/proc-pid-vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 4e6a3e53f9757..c5a66f481ab4d 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -221,7 +221,7 @@ static int make_exe(const uint8_t *payload, size_t len)
  * 1: vsyscall VMA is --xp		vsyscall=xonly
  * 2: vsyscall VMA is r-xp		vsyscall=emulate
  */
-static volatile int g_vsyscall;
+static volatile int g_vsyscall __maybe_unused;
 static const char *str_vsyscall __maybe_unused;
 
 static const char str_vsyscall_0[] __maybe_unused = "";
-- 
2.53.0

