Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716079;
	b=wU69ITzaZXkjnObnvCblsYg3HFz5ib8rimQ+FBDVEKVYC3S65h0qUDqK/3bqf7hTRXPC
	 gRcfEkFefpsp8+4woU+pN6x5pYZT3gLA7qlhrsh/VdPV2riXBZmKEX/PjcfoZJa629vl1
	 x18H0aKnUcgxUFlsnVFlIkTzWZk6/RpXe875PSWeTiUnvR3pQETOqpT4CXHqM0x1CgUst
	 LoEr2+dQypzk3DrGblH20QlBJ0fWfBpf2xlT79UD+u0TKCT1luQxnHFpk5Pf1mlNmKb6s
	 ZrTy4L/CvHyne52a37I9iqsB+2juwKGKwNw9jzjXof5jj9v48hzti6wOLHFbZn0WQ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dejmHhxeXbifKefac16SRC6v8LfF3VPO/ivty0pHofI=;
	b=erZkof23WKVSyJGNY9gPus03kqbQC8CEZ8u/JEcb3Wtm7cjl11N0dBuKNITSAlnh1ohQ
	 rYkQt8gu6K7MPfG+wALuY4rvtJZVH7xnBLxzod6iVOZKjOpKrAr8oxjy7cAyvNWmp5BHG
	 KoujHb5nqxYah2sARzfNq1z09Eya6Il3v4SyheeL4nmnMOPUwCK1mdUU1Fq0/RVYSKkl2
	 zJ7oTL/JYIifPicMUnfnf9FYjmAS/RFAnPNB+xGHf07Q8dWUsd1nFS1obMchGL9iT0WxQ
	 BLIeupAPJKQh/ThzW7FW7zZ/CYBRttWK9z9xR88IeHnLD64PtoelIA8B5rDZo3gKQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUKzUwyK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E143606A32C;
	Tue,  3 Nov 2026 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUKzUwyK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CBC1F00919;
	Tue,  3 Nov 2026 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716078;
	bh=dejmHhxeXbifKefac16SRC6v8LfF3VPO/ivty0pHofI=;
	h=From:To:Cc:Subject:Date;
	b=nUKzUwyK0jqNK151DC/OEVBoJAFG407hZrQ/MasVYD0biSZutqbyf+1knwKD4Yqqd
	 GVMota9jUUK2m4BSRL5GkG75UJbVC3E/ZJHsn15Z6UdXek/7MSnBI8rL+pyEVyYtLM
	 SImgscDKmCOEFdPG7weJ9C2SuC2w+Y7Pqs3m3yE39wtUGeHiAmM+dt+pqVid8ME/UT
	 sWcCjssy4K94wqnkkLJ2BbvJKKLUxnnUBqurlaUyRL6OuY+xUQm6T4pHnb5nYM+WkZ
	 nJP+CqxPHm0YZIAHpPUlbDPMOajRlPhwQ4ubFIaFmjuPspNiz5DAEAAHsfrrjYyt1H
	 X3+k0XKREgR6g==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <aleksa@amutable.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: probe for sanitizer support in fchmodat2 and openat2
Date: Tue,  3 Nov 2026 09:27:56 -0500
Message-ID: <20261103142756.132111-1-sashal@kernel.org>
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

The fchmodat2 and openat2 tests are always built with -fsanitize=address
and -fsanitize=undefined. Toolchains without the sanitizer runtimes,
such as clang without the compiler-rt package, cannot link them and the
tests fail to build:

  ld: cannot find /usr/lib/llvm-21/lib/clang/21/lib/x86_64-unknown-linux-gnu/libclang_rt.asan_static.a: No such file or directory

The same happens with USERLDFLAGS=-static, which AddressSanitizer does
not support. KernelCI's clang builds fail this way on every
architecture.

Link an empty program with the sanitizer flags first, and only add them
when that works. With the runtimes available the tests are built as
before.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Tested on x86_64 with gcc 16 and clang 21, building both suites with
O=: with the runtimes installed the binaries still link ASan as before.
With clang pointed at a resource directory without the runtimes, and
with gcc and USERLDFLAGS=-static, the build failed before and now
builds all five programs without the sanitizers. fchmodat2_test and the
openat2 tests give the same results from both builds.

 tools/testing/selftests/fchmodat2/Makefile     | 18 +++++++++++++-----
 .../selftests/filesystems/openat2/Makefile     | 18 +++++++++++++-----
 2 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
index 4373cea79b794..21f6b0b0cdc8f 100644
--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,15 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS := fchmodat2_test
+
+include ../lib.mk
 
 # gcc requires -static-libasan in order to ensure that Address Sanitizer's
 # library is the first one loaded. However, clang already statically links the
 # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
 # -static-libasan for clang builds.
+SANITIZER_CFLAGS := -fsanitize=address -fsanitize=undefined
 ifeq ($(LLVM),)
-    CFLAGS += -static-libasan
+    SANITIZER_CFLAGS += -static-libasan
 endif
 
-TEST_GEN_PROGS := fchmodat2_test
-
-include ../lib.mk
+# Build without the sanitizers when the toolchain cannot link them.
+ifeq ($(shell echo 'int main(void) { return 0; }' | $(CC) $(CFLAGS) \
+	$(SANITIZER_CFLAGS) $(LDFLAGS) -x c - -o /dev/null >/dev/null 2>&1 && \
+	echo y),y)
+CFLAGS += $(SANITIZER_CFLAGS)
+endif
diff --git a/tools/testing/selftests/filesystems/openat2/Makefile b/tools/testing/selftests/filesystems/openat2/Makefile
index d848aac96bded..2f712dfcbf75c 100644
--- a/tools/testing/selftests/filesystems/openat2/Makefile
+++ b/tools/testing/selftests/filesystems/openat2/Makefile
@@ -1,17 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += $(KHDR_INCLUDES)
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(TOOLS_INCLUDES)
+CFLAGS += -Wall -O2 -g $(TOOLS_INCLUDES)
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test emptypath_test
 
+LOCAL_HDRS += helpers.h
+
+include ../../lib.mk
+
 # gcc requires -static-libasan in order to ensure that Address Sanitizer's
 # library is the first one loaded. However, clang already statically links the
 # Address Sanitizer if -fsanitize is specified. Therefore, simply omit
 # -static-libasan for clang builds.
+SANITIZER_CFLAGS := -fsanitize=address -fsanitize=undefined
 ifeq ($(LLVM),)
-    CFLAGS += -static-libasan
+    SANITIZER_CFLAGS += -static-libasan
 endif
 
-LOCAL_HDRS += helpers.h
-
-include ../../lib.mk
+# Build without the sanitizers when the toolchain cannot link them.
+ifeq ($(shell echo 'int main(void) { return 0; }' | $(CC) $(CFLAGS) \
+	$(SANITIZER_CFLAGS) $(LDFLAGS) -x c - -o /dev/null >/dev/null 2>&1 && \
+	echo y),y)
+CFLAGS += $(SANITIZER_CFLAGS)
+endif
-- 
2.53.0

