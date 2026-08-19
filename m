Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635E3A641D;
	Wed, 19 Aug 2026 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181019; cv=none; b=J5/ek2SOybK6VRc55lSh4SE+kCH0VO8OKmAzNhOBHdly0qo+D392BRdDfKBY0HvA8dAnXU2EexIUOqF2rOY/CkFSYgYUzQrZLxlNYHoRkKbpDrBVmUQh1aJBXwGRFTfAfXf+m7t5obKqXaXFZmHO9g5SYropNaK0oRVAqUALo2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181019; c=relaxed/simple;
	bh=dsu3ug1yJTi0SPZbLicDCFNStcMxXGAWYCl1/1v264s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wu2DV3ZHFoE9Suu30kM6EHJRhFAvC5GP5UsR/pr1bvwt3IzvfnSiNIi9Nr7Xzhanin8fcWO3cTAzJhpQJps29x3RondXPWsQDJcqEff3CgnCPiB96r3o96r6L7+vuupb/6XlASkdM8iK/GjKEwwbHb88r/YrOudNm5OPbs45qz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6JWGD+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6JWGD+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF71F000E9;
	Wed, 19 Aug 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181018;
	bh=ivPc/dtcW/97whhIcc40lJlLMO/RUpWFUvsYkOmQdfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K6JWGD+W555VcCnv/WfeQSB+QTrQbSBqmZ9f3ug7SqSUGzYbWr0dw66iiH8N56xB3
	 FVhtRLxW6JDZUa3YuUwlb9kGKhtvLUcxhU6d7R9+RD83f0WYxXybttNB3adLAvDfZx
	 cdl2qR5wwhP6/IQem4P/DhDavLdhnZfGQvoIXBDmhn2ucjkKPL8lVuji0h2Glg3S09
	 e/bA11p7IMAFLWhywPR4+fGjqwsZYLmbvb+kfG54EEBI9/GulE6lkFCq3hklGMCDgS
	 qrrz5HvMZLX0fyPeIhW1dc8zjIDKv+nb124YfIlTOyLZwA7auRxlmzONjbyM/Dkjwz
	 1ySXTCfRaRz8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:21 +0200
Subject: [PATCH v2 04/22] selftests/coredump: discard the right amount
 after the coredump request
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-4-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dsu3ug1yJTi0SPZbLicDCFNStcMxXGAWYCl1/1v264s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+7pRe3+NMWjXSGn5lHmO/EKd9Leiq2r49pmuC9Z
 ynJFa9fdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkViYjw76XK//37H+/YW/U
 tHo7Lyn1ta89ou43Hp/Le/qinD/j4lhGhn9iWpqvbRasebPDKSth9Szdm0/0Mzj/7pdY5XOlfc4
 LHTYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

read_coredump_req() gets the leftover wrong twice.

It takes the absolute difference of the two sizes, so a test binary that
knows a larger struct coredump_req than the kernel sends tries to discard
bytes that were never sent. And it hands recv() sizeof(buffer) instead of
the number of bytes it wants. So MSG_WAITALL waits for a whole page.
Either one blocks until the kernel closes the socket. Which it won't
because it is waiting for the coredump ack...

It's benign today because struct coredump_req hasn't grown. But let's fix
it for the future. Compute the leftover as what the kernel sent beyond
what was consumed.

Fixes: 59cd658eaf40 ("selftests/coredump: add coredump server selftests")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test_helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 2a20faf9cb0a..524fa5370593 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -235,10 +235,10 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	fprintf(stderr, "Read coredump request with size %u and mask 0x%llx\n",
 		req->size, (unsigned long long)req->mask);
 
-	if (user_size > kernel_size)
-		remaining_size = user_size - kernel_size;
-	else
+	if (kernel_size > user_size)
 		remaining_size = kernel_size - user_size;
+	else
+		remaining_size = 0;
 
 	if (PAGE_SIZE <= remaining_size)
 		return false;
@@ -250,7 +250,7 @@ bool read_coredump_req(int fd, struct coredump_req *req)
 	if (remaining_size) {
 		char buffer[PAGE_SIZE];
 
-		ret = recv(fd, buffer, sizeof(buffer), MSG_WAITALL);
+		ret = recv(fd, buffer, remaining_size, MSG_WAITALL);
 		if (ret != remaining_size)
 			return false;
 		fprintf(stderr, "Discarded %zu bytes of data after coredump request\n", remaining_size);

-- 
2.53.0

