Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FD28B7DA
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=QB8byvDMQsRKAppTXkIT53rV8EQYpHSJIQmyFe5ZgXTqn1O0Rn+I+XDmJijpDwm1nlHuPqb8QW61xOhlt7yS5PZ3wudCNUvS4yuDOmk0OD5ApMtlefNVPgHFgGjqm1A+1EPj1qqsr/UlqwMMnDyRvD2UJVpDAZmwB0BbARwDuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=wucB5NEXGlRpcJdWVa6eDN51pXZkmE2rxpbSdNl0aYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PA4lZNyKpD4qDNPTHWWLM2C+q/vxOjVMgGO7I9jGwQqNVAl9RnwKZT3mqQ/IGiswE9BZ9yjxYF+u2WKqBnrSC+mZ6KZbQFD6IkkQ9UCZpxnfbrCtC5pwCjgiTHCxSzZCwKf1aiMgaLQXDhpqMcsSbrSVaC0Bugw8ml+VEktrRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jJKqnuq0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jJKqnuq0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JmC1e2fCkyOX0Hu6c30PxljXY4u5nLSLY0v757xaHHk=; b=jJKqnuq0xMU6k0qT0GFTHGhNSJ
	KoErR9q8U09nBl4ZhadAX0CwLQaeCT0izOJnzG8eNDTDO5niymZrAhoixAWaKYGbiVQfJ+Z5OMmKX
	+dojQCyigGzYp27HW2GBL3Kj3MWKfBJLlE/IQVS4p+wv7J5AUOU53CmqPwTS7AqOmmwW5CUXh0mt5
	l4GOwhfQiCtZ5waW72OCrS64SW8T2NQySHOGsnb/ktOUdehCk2sq5xubfO0eCVdjZoz9of/+GLPEF
	HpIO6TGICKpq5fE+aBFwupx6ePwHEQ4FD2RNryT1g9l4A4icbmybT4NqfGRMg3MLYxOsw9Y1uqJtO
	FbRVohtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98s-3UVA;
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
Subject: [RFC PATCH 07/11] reducing rcu_read_lock() scopes in dput and friends, step 4
Date: Sat, 11 Apr 2026 22:34:50 +0100
Message-ID: <20260411213454.2418381-7-viro@zeniv.linux.org.uk>
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
index 9584cbf43aa9..4f38af6fabae 100644
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

