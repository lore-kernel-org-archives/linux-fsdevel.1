Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B981384CEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055303; cv=none; b=MgjZS2VhjdvgzPZDI3qs19NhHxx/e9ValpL7YmU3P/plE2dTxZL6l3N0Xl5g6SEM2bS3M6rliKqxIqWXSLaXwcNBt/o9jiFsjBIXrvBSzgpmFVtLzhlEWsixSsG5Y9F95EEPX2BS9KqBQTqLgBmcYGxT32NP14Q4jqbq7qgMp2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055303; c=relaxed/simple;
	bh=N/jrKkHw2BcVPQfX3RZkyKgyQEPpUfbrgqrtbxQkLdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f54F1kGAxklE6Sl3Hgi6wUCAPVOGWu5Jkbte4B7XU+00ElGKac4pEx8CndMy4ZHVMKIwXcvN1wlhwawbMLidfMGfwl3VmoqGUc4tPde4Ct/jbNiV4Z+OSaKupMyLHF9LpWf44d6UYxhoY8nRg6X8hbe7ArT1k4NoUFeHfc00nhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBpOqOLh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBpOqOLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9094A1F00893;
	Thu, 10 Sep 2026 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055301;
	bh=06m11aklNhJpstBVPKRB/RHBSPgvp9Y6/Ntsbb+VuWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cBpOqOLhQ1MxrzfRejfvkl/2sBx39m4v82HpsLz3Ir9DDvpi/Blm6Crz7owqh1+u5
	 umh7AEJo4Yfqs5tEUPqOirIfFl1ieDp4OnIwqw+k/WqDmu7DFh8sr7dskSA6LnHhEw
	 sI4boTcuh4JpVuH6XhvyHPnYDIMRKc80xS9u6s8HtLbgcSMdHuLdP/2r+uPs708VVo
	 ZEfIvDz0dh/ixXvnhI+5YTZUC6yqHYLo+DqmpyokeJyaCsfn6mzhY0ne+qaz8nZ5JO
	 xfMi/l5vwX8itnhZ2Z+jdhqxJur9sXKL35k6mOHe6+aMyxYtKiNjaHDe6OmZvcLfXe
	 KocvarObzjfVQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:47:59 +0200
Subject: [PATCH RFC v4 01/18] fs: don't open-code file_close_fd() in
 close_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-1-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=N/jrKkHw2BcVPQfX3RZkyKgyQEPpUfbrgqrtbxQkLdo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumibeeS70qSlezbk8Ma+4z+amVh9veDmX/83MwI5o
 pItrj/37ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIFHFGhsN9EY1sm88o/tzr
 K7DfJu7TtIcqR2LVVvfdlPUKVe48ysHIsEKLlX25Y9zqH04NX/WP/ftaK9NRsY4zu36Wcz8jF8d
 dFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

close_fd() takes the lock, calls file_close_fd_locked() and drops the
lock, which is exactly what file_close_fd() does. Use it.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..59673547de90 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -732,16 +732,13 @@ struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
 
 int close_fd(unsigned fd)
 {
-	struct files_struct *files = current->files;
 	struct file *file;
 
-	spin_lock(&files->file_lock);
-	file = file_close_fd_locked(files, fd);
-	spin_unlock(&files->file_lock);
+	file = file_close_fd(fd);
 	if (!file)
 		return -EBADF;
 
-	return filp_close(file, files);
+	return filp_close(file, current->files);
 }
 EXPORT_SYMBOL(close_fd);
 

-- 
2.53.0

