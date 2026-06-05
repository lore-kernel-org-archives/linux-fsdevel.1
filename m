Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B693112BC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636158; cv=none; b=HArKHJSKA819rWeG8+x9VGbh81BLIRF3P1Ju38MSGd4sSnSfDdWfHz5Z+k2pKUBUcRkFANPsfSBXb682BOTCwide691tgK47dCxpgk5uiBQWvJ32haGjMKkLttQ3kDbLLUq4exWURno7orDiEN1Mz3PlPrIlpg8ZOfxjXIr16O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636158; c=relaxed/simple;
	bh=tGXpDWSyk+EnPT8TLTHlyp8vOXrCaR0VsvCeUlShbwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQmU4KkUn31/wcpXhuFiDFJWKeuZA3RNJQFLHLf9BHg5L9V/wo4ofxexdB8Ryt2rDeqMq/JgWxjtFENbBs0mLHVLuTFX03s+CwyyY8rZxcFWt9zFsUYA2w1Pjh9YKd+0HUNyQKibXjXaawNqvmgrbTv8fWbaYliTOXqAxwkCKNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=dLBnP0JS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="dLBnP0JS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9iJKNwsxvOC9yahTet2lnZCpo86rjvzgjC2wKmKRbM0=; b=dLBnP0JSAKvjAyaw4jVRTjfq0b
	Kl6qQ9Zxx2YmjAvRBQN5h0BidukoIxrfnOpSDbA78vVBXIovRDwHa1EJAuielkt4886vr7BRpsJ+V
	T0tcPU8CMALQt5GDgWVA8ErcXi1Jq0lzqj5PBZTzzC/MuKlCFYYG3eRacktoLLJ0TB845GKPrzwnG
	42V/a43r8l9S+AEag+kNTa7dEj0t3oHI8kt87xG+zz8Nnxm1w1yne5+jSotQ79ajygJwxgqeCbnHP
	wWpV+6vS/oPyoVih8M1qqDbdX+tnpdTq1hcn2FQRJ+OURXgZNLlEiOTOpBoMWSUWh8LmZzDF8N7Pw
	jl5Kyx3Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnv-00000005Tru-2HBF;
	Fri, 05 Jun 2026 05:09:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 02/22] alloc_path_pseudo(): make sure we don't end up with NORCU dentries for directories
Date: Fri,  5 Jun 2026 06:08:50 +0100
Message-ID: <20260605050910.1306432-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
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

