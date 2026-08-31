Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C73EAC75;
	Mon, 31 Aug 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175310; cv=none; b=CVnRMUsMbk5+WJdfb/DpCUJj7hZ5EQ1sHDM4ga9vh9+xI+6QKT8le1vswqu9Ht+92hMWN2razO+F2XVPjhCuMlqe482LwAgr7OXE1cH0M2byLK2Rir2CdJx6G+iNSqyrGkqfafPNmVEh0fqOy0lSVNXaCAnU/Z5XbhBafH8BBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175310; c=relaxed/simple;
	bh=yA/Xz27iNSl0I/FYFPwMCx9PJl0ttUYbsV6seW06gok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxByMPgFSB5mnPzNjygRjb+5NpbV+UfHj09Sftp5qRVY/2ZbFPJTBaYPQjbz5S8+sSpK7o5rtOa1E+ohFQvrsuxyINRgvNU92QtZa3VArSMgpiPPB1DeFIVLoc6wc9DBqEuV8MEyfI1xMhRknaE3e/ogf1T2OoK8ByIcW3aCViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI+SfSZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI+SfSZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B2D1F000E9;
	Mon, 31 Aug 2026 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175309;
	bh=kB/2xO2CtThMIOvpgDlR1yhv6emlsZPwXXBBmEolq/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oI+SfSZqMHQZ3+XfjEAMf1x3Vdswu1UFns9ZT7xz+Vi+RTFp6KSdrQO23Q4jow4Oq
	 fwX/W2m0Jf82Jla/VF9p0A1ABXkK3BuX2zbpksRLhDOgVqDwm3+AWzxKgA/4UsuArW
	 gBoqCa0mRayCkfNOrM7Q8lIKzU5DWjYid0uRVaYYBQShlGl2bU7N7IaEHZUxcGppDj
	 X913fEvgGEZuw3ewgX1gIEMzvHEwHJCpLtMuRS6lSjlAY3IgHr4lwOurgsA+EvFzs3
	 yng7tt8Z522of86L63wCyen+nJ77ZA/DCBM1qdleUqlwxrPdkMkEJwCd2yLlxoygT0
	 K8coXOeX3gaYA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:18 +0200
Subject: [PATCH 06/10] af_unix: record the pid of the connecting thread
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-6-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yA/Xz27iNSl0I/FYFPwMCx9PJl0ttUYbsV6seW06gok=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd4otmjuhXNHep2aGMvapxSzt5vKbej9vuHQvur+r
 4smmpsqdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEeCvD/9LrDm4Xt9w8JDrN
 zimJyetEwMvTJ5OnXD7NmnGtOWXpLg6Gv4KN7+s9U2f1xGtYHTob6BVQ8t5voXSp2eQdTxY5clb
 sZgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently only the struct pid of the thread-group leader is recorded.
The identity of the actual thread that connected to a given socket
cannot be retrieved.

Add the plumbing to make it possible to retrieve a pidfd for the
connecting thread. Nothing uses the thread-specific struct pid yet. No
functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 net/unix/af_unix.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 335abd23c9bf..d01ee76c8026 100644
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
2.53.0

