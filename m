Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4B448CFD
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913281; cv=none; b=SOQSgZVP3MLCx8SAtsGGmNbATVHt80+Rqr9/wPNmKc+bqgr4AVsjnVnukPHMXhGWjILd3+/A6/NQ15SLpnRbwZVyc0cHzZTJMYWtkBePcd/LZwoKe0uHTBBFwJY3w9ahZ4XUoViF+I0JK3zlX9v48Ws1i2GwJoGTZe7O5FrHCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913281; c=relaxed/simple;
	bh=BhrYXuPqq4Tq0j4CkXmq2JxYIle7khWTpjkatFg7E+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMKjWXxrfa9rluuITyealNklb7SpzQaGheSqbGTw61x+/h+sc608lMC/1/5sXzF0N5rQbwzowN0+tRa5nXyWg7p3lP2+0bLJ+zjUPvc3bgDnW6vU5ltKCtVrmrknql0zq1zGox6kZdueJs1bOnCa5R/5eDxu7Bo8EcqyMlFX9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klemPDjo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klemPDjo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso7967895e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913276; x=1785518076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I/iJnofotIt7h8Z3Oqw49Fdlh2mKhenEyUhJcxgxuyU=;
        b=klemPDjovheT+RACWVNUb7QWASbTOdMfICGMGy9qBzG0PtwqV1NWJSqNBrpR+XDkIB
         1wlUn8TU3uW7jRX0KKNnuLnUELeMq1Xx+0UQMh9Mppvt7yp25uljLEzP2ZRctgPcm2Za
         bLRbU3+9NBo6alx9XFa9ozjLzngCK/h0qiEHAEQlx/UjV1SGfkqu9hZGbI0b0kNw3W/2
         OyWm7yj/QFmrdp4abm0VI+Oxbdd4QnQTEeHx19QohNakATQaClnbXSDsBfyfVcbN4Q5X
         IWZUY5FSqfta7+b/d0VYXUtce5vUmKtFHjvsEg0bsHJwqUSN4yVOHoi/G006x8OxFUAl
         SF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913276; x=1785518076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I/iJnofotIt7h8Z3Oqw49Fdlh2mKhenEyUhJcxgxuyU=;
        b=ITN1+xx5VMVR4ZMrsggh465L3b2tYpskd23mXsKijU8p766oB8Z6gmS5wMZhJy6G+G
         QTRS1py7HM6EdmmHbE8SpdT51JN6f2fjrJGYWs0lZXz6oudePL2z33tetgAlokkZiHzy
         YzLYLn+yjWnSmXn0qrSjHxurShcHjL8M4XJtS22Rww3HckHzBRoxQFTMwVRBBkiMSoYK
         B1Mq1BJBZjzkn2/j36kxY2fosey6vFbviALf9xG7frS4cBds4voR0PPWJNe57c+hVczB
         uznamuvsGZQqhaW+gLY/d9rdH06CcTFN3bCS6i1j21q+5Vxt7flH0qrIHpgGJ980sEag
         nB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RpZLy0/IpF1Srr88g9jMFb51BDhLVk1cTwGmotqGrglQR5qkuhrD+rxvnSXuxz7+n7S1088nItm8dBUJtDG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+bLrJV8lp3CmaA0VbiWLSvCNVlFfPolrH3VbLoPKRfG6Dlhn7
	VgBEV9MdmWF4qlicr6klrknc+7/ACs5p1zn7jpM2HBwPlEwqXu0ZD1mg
X-Gm-Gg: AR+sD13/I6Or7fTSL7OpZH4tkr55tuHpvLId0eExvfOnjPZW7FfALvKHUCXUgUCy8xf
	Yb4687678CsaNV2TOpVQAVJGxR0x3wfOxD6hIUDCE39qcV3jOHXqWjiSQgNVxWsdHtR+/j/nbxW
	LPR5f5Qvp2+Ajhbjv1GegL43S1Zmyw5pWJ7WgfEBRzBAUIbOih7v3clJHRBe95rxTtjsZhpNqLA
	Um+XK9qg4obV9Ulr3bOBjYIsk58SBX12mqhRk3Wy31Nw4Ba3OWAhF1GacNS7U2Y2DVCI5JIFQSR
	+O+j/FuFyGqhEcoONRPNpx8DnSw1F92TCv9Jj2eTdUeGD4BjlkJe6xNBc4lU/YvVoFzWwCYlrDb
	GIfAYJ5ngdFlOt7gRpP0D1MyQpdT6uMqRLu0Yjnn1fz7NWUeb6FXy9NDfgjHhFBL9dokTdCaOu4
	/6KmMxCqcl072MrVYuzUo7wEieV5KNn1sju4emSUgF4i8jJjdVujqJ
X-Received: by 2002:a05:600c:4e91:b0:495:62bc:a022 with SMTP id 5b1f17b1804b1-49573cd20c1mr89068065e9.13.1784913276204;
        Fri, 24 Jul 2026 10:14:36 -0700 (PDT)
Received: from f.. (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499c473sm4175225e9.11.2026.07.24.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:14:35 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 2/2] dcache: use lockref routines for dead count checks
Date: Fri, 24 Jul 2026 19:14:22 +0200
Message-ID: <20260724171422.429284-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724171422.429284-1-mjguzik@gmail.com>
References: <20260724171422.429284-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3e9af9de7074..2aee85f3fbaa 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -434,7 +434,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 static void dentry_free(struct dentry *dentry)
 {
 	DENTRY_WARN_ONCE(d_really_is_positive(dentry), dentry);
-	DENTRY_WARN_ONCE(dentry->d_lockref.count >= 0, dentry);
+	DENTRY_WARN_ONCE(!lockref_is_dead(&dentry->d_lockref), dentry);
 	D_FLAG_VERIFY(dentry, 0);
 	if (unlikely(dname_external(dentry))) {
 		struct external_name *p = external_name(dentry);
@@ -782,7 +782,7 @@ static bool lock_for_kill(struct dentry *dentry)
  *
  * If @dentry is idle and remains such after we assemble the full
  * locking environment for eviction (see lock_for_kill() for details)
- * we mark it doomed (->d_lockref.count < 0) and proceed to detaching
+ * we mark it doomed (see lockref_mark_dead()) and proceed to detaching
  * it from any filesystem objects.  Otherwise we drop ->d_lock and
  * return %NULL.
  *
@@ -946,7 +946,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
 		rcu_read_unlock();
-		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
+		if (WARN_ON_ONCE(lockref_is_dead_or_zero(&dentry->d_lockref))) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
@@ -1644,7 +1644,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_lockref.count <= 0) {
+	if (lockref_is_dead_or_zero(&dentry->d_lockref)) {
 		__move_to_shrink_list(dentry, &data->dispose);
 		data->found++;
 	}
@@ -1676,7 +1676,7 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 	if (data->start == dentry)
 		goto out;
 
-	if (dentry->d_lockref.count <= 0) {
+	if (lockref_is_dead_or_zero(&dentry->d_lockref)) {
 		if (!__move_to_shrink_list(dentry, &data->dispose)) {
 			/*
 			 * We need an enter RCU read-side critical area that
@@ -1747,7 +1747,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 			spin_lock(&v->d_lock);
 			rcu_read_unlock();
 
-			if (unlikely(v->d_lockref.count < 0)) {
+			if (unlikely(lockref_is_dead(&v->d_lockref))) {
 				// It's doomed; if it isn't dead yet, notify us
 				// once it becomes invisible to d_walk().
 				need_wait = d_add_waiter(v, &wait);
@@ -1823,7 +1823,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
 		spin_unlock(&sb->s_roots_lock);
 		spin_lock(&dentry->d_lock);
 		rcu_read_unlock();
-		if (unlikely(dentry->d_lockref.count < 0)) {
+		if (unlikely(lockref_is_dead(&dentry->d_lockref))) {
 			struct completion_list wait;
 			bool need_wait = d_add_waiter(dentry, &wait);
 
@@ -2822,7 +2822,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		spin_lock(&dentry->d_lock);
 		rcu_read_unlock();
 		/* now we can try to grab a reference */
-		if (unlikely(dentry->d_lockref.count < 0)) {
+		if (unlikely(lockref_is_dead(&dentry->d_lockref))) {
 			spin_unlock(&dentry->d_lock);
 			goto retry;
 		}
-- 
2.48.1

