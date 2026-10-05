Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7564BFE91
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213002; cv=none; b=PyngMr9CzvlV9gu3xnwEVy6N5gQHnO+cwNBickWFP7jCQyGmA1K+keNtV2TwSdvFwGFFGk+sAg20kKCLPFakO90PYzOVpHpk6+qCccmejc+EumllIL6RwhAFYHV+1V0pM4ggDy26ht/komrQ0WqOUlIgHUgy+QjsqWALIeNTASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213002; c=relaxed/simple;
	bh=mgbyJhEgBJGneHMBihhStS+dXS5x2dyMqyW+sSOWoRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kuj2Dbzzdq55d1QQEos3fNvxnLvSCePF1iYpd2KZunnjkkkD04B+VPLBLIfMWsZZPFuJ7LYiC+wrqIlyeEq49jd9YyGM2evC7GdXgS9ZopLyvbFuliJMHZbN1v1YMnam+j1wr4REX1sqD5ll1inBGWjG2Rpi/yjJzJWVrhhbNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=fEjqu8wi; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="fEjqu8wi"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20f4bso1540680d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212995; x=1791817795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lgUC7T7/VHvtmnRhJu6KYjSavDN2P9DqRdXTfg84HuI=;
        b=fEjqu8wi5eVzzAkmnfsIiKCLAHG1K8807OnoGe6+/dTyLQkc3tsc19y39mNPggQPkn
         AEY168lWuNnf8eX+f3e3CJYzqWMvTbt7DSXnNlDJ4JbAFqLAKT0nIZi5/Aw0FrcOTneB
         ErkQKVlBC6vosRyRg4X97ywdogVmbSyiAQmOPvJtJWqv6R5key8TfAA7DY8Py9zzkKgv
         80CDnsMny8xTsNMD6N5XZ+oLobMha2WX8JjEG4EOsEbGIwaRtLBhkEItTL+EihBI5E8H
         v2YBqR2YqyGoWPdqIsOy9TcS5wxfzqQfrbJ+wV8dMs85MNL5zFYccSFPsjOHoBRnl74Y
         9QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212995; x=1791817795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lgUC7T7/VHvtmnRhJu6KYjSavDN2P9DqRdXTfg84HuI=;
        b=2VZCwSEqJqjrCdZ4W1b040LIG/ftyXBHeE3twJaI7S9jLaB74dzDHyKiNM8eFVsNB0
         ROEi6g2zgNpaBYtoOUdVsPOzG857FcPVECyhzV3l4zkfSv636b7YNOwmIBuNnRCPB+kQ
         wuvwUYHrR88novb9jhXPBg8CF0EuGRsfOfAjrDxsNFfOujgVIW5bnXzbbajJ9HzU5tfi
         Yal52xKzes1BI0CvDpLV2wjWtYsxjPcP98pitKom2QTPVxD5BgNSTztaRZsO0bYZw6Li
         9+hpazXeYSQC6urO+hbMzWJETH2AdwNd/8nD88A7vJUySpubHN+lNPQWpt9xzsHtysri
         449g==
X-Forwarded-Encrypted: i=1; AKwUvBzHBGlnPSk8EtgKefvh8/Q3S8eCs1Wh4WBs9KxNooi6BmyQfLl1rgi9pR/jS9lWR8bUXLKh/ADJNW+GTu/d@vger.kernel.org
X-Gm-Message-State: AFuF++koF1RmdP1Tq6SyY8FXsr+V5tJDsIVjxro2RVjKWtazRjV7+REU
	0r3+Vq0hP6m/XFP+vX+9nZgrus11JeaL3eSRr+Bri1z5BNKo6225DOS1GjiOCojVl5F+
X-Gm-Gg: AYBFou1PvC2sr1RBWE7r86yyye5TD07Am+lIJqFIRNjWSFb08VNc8S/kRWY/i//OhiD
	uH2TfmkD158TEJ9K9uHpgrZsJzZmU9+ah9L4E47gffacamG8mWGj6eRPfOsxntlS8kM9HOGFFks
	1ZLgFvmF0UdANplSxhWLcVCty9AOyHpkLyVEaw0a5FoEht36osSfB6MNZkfIkqRAoMreNf6nDSk
	17RYYwpZ5iJbdmsPI3H/onuuwiQnMn9sxBpQVjR6xVZ1LDbrQffL0/qAfSYPu+PEzsHVPo3paut
	JXOFMoW33lZAJO2AIvh35xr/IpueVLh063kzl50BsTsoVdMgaFkucrllQ5qTW4NJpMrQKhEYDBT
	fsVXhtVY5ATljCQCr5XRrQnARw8BTKGdziNOtbHBFiFPTyJWm3lv4HLxgBgeDtuLO9MzhOA+BUl
	eHyl83N3Ot4LXPR1PJyQt4DnX9gR8HQ21pQ8n3KOohxdM8SFOiaLKgc2rAozknh2kwM8V/op2kp
	qUzKBcZnS6tQRdCwN5UrzVU6d5TxzrhZUyT60xT3UmbJXPRhYR2cjJxhawvKwdsZg==
X-Received: by 2002:a05:690e:118b:b0:677:d375:13d2 with SMTP id 956f58d0204a3-677d3751a58mr1307931d50.42.1791212995292;
        Mon, 05 Oct 2026 08:09:55 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:54 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:36 -0500
Subject: [PATCH v4 06/10] af_unix: record the pid of the connecting thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-6-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 net/unix/af_unix.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4e571c5a0e16..b7d62e61d9c4 100644
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

