Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1705401A13
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472905; cv=none; b=X9Kk2Qc4YzILJwjmJG2pLQaMoOvXgInIZG3bBIK9TY2A5qIU41xoQP1gp09K/2FD1BKujYWoKEcC1NLNLwndfnKG6u0oXtFjkcq5B4/+sURO2Br0TV1pGM4saJ+SejUdhyUqAX2Jdxj9jL/VisXIBLOfzlXLyP6/VZkcXfp3KWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472905; c=relaxed/simple;
	bh=Szy3jMSi+5fiUYExH3Q+THTfm1vzHGd7FbdzL+AZ09Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKb4lPyXcVFwdgiEP8s+XvnM9KUlT6JGG5uucm/km/ktZDvuBLolVdeNNJYeIvyH8eDRZImLaA89fB8PXQpEQ3QUJhxLOo6Vy7LP9U2WXEHwULH4rM2fE0RR5gjFeWft33vpzduvzJgbTvN9e3Y/RiAgEFQAVDP46O1XN2rt4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u7rJ83Vc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u7rJ83Vc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vEMOwbyfWPbwkzu8m1kkgOnR4ZwARyk/e5PqlZaGXV0=; b=u7rJ83VcICjN3h6efGT3L5Q/8d
	JJKASLz6Sk6RGCFXPzMG7Ym4fsfsxn877f2Xz3+oUmvvmNde/f2k/KPh4iB4OodtMUl+3Vdof+cyF
	SOzdLNkQA3xYkN5SSqMfffkdBmb7Bw26Fw30f34+zG+6lq6k70Kgwe4or56duIhoLYR7uaLeS6QOe
	VM1pPjTEWPYw3WAbPD9JyAhHFCoXFLDKllu705K+4uTn7zvQqk4c1fvTAwClEKiCo5thzXylKIbqa
	KzwgJfBj1Y5O5TqO+vR3BoRokid11t4Es+nUMgOimXrKviAm3NG52tHJBV5HQCw24YHb5VldObHY5
	fZMdiE7Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUgKl-0000000CjDr-0mGK;
	Wed, 03 Jun 2026 07:48:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 00/18] configfs cleanups and fixes
Date: Wed,  3 Jun 2026 08:47:54 +0100
Message-ID: <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

	Updated and rebased to -rc6; changes since v1:
* added a fix for races between lseek() and directory removals; had been
there since 2008.  If we use list_for_each_entry_safe(), we need to make
sure that the next object won't get moved around and/or removed while
we are in the loop body; holding the directory locked is enough to make
sure that another thread won't add/remove stuff to that directory, but
it does *not* prevent cursors being moved around.  So when lseek() for
those switched to global spinlock for list protection, all places that
relies upon the directory lock alone for list traversals needed to be
modified...
	Fixes (configfs_lookup()-triggered UAF and this one) are in
the beginning of the queue; that's #fixes-configfs and the rest is on
top of those.
* fixed braindamage in "kill configfs_drop_dentry()" (used to be #13,
now #14).
* added several "correct the argument types" patches - removing
never unused arguments for configfs_attach_{group,item}() and
converting create_default_group() from parent's config_group to
parent's dentry.

	This branch (7.1-rc6-based) lives in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.configfs
Individual patches in followups.  It still needs more testing...

	Review and testing would be very welcome.

I've also pushed tentative followups out into #more.configfs, but those
definitely will miss the coming merge window.  Will post separately...

Al Viro (18):
  configfs_lookup(): don't leave ->s_dentry dangling on failure
  configfs: fix lockless traversals of ->s_children
  configfs_mkdir(): use take_dentry_name_snapshot()
  configfs_detach_prep(): pass configfs_dirent instead of dentry
  configfs_depend_prep(): pass configfs_dirent instead of dentry
  configfs_do_depend_item(): pass configfs_dirent instead of dentry
  configfs_detach_rollback(): pass configfs_dirent instead of dentry
  populate_group(): move cleanup on failure to the sole caller
  populate_attrs(): move cleanup to the sole caller
  configfs_remove_dir(), detach_attrs(): switch to passing dentry
  switch configfs_detach_{group,item}() to passing dentry
  configfs: dentry refcount needs to be pinned only once
  configfs: mark pinned dentries persistent
  kill configfs_drop_dentry()
  configfs_create(): lift parent timestamp updates into callers
  configs_attach_item(): drop unused parent_item argument
  configfs_attach_group(): drop the unused parent_item argument
  create_default_group(): pass parent's dentry instead of config_group

 fs/configfs/configfs_internal.h |   1 -
 fs/configfs/dir.c               | 315 ++++++++++++++++----------------
 fs/configfs/inode.c             |  25 ---
 fs/configfs/symlink.c           |   3 +-
 4 files changed, 157 insertions(+), 187 deletions(-)

-- 
2.47.3

