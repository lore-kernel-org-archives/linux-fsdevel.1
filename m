Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1794908C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587667; cv=none; b=WTP0FXuAmAUgEWQ0h6w6otnWG2CJGt+zNCss9sSKdWXganCGx4WqdzpM3VmzvtcFsjHHe3yriDc0qtVJGxexP1XY5qa3tiAAz+6XTTnKSpQOtYh833NYFH8PWW/GV6DnPxmnXEmMnrVBIE73OpYGIBhflwktRScegd7XIFZrmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587667; c=relaxed/simple;
	bh=/PV8bkEcmNLE+ijOGsRCg/0RHzPtaUQOaZJFKtUlBvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JI3BG4rZeqF6AS0M6P59CPqFFfjQQAdb04wK5rqoDGYVyjm2+SAcjmaBIA1duop5KDYX9xsTAwolc2ckRv5US391V1S7TGQW5lLOP8I4Tw7FHloFRjsWEBq8ax7BAYafWY9D1NreKsyl227XgrBhdNUtLPd/5wjKA65HaN3+2U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=UQS7l9Lx; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="UQS7l9Lx"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2aff2c45efso205202166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1790587661; x=1791192461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPNufo0xGsOqd33WmAs2+EzxZR69r3CqEUC2DYFiTqk=;
        b=UQS7l9Lx14ZlyERjb0GQR0GSN9fmt3dYNxS90q76ZlA4/jpYD5O/la7zoeX4K28msa
         iwnbcXdnuJzwO7NpQLvqZE8Qp7dX2VUW68TR+NrKz9z2uxJ07W/d/c/0TLcf4v9jmGAM
         LWacF5A5nSBxjF9ru4YB6dBG4jcdb6pN4qxeU5XX/yie9Yhu0auWEnpl726RUXB3XVLY
         9zbMbfcHVAhscQ5f6YeQB6Nh3jyVajUzLACedexMW1W69tofrLUFL2cYz627WHQjh9GV
         BRyFnm9kGmH3dAsUp9iMzkat7G5opkhzLv3OQuGkwei4wnnPGqsfAdW6Fshy0ffz4CF7
         Sa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587661; x=1791192461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNufo0xGsOqd33WmAs2+EzxZR69r3CqEUC2DYFiTqk=;
        b=hu/njlw7epTzL/eVrhqnZsOG0ty6BKjZByY+gStBfbUc6FY0+RaZpJL61upwQWJ6Yz
         FUfYtc3DLzeQA7xp8+udF0DQH4rkK22+Uf0dZAYT+hpTu49xMlhDDlPzOUOziu4+zr+2
         Gm2Xl6leXMztM64bf50RZjFyDh/qdYhkMXbKHYTwAi2ndpr0CzRBTN212hGAu5Kbec2G
         7xTEIUsHmlNuKrB926cBuo69xy+4EIzoLgOofuGY6xchZi4pocCuMlxMvlTLpHk4wIIe
         al3IB3TxmnjpnUMaJtmh81SbCOjpp/jrqb08cNkz384AQS1ubZ+IGnj7xxntqRmKYbu9
         Jpzg==
X-Forwarded-Encrypted: i=1; AKwUvBx6zUPvs2TZ3sgkeQeH3PScH7FkX/V7Da5bCoIB6ZdePP9lEc7+GR/EXZnaKIky9QyDNt9+z1fHMymCA966@vger.kernel.org
X-Gm-Message-State: AFuF++mRij51+PoJBsuxhTdBGAC1c8XuGyUhOkHZ4ewzL6u6e0UzaZFE
	b6Ep8M/eysG7lvEyYf6bSsLWxlPC5m9ZC+7M2+3J7cqmjLWFZHVrm4YHAjn/BnCqkY2q
X-Gm-Gg: AYBFou1qbYTMufE0vIuGVK7fZpP98SxKfi9Cq0C/WrwDyOhZx0gs8O2GzSVm8t3q+yJ
	zFpJI+wzbxDiPvT37pP5f+N87eyHB8Th+F9ktJgI8U6xQJwr0t1UtCzvAwYyPRQ4rxZZiY+clV5
	eQQpGPBAqv6bKCuz3zO5BhMxLzO7XQiuMUeKrtqO0j8x3ggdoOgkECLi1MetqIjp4JnTayc0f5C
	g/abJu69TMmww465wzGdzYLhjkEJTjSMCiXD52oeGneL2ocNXlXIyvIYe846Is8HfKBk8s99Po1
	tKs8ixRtsfGdQFSn1+T1sq/EF3f7sMvqxzJgpS0tJUViYheWbM7UEX0J0ESBKHqRAqqKlORND+b
	iBwaWpgrOva8Fer4bUfXqXZcluJcA4zRQ+Jr5WeZ/pIgV0NpWt6SVhZ7N/jvU0I1/nINsq/+a9/
	vQ0uOUwgu/G69ufsaxsIav+3uAQ81c/+WisTvNRML18WPnmKat/v8HVOLS8STwUGMq2liFv2Imp
	6zIYh2ZMbpLIrDvXFznK30B22+dtlAu5ENaNqS/yQ==
X-Received: by 2002:a17:907:1888:b0:c29:4513:f6fd with SMTP id a640c23a62f3a-c2ac24fee36mr999083566b.35.1790587661570;
        Mon, 28 Sep 2026 02:27:41 -0700 (PDT)
Received: from [169.254.24.37] (tmo-085-169.customers.d1-online.com. [80.187.85.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm205609466b.1.2026.09.28.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 02:27:41 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 28 Sep 2026 11:27:13 +0200
Subject: [PATCH v3 06/10] af_unix: record the pid of the connecting thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-work-unix-passpidfd-v3-6-532018a91b21@amutable.com>
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Currently only the struct pid of the thread-group leader is recorded.
The identity of the actual thread that connected to a given socket
cannot be retrieved.

Add the plumbing to make it possible to retrieve a pidfd for the
connecting thread. Nothing uses the thread-specific struct pid yet. No
functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 net/unix/af_unix.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 66a26a10871b..634db1b40ecb 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -743,51 +743,47 @@ struct unix_peercred {
 
 static inline int prepare_peercred(struct unix_peercred *peercred)
 {
-	struct pid *pid;
 	int err;
 
-	pid = task_tgid(current);
-	err = pidfs_register_pid(pid);
-	if (likely(!err)) {
-		peercred->peer_pid[PIDTYPE_TGID] = get_pid(pid);
-		peercred->peer_cred = get_current_cred();
+	get_task_pids(peercred->peer_pid, current);
+	err = pidfs_register_pids(peercred->peer_pid);
+	if (unlikely(err)) {
+		put_pids(peercred->peer_pid);
+		return err;
 	}
-	return err;
+
+	peercred->peer_cred = get_current_cred();
+	return 0;
 }
 
 static void drop_peercred(struct unix_peercred *peercred)
 {
 	const struct cred *cred = NULL;
-	struct pid *pid = NULL;
 
 	might_sleep();
 
-	swap(peercred->peer_pid[PIDTYPE_TGID], pid);
+	put_pids(peercred->peer_pid);
 	swap(peercred->peer_cred, cred);
-
-	put_pid(pid);
 	put_cred(cred);
 }
 
 static inline void init_peercred(struct sock *sk,
 				 const struct unix_peercred *peercred)
 {
-	sk->sk_peer_pid[PIDTYPE_TGID] = peercred->peer_pid[PIDTYPE_TGID];
+	memcpy(sk->sk_peer_pid, peercred->peer_pid, sizeof(sk->sk_peer_pid));
 	sk->sk_peer_cred = peercred->peer_cred;
 }
 
 static void update_peercred(struct sock *sk, struct unix_peercred *peercred)
 {
 	const struct cred *old_cred;
-	struct pid *old_pid;
 
 	spin_lock(&sk->sk_peer_lock);
-	old_pid = sk->sk_peer_pid[PIDTYPE_TGID];
+	swap_pids(sk->sk_peer_pid, peercred->peer_pid);
 	old_cred = sk->sk_peer_cred;
-	init_peercred(sk, peercred);
+	sk->sk_peer_cred = peercred->peer_cred;
 	spin_unlock(&sk->sk_peer_lock);
 
-	peercred->peer_pid[PIDTYPE_TGID] = old_pid;
 	peercred->peer_cred = old_cred;
 }
 
@@ -796,7 +792,7 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 	lockdep_assert_held(&unix_sk(peersk)->lock);
 
 	spin_lock(&sk->sk_peer_lock);
-	sk->sk_peer_pid[PIDTYPE_TGID] = get_pid(peersk->sk_peer_pid[PIDTYPE_TGID]);
+	get_pids(sk->sk_peer_pid, peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 	spin_unlock(&sk->sk_peer_lock);
 }

-- 
2.55.0

