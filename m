Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CEB4AA018
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364742; cv=none; b=B03zaOltSZdK+DT7A5Bl54BjO2sM5bjLFbNA6ZGifxyaM1bex5bXDcfJ66b0gG1B0oY/ojM/D0MHYbtr4pvrbrwmQOl9q/JEAodF9c5n+AQKKtMljTSr/ArscOLM6blFvcZ5L4XaWziEgEDs+Qws7s6WJ6jqO9xH/ugml3ZaKWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364742; c=relaxed/simple;
	bh=DrscpHIGnDs6UaTiQJmbFuQqDLL3TR77zTejLbdcVmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZAdzbPCqH/jh7mgHTCG+rvhBAUz3GjYGxTnux+ofdcvON/Tg9+TLRp9NBkSohH/ZBGp0dgpX5lbio6JslnmmYwOgCOMeOrp59E/9fdzUUQRPrdp8+LozquNCJHqNgRAm/56kT6EjohoERv7e0d4+Hx2lRfVOeo7hgRYj+zssPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk0WTxHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk0WTxHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594021F000E9;
	Wed,  2 Sep 2026 15:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364740;
	bh=c/Z5ryJMQN1sSyGyc47sf/Wnd4AsfDmjSePxQCpzROg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Jk0WTxHrH+UFLxpkymLZtdktd716aBp67kEP6TybqQjFoAiBTGLn8E/G2G/kLzvNq
	 vqpEnxxO2ZHQcgcIvf1EjWSw9/qc/twPDX/5n+3IwFr7A867VqmGyBb3dKmxnlviqc
	 e6Ks7jg/+lFrJDbf/rUFfT7BF6yfvuaQuC7T39q2s2lcEhpNjX9d4K0IAfzygV8ZSd
	 tpCROkqQ/AbA6FwhGJMjxAoXTKGrnQHOMVkgdh7VW7Is0tp0LuFicgIiKgGJC/l1UX
	 nFmqUHxH9B9jSW5uTp0M33nEcuMOsWoC5XA0hMN2BehaQHLy38JuMCtg6pL50PL/4e
	 JmoPkJA1a8X2g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:26 +0200
Subject: [PATCH RFC v2 08/16] exec: release fdtable after exec locks drop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-8-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2310; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DrscpHIGnDs6UaTiQJmbFuQqDLL3TR77zTejLbdcVmY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF9xkPV1cNTn2j1hq7snH3HqFs4sbn8taJVy7PGev
 X8v5b6911HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRkDeMDK9+i2YYpi7V7PO+
 M7NB+TYLX36P8A3pS9sWftPPXzFF9QEjw2q9vht5FYqtNpcUnCP2vitqSVZ661OYG/VLr4k7aaY
 TPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

During exec the task gets a private fdtable and releases the shared
fdtable. This all happens under cred_guard_mutex. If the exec'ing task
has the last reference on the fdtable close_files() closes all files.
Today this happens to be deferred to task work. Following patches will
make that part synchronous so the final put needs to move out of the
cred_guard_mutex.

The shared table now lives until free_bprm() instead of dying in
begin_new_exec(). This doesn't matter as nothing can get access to the
old table anymore and closing of files would've been deferred to task
work anyway.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 6 ++++--
 include/linux/binfmts.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 713819244d23..be8601d9c691 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1165,7 +1165,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 	if (files)
-		put_files_struct(switch_files_struct(me, files));
+		bprm->old_files = switch_files_struct(me, files);
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
@@ -1472,7 +1472,9 @@ static void free_bprm(struct linux_binprm *bprm)
 		mutex_unlock(&current->signal->cred_guard_mutex);
 		abort_creds(bprm->cred);
 	}
-	/* The exec locks are out of the way now, see close_cloexec_files(). */
+	/* The exec locks are gone, release what begin_new_exec() closed. */
+	if (bprm->old_files)
+		put_files_struct(bprm->old_files);
 	fput_list(&bprm->cloexec_files);
 	/* exec swapped the mm but failed before setup_new_exec() freed it */
 	if (bprm->old_mm)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index be935320f1c7..0f0fcf859b4f 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -37,6 +37,8 @@ struct linux_binprm {
 #endif
 	struct mm_struct *mm;
 	struct mm_struct *old_mm;	/* replaced address space, freed by setup_new_exec() */
+	/* Descriptor table displaced by begin_new_exec(), put by free_bprm(). */
+	struct files_struct *old_files;
 	/* user_ns published to task->exec_state at execve, narrowed by would_dump(). */
 	struct user_namespace *user_ns;
 	unsigned long p; /* current top of mem */

-- 
2.53.0

