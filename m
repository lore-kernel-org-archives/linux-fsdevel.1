Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793715787;
	b=MCf+j1I7tIoiGTKDi8tOsoB4GIOTJ9u1ZToTb9zXiuuZhqozmGt0Se5IaKkJ2/eoGFuM
	 NpeSQBs/hMkxYYR+GdkFfaTpWlN72t4pb8bmDU4CIjhlBIib0hrvljCbhZk4JsRzoOtPH
	 CqspaBe/UH2H5j0vsxUY34EiZOKKSi74vgzrM5F7lWwlNtSYX2KATJ17bKBc8d7ae+UCx
	 EcA8Y7q3l6ZI+/LWMWKwY661Ogts7tLpoLDSp/vreIheCgfe4ysdqnAH+8iaV77ydDfXx
	 gyYu5HlpQkQvlWyD+wB1ygnTJ06QrZEpcuk87dXMo6YmMw3GR8yiQwomgrxvbEqhKLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793715787;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o7VM6e2M+ho3AEfJ0rmxjTEZRPjXG/crZffo7NprhH4=;
	b=Mxy75GV2PuBhLHKvvb+q9nMnS9lYinYO79IxMlE4DpqNrD/k2CjnRRtQY+JyHzrrIMqJ
	 Ll01oOumIlHaFauDSdQXqSMh/ziuaJoBEN9qK8UWH8ozvq1aaA+vtdN3XG/mnPstxRszk
	 ZjFlhtpZTgD8FP8dIPNrPUw5el2fhEY6uNatcQ/PgT0YxAZR6CTTCTIpJK9JAgE0IxbyV
	 //LoRfAdwkXkJ+dFiPwMsCREDVVhwxnMUkn+qxwYd2eO0fHsofFypPwaehX3ofLVEwORk
	 MRwn9/TFWUKYb4MX+JmDAQhNxlIqVKfe121DjG9dHUUjngcaT3uq0kzxLYGO/iJDlUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XQjOgY/l";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B97B606A326;
	Tue,  3 Nov 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQjOgY/l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E561F0093A;
	Tue,  3 Nov 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793715786;
	bh=o7VM6e2M+ho3AEfJ0rmxjTEZRPjXG/crZffo7NprhH4=;
	h=From:To:Cc:Subject:Date;
	b=XQjOgY/lwMngj5FKic6DOI41rYN7SbyQVRssNtXIju4hKd7Jh3axVobm1BydxpFoH
	 siOu8IL8vmfVjvv3dkV4IUexLAPYjNVZxTQpurjqDxlKO+3TNBTkP7S9guwDL36tls
	 y1NNV3/NtNgj0u6nqAU9cCeG7uwqC1s+4Hfq4PuD4ztoatxUCD3vootuSzWzw9LxiP
	 SHzLtBExvNDnwgEyUQlPwF1T+qn/RVRW+bpIN0geku6suknO0/BVyeIuJeqBTHOqkp
	 zQKbJQSdGkXKjWYjwfWyCxt4UOR7UloYMxuw7ZKbqKtmTyMjRM39jYho/N6F9EO461
	 HC5W4SWz6GcNw==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/proc: search the kernel headers before the tools copies
Date: Tue,  3 Nov 2026 09:23:04 -0500
Message-ID: <20261103142304.122564-1-sashal@kernel.org>
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

The proc tests are the only selftests that add $(TOOLS_INCLUDES)
without $(KHDR_INCLUDES) in front of it. The <linux/types.h> in
tools/include/uapi then replaces the real one, and unlike the real one
it does not include <asm/types.h>. On powerpc and s390, <signal.h> pulls
in the kernel's asm/sigcontext.h, which needs __vector128 from
asm/types.h, so eight proc tests fail to build on powerpc and six on
s390:

  /usr/lib/linux/uapi/s390/asm/sigcontext.h:73:9: error: unknown type name '__vector128'

Put $(KHDR_INCLUDES) before $(TOOLS_INCLUDES), as the other selftests
that use TOOLS_INCLUDES do, so that <linux/types.h> comes from the
headers of the kernel under test.

Fixes: 81510a0eaa69 ("selftests/proc: add PROCMAP_QUERY ioctl tests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
KernelCI's powerpc and s390 kselftest builds hit this. I reproduced the
error with s390x-linux-gnu-gcc by including asm/sigcontext.h with
tools/include/uapi in front of the system headers, and it builds with
the kernel headers searched first. The proc tests for x86_64 build the
same 26 programs without warnings before and after, with O= and without
installed headers.

 tools/testing/selftests/proc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index a7de2bb6d8be1..30cce563d9a33 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += $(TOOLS_INCLUDES)
+CFLAGS += $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.53.0

