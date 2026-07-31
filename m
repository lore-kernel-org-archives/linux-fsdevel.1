Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD953D969E;
	Fri, 31 Jul 2026 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486983; cv=none; b=uHFZ8hhXOQ8tyZ9U34MFLnrtbI0TtaeI64IAnDjZxWbq8R2gt/KtvDlunQZ4WsbzRpILSQFr3D2T3+h4DfzHj5966d4dm/qFDXEFQ/JnKYPTaWG7/ppEZmxSNa72yynpCrPOr7IBNYJnA9371eZmxeQfkxnmbtzbuo4YZyMPIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486983; c=relaxed/simple;
	bh=bIbiidaIOuPLTAdbrF+XGnUrS+bbi91IRDK6SSDbgS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZWatCM16osSznBtfTnU5rgBqVw3LACROJiSpdULblIZuNOdQhX+mqbhYYF1WGbzwG6E/6ca6aM9dkZM5v9n09fR2wpfglZSOxKbgX/8ha5tJS6FEJGLItAgXWvlrrHE6JaRG4Q9AwwQzNpWfyp12a0qcUabIIyDwWXf5MRIKAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpi1rc2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpi1rc2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2161F000E9;
	Fri, 31 Jul 2026 08:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785486982;
	bh=8sEpoYCad2ZbqifV8oaNMsJKCf+1Pn3bhni5b4xnyW8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kpi1rc2u82N2iOb0iwnv5ooFkBDNe5vLIREeasrz33eaznSxavqKusRpEILKxX8wz
	 92smGy8jAumq6FkYDnz8HuVFQf97BvLf1ACmqMwTnRhtFA2ZXmydAmJc7SyBsio5DT
	 BO4/lODDbjI1CF7hF56ZGbNVhGefKcjfzUnb2eFkBTVn9MBWcUSo+uFIIkoX8gQbwo
	 1mGtZ/gQfLL9tlguUNaLfmaBD8loM9y10zBbSKMsxkn58i/gnTFi71r8csGfeXzEi3
	 uKB6dnurTjoXXJH6VS5bIJE2KEMopELhtpk3Yh65Kwe7RwVwgtc95zI0YT33wU/5Z5
	 xJatNLVh3LAkQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 31 Jul 2026 10:36:06 +0200
Subject: [PATCH 2/3] fs/namei.c: fix kerneldoc of atomic_open() and
 vfs_lookup_open()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-work-lookup-fixes-v1-2-2412b85cf65c@kernel.org>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
In-Reply-To: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-af865
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bIbiidaIOuPLTAdbrF+XGnUrS+bbi91IRDK6SSDbgS8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTlxDVwfLX6Ird8yvXnNluZRepl5++83jlhU92Dl4Wfr
 ff6XJf90VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRA+yMDO3mFlIOS+uqCtaG
 X2RPO+B12TSQ2WlmlGPZBSm/goRNJgz/Kxg8Zs3c46ysuch7Se3OnxWTqtNsFu0W2Ju3cYs9H/8
 JFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Commit ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
turned the comment above atomic_open() into kerneldoc, but wrote the
return description as running text.  kernel-doc only recognises a return
section introduced by "Return:" or "Returns:", so this added a warning
under W=1:

  fs/namei.c:4362 No description found for return value of 'atomic_open'

Give it the missing colon.  The summary line also has to stand on its
own line, so move the "from a negative dentry" part into the body, where
it can say that the caller has to hand over a negative dentry.

Also add the "to" missing from vfs_lookup_open()'s description.

Fixes: ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
Fixes: 536227b814bd ("VFS: add vfs_lookup_open() for nfsd")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 226abf613983..e31905dfeb20 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4337,8 +4337,7 @@ static int may_o_create(struct mnt_idmap *idmap,
 }
 
 /**
- * atomic_open() - attempt to atomically look up, create and open a file
- * from a negative dentry.
+ * atomic_open() - atomically look up, create and open a file
  * @path:          parent directory path
  * @dentry:        child to ->atomic_open()
  * @file:          file to attach child to
@@ -4346,6 +4345,9 @@ static int may_o_create(struct mnt_idmap *idmap,
  * @mode:          create mode
  * @create_error:  return value from may_o_create()
  *
+ * Attempt to look up, create and open @dentry, which must be negative, in a
+ * single call into the filesystem.
+ *
  * If a non-error dentry is returned then: when FMODE_OPENED is set,
  * the file will have been attached to @file by the filesystem calling
  * finish_open(). If FMODE_OPENED isn't set, the filesystem instead called
@@ -4354,8 +4356,8 @@ static int may_o_create(struct mnt_idmap *idmap,
  * FMODE_CREATED is set when the call to ->atomic_open() actually created
  * the file.
  *
- * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
- * On error, atomic_open() consumes @dentry.
+ * Returns: the opened or looked-up dentry, or ERR_PTR() on failure.  The
+ * reference to @dentry is consumed in either case.
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
@@ -4605,7 +4607,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
  * @mode: initial permissions for file
  *
  * Open a file after lookup and/or create.  This provides similar
- * functionality open_last_lookups() for non-VFS users, particularly
+ * functionality to open_last_lookups() for non-VFS users, particularly
  * nfsd.
  * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
  *

-- 
2.53.0

