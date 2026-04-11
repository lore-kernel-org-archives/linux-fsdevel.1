Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E2280CFB
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=pfdDt/r+EBETjAv4SeSxvvCddeeQWuyfnuW81Fz945xgX37wZiMYDGU2iVPG+n/D30XaNLACb1vn3ZUe+Fq91PkffEtL5rOsPN0LI4Ht4v4hWvT5ek0b+iwqI1RuDWvfBBBbHtZsex/DqH+GGjp0qmsyfWNOjk9/T3nIP+qxhao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=mUgNGubvxGEg2s4yrAsP9rwQlabLmRioBp3vniMXONQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGOfO8Q+oQu6eL68X0n9DT3DMUbbTVJmn1zgmtLVQ+5jd5BKRqqxxszRqPsviHNLHafsj+DCNCbanVwT/8eEZtTDe9yRAWUQ7XOY2MvRp8ovwF57e8ZBLiLrNozkdfaEvrs1xan45umkFRMdMs8wbZtbE2gnbHLXI/7F1duMvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Eh4QaP/M; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Eh4QaP/M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/vjWjbUGfBALyeJR5CrCf2FFq3tFF876tgYrLpMqJRo=; b=Eh4QaP/MJgsyrIKygbJbjeSZb1
	4MZ/N4DmbY5F4WFYWHBrrKu8ly4K3R5/oj9/cbKRVoVfgUxuLe9X1jJQSCpblJelOzXq5uhJyNemT
	bPwaw6IOPRehpd48AEUOGKHvmJlDiFZ5Rye3Y910KHCHcDH2TqYiSClbQdcg3OZwXI0mWiA1nxvlQ
	YdIOdzCcSFBj/r+yCl/HTnL6fadeCUDgLgBonWRO2VaPN8e+DrkNsAZ24Mcs9LcrNhEiLrYIqtnU+
	whRTDRKucV2AuF8qUxajD1HjvdhqCXCbKbP4nEi+qrqBbOKfoh70BGL2YqHhOpeQdztZYH+V89TkK
	QLoPah4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyh-0000000A98g-33P3;
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
Subject: [RFC PATCH 06/11] reducing rcu_read_lock() scopes in dput and friends, step 3
Date: Sat, 11 Apr 2026 22:34:49 +0100
Message-ID: <20260411213454.2418381-6-viro@zeniv.linux.org.uk>
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

all calls of dentry_kill() are immediately preceded by
calls of rcu_read_lock(); move those into dentry_kill().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3ea46d1182c5..9584cbf43aa9 100644
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
 
@@ -1195,9 +1194,8 @@ EXPORT_SYMBOL(d_prune_aliases);
 
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

