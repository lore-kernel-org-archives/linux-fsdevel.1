Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51549576ED2
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969183; cv=none; b=gOrkdJiqtf7pDUIcZU3jIPvdc43jY2ZJp6mXLDVnR1CDucvdJtKRsFFMUeduf9DdphBNJFLmgOD7zws2Ukb/YQOwc8Fc+5DpPxkv1jEjg3ZCs5pdaW3acQym21rk4XGXnYthUQioLoo97P85HXX4KQHegvEMTbEHcK2yzGq9KrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969183; c=relaxed/simple;
	bh=N/jrKkHw2BcVPQfX3RZkyKgyQEPpUfbrgqrtbxQkLdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXpBtkqEAbgxKKlZ6icSU0m8LUk156U/3fN5AqzZA6yUrn8su8XxIEIBcSGTysPIvuat6fLdp32rp7Q0JndzWQYC4dDjORG6N5q6clbetoABU0ZZzh7OYVjNzFt3pppdhsOzggX4brxqmHPJ4y9G3k5zkFN/hYyqMpOW9xybF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CxHiLqY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CxHiLqY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE8D1F00A3A;
	Wed,  9 Sep 2026 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969181;
	bh=06m11aklNhJpstBVPKRB/RHBSPgvp9Y6/Ntsbb+VuWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CxHiLqY6seozZgKYNSMbsOxbQfd/SfujTRgz4T0/IvEQF2Yvoj+N6Pynoi/QYA8Vj
	 IicJuqRr0+wGf8K4ZWKNRdg3bZ+dVnHEX483CsPKYMJnMOCmi08RprrfPp19qoGRvo
	 mGWXj/8SopyblC/pZdT008EtvNL8zAwI2loAUBa/B97jkT0QKc+AP/i5jAAjdyeQ41
	 zSo/abGnOE0xQGjGVs5ZgdfkorN8j5NqaLp+VjlXgY6J3YQZd1XvR7saYtEkeSCQ6t
	 5SWKG6GKgmu175DqRRVCgf+utEQQKmRLMyO4RDjbG5BzjRwmn1v44gOe15stiujOCF
	 kSdZsCs9oPeuQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:44 +0200
Subject: [PATCH RFC v3 01/15] fs: don't open-code file_close_fd() in
 close_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-1-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLjaN0Wo6u21+i3aU1a5by585HrlWKrI1p96c6s+l
 qzZEv7QvqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiGToM/+MKqrft+D05bE30
 h8dRF/jUd9ecuD/xIbee/EUeoRLdz1cZGc4eTdz+1TapRWXnM699PaemymU2XHy/siSw59Yxj4y
 FaQwA
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

