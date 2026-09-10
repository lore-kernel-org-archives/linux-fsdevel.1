Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8E148EC88
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055319; cv=none; b=GIR8L5IkFYtaYJVfqpLbHdziNLbOY38iKwnDqYogAkNfWvEvHnvNN+il/Un3WGNbNNKahGV+gK4QhT2KhflEYiUojyfFdqWKb89N7PjsUif/KqwUZeRbqvm9+vG+OB3qIwAi/01Htxg9vZqJmDsK51mhHPanpy3WeIOWlGlz2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055319; c=relaxed/simple;
	bh=PxyyXPOE8ycy9IQzZwapz2hpjOhLU9ku6+6XcQeZ20I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/BVzc1eSLBRBuNEyAkYLtoRxMvKY5PNm9eJpezZBvw6FP/UL9UO+lionc1+Mu7B2nTWHr7qZ1BUlZaJBxLxkSHcf5h33+ygP5sSY2IBCsR3bi2ymUKsgmCxmQRBgKdl0VLLYkok7IsBVjqeizAjYcM625RV3OhX3XpEcyXBY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKyBcVNe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKyBcVNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4EF01F00893;
	Thu, 10 Sep 2026 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055318;
	bh=+wYLSRkQsOVEUFbc2X+ZQ5LrB1V1iPuBcEj3ch4jXvk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QKyBcVNewzP09ToI1i/v76CgJLushjFjLg+H8B+HA7c/WDaHoP3YTP1xjcXRvZlAp
	 xSNJc/Cr0a+v90t4mtRU1U7YiKtKaxQeQTiX1PKBx1vfiGYHDg41stUmpgyljfAimq
	 HP8vpzJJZIGluqhA16MZWYkN4FDYaD65JkS/5TgLjNH5PxLKFYIGAfuFtFaJ6D3r7Q
	 9VMWW4Gj1hF4/Ejd1D8MNyizoIQf+3ukYAHSwm9lQut36q+kD8EGVvBqEyKW3E9Pde
	 lKZ+NnhA8t81CYZIK1XZRnvIcRDSX1ZuRkm60SX8/UOJlY7PolfRj9r56xX02ngAgG
	 tIZ3aTJKFT2bw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:05 +0200
Subject: [PATCH RFC v4 07/18] fs: make close_range() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-7-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PxyyXPOE8ycy9IQzZwapz2hpjOhLU9ku6+6XcQeZ20I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumirvjIxU4at7Z6d7nKJ8Ca2cmvp+duPJHeXrC92i
 2Nj4pPrKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMj7j4wM3XqCucuvetRo9bbM
 qlzv92Oa/SweRuErt70TFqy4YTf7LcP/8ryIqa9WnQ/czqTo2sbflvEqUWpWZXT9zZwNvakS9wV
 5AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

__range_close() closes through filp_close() so every file the caller
held the last reference to is punted to task work. That costs one
cmpxchg per file plus a list entry for any later task_work_cancel() to
search under ->pi_lock. close_range(2) exists to close many descriptors
in one go fast. So convert it to the same synchronous treatment as
close(2) and close_files().

Flush and put each file inline while ->file_lock is dropped.
close_range(2) now behaves like close(2).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index b2b466dce7fb..178c8cb9da09 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -807,7 +807,7 @@ static inline void __range_close(struct files_struct *files, unsigned int fd,
 		file = file_close_fd_locked(files, fd);
 		if (file) {
 			spin_unlock(&files->file_lock);
-			filp_close(file, files);
+			filp_close_sync(file, files);
 			cond_resched();
 			spin_lock(&files->file_lock);
 			fdt = files_fdtable(files);

-- 
2.53.0

