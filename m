Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4B4A99A8
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364723; cv=none; b=tqVEuHUdtIflVc3oMOK4anJmbUFw4V3x+wMxv7UEKXTBicxnbMkWKmEF3AsdJCS3xtD4IDKQT15mRCRP/yAfQ8HYXOuJJA55Ot8gnF77DPB8KuyXToEIKHEbmwKzmx4x0YWPy8OgSQlEVeF5ugEnMzcihqwV7tzeWHzeyW0eMf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364723; c=relaxed/simple;
	bh=N/jrKkHw2BcVPQfX3RZkyKgyQEPpUfbrgqrtbxQkLdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Go7lE7vChnMFN5Bomc/49MkH4qdihDnzHtTqxCpir1cnyy/oAX+eDwOsW2W9LvqtFSMpjUKgsgaMHKKZWIYLkLtvOk6HbMrQ3+9ckHrEBY1hiXSdmAtG3SeDMh9krD9IaJaG0D3F6/Ptlk0KFvfCpyLC3zkKm4HKxAWJRXsfJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jofD2Ofv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jofD2Ofv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32351F00A3F;
	Wed,  2 Sep 2026 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364722;
	bh=06m11aklNhJpstBVPKRB/RHBSPgvp9Y6/Ntsbb+VuWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jofD2Ofvj3aFq7lDHKkqcPu/pzq4jOvSfaxuQCHXJ08Qr9cXhW1GIixl8dG2ogUdc
	 2w8qGVJs5eHfayQ/1MIUO0BrrkhpE48/M5hLlpa1+fYhbNuU9a/d6jPK0TF251qxC1
	 57jV8Qm/R4WGAIj0ZZ0VcjJfqVmrJt96pV4P3jwJ+iS+hziS3oHNKgujDstfaXVNxJ
	 GyYe+d4sTByHjiF49raG/POx87lcQ9LwCX6odDJGlJOcmUPo9GA78QFvfxGdG18G+O
	 y4Hh1nZpzH8S0BSngo4OEeiBgW0jQBaI2XQjrtw38pHfBqw0PJ0PCX9XddnBErznem
	 ggVDPAcE+LmBw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:19 +0200
Subject: [PATCH RFC v2 01/16] fs: don't open-code file_close_fd() in
 close_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-1-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=N/jrKkHw2BcVPQfX3RZkyKgyQEPpUfbrgqrtbxQkLdo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/e8HGuxk85BltnMauXIVrNJWz7JZiX57qnix8pM
 X/afvFrRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESKGBl+s5eynbt/QWSLhsVh
 pumXGR1V160XCrbi7Z9flnvnhOWkPkaGM1/ONSrNZgqO6djEzH3vHr+/i9CmU0EeWT8XlcwL2Pa
 bBQA=
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

