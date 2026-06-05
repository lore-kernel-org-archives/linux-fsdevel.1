Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB613B1EFC
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636157; cv=none; b=MM98v8Uc39XXvitHbBly//0XJzXsyn/iiEGBKtBuz6CUgEmCEourWzBhTLhIQW8024zvikyRuAs9kUEUtYci8Tnavtah8MmIJO5cQJW9Iv7PxLxG2QhkzceMMJbHP0FsULPlYQ/Jj4drPXZ/2e9WXDf4BkMPQHSqEITKrLR4obY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636157; c=relaxed/simple;
	bh=ZsVfqeZtzi9zDAkbzGZOJofGw8/sOxY6Ae2QKQF3nnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7de9wi03AU8mgN17sRb4I06Mrewwa7reyzyCyoUSzdFV8dKIT5elHR0zDVPP5qME6y1F6W31ZQa7YXPnYIGAIEh6RlZmzsTqpSOvufTfXsdLASPGxzH9lK7WKqbizX5Bj2+kvwTQ0ED9HKsHIJ2MkR72hBUO/B5F6SMLNDcagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z0DfAK/F; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z0DfAK/F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KEhW/akt2/cIqnE4dVezYBM8F5HWFzdwcJY95JO1PLI=; b=Z0DfAK/F8zmzvabqLf3/b7GOe4
	csVmqCP/g37+ccA7+qtWMTElqKwZERJ1V+Svq+awVMqF8XMxaF5ZpUN4Fbvsun4gj1nZ6PjutM6W0
	y+509VktW+YoYs9BZvFPc7F+CQWcJsreLufJ40oeSTJiHTJl4pc5eN4pq1uy4v0u0b2ZOxQUCfKI7
	dFR8/7HudsK/ZzFFBKdIJbYCTWQUm5Vcj7nfVq9ykaeLVcOiGMOpZnoxo+SRehefJhmRosnVrBXWy
	n0sPfmkrecd5n54uR9CE6FCXyaDNL5gy5FXU35XasdWcSr3lj7Hb3zIIc3Aur0xqcSJBZsboCM+Mj
	OjSI9skw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005Tsl-1m3x;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 08/22] d_prune_aliases(): make sure to skip NORCU aliases
Date: Fri,  5 Jun 2026 06:08:56 +0100
Message-ID: <20260605050910.1306432-9-viro@zeniv.linux.org.uk>
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

Either they are busy (in which case they won't be moved to shrink
list anyway) or they have a zero refcount, in which case we really
shouldn't mess with them - whoever had dropped the refcount to
zero is on the way to evicting and freeing them.

That way we are guaranteed that only the thread that has dropped
refcount of NORCU dentry to zero might call lock_for_kill() and
__dentry_kill() for those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea26bd2dd2b2..b5604b84bafb 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1200,7 +1200,8 @@ void d_prune_aliases(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	for_each_alias(dentry, inode) {
 		spin_lock(&dentry->d_lock);
-		__move_to_shrink_list(dentry, &dispose);
+		if (likely(!(dentry->d_flags & DCACHE_NORCU)))
+			__move_to_shrink_list(dentry, &dispose);
 		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&inode->i_lock);
-- 
2.47.3

