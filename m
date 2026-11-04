Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802296;
	b=onbEIMLCjslv01UDVGEusII3+kxaj64+dVoToy77aUR6PRWF64KiMVz5pciuJREnReH2
	 6tNefXc2UsnAl9peX3/Q0TE4f1SG7uzaHr3QevAAV/3HRbdkZDrMGKMlK23KwxPqNKAKo
	 lXmNcGxRWyxHdaJM51BJRDRpT9xgDQV7WJL6mOV8s8jHQmECK3inf7PC3subjTN5LjuQK
	 kWqC7H+JkuAbPw4+hHkg70CZeGHTdEMO2o/z93cKpxYPEMWX8NClqv5FGH/ENH6z6CbkC
	 2wfxC4IbZw+PoR3FXzZ7YLq2lXcTTh7QGCnoR9+HlCISw64i9gTPXN8adMWJAwCMWSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=j4hI/wR+O9+PtJMYpH1LsmOwgDKx85E/tA4Sa/she98=;
	b=X3nPIS8PWmJOrp5Ce3hXn7iR8362FqpBAgfZbAWUyPC57rZ3F4qo0U/CCQhPKBEtZvZw
	 Z7LHoO8D127weVhNiUkB+V50WFjf/5L082XQKVMzeUIQ1HDPYNiDCHtiQEcIVLjMqZcn+
	 AfJzzMqY34lUp4muI78W6qQVQeiNKAZ59Mr5Iq3JdAJRMVFn6JM3rHynGaoWg9xB8IZPJ
	 11TWQ9C0+1xBygx+a/bmuJc7NV1xNMhx9d+jsrKUQb53tZgkJnFpTxQGU2VhV5cRteXd9
	 R2n8yzSK/+DnhZAkHEMZdPy9GryJWDyWkTOsJPXtVDCBNwwSEVjmY7LrsMqoeVWP3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=K1WLXHLT;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F2606A33A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 14:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A69F2606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=K1WLXHLT
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso203826137.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 06:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793802294; x=1794407094; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4hI/wR+O9+PtJMYpH1LsmOwgDKx85E/tA4Sa/she98=;
        b=K1WLXHLT0+jtSTjCNOaJdZ9ivBFZPbp8qdHxIJbbH5mAS2aeNG6txI8cqZlUp4qplE
         bA0k4Ws4BAuR94I2fVfnZr5A4fdf4Q5t5UTKJ/+bxkIVh7qFLNH1d0lmq19w35PUshtu
         u47BzkNfhWPGC9EdWB4bbFt6TlxoAEZJGU2nXcPRBoCyakdkrnVs2sMCH896KvDu6BUp
         EUuEkBr4mz7OcZvOc4nqNNeiqSKKB8z/C4Ve8ZqybfsP07cjFVwaaNIkH4tWRf5+h2X9
         zCAmIWmcJGxtloeSnO/zOnOZsdR0QuZ1+iZkaW9LVkXgnmpgYGsge0vyAtyqF1OUpDnO
         PZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802294; x=1794407094;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4hI/wR+O9+PtJMYpH1LsmOwgDKx85E/tA4Sa/she98=;
        b=fnGeI14jjxB1Gq4noNwU358nVzXllLRKc6O+CCXiM7hqWG0BpQVMycsmhZcKrYmKD3
         ZngXJ2QT/1hxTyLbLViv7oq1Wcrj6yeiHCB3rftOKn8n3RX5ajpluvMWYY6NBEHqaYSD
         HnnvAtIFGp6hgnqF6sRqYENbN3TZcxMSQYWTSg7U3Z1utRQIMEBgabuk3Bd/W2PMnvLS
         ijlTXPs/Xsg4YRBzxghQNUZ2nqZQiBk9eW0Mml86nKUSgdm567mXUqsuL0MeGWiYEoSB
         Y/INW8OJ28TEsvTepIXsfiYSq+sdgtcOmcK6Q6PQKLSVWEgyK5VwODzG6Exfx6sKSVDX
         XaNw==
X-Forwarded-Encrypted: i=1; AKwUvBzxErQKaeDk6a9CRaxtKmiFFItZ2cpBMVS+IhXibrPGpwQpxjF8rZiHRWCbwkDpPBTj/Rfywap7wq+BPNsy@vger.kernel.org
X-Gm-Message-State: APuU4Z86r5vOjI8AztxPK2kspBlAmehfIfboyZdsz6L2bru6nJN51ODe
	bgF8OkcnAaTBebBPaFtfXm8I7Tl6CATcy4m+o/3fMKIdXBlzR/QYwfEC9BUvNglWdKY=
X-Gm-Gg: AYBFou0luI3Uj8uAOf58pUSqih0qhVdD3jz6/20luggtiZbGul6UP8I+TBVFuzWOqEc
	4W+PntvIpMaJa5v39kAhhsB+fA0BjIORxMoZXknm9WrWhQu+OOgIy1Datm4VOp+07xaU1pVNP5o
	fdav+sfetYzmkHxCmXJX6jXFJP6FgStKuDguqwjK7obV10HLVHbMrVrqwwWZnVvTN5SX8n0tPua
	aUcbdOYWRtvcojIQWbQ1SWtKJWvPBejOB0bICjcH+nPOsa9Ns3WP1p9xDzpZu7imEYoiOLrMJfC
	AuyIjok7TsHgy2s+Ca1LiqZyAkdTDmHjQN3+fwoHkxFTiF8RXtejIQcpIDfOcUPMhGFBT7aRV/s
	yZ72p4ew5aicmPPcNfBtvb/hDORz36thYEjCQqMMd7M5GDmacr/vqzCNJBV78LhOTyKgnVHf1Nl
	5RjWjWdqMKUtnmpN2j8I3+XuFl7w+YmVKR7fff5ct+yOXFRcvqM05vU9oR+L2ROOjDR5LKN5H6i
	MDf4Z6waHxHZ6HVnOJO3j6CTjkZ/CLwtMU7cgvKssf6YLTQQSyyyqcAcHhendSwvfkonZLS8vgp
	56JOGcvrd0+p9axMzH2pALUyHeB1247pm3f4Ih+7LxKQLw==
X-Received: by 2002:a05:6102:2c0f:b0:7a6:d11b:16ea with SMTP id ada2fe7eead31-7d0725528eamr6330877137.6.1793802294559;
        Wed, 04 Nov 2026 06:24:54 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm1707725137.3.2026.11.04.06.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:24:53 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 14:24:31 +0000
Subject: [PATCH v2 04/13] fcntl: use cred_ids_allow_sigio()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-cred-ids-v2-4-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
In-Reply-To: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793802280; l=4161;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=BNh6wZFJGhDv/1Io8ag/rEiM19dXvdTZ1+clZ5AlxUc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEuQ3pBKGnZtTA/uiW57mwGZkg0pMghtcZ7iX/NzZSuY7t2jmozrg26xlXNTWjeHRRHJ/pzp8ud
 /swmwoI9mjgE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

sigio_perm() has the four comparisons of kill_ok_by_cred(), and lets euid
0 signal anybody. Use the library.

The library compares credentials. F_SETOWN only copies the uid and the
euid of the caller into struct fown_struct, so keep a reference on its
credentials instead, as struct file does for whoever opened it. That makes
the sender of a SIGIO a credential like the sender of any other signal.

F_GETOWNER_UIDS goes on reporting uid 0 for a file whose owner was never
set.

The credentials now stay around until the owner is set again or the file
is released. Clearing the owner leaves them alone, as it left the two ids
alone, so that F_GETOWNER_UIDS goes on reporting them. Who may be
signalled does not change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fcntl.c             | 19 ++++++++++---------
 include/linux/fs.h     |  4 ++--
 security/landlock/fs.h |  3 +--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9b71bc9d71d1..07fe32330bec 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -120,6 +120,7 @@ void file_f_owner_release(struct file *file)
 	f_owner = file_f_owner(file);
 	if (f_owner) {
 		put_pid(f_owner->pid);
+		put_cred(f_owner->cred);
 		kfree(f_owner);
 	}
 }
@@ -140,10 +141,9 @@ void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
 		f_owner->pid_type = type;
 
 		if (pid) {
-			const struct cred *cred = current_cred();
 			security_file_set_fowner(filp);
-			f_owner->uid = cred->uid;
-			f_owner->euid = cred->euid;
+			put_cred(f_owner->cred);
+			f_owner->cred = get_current_cred();
 		}
 	}
 	write_unlock_irq(&f_owner->lock);
@@ -315,9 +315,12 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 
 	f_owner = file_f_owner(filp);
 	if (f_owner) {
+		const struct cred *cred;
+
 		read_lock_irq(&f_owner->lock);
-		src[0] = from_kuid(user_ns, f_owner->uid);
-		src[1] = from_kuid(user_ns, f_owner->euid);
+		cred = f_owner->cred;
+		src[0] = from_kuid(user_ns, cred ? cred->uid : GLOBAL_ROOT_UID);
+		src[1] = from_kuid(user_ns, cred ? cred->euid : GLOBAL_ROOT_UID);
 		read_unlock_irq(&f_owner->lock);
 	}
 
@@ -847,10 +850,8 @@ static inline int sigio_perm(struct task_struct *p,
 
 	rcu_read_lock();
 	cred = __task_cred(p);
-	ret = ((uid_eq(fown->euid, GLOBAL_ROOT_UID) ||
-		uid_eq(fown->euid, cred->suid) || uid_eq(fown->euid, cred->uid) ||
-		uid_eq(fown->uid,  cred->suid) || uid_eq(fown->uid,  cred->uid)) &&
-	       !security_file_send_sigiotask(p, fown, sig));
+	ret = cred_ids_allow_sigio(fown->cred, cred) &&
+	      !security_file_send_sigiotask(p, fown, sig);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..88748be03505 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1185,10 +1185,10 @@ static inline unsigned imajor(const struct inode *inode)
 
 struct fown_struct {
 	struct file *file;	/* backpointer for security modules */
-	rwlock_t lock;          /* protects pid, uid, euid fields */
+	rwlock_t lock;          /* protects pid, cred fields */
 	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
 	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
-	kuid_t uid, euid;	/* uid/euid of process setting the owner */
+	const struct cred *cred; /* of the process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 50b3ddb8ac1c..d3aa84820594 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -84,8 +84,7 @@ struct landlock_file_security {
 	 * @fown_subject: Landlock credential of the task that set the PID that
 	 * may receive a signal e.g., SIGURG when writing MSG_OOB to the
 	 * related socket.  This pointer is protected by the related
-	 * file->f_owner->lock, as for fown_struct's members: pid, uid, and
-	 * euid.
+	 * file->f_owner->lock, as for fown_struct's members: pid and cred.
 	 */
 	struct landlock_cred_security fown_subject;
 	/**

-- 
2.55.0

