Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE92DD5E2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=F74XegJnfEOfC3HgHH4CsoXy0nwYj1O8xipF1+aQrm1GVuCWTuTpXgbIkxRBUrLxYQjTGL8bNwdpWgw4X7fQUiJ6ry9X0XNp7Wb3U6Oo8IlJJcyziNh2MESQ0gqvPACdfS4KTATZN67fyx92pB3wT84JF7L9JpGa/AgxwyhFb3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=xUx4Ngkb+5Wl75YeZpVQ/VJaqosrunH2YoZpEnOL+4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+Baja9eBiZuK5dmqZnDTPbzv15OwRSR/CyUlSc4/ch86iolmt0w3QMK85cgROH39zW3L4SNjzRejbdxgPNPVUacqc+1RNolT21JNTxWW5oIUObiPNb1jXnyzuP+KWzUARvznJ4UV55xFV/wgte6v+SvaHxX2+PBei5QlBKtoU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Or/oaTMK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Or/oaTMK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IPyJ3A8jevUwcbAkwNKVo1SOrWkVbRce+3ZR0654nVQ=; b=Or/oaTMK8cjUaRGGPfCpNyhmq/
	Qw82I7EYQEg3kLPixsgX02tYGtGArp2tFhXZTDwZs89rcPUwAVcLZAg5+MgqSyLxgQb/hBzA9UnA5
	QTPDP9YA652y/L0TYst/OyCwdcMdS5b9R97VgHQXUZvDOwPHsyN4SPhBwFqer02TSRYapMd6DEOEz
	uuWD+lgN8JRHBbEsYaK8x1MZc7D1z5DB+IMOkdE7pLZj5NgaIvgC1AVqyoLjbcBcQ5rmXnRDKToNK
	cWZijjojaZGUy4XmYnN127F/BW+KVAmC1m7xZ8XSTDHEmnbDHKA2QlfTHcTD+MSlwfKqy/59UJnnD
	Ag/InTbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005TtM-3J8g;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 10/22] fold lock_for_kill() into shrink_kill()
Date: Fri,  5 Jun 2026 06:08:58 +0100
Message-ID: <20260605050910.1306432-11-viro@zeniv.linux.org.uk>
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

Both callers have exact same shape.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ffaaf48533e6..3325ca535bf6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1211,14 +1211,15 @@ EXPORT_SYMBOL(d_prune_aliases);
 
 static inline void shrink_kill(struct dentry *victim)
 {
-	do {
+	while (lock_for_kill(victim)) {
 		rcu_read_unlock();
 		victim = __dentry_kill(victim);
+		if (!victim)
+			return;
 		rcu_read_lock();
-	} while (victim && lock_for_kill(victim));
+	}
+	spin_unlock(&victim->d_lock);
 	rcu_read_unlock();
-	if (victim)
-		spin_unlock(&victim->d_lock);
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1235,12 +1236,7 @@ void shrink_dentry_list(struct list_head *list)
 			continue;
 		}
 		rcu_read_lock();
-		if (!lock_for_kill(dentry)) {
-			spin_unlock(&dentry->d_lock);
-			rcu_read_unlock();
-		} else {
-			shrink_kill(dentry);
-		}
+		shrink_kill(dentry);
 	}
 }
 EXPORT_SYMBOL(shrink_dentry_list);
@@ -1688,12 +1684,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				wait_for_completion(&wait.completion);
 				continue;
 			}
-			if (!lock_for_kill(v)) {
-				spin_unlock(&v->d_lock);
-				rcu_read_unlock();
-			} else {
-				shrink_kill(v);
-			}
+			shrink_kill(v);
 		}
 		if (!list_empty(&data.dispose))
 			shrink_dentry_list(&data.dispose);
-- 
2.47.3

