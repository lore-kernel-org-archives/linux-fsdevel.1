Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D103CBE7F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960446; cv=none; b=i+QLMPYLwZLIBFJMMicTpEm0T1cfL/nEaIWFjXz39EusakVibK8jOjjJMcF0R6uBOj48wShFQwcyU2XL6Sx7knEOTqo5bCi08+rK3S6mrZ+pH7PhZma0nAQ41SXu6YnsnnKG1GhJodOMEWjlddRSZejxzZYstGD6lNfJVzTXijE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960446; c=relaxed/simple;
	bh=EJtn0pfWczQ/GTfE17NQVYuVK/gQDDMd4AAsi0e02s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyQGeA83sZEv2GFhpulzAEU6XdaTx9BhLqUVGE008MGeeYCDVl4Vy7+5gNDC4/WMKCWquF7xBMzaiH843wscfU8Cx+h2Hoty7xyBN5MBp1NMLpZ6YW5A+Npn+WBKNvI+BRuLq2kY6g6/NAlp9LoLjIg/Bj+plyjnSY6c6lp+JRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=q6wJPj9Q; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="q6wJPj9Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+bKttSx6Egd4A6tEqNoOBYNrNNngI4HWDaGCPS2CDwE=; b=q6wJPj9QJlX2LS34QTkGndqFOm
	NHAs0VAhPSnkwrTFCvAu/axSXmR2mc11tQeXHyGbw9t0Ce5Kab2Qn6gniyxcjaM9RC1kA0VWtW15O
	L2QVAlaMS8OhMd81YH4+YrU6+uB+ZK6d18+gEBInuxz4iV0auUMdiC8RMpYv4Vm0IINp/f65aXTX8
	Fc2nD742Dt5gLyJquRBhVOAPn0OMfxIa8Jp9qtgRXTI305VYGbyQymaGJyx7Sq75Dff9kDAFGC5XJ
	oeso4n7Z1QccVPFeaPovN8tmwhIKs9UgxbnyOPhLUpBeushgRFT2VNvb8qNfkSPFVZ93gz/Ilg8fX
	Gc7oEyzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8je-00000005I8S-31DS;
	Tue, 05 May 2026 05:54:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 15/25] reducing rcu_read_lock() scopes in dput and friends, step 4
Date: Tue,  5 May 2026 06:54:02 +0100
Message-ID: <20260505055412.1261144-16-viro@zeniv.linux.org.uk>
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

Shrink rcu_read_lock() scope around lock_for_kill() into
lock_for_kill() itself.  Note that spin_unlock() can be
transposed with rcu_read_unlock() - RCU read-side critical
area remains the same and even if the structure containing
the spinlock gets freed from RCU callback run immediately
after spin_unlock(), we are OK - it won't run until after
the last access to spinlock done by spin_unlock().

Inside lock_for_kill() the scope can be shrunk down to the
area where we drop and regain ->d_lock - rcu_read_lock() scope
is needed only to bridge the ->d_lock scopes together.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index bcaf17840939..4222d89692a8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -763,6 +763,7 @@ static bool lock_for_kill(struct dentry *dentry)
 	if (!inode || likely(spin_trylock(&inode->i_lock)))
 		return true;
 
+	rcu_read_lock();
 	do {
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&inode->i_lock);
@@ -772,6 +773,7 @@ static bool lock_for_kill(struct dentry *dentry)
 		spin_unlock(&inode->i_lock);
 		inode = dentry->d_inode;
 	} while (inode);
+	rcu_read_unlock();
 	if (likely(!dentry->d_lockref.count))
 		return true;
 	if (inode)
@@ -781,13 +783,10 @@ static bool lock_for_kill(struct dentry *dentry)
 
 static struct dentry *dentry_kill(struct dentry *dentry)
 {
-	rcu_read_lock();
 	if (unlikely(!lock_for_kill(dentry))) {
 		spin_unlock(&dentry->d_lock);
-		rcu_read_unlock();
 		return NULL;
 	}
-	rcu_read_unlock();
 	return __dentry_kill(dentry);
 }
 
-- 
2.47.3

