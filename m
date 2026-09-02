Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CE4A9D61
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364729; cv=none; b=MLhuLDKFNkKLqymwrvo3CbsI/E7ikNFpfQl3gfLzvZhyGcQ/xk1kQNDLFo55X23fEkqk9kRk/Tz+aP42ghn3yV3bF+HwNFFlPKMfkI8MKGkV9klWgK/WpgIYHukz7wbLVXI7I2I+OnRXGbtnw2i8+L++0h1I0iWa/NItMvU/8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364729; c=relaxed/simple;
	bh=qQtOWH+id7e4R/plvSX3BrSEDhQtv13ozDkgv4HqfsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1i8p37qwR+pKq4HPCi3q42j1vbXTh8ge+xfhQD0G6kd+UsZC2KIXQLgJ4LrI01BCBCFpLAnYBOeG2uyJa54bsT7KZWpDKQuI4oSYYwJCQmmVC9ULsibs4okdCTJE7K4Ohs1SJyH+0HxPYC+Db64OKUx3I+l15ANAJCLPhkpExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcUUVhr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcUUVhr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A0F1F00A3A;
	Wed,  2 Sep 2026 15:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364727;
	bh=hhBAECpRk8ABWzO5QCVlWdHmdZyHyiW4ajcBcg98ZP8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HcUUVhr3Y5ccLOmIUnfruXkDhWVaMCTEFZnr3/KzyB9hYBFZWCfNJHS3AyGyGzkQP
	 F99AL9k0OqJ/Or4QJPd+38Cit/5gAFmiXaUk5s6RiUFDsnNpmOA26Lv/RsorIDrMFh
	 rZMQq2qnDAnJ+kFwGnEEqtJ+UUstVtlpnkOD3WoB243oU59hIEO1lqM24WAmmychSF
	 5wb+d/B72WtMN37n8W96Qwk7/Z6+ZIJWlAhB8GYPP4F5j1KY9UtB0X9AfnXy5Cs6ZY
	 pfbq6WZsBmbsnNKt88sT9s79Cmq61GUlXE1GJ0scD6Ak6Nd4sMYhDh0u+35F2XhxD1
	 EDWPlt/a4ihwA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:21 +0200
Subject: [PATCH RFC v2 03/16] fs: rename do_close_on_exec() to
 close_cloexec_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-3-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qQtOWH+id7e4R/plvSX3BrSEDhQtv13ozDkgv4HqfsU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF++1+z0o19bzvSv628/LdlcmbXu17FTAfnTX6jd3
 8MV8DfKqqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BeAirIwMb7dJ7p3aK/LPXueq
 +8qCLS1ZhRyp0qdPVj0vdwnW9jnFzsiw1b702Iu9PG+Cm38bq2VZCe8O+OfTwx9menhzKvt37Vo
 GAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rename the helper and align it with close_files().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 2 +-
 fs/file.c               | 2 +-
 include/linux/fdtable.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..92a02bce11d5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1220,7 +1220,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * trying to access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 */
-	do_close_on_exec(me->files);
+	close_cloexec_files(me->files);
 
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
diff --git a/fs/file.c b/fs/file.c
index 59673547de90..be06e09df41c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -884,7 +884,7 @@ struct file *file_close_fd(unsigned int fd)
 	return file;
 }
 
-void do_close_on_exec(struct files_struct *files)
+void close_cloexec_files(struct files_struct *files)
 {
 	unsigned i;
 	struct fdtable *fdt;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..e6b641d9eb91 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -105,7 +105,7 @@ struct fd_range {
 	unsigned int from, to;
 };
 struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
-void do_close_on_exec(struct files_struct *);
+void close_cloexec_files(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);

-- 
2.53.0

