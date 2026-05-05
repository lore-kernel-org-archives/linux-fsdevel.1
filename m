Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBB3BD643
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960446; cv=none; b=aNLgm1hjyqvENLbkgwgZSaVoVvalpzLrauLJ3Jro7PPnCwZAxIwLZoiZTXY5ymqVLG0mTS0k9UmXRTRq6Ro0N3bw1e0wJMPo4BR7ak25OxtWasGwiToya3r6S+hbxJBlHhOM7segur2iuf4IOe67E5Z7eG1l9I0e1l6C+W1+qGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960446; c=relaxed/simple;
	bh=VZR3V/GCy7vBLioxQaZziCzKp6i+lv1cCm71YeqUWO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOJR0fesaVWEiSMEM+Ia9pE1ED7c/mEEmZKaq8POpxnm1os/c5yU5hw1eSIez35Gq/V8BlmcF+CTY5qOO8fWS9D5qfsboIMzU3hTOdMAXiNXpvptFgbvoLtDQkCW7dztJYsJm9n/ILd56z0S7gJT3Oasxn2dq96Ahl4SVu5YRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QxY0qcOQ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QxY0qcOQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AdyptZnnJtIYPe2H679p/iMs5oEyVfs75XQNZIwSle0=; b=QxY0qcOQfLK4co85W5uK1PzTSs
	1UPvlincryBD1oeX5YAxKrcdnEuOxJewi0s7lCNpADv2pgdQ88/K5MgQBFXrDuEa7N9+OAGWBiW5Y
	W6+xwmOWnHrBXmS5k5q4HAmvBDINsbPY0zIXkT5PT7+IHwsvkJgCEly43skX60WqfWur2H4RH36rU
	xkrAgF6iXRRJ2/HzeDCCXS3CrBxKQ6y8AbtTPyNiHFZvNIXpK/snWLtGcg/Qv1oks1NKdNPHO6NKm
	4MduAsJPznmnjyIDg9AE9y+FQXUnBF8YFj6TJQK1QWW8saDOIrhZY9qXV2I049bQtILJy59MMcvLU
	ODzx4p9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8je-00000005I8I-2VrL;
	Tue, 05 May 2026 05:54:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 14/25] reducing rcu_read_lock() scopes in dput and friends, step 3
Date: Tue,  5 May 2026 06:54:01 +0100
Message-ID: <20260505055412.1261144-15-viro@zeniv.linux.org.uk>
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

all calls of dentry_kill() are immediately preceded by
calls of rcu_read_lock(); move those into dentry_kill().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cb1e27d8a900..bcaf17840939 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -781,6 +781,7 @@ static bool lock_for_kill(struct dentry *dentry)
 
 static struct dentry *dentry_kill(struct dentry *dentry)
 {
+	rcu_read_lock();
 	if (unlikely(!lock_for_kill(dentry))) {
 		spin_unlock(&dentry->d_lock);
 		rcu_read_unlock();
@@ -932,13 +933,11 @@ static inline bool fast_dput(struct dentry *dentry)
 static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
 {
-	rcu_read_lock();
 	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
-		rcu_read_lock();
 	}
 }
 
@@ -1216,9 +1215,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
-	rcu_read_lock();
 	while ((victim = dentry_kill(victim)) != NULL)
-		rcu_read_lock();
+		;
 }
 
 void shrink_dentry_list(struct list_head *list)
-- 
2.47.3

