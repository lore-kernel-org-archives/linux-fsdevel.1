Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDE146A66
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=R/+3rc9KR/ZcAdaaDND8lxGi4Hj4DnsSrzSHbzOnffIeg0s/YkGq3AT4XVbwMmZDRrvqPFpXozBSijW7mwjDkKQMPaOS4MfbGrwsxZER9T2UP/j7i+OhENpEcNtPTU35GqWphTyDTih6q4BVKcu0Zd2yaN/FZT8DGC85L30WgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=ieEPeIlJVh8gAJYUQgl6h2F7Kdaucv1KRuMAgWlFpwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6bkI5G/Hv2ITcrNSbLhqVsyCVVtdd18228oOUMKXwXeWNtcdCSSucbpdnWYZ4IBgfJfJ1GBchqvLYCf876N1jKR8X0DDRdOX6ozUwwFoLpu9x7OXbgH2ESKzsawNNbz9zPnlk4amUITIjq7Cq7nlAZT7HH0oN6JZ+p6wRyMjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=loTsHMjB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="loTsHMjB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nsNgl4c3uVeTLariaOIBAHv+Z4JHiJh90z3VssATSmg=; b=loTsHMjB6LrIXgwEPkgiHp236o
	6NKrk6ChxWqDItMDmiu3mMUGlIp0EgY/QM+5CjCCjCRFXKAk8naMZGPUWswrs17EvDdepXleXfHzo
	9/ymX6eKtoigf9VQzbhD+xvwIlxmjNj4ncsNWqrfJoXxtoXpUWzJvUi2Y43tSOrq9kQzDuFfF+8zU
	vBJMhO3quHeqBPd/3RlZbH2XQYYJbVhCXzj4AZJdCbev2W3cK/x+7WhEdlS3BRQT4PTpzGNOuYJLv
	sl8Wk37t8l+MloKA6UFJOnX43sSDiSBV99L5kfLXEMt6xzgQZ9B2eGzN2vtKGmKbuEJAwGPOnqh3z
	1W9dm8Jw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98V-2QWs;
	Sat, 11 Apr 2026 21:34:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 04/11] reducing rcu_read_lock() scopes in dput and friends, step 1
Date: Sat, 11 Apr 2026 22:34:47 +0100
Message-ID: <20260411213454.2418381-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
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
index c363faebfae4..2eaaf7b4de49 100644
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
@@ -1669,6 +1671,8 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
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

