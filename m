Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCB576EC1
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969202; cv=none; b=axEpEoihDQnGY+okIqNGOw6Cb/h7kSHPilC2isZ38dMwduiiaTleUJNm76Df9b2HNdPtD0wQqUP1iR0fh8pCs4Zi7VcwJIqdsLzo5O7Gj4+AMc4wXRiYqFUBjFPxhaYKiKrPm17MDQvkfEAKwMp5dL25gR3NdJW1vTorDKNSv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969202; c=relaxed/simple;
	bh=kky3uTIv90dIhc0aK9Rf76thC7AqszLRdA3IpA3CkAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRe4DhTbL5kmF5N3hd0r9sHYz5H04aQ+TLPc8jxnWgA2PgfMPZ2YNNmfAvfBy/pRQZGnxFhPrb1D8x0BCI/s8OXr22Wwls00hobzY8pEd4M3tZrAMz5iQVYfeS+R7HpCgl1ak4Zp2An2/x9swEgeoucsT2DBRZrTJRKLBQy51HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjrjWXiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjrjWXiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655D31F00A3D;
	Wed,  9 Sep 2026 15:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969200;
	bh=AmCRR5uoDQ/4mGi7vY+PHaJ5tMir3lwyo/zCiwpCmfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MjrjWXiGrtwythwjn5Em/gsYnE/hWVCqIEPzbjX+DWUJ7S4tjFSD8t9zu38uBoPix
	 HLvf1meO25Qqxw240hAlylKPW050m4D3phU+u2qaXiePfJSqTFqJTYoeNdNQmknpIc
	 yP4CF2gsU9ulIV1F9wRZ+b1WrEi5PUAWSTqA7zXmDfVaHXiIlfalTtcHHRzdDj5XaF
	 dq9y8+QdRM/qx9HRxGBNXJ4yx4O6c4YouYV0EJSL7Q6L8yx3yiewocsHG+XhZUgu9x
	 r2I1mTxmmBuSpdJmZDMImxiq49QITXUZdkpP/mqjzhrdl7PFpovjcLEpxwfqhkz859
	 ql+CHn3/eO2gw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:51 +0200
Subject: [PATCH RFC v3 08/15] fs: rename do_close_on_exec() to
 close_cloexec_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-8-04f907687563@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kky3uTIv90dIhc0aK9Rf76thC7AqszLRdA3IpA3CkAk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLga1X753M3b/TbavyZfWhZ4aV6Lh47W1Wu/2ZZKa
 zAViS+s7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+ylGhg1+z858X7B6VtBf
 p+bcNovfp2JvM3Lot0977B3z61q92kKG32y19nq//n6/kphQXCQ1iSewjcFV+8v5pf3rTwrlCZk
 6MAMA
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
index ae4702d7ae5f..71268b916419 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1179,7 +1179,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * This must happen after the point of no return, and after unsharing
 	 * the FD table.
 	 */
-	do_close_on_exec(me->files);
+	close_cloexec_files(me->files);
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
diff --git a/fs/file.c b/fs/file.c
index 82b17fe50d25..f99389bdfadb 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -908,7 +908,7 @@ struct file *file_close_fd(unsigned int fd)
 	return file;
 }
 
-void do_close_on_exec(struct files_struct *files)
+void close_cloexec_files(struct files_struct *files)
 {
 	unsigned i;
 	struct fdtable *fdt;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index acd59e40b76b..fe033bb35e35 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -107,7 +107,7 @@ struct fd_range {
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

