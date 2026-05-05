Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836A3C2768
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960445; cv=none; b=m9brHU/Ls3a0w6KcbITu/nmyLQ/30M7DCVOuTiV8hVIAmhwXOFZnTJC8AZy9Pb2O/E0I8vIq9JO80LGOwlQStvM+cZyLc6x3v/1HsTCw6lsjramYriA5kAxFAzrS7q+r1raT7D2BxN7DwoXUuBiKps5y5p88n6iDc/KzzOCaYL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960445; c=relaxed/simple;
	bh=c84P57wvbwm9aYUjeK6x1gHGJ3MqfDr81EYVWSoRmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxWNJMMOq2T8jZvWxxAwUgEO/WOzuBr7FFK8DJ30p7ciI0qL6ZlMMMznw4RkAtGwA7ZGjCpzWjw6zLBb0xVRKm8ZtpejYWlrPU3No4tH+e0iroT1nKB2S52w57BaY/ZKvN782ROIicrvTfdQEG/y01E8kDkU7DTHdCWbUM3X6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nAXg6Lo0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nAXg6Lo0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OeKkLbt/CTaVTc4tUQ0smwd6LOffyf9RbvvLM4o8QTk=; b=nAXg6Lo0aD6T3GYzrsKnDBsPcP
	yYkGabaxmrcBJ+xUECGJgX7sa+N8omd4jBkoHHwj7l/+pElg+vZILd29WsKW2HwEBp5vSpDmfz/cX
	HV35Hm1qyI4BQcap8Ul8wcEdl0qF9fMYgNpzbxHBC2jRp5ZvVm2ylgNqYLK7Ly2umdUJatIFnG35W
	5oDlvsJH61o+1SNelKC9tfPWTgqHUruJ+y4HBY744usrAdYcGkLyrOZaXh8vN3bT89cWFuhekPhaq
	YwuSfv10D7Mq6CgGIDsp+uokN6jNAQt0XjS7yFly4vI2qHOKsq+nDEOPJimkYkYrNBnW504NX5hIN
	HYPUK4NQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8je-00000005I72-0fIn;
	Tue, 05 May 2026 05:54:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 12/25] reducing rcu_read_lock() scopes in dput and friends, step 1
Date: Tue,  5 May 2026 06:53:59 +0100
Message-ID: <20260505055412.1261144-13-viro@zeniv.linux.org.uk>
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

rcu_read_lock() scopes in dentry eviction machinery are too wide;
worse, quite a few of the function involved are not neutral wrt
that, making them harder to reason about.

rcu_read_lock() scope is not the only thing establishing an
RCU read-side critical area - spin_lock scope does the same and
they can be mixed - the sequence
	rcu_read_lock()
	...
	spin_lock()
	...
	rcu_read_unlock()
	...
	rcu_read_lock()
	...
	spun_unlock()
	...
	rcu_read_unlock()
is an unbroken RCU read-side critical area.

Use of that observation allows to shrink rcu_read_lock() scopes;
it's too delicate to do that in a single step, so we'll split that
into several commits.

This one breaks rcu_read_lock() scopes in front of shrink_kill() call
in shrink_dentry_list() and finish_dput() call in dput(); in both
places we are withing ->d_lock scope, so doing that won't change
the RCU read-side critical areas.

With that done, we have all calls of shrink_kill() and finish_dput()
immediately preceded by rcu_read_lock(); next step will use that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7cf965f9fb29..d690c18f0c33 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -978,6 +978,8 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 		return;
 	}
+	rcu_read_unlock();
+	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -1682,6 +1684,8 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				wait_for_completion(&wait.completion);
 				continue;
 			}
+			rcu_read_unlock();
+			rcu_read_lock();
 			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
-- 
2.47.3

