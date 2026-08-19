Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376523F329C;
	Wed, 19 Aug 2026 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181112; cv=none; b=AgjgbtdPU3AdbxiHbSUw0XO71bcuzrNCe49A1eQ+nW10b/tGFHVaz3Fb3Egqe/8aSN+RC37g4UBS1aEEkBewh2kBN0x7vPYUv4mwEiv2pBTIW7ENoOTnVlz1V20h3szTUqDiDw/sf23XePN4mtlRvDPfnyol5x0ahZr12d8vj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181112; c=relaxed/simple;
	bh=CDf2/UuMc2XBowFgVdwGiPjPw3vkqMeWbhqWHKnJoXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DmEV8F8ah1Kj/+Kpv+tiXAvcqdpyu4gu41OtRMsK3Z3Abt+c8jPj8ieybvhSWc6FhKAguNMpNbJA+xGPUyeFrXS28UNa9MD235Syzeec6xXF6N6HG7hyBnyQo3ugGJNISttMdJPSKG3FA8HyAEPxtOyLLleSIp+we9bmB91Svl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEo/GcvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEo/GcvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF091F00A3D;
	Wed, 19 Aug 2026 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181111;
	bh=+eE/AORVX+nBzdLhuXTjCNB11etNcl4Di3dO/GDhzUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UEo/GcvLbLse8DiCCa3t7vPZHj60cEF3fZrSik9Od4RpIOFSFmMwo7fEUfZgZR7Pt
	 udxRLnjSlYQv3oQqouyBpSyVJ6zf6n9Gy6bkUImPErHml4pJMDGP/IlljQbGMNFE04
	 A9TSHt3Ty9JknWI0dDqGELgO+d9HDU+otlMyoh1+dmSL4Jm4iKqraFCz3Frums7sDZ
	 LJ/mF44Lqx0HvnRhIYyIVcXddqyH3nvErDW/W1fcMaloLXs84ii1v4U5HDOoHgdSz8
	 unuwJWVOrMcWushztXgAFusUL71pcM4wVr2qDXyb1WFG9jdw5B6V6rQhddIwtTMFNl
	 rF5qLRVxZxzvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:37 +0200
Subject: [PATCH v2 20/22] selftests/coredump: put a hole in the middle of a
 sparse mapping
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-20-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1482; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CDf2/UuMc2XBowFgVdwGiPjPw3vkqMeWbhqWHKnJoXk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me9vF+H9di5sY8ORyo2Z2qz/hCYU/K/5+HdTcsiVe
 cuKvmaFdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkgz/DXznjj78+PZreIRbI
 +6nK0qx146GMc785hBbGqdUv+HuQOYnhv29pM/eVHcLM3xs938SYnmKtqXRtfqxaKHxaXU953YM
 8LgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The crashing_child_sparse() helper touches the first page of the
mapping. That forces everything behind it to be a trailing hole. This is
easy to handle. Make the test more difficult meaningful by also touchin
the last page. This causes the hole to sit between two populated pages.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test_helpers.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 45d76fa0f469..89f3954c5607 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -58,14 +58,16 @@ void crashing_child_sparse(size_t size)
 	char *p;
 
 	/*
-	 * Touch the first page only. The whole mapping is dumped because
-	 * it has been written to, but all of it save that one page is a
-	 * hole.
+	 * Touch the first and the last page. This will cause the whole mapping
+	 * to be dumped because it has been written to. Everything between
+	 * those two pages is a hole though.
 	 */
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE,
 		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
-	if (p != MAP_FAILED)
+	if (p != MAP_FAILED) {
 		p[0] = 'x';
+		p[size - 1] = 'x';
+	}
 
 	/* crash on purpose */
 	*(volatile int *)NULL = 0;

-- 
2.53.0

