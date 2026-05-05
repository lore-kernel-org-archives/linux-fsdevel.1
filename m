Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676D73CBE78
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960445; cv=none; b=X3n5YPckdSP5L8eMTdxfPi8/5F2bN971LfIEAOKuoU13FMKGNfAELb9C0JfXz3hdX7Yun0Bu7X8GT6stodCs1upSBTyI/ArJ9WIh3/ZWn91x5LO550fRTOwaC+9XDpo1P4nKo2Vl8mkLFsMvunN9+/qRhRjfH6qFFwoQ8JporOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960445; c=relaxed/simple;
	bh=P0TQ5Afs6aMp+MYFijihkykHlv2rPiaJjtFtJmajHuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT/SSt6qnJtdpdhsigH4Id+JetyZprfkQIEhgIk67CGD1V3AfMs3bZS8E/ptUdG7ZUA8hQCLxHF26eJLkhWP+PhAmpfKH4hqs6ZW8KvvotiuXDywquQ9gAg3Ry7cCKQAQvRh/hDohm6idLQDrG12YfpCrrM4RB1ATgS+RdYUYm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mYu4wFlb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mYu4wFlb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=whOYg6C+m6DSrH80znpJI6DApiDRTaTcUQLYkAPbB/8=; b=mYu4wFlbiNI2vkjR4X2fSKlcId
	TVq8WOvbaDS40/t7si8j4hBHrNl4Ogzg0z5xI+dZU2SGyk0h9FB6Fe8zOwsdKZgbi+DaKPcgm4JtV
	1hHG6WvNqXSRx1s59aFa30vUQRwz69thipYFBG7PwgfzEG4Lxu5TM7RogdZaI5S1ElC01G5E3IXmv
	uto5z/QTXHXSLLeCsJPFe5+p+yfsuzLxD/jUGFE4w/bGJvdwx/s3Vk9yLU3F2Qnr3zVpZobdXz0Vq
	1d4bSJUPZkCQy6Z1uJ7sVRACA71MsyNByQFn9BA77EZl4Wj/PxH9FByOf3oWUz7sXrbz+IVjnfe+b
	9nsWZX5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8je-00000005I88-216l;
	Tue, 05 May 2026 05:54:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 13/25] reducing rcu_read_lock() scopes in dput and friends, step 2
Date: Tue,  5 May 2026 06:54:00 +0100
Message-ID: <20260505055412.1261144-14-viro@zeniv.linux.org.uk>
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

All calls of shrink_kill and finish_dput() are immediately preceded
by rcu_read_lock(); move it inside those functions.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d690c18f0c33..cb1e27d8a900 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -931,8 +931,8 @@ static inline bool fast_dput(struct dentry *dentry)
 
 static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
-	__releases(RCU)
 {
+	rcu_read_lock();
 	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
@@ -979,7 +979,6 @@ void dput(struct dentry *dentry)
 		return;
 	}
 	rcu_read_unlock();
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -990,7 +989,6 @@ void d_make_discardable(struct dentry *dentry)
 	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(d_make_discardable);
@@ -1218,6 +1216,7 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
+	rcu_read_lock();
 	while ((victim = dentry_kill(victim)) != NULL)
 		rcu_read_lock();
 }
@@ -1235,7 +1234,6 @@ void shrink_dentry_list(struct list_head *list)
 			spin_unlock(&dentry->d_lock);
 			continue;
 		}
-		rcu_read_lock();
 		shrink_kill(dentry);
 	}
 }
@@ -1685,7 +1683,6 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				continue;
 			}
 			rcu_read_unlock();
-			rcu_read_lock();
 			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
-- 
2.47.3

