Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AFC3F926F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676042; cv=none; b=ZGQRJs9y4jco69/hZAoTloj2n9kU/omgBgy6Vex5K8cSUu6aY69iQGqLSnObLGE/WyKW92RcU8gnIrUs2Qso8wsjA53gs1k00wzv1JELR0W3e+nLHkXbegFR4bRGgYDGbuzFS0jwmHPwzFPTbWaTuQ9tcHerkIiWQO0TnEklia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676042; c=relaxed/simple;
	bh=V2ZwUb4Psjj4W9n/i3kdwmyYBsECNeStUAKv3jHoz/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKpabRgsP1+/y7YvDCM2fPAsFHuLo5Y63wOkZr+SZI7z6+jjynk+vmYAuf5wr2tZRrI3TeJkZ338s+Ba+Ver2HJDENakvUDvUhFz72RWvMrOqe8XKwwxZ6BLNTRN5uwcIfOoXwkupcWr7Sgnai3rdB3npVFt98Fw0hCUN58U5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdWPBX/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdWPBX/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA1D1F00A3A;
	Fri, 10 Jul 2026 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676041;
	bh=k0J29d76T8nB5uSo88Mi8R4t30MRslE8/ZOmMKaFA9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hdWPBX/oyNii0u9yP2GneFTkJ7IFuhUtxEjPB84ocWT9O3FqOR9uyMcx0PDgNbW9e
	 EI0No67nvK3AuDP4wkUMWkUb9jRceORpCNiyPqTJkLYmiA00yXBxz6UA35d57ys15a
	 Uj3jCiFRTabN8zBAJ1a7A/9V4qAP2YhPv5EJU21lOP9ALxFOVXwHaYFHfZLRRxEyIW
	 vesXsCTk+bOsOKFfGZ9igGmIjEUNwRdd72Ocpsk6waS7SrHXY98FZcgqOwPpWg35zU
	 ygFWMqdAe22JBfdEMQexLHvba77jpbYSKyTD5iGeKrWXONEKoBQ1MbLvZaW6Mqq557
	 wo2bm9/NKjwUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:22 +0200
Subject: [PATCH v3 21/24] binfmt_misc: use __free(kfree) in
 bm_register_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-21-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V2ZwUb4Psjj4W9n/i3kdwmyYBsECNeStUAKv3jHoz/4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Il/PqOC/TjTxdtJUxb/Tlz07O9KVsm4dZMX878s0
 1flP8vA31HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRBRKMDGvZpQ/difKLPDvh
 e6DClgbBtn+x355MDX83XX15gOL6FdsZ/vC3XXg4kcdjS2n747ANpklTDu7gC4r98ypTavr64vt
 3l7EAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

bm_register_write() has to free the entry it got from create_entry()
on every failure until add_entry() has linked it into the filesystem
and made the inode its owner. Arm the entry with __free(kfree) so the
error branches can simply return and disarm it via
retain_and_null_ptr() once ownership has been handed to the inode.
The interpreter file keeps its manual error cleanup as freeing the
entry would not close it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a9e1e0bbcc60..eb56aa6a3ca2 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -800,13 +800,12 @@ static int add_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *ppos)
 {
-	struct binfmt_misc_entry *e;
+	struct binfmt_misc_entry *e __free(kfree) = NULL;
 	struct super_block *sb = file_inode(file)->i_sb;
-	int err = 0;
 	struct file *f = NULL;
+	int err;
 
 	e = create_entry(buffer, count);
-
 	if (IS_ERR(e))
 		return PTR_ERR(e);
 
@@ -823,7 +822,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
-			kfree(e);
 			return PTR_ERR(f);
 		}
 		e->interp_file = f;
@@ -835,9 +833,11 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 			exe_file_allow_write_access(f);
 			filp_close(f, NULL);
 		}
-		kfree(e);
 		return err;
 	}
+
+	/* The entry is owned by its inode now. */
+	retain_and_null_ptr(e);
 	return count;
 }
 

-- 
2.53.0

