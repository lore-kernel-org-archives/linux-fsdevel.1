Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6A21CC71;
	Tue, 11 Aug 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462059; cv=none; b=HpdOyTuvoUodyqTkpa5yrZ7Xd9/ezl6JGUu24a7jc8vPWAsNPWvfnEATd+BfmgmB+sBsV0TfmlZbc7VHxD6o95uv3BuQZyUR06sl+C+qdauoUyDpLzS0+ew0SAcp2vJxKEQhzxHZgq7/tfDRdkDEU51zK17StwjAZ3YdWr5zS/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462059; c=relaxed/simple;
	bh=9qfTBP7vyCivJLvwjV8igaT+fa50Nmgpl18ZhB0KXys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZusbNEbphgTcD4P1r/eV54URJ4L60Q7qHVaGsSaEbia5mje2O259LcfJTrzk6XCtQQE+WV1U4bpH2gADsG7NP0tVTx98jvfEZndiHpxbiNKNJYaTT+ulPYxHOt7PVDdUBlZMosi97lMx46yqNmp2MXPsZpJkfZfzJPgl+PiHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC4py+uv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC4py+uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065F41F000E9;
	Tue, 11 Aug 2026 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462058;
	bh=CTiS8U5K7y3D0Dlv9kThq0rqgw/f8AQWtxw0lGe/Dc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mC4py+uvPpGye50ncXW6tN5UwwBurfR2YI6g2akn5SfoyucoN96Iuhu+NxGTOrH3o
	 MkqTLLRiH2AM9KlPjaR2x0/fyxoEibIafXOO4O/yk+7kseDcfoaIkc5ywjS76KIh58
	 uTZGsjBx58J2PC81zMZyAa3QR4lsnnkWNkaeafOqjDnExeGsfDgFeg0O0m2o91+zjy
	 TB1TdF8O5kIbuCnLqub754cG/W44hcDiRBfFXlySYmvNGiETfFDzTm3//KQOSCridE
	 jgNVU4iczl3HxAAwk/QzeZhQD+wpVjBU0+izdycJrar7GDIr9osZh/vZGtrcxKAzJR
	 Hkb2FHgVGGr3A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:22 +0200
Subject: [PATCH 01/11] selftests/coredump: discard the right amount after
 the coredump request
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-1-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9qfTBP7vyCivJLvwjV8igaT+fa50Nmgpl18ZhB0KXys=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2ydMf7Yj5mq10YbIOXkbJ95a9/zScZZbVZry5XOvO
 yzzO73VuqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiArMYGW7aJ8lq/vFdKsUS
 29T9edfMloBLLCp5ugHMK56ferXk0nFGhubEiY8Kd3sz7VsW2vO1z4dNb8lS6azWlYGrFy32vBp
 iygsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

read_coredump_req() gets the leftover wrong twice.

It takes the absolute difference of the two sizes, so a test binary that
knows a larger struct coredump_req than the kernel sends tries to discard
bytes that were never sent. And it hands recv() sizeof(buffer) instead of
the number of bytes it wants. So MSG_WAITALL waits for a whole page.
Either one blocks until the kernel closes the socket. Which it won't
because it is waiting for the coredump ack...

Its benign today because struct coredump_req hasn't grown. But let's fix
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

