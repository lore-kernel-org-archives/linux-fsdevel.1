Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924056;
	b=DQIK8CPNgCtsMQUnXG7TZjey8MUF22OqglJh5vnnVcq25I6xxYGN+8mBzUeXhzqKdfIk
	 3t5FT/RMN5y+G6C1Gi+2DLXuGFUdQG2WOLYCz8pYk84acl4ORX5Ru502nGgjhH8xyjgpo
	 UjHr6Oa7/wxvLRKGeby2HT3U1bxlpCLj8I4pbvuvgVEbLWDE27DzkwuPOK6T3GWNohr0H
	 LQ65bptruxjVylmAXum2wv1U8llUyNjmySlbWnxwvqBg38skq+KQe5nBnL1hIq54tkD0Z
	 HKKs6cX0ES/0MKVX9SaItWhTo9mBUibCklVjRYLG5VLCqQifoEJHuwiTxw38N/bzC+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924056;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RCJknPnpeqcN/VUpgs7A4b1TZvqIEuWwL/dROW8XZRM=;
	b=4SF4qnY7vw+5F/JAyzQPEIC7d61bo//WIORbbqk9Kv95jmqzlew0+IBn1NHUjA627tFf
	 HeLNQHtAsEz6nXqwiy+rDNFaTbeOW7rpdIzLoRzFkOEt+t3N/awxnTNRaNrG3aurc0wIB
	 RWuruT1jPmfAw9J0be48KnACBqerfjHJg1xH8NfcS6XZbc53dtOOAcFlw7gvHMaacXkmp
	 O2npqORn0SSzEpYAC9sFCv+ySXh4hQOMeQYXi6D2nzMmh7iNH5901hDhEsBbIFNBIY7C8
	 jX4GDy+Qbm8H47vvxmqtNT7jLValT21s5AjoPwGCRHaZvHdJvDMR/1Cil1u0K7UnVeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbPDQVWn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E63606A329;
	Tue, 17 Nov 2026 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LbPDQVWn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C7E1F000C4;
	Tue, 17 Nov 2026 14:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924056;
	bh=RCJknPnpeqcN/VUpgs7A4b1TZvqIEuWwL/dROW8XZRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LbPDQVWn+jSXBmw3+3u0jFLfJBZ/pS8YlMIo1dxAh7uVlad/Zc+UyLLLOu7OqqBqx
	 rBSOZi9uV4fyQLXvWDdoGM7eEMKg6A+4ZnJVwUL4FIRDbN+Fa1VZslW4Vu8suhXIiK
	 e7pHtcK46dzGno/Nxm7HEPB1ILzwfw3hMRdUvJoVM34yg4ZUzp1VpaRvo/JpFmAO3T
	 SqZWW6LKWNXOrHByeCj/vlYOXGq94ehKO63zBdCE//JaO3yJhY6P7BCW777du8b8RZ
	 5Y99u6+kDGGAML9UZXvYpVI9uV+vHNo4e7v8IsbJZrEEbM0TFmMgIUOg154RxgDyas
	 leB9pWtNFFbIw==
Date: Tue, 17 Nov 2026 15:00:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hristos Nenkov <nenkov2004@gmail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Seth Forshee <sforshee@kernel.org>, Lakshita Jain <lakshita.jain@databricks.com>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, regressions@lists.linux.dev
Subject: Re: [RFC PATCH] fuse: preserve daemon-owned ACL permission decisions
Message-ID: <20261117-tanzpaar-dreihundert-attentat-6f03576b56c9@brauner>
References: <CAO7_G+ypR12OwOiwnrqXDAC9zoboTMn_qLoASfJqYP3H83Vk5A@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO7_G+ypR12OwOiwnrqXDAC9zoboTMn_qLoASfJqYP3H83Vk5A@mail.gmail.com>

On Fri, Nov 13, 2026 at 11:03:15AM +0100, Hristos Nenkov wrote:
> Introduce an opt-in inode-operation flag so FUSE can make the ownership
> decision in its ACL callback. Retain owner/capability checking for
> default_permissions and negotiated POSIX ACL mode, and leave the generic
> ownership check in place for filesystems that do not opt in.

The flag is fine. The rest isn't needed.

> Enforce the FUSE mount caller restriction and wait for channel readiness
> before reading negotiated policy, including requests on the mount root.

Neither of these. Before v6.2 posix acls on a fuse server without
FUSE_POSIX_ACL were plain system.* xattrs. xattr_permission() let them
through without an owner check and fuse_allow_current_process() was
never called for them.

The handlers were only switched to the acl handlers in
process_init_reply() so a write before FUSE_INIT took the unchecked
path. That's exactly what happens with the change below and
fuse_do_setattr() reads fc->default_permissions before FUSE_INIT the
same way. If that window is a problem it's a problem for all of fuse and
not something to paper over in the acl path.

And fc->posix_acl is only ever set together with
fc->default_permissions so checking default_permissions is enough.

I kinda hate that we have to use an iop flag.

Please send a v2 that does just this. It survives Lakshita's
reproducer:

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 738abed9a8166..56cdafabfb399 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,6 +98,15 @@ int fuse_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 	const char *name;
 	int ret;
 
+	/*
+	 * Without default_permissions the server does all permission
+	 * checking, including who may change POSIX ACLs. That's the same
+	 * thing fuse_do_setattr() does for chmod() and chown() by passing
+	 * ATTR_FORCE.
+	 */
+	if (fc->default_permissions && !inode_owner_or_capable(idmap, inode))
+		return -EPERM;
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 1341b681d0ed3..d7070f58d7ec7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -439,6 +439,12 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	 */
 	if (!fc->posix_acl)
 		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
+	/*
+	 * Whether the kernel or the server decides who may change POSIX ACLs
+	 * depends on default_permissions which FUSE_POSIX_ACL turns on during
+	 * FUSE_INIT. So fuse_set_acl() does the owner check, not the vfs.
+	 */
+	inode->i_opflags |= IOP_SET_ACL_OWNER_CHECK;
 }
 
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index fe77934ea8f20..9256607e897da 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -949,7 +949,8 @@ set_posix_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(idmap, inode))
+	if (!(inode->i_opflags & IOP_SET_ACL_OWNER_CHECK) &&
+	    !inode_owner_or_capable(idmap, inode))
 		return -EPERM;
 
 	if (acl) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77b..016eeea5da5bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -628,6 +628,8 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_CACHED_LINK		0x0040
 #define IOP_FASTPERM_MAY_EXEC	0x0080
 #define IOP_FLCTX		0x0100
+/* ->set_acl() does the owner check itself */
+#define IOP_SET_ACL_OWNER_CHECK	0x0200
 
 /*
  * Inode state bits.  Protected by inode->i_lock

-- 
