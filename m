Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850D32779D
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 02:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789265727; cv=none; b=ApDwQpXugCJDywFzPWUO4vm0kiGILD5ihSiPDK38aZarwrXelT/abTKVTX6DYbnunRZaXjksocpr+Q1W2g0YOqZomnkgtS+TRkRXh0763RzXBt7Px7XwgOx5wRvq4b3XgS5vqGNlTYVvU44oXB+eUmQAzgJflTo4kSbzP1QqyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789265727; c=relaxed/simple;
	bh=XAH7CnimcRNQoRRE+99q5yKGEMhsVyJ4d/BtZs/Wuxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euNoRYgpArZogDmBoIorLcqYZkUbGDhS29KNIYNjF4RBpMEA8YtYCXqPdrrFWkFHt6gJg9tmZMbabKtHrnQp+CrhSx4w76rDstXzBLVQubpZzjgacn/K39Zc19QbrIIhuNwBfcjPpfXROwUpevvUUTnbaILq3T6BSPZU5BPHOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X+pzcJYP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X+pzcJYP"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XAH7CnimcRNQoRRE+99q5yKGEMhsVyJ4d/BtZs/Wuxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789265723; v=1; x=1789870523;
 b=X+pzcJYPPgFr4zZgH8s8O5SHInfbQmbQPSAAPcWVYXxjAD2FhpxBH2rbLX4JOKzq2YF5pjhj
 ZHfaZP2ecAizAt6IZYwkguXOm0k4riPVDCa+QeUekkxc25+iyWLyuIaS4njzu/su1kOBFuLfgpG
 i3UBL/idVxdj1ycRePZANleY=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 71917a76d207099f;
	Sun, 13 Sep 2026 02:15:23 +0000
X-Mizu-Trace-ID: 71917a76d207099f
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kernfs: free the old name outside kernfs_rwsem
Date: Sat, 12 Sep 2026 19:14:53 -0700
Message-ID: <20260913021453.21507-4-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913021453.21507-1-shakeel.butt@linux.dev>
References: <20260913021453.21507-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernfs_rename_ns() frees the replaced name with kfree_rcu_mightsleep()
while still holding the kernfs_rwsem write lock.  If the batching
allocation fails, which is what happens under memory pressure,
kvfree_call_rcu() falls back to a full synchronize_rcu() before freeing.
A rename can then wait out a grace period with the write lock held, and
every create, remove and rename in the hierarchy waits with it.

The name is already unpublished by then, so nothing needs the free to
happen under the lock.  Move it past the unlock.

Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/dir.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1fa288a48d7c..b071071e51b0 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1820,6 +1820,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 {
 	struct kernfs_node *old_parent;
 	const char *dup_name = NULL;
+	const char *put_name = NULL;
 	struct kernfs_root *root;
 	const char *old_name;
 	bool reparent;
@@ -1905,12 +1906,14 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	kernfs_link_sibling(kn);
 
 	if (new_name && !is_kernel_rodata((unsigned long)old_name))
-		kfree_rcu_mightsleep(old_name);
+		put_name = old_name;
 
 	error = 0;
  out:
 	up_write(&root->kernfs_rwsem);
 	kfree_const(dup_name);
+	if (put_name)
+		kfree_rcu_mightsleep(put_name);
 	return error;
 }
 
-- 
2.53.0-Meta

