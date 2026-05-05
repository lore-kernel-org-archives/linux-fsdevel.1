Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175193CBE93
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960447; cv=none; b=JQ0/DNC5jDVuCe/oKQTAu00fvWvgFUU+yuAQV+xPS0Cy/bXVHhLKyrTVg4WEaiHAMTm//uaAZFpKyabc1PFjMrPIvJxXKqHF/srV3HFEs9SLEEbRaAgnHp0qAZhAbCD86g+CrVI/WTpxzCyIBdE88nhUbA+DjHiZN+muqIWWh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960447; c=relaxed/simple;
	bh=3P0rPfADXctwvLK4WfMSg0ZzMTBQrmsJ16rZ/Pakslw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0mC00qMpcSBlgcDg8yzP9ztDwkFhKbs77dV/a5y6003FxQQBH/ABYVevHNxotDiJ73uNuhleUqA7Elz2yUE085AOj5PgC8d382ntFwCOzpCb9QUdvt8Zrq6qJpujSMgo8RFmAVaz4Kd19Vt3FlTW+EqUDjZExRwP2B7kdas0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VMQ3Pt0X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VMQ3Pt0X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tccdeYMSZOogITDKdadipNrFfBqYXjZRvsKGk1tHLkA=; b=VMQ3Pt0X/s1vR/Evb5n9MuBPXu
	aBM2E1OweztzRN/pvjAbg6WTieieVTaQh4+L3plDxnwf286Oe1LCBobEB0ygmuR2pX0CxQIJABobM
	NdcRk/k5N+OlZLO3AgVuiJiKZMX1dXGhS1UI4fvNSj9eNtkYuUKMxf8+khoWIb8n8JPWqz7rzatRS
	wBCYRAIoCLggsqSsPAvkKjaVnJgmBKagy1dcJBMlLJan62VCMqSla+Qs+ZHXR1lt/Orwi59bsOfTh
	ppu/Fu6lD8G7aQrzmyaa7txBgpVwpmnIe8O+xuG0b8jWEJXhNwa/l5YutmH25IR8zm2XtnawYoxD1
	w80yhR6w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jf-00000005I8Y-2yPM;
	Tue, 05 May 2026 05:54:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 16/25] reducing rcu_read_lock() scopes in dput and friends, step 5
Date: Tue,  5 May 2026 06:54:03 +0100
Message-ID: <20260505055412.1261144-17-viro@zeniv.linux.org.uk>
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

Shrink rcu_read_lock() scopes surrounding fast_dput() calls.
Both callers are immediately preceded and followed by
rcu_read_lock()/rcu_read_unlock() resp.  Shrink that down
into fast_dput() itself; in case when fast_dput() ends up
grabbing ->d_lock, we can pull rcu_read_unlock() up to
right after spin_lock().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4222d89692a8..5872f369ddaf 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -876,6 +876,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	/*
 	 * try to decrement the lockref optimistically.
 	 */
+	rcu_read_lock();
 	ret = lockref_put_return(&dentry->d_lockref);
 
 	/*
@@ -885,6 +886,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
 		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
@@ -896,8 +898,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	/*
 	 * If we weren't the last ref, we're done.
 	 */
-	if (ret)
+	if (ret) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Can we decide that decrement of refcount is all we needed without
@@ -905,8 +909,10 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * dentry looks like it ought to be retained and there's nothing else
 	 * to do.
 	 */
-	if (retain_dentry(dentry, false))
+	if (retain_dentry(dentry, false)) {
+		rcu_read_unlock();
 		return true;
+	}
 
 	/*
 	 * Either not worth retaining or we can't tell without the lock.
@@ -914,6 +920,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * but we'll need to re-check the situation after getting the lock.
 	 */
 	spin_lock(&dentry->d_lock);
+	rcu_read_unlock();
 
 	/*
 	 * Did somebody else grab a reference to it in the meantime, and
@@ -971,12 +978,8 @@ void dput(struct dentry *dentry)
 	if (!dentry)
 		return;
 	might_sleep();
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -1024,12 +1027,8 @@ EXPORT_SYMBOL(__move_to_shrink_list);
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
 {
-	rcu_read_lock();
-	if (likely(fast_dput(dentry))) {
-		rcu_read_unlock();
+	if (likely(fast_dput(dentry)))
 		return;
-	}
-	rcu_read_unlock();
 	__move_to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
-- 
2.47.3

