Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9501576EBE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969193; cv=none; b=e+Is8wz7I4OrCrzyoyjr7hymLtx8aNjLeOW1w3gp5MSonequysMKLYqoXSrB+nwztCb+hhX8hYsX49tktT5HynCT7tNg7haQuKqA9AXpvm8E5Op6Loz7U5aoxjdiuojQFVxdWJQBzuAezI4mMZVD6G2xGyoVxVM2MgtTkboWA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969193; c=relaxed/simple;
	bh=kzLf7ubXX69fJnu/H+0Z/4/ZnFRhmo4/m7JiXtw+3RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ydk2h5eY0JFF9gU7h3w83Mc5kmnrJ1dZgcRr5tsUNAC2VC2ptZyKNqmjO8ukPvToK2eF5eOc01XMLLMmLsrLOBcmabczw8/NHNZCnT6oLuwczE5Gg3kaZ0AAD+HcnZvMSuAR/CHUOZsGyORQ5OXFFvewiH0O/lIk5Z3EaLTLI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQmgEUoD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQmgEUoD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079121F00A3A;
	Wed,  9 Sep 2026 15:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969192;
	bh=XznAbig/fOAGdylG+44BV0/LM87yyRIk8IYGmq5wpmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fQmgEUoD3JMoAr16zq3lWtQxi+O6X+YyCnIJNju067436CgzBsw5NTSdl7CFd6Oo9
	 bwkx+nWA378kUUJ3dAcre7N76YqNJUiqRAi19xAymLPe613pccee3bItKXJPh7TlX2
	 dpon1uaBmFT7YviLJD75hQ07Etl1xq0LZoUJ3BpvhDdXb2VGSM3XIemPTMSiD38tnh
	 niyDmawpcjXCeV6pjkoav8d0TyGemb2JUkp5dagYGnznFg782WX7Og331ceGAYMgIf
	 xDEkbrbA5Z3faBkXN26sNM7hPm/UeTHb3ULCirpXjQeW54SOpXhPn2jUi8W1+5C7bj
	 uQwdTt7tW83FQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:48 +0200
Subject: [PATCH RFC v3 05/15] fs: move filp_flush() to other file helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-5-04f907687563@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kzLf7ubXX69fJnu/H+0Z/4/ZnFRhmo4/m7JiXtw+3RQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLjK5Lz4Yd6N65feuNzt2Wk1/alxq/k7rmkGUySfy
 PPmt/6J6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIht+MDG8unorcvfl21vOk
 LdO9133JmaL8YfVxF4aAYrNkz3ncfV8YGS4I/i8p/KTdMbe870jiuizfDSm1Ei331i1e4xO/KY+
 zkQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Various functions will flush and put each file inline the
way close(2) does in follow-up patches. Drop the static and add a
prototype next to file_close_fd_locked().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/internal.h | 1 +
 fs/open.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index c658c8a5ebd5..b1ca3320cb21 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -198,6 +198,7 @@ extern struct file *do_file_open_root(const struct path *,
 extern struct open_how build_open_how(int flags, umode_t mode);
 extern int build_open_flags(const struct open_how *how, struct open_flags *op);
 struct file *file_close_fd_locked(struct files_struct *files, unsigned fd);
+int filp_flush(struct file *filp, fl_owner_t id);
 
 int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
 int chmod_common(const struct path *path, umode_t mode);
diff --git a/fs/open.c b/fs/open.c
index 6b1c14e684a9..7181665c3af5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1506,7 +1506,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathname, umode_t, mode)
  * "id" is the POSIX thread ID. We use the
  * files pointer for this..
  */
-static int filp_flush(struct file *filp, fl_owner_t id)
+int filp_flush(struct file *filp, fl_owner_t id)
 {
 	int retval = 0;
 

-- 
2.53.0

