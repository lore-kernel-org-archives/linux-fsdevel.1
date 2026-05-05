Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AC3BFE2E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960443; cv=none; b=MkN+tZydF97Qcoun0sKKXXPEXfmtPMRT3W0SsOjIZhIaCkd9SGXmiwZ7IZ9gpBZerkvUabOb74rdH+3gmd8iS8XcqdvyFyQE5KozY3tget1ZxHBHERXUuQMhQuwjUeMYzDcdYFUF+YGa5zmNOPUP3WWYEchXuNyVtQQiaspc6/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960443; c=relaxed/simple;
	bh=tGXpDWSyk+EnPT8TLTHlyp8vOXrCaR0VsvCeUlShbwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmquskyRUPfD7BrQ1ADX5H3AVkVA8qcVvYFak10nzj5T4FJ4Uq6PV7S8BJnIbeLm8SyI+uIDaaOTXnRCe3yaD7MHFhsmuiJyO0mkQeijUVrzoX0gvNHdgFQcpAi2QRusRp1rCcQOtoH/k0Y1DKC/RFCuq3OKgHEM41L0KmhxSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eSUPsB8L; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eSUPsB8L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9iJKNwsxvOC9yahTet2lnZCpo86rjvzgjC2wKmKRbM0=; b=eSUPsB8LYSz8jlcRB7W7lpX5ry
	Pb+7mX3ndRHmMYEllDWo3/xmrkgjkhP78e3v0oJdM+K2Ol3fhUdCqcmf10xfqpEWmYz7TDZnqgx2A
	aB9zCVr9lkvK0SDjHRUA/vEgoknJFFIK3+gQpi2CmZWH1aQer/NoL/5WCAaZ2x9DLWQm0LOA2QzdU
	v2v+nOeE6l+RedIhIp/N4M4gLU686kbn0T8s+xk14QFPo872h8TTA+6lj+ThhK7RAVzEZPSP+TFDb
	JxAhuWjz+jaRFyXJl38FoWVNWL2XTXQLLtbTy/obPIgn6nHMvEuf6BeW0jWiddtQ57Xo5sVL0iqmB
	xaylpzQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jW-00000005I5X-0EgL;
	Tue, 05 May 2026 05:54:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 02/25] alloc_path_pseudo(): make sure we don't end up with NORCU dentries for directories
Date: Tue,  5 May 2026 06:53:49 +0100
Message-ID: <20260505055412.1261144-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A lot of places relies upon directories never having NORCU dentries;
currently that property holds, but the proof is not straightforward
and rather brittle.

It's better to have that verified in the sole caller of d_alloc_pseudo(),
so that any future bugs in that direction were caught early.

That way we can be sure that
	* current directory of any process is not NORCU
	* root directory of any process is not NORCU
	* starting point of any LOOKUP_RCU pathwalk is not NORCU
	* dget_parent() can rely upon ->d_parent not being NORCU
	* d_walk() and is_subdir() can rely upon the same
	* alloc_file_pseudo() won't create multiple aliases for a directory
without having to go through a convoluted audit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/file_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 16e52e7fc2ac..108ba09fb402 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -402,6 +402,8 @@ static struct file *alloc_file(const struct path *path, int flags,
 static inline int alloc_path_pseudo(const char *name, struct inode *inode,
 				    struct vfsmount *mnt, struct path *path)
 {
+	if (WARN_ON_ONCE(S_ISDIR(inode->i_mode)))
+		return -EINVAL;
 	path->dentry = d_alloc_pseudo(mnt->mnt_sb, &QSTR(name));
 	if (!path->dentry)
 		return -ENOMEM;
-- 
2.47.3

