Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925910;
	b=LF4mdfBtSKb/P9jmM9V+ecyerk6gI9nEvW4ZV9yU39+Gv3nLaMpi1o2xKbDT15abbdXX
	 Hc1n9OZublKWGaSo6wXX5WdxqWRG1PFPvryHyPg1qXlzJ2bAq0252jtJ2YS8FQAYLtMeO
	 obK+Z+IT4jUctaU/cxBAmkPLW4edDKVRwzJ3ggO2YZqImprJklNYSljXXyeRrxN7MKBrI
	 yPpte4yqKcyJNWO0X3dLzVKygPVnC5ztsyCR5tCdFb7s/kgD+Bs5vzn6A3uz3WJCH+iPE
	 65mTG63Bkav0Q7QLzX25pdCMvTlXJrKXUJLrIn3yY3edzEjM2eXBRLKMQyw3Z77kZZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=TszkTcdWcLDyL+0JxTi5b09ZBrAAFon+oeNujwIlDTg=;
	b=N07USs0pD6JM09LtQhwtEbkWqWPXmyVBxjkbzKSIo5RYI613uVJK7nI30wSYixoffR8C
	 r0OmvmKVo9LD6Rc/b9KPSGUCrdWMyeH598O7g3tn3Evv1zqoiU4mbxA95WLnrH/wbSGHP
	 aFl0AZsSpkwF/j7SpSadUjH8v5jtVUuE5PYGyijKtNVPbLSUjKZSU27hzy+lUlvJEaHnp
	 VjWZniM4ag5v8VqESWvmi9m/vUWdglm6BC/DUupDy8OwFvH0HQ7hCHjs80jtCtU77Fwcf
	 qzCskgZNynUh1Q6eJKLfmP2Oxb/j68KEM+3nZ7oIk1ysDFP/ty5z2vWVBpeWvb7vyRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWWIrnJD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43FD606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C43FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pWWIrnJD
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5365d26ccbdso34117171cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:31:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925909; cv=none;
        d=google.com; s=arc-20260327;
        b=r6JgcW1kR/eWf6LMA/GWcYiafAWgG3iBOqQ1dugmuOi0CEhmGkRdZ7AsePQhvcperJ
         45wlUepAS+6R3WRmpv66o9xD6Q5LZI0ZUUTPPN383hGIQZlfkVkfqX5qQoBKJ8ytlErp
         31BkUG90J3nij+Y4so462YKZm67zXpngtdl7B5wvWN7EQPK8BQOBvhsnAhUVDI1bqziU
         t2CqCwH+IvmsRNDFe2Y0HHThR0MmKVaKwlCooAMU9kwHAQoS/l8V7c0l1SEmNQkuE5xw
         /E/tLv9VNVsYTamprsbMexzNiVeL/jcXuxC44XXoYD3bISa2RyWL7IeMouUl107HPdqs
         EIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=TszkTcdWcLDyL+0JxTi5b09ZBrAAFon+oeNujwIlDTg=;
        fh=lfiIjzi5I0HnuBCXsxRUQ+gDGUJhnmDeRvZZEYoRUWk=;
        b=TFAPGVXc2xtMHtlNLAKHpJa6juwmUg0JfePq+OrpI3c0f3nUYopvML9qwC7sEUDRhB
         yRJCvM6pH1/2bWqeNfhSI7/3SL4BnX+ucI3VdA+Lh6xhWB2MqvbVHFmDWJJS3QAoP2cs
         l6/KUbxIXnm3YQW9XiBPC7kRrf5kogfJc0HT2qnul6NEzEDXwXpjlg6MmMkKvXc4etOt
         Zd0V1Th46/16ecNpvfUEUQijVbmpO8Bx41dFdgI4604DFTyiFwLFeDQ9nizLy+vqqFWv
         32KHiP3ag8Gtj69eNoIc5Jdd+Yny7eU2jKBLRnmlRu69B28289UaLmzN/FqZIwc9P9EY
         5BLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925909; x=1795530709; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TszkTcdWcLDyL+0JxTi5b09ZBrAAFon+oeNujwIlDTg=;
        b=pWWIrnJDW411z9/rs0j202liUMWzpzOVNpieNqTzF5py+LAXYrrYy6r8xPR6Z0IzO/
         nsjWj0JN5pDO+DRqQU385B+96mB8Drv9kzOvfRvNaj1fNO0ILTwxNOVshwPjfk8iIFWK
         b7XdCHidoaooUJkxkwhcZCvXWl6Jny44Ey7SuxB8cBtFjITfr8J+XIc0SjGs3jgz2UV6
         cpSd9K1MCO6FXmE3Th7o5CobUxvHfBoesm2PrO9Cw1wMBAGEFVqBbzDqmYJhqQDcCcoN
         3/Av+tsaVohBSevOwK02nnH04cUwtBEIFx7RZrvhduZSbya607hrr7ds4UMSjc7aHREu
         yopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925909; x=1795530709;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TszkTcdWcLDyL+0JxTi5b09ZBrAAFon+oeNujwIlDTg=;
        b=HHVmy3vFY24csrrHdpVfd5Tuue+X5CIQiSGq3DbDMXVVuTJUUbZ9REq2Kt8DPRiCOe
         TYVMeADR61ADWvV06L2uXKyx39tZsWCMPccXhWWvh/r7A4pF/5LgrTt7EadOuOpkeV9E
         /+xZ0TuAWBxz1ngD6wxq4nHkL0HefJe2qBQ9oSisjYLFz/9tCPyatdVjV9P6rIh3Hk/f
         xJ/9KjGBAJ5xMKGbnzcxXNCcjx448HX+zAipF71HPWTA3wJvr2QKdbvxeyxMCmUSVr3b
         4GRLtT5eSGKsAoma3O3uQu1Gkxhc4g7RvBWU0pdUtMgjUwARZKid7uvOsBAP8ros5ptx
         oqMA==
X-Forwarded-Encrypted: i=1; AL+hErFJCGgxrK5X1xpeV/OSvBG7vgr6AWOwABTiPAiWxDJcLyb49mT4CShoOwDU+A1zzd7M4zqmaehLpjBaT9uE@vger.kernel.org
X-Gm-Message-State: APuU4Z+XNxQ9nDH8s8upbPmKEgmyU+S7ZWSMGUCNPOtSy/0XuShMHSCE
	bqEOelrAbwQHkFpzVtLjx9ki+v6ql65dCR2am4ZIuhyBSDmCBD2O+C54r4xJdk4I01GTeNxHaVY
	j7JD2AqbrOg/fS+Z84IqGx0KOIDJVp18=
X-Gm-Gg: AYBFou0kSH2JzAabXjeCK4Jqi4igbzTLoSD4q6e/ZklYgK6daqD+9N2jSJN857mfTLY
	JN4abbOgMtd12bah/PDVh9jqi2sOlxfYdFrmBcKOWXEenWZSQsp6Znv4cpzI6jSGi6/VF4OPl80
	+oBx6qcRwmDN+Nlq+4jCKpY4IHQEPv8NRSPaR3UbiFq+lhlTPmVt8bFlpDnFCPAI5MdIdu/BmLx
	hDF5+jH9dsi6LjgjM1eMTd/bk6KwSai3uMGTcyIGDdhQfgDwanIRBuUmJ3mzNp7pPAvvTlezAov
	Y7q75fs3nVAlBqUpVhU3HHDryDTtEiCkrqLK8G9nKfm4Eb+0G0e4R3MKgsP5wCXb63cYEdh4xaO
	xa+YFopCoqMuLeglovDvblvwNdgWjGTM976I=
X-Received: by 2002:a05:622a:304:b0:533:2717:6221 with SMTP id
 d75a77b69052e-55ac765f6bfmr222851271cf.31.1794925908476; Tue, 17 Nov 2026
 06:31:48 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 17 Nov 2026 08:31:47 -0600
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Hristos Nenkov <nenkov2004@gmail.com>
In-Reply-To: <20261117-tanzpaar-dreihundert-attentat-6f03576b56c9@brauner>
References: <CAO7_G+ypR12OwOiwnrqXDAC9zoboTMn_qLoASfJqYP3H83Vk5A@mail.gmail.com>
 <20261117-tanzpaar-dreihundert-attentat-6f03576b56c9@brauner>
Date: Tue, 17 Nov 2026 08:31:47 -0600
X-Gm-Features: AclHuK_WIFhNkCr5GXrVFJRrFg2_b-Bo8eosWpjZkIoWkPjU6KqPeknhrXUxKYs
Message-ID: <CAO7_G+xaooz=gYyO5kw3Qbz+1MF=TUD-XQpAy33ETSX2xBVQ-w@mail.gmail.com>
Subject: [PATCH v2] fuse: preserve daemon-owned ACL permission decisions
To: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Seth Forshee <sforshee@kernel.org>, Lakshita Jain <lakshita.jain@databricks.com>, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

FUSE daemons without default_permissions historically handled POSIX ACL
ownership decisions themselves. The generic ACL owner check prevents
non-owner ACL changes from reaching these daemons.

Add IOP_SET_ACL_OWNER_CHECK so a filesystem can perform the owner check
in ->set_acl(). Set it on FUSE inodes and check ownership in fuse_set_acl()
when default_permissions is enabled. FUSE_POSIX_ACL also enables
default_permissions, so it needs no separate check.

Other filesystems retain the generic ownership check.

Reported-by: Lakshita Jain <lakshita.jain@databricks.com>
Link: https://lore.kernel.org/all/CALE1rk6tGt_Pe7CpFL1NSTgugVpXLH_iguO2D9VsAVHn1p-02w@mail.gmail.com/
Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Hristos Nenkov <nenkov2004@gmail.com>
---
Changes since the RFC:
- Use IOP_SET_ACL_OWNER_CHECK and only test default_permissions.
- Drop the caller restriction and channel-readiness changes.
- Follow Christian's proposed four-file diff.

Hi Christian,

Thanks for the review. This follows your proposed diff, with the owner
check in fuse_set_acl() and no caller or channel-readiness additions.

I built this revision on f66469d9905b39d2c260a15d7d6db450f4db67c1
with a minimal x86_64 configuration. QEMU TCG runs completed 88
assertions on the baseline and 88 on v2, with no mismatches against
the respective expected behavior. The legacy non-owner ACL operations
are blocked on the baseline and reach the daemon with v2.

The tests cover ACL set/removal, owner/non-owner callers, all three
permission modes, daemon denial, malformed ACLs, read-only mounts,
and tmpfs owner/non-owner controls. Checkpatch --strict is clean.
These are targeted in-memory daemon tests; I have not rerun Lakshita's
exact passthrough application reproducer or the full kernel suite.

This revision was prepared with AI assistance; no Tested-by or
Reviewed-by trailer is claimed.

Thanks,
Hristos

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -98,6 +98,15 @@
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
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -439,6 +439,12 @@
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
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -949,7 +949,8 @@

 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(idmap, inode))
+	if (!(inode->i_opflags & IOP_SET_ACL_OWNER_CHECK) &&
+	    !inode_owner_or_capable(idmap, inode))
 		return -EPERM;

 	if (acl) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -627,6 +627,8 @@
 #define IOP_CACHED_LINK		0x0040
 #define IOP_FASTPERM_MAY_EXEC	0x0080
 #define IOP_FLCTX		0x0100
+/* ->set_acl() does the owner check itself */
+#define IOP_SET_ACL_OWNER_CHECK	0x0200

 /*
  * Inode state bits.  Protected by inode->i_lock


On Tue, 17 Nov 2026 15:00:51 +0100, Christian Brauner
<brauner@kernel.org> wrote:
> On Fri, Nov 13, 2026 at 11:03:15AM +0100, Hristos Nenkov wrote:
> > Introduce an opt-in inode-operation flag so FUSE can make the ownership
> > decision in its ACL callback. Retain owner/capability checking for
> > default_permissions and negotiated POSIX ACL mode, and leave the generic
> > ownership check in place for filesystems that do not opt in.
>
> The flag is fine. The rest isn't needed.
>
> > Enforce the FUSE mount caller restriction and wait for channel readiness
> > before reading negotiated policy, including requests on the mount root.
>
> Neither of these. Before v6.2 posix acls on a fuse server without
> FUSE_POSIX_ACL were plain system.* xattrs. xattr_permission() let them
> through without an owner check and fuse_allow_current_process() was
> never called for them.
>
> The handlers were only switched to the acl handlers in
> process_init_reply() so a write before FUSE_INIT took the unchecked
> path. That's exactly what happens with the change below and
> fuse_do_setattr() reads fc->default_permissions before FUSE_INIT the
> same way. If that window is a problem it's a problem for all of fuse and
> not something to paper over in the acl path.
>
> And fc->posix_acl is only ever set together with
> fc->default_permissions so checking default_permissions is enough.
>
> I kinda hate that we have to use an iop flag.
>
> Please send a v2 that does just this. It survives Lakshita's
> reproducer:
>
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 738abed9a8166..56cdafabfb399 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -98,6 +98,15 @@ int fuse_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
>  	const char *name;
>  	int ret;
>
> +	/*
> +	 * Without default_permissions the server does all permission
> +	 * checking, including who may change POSIX ACLs. That's the same
> +	 * thing fuse_do_setattr() does for chmod() and chown() by passing
> +	 * ATTR_FORCE.
> +	 */
> +	if (fc->default_permissions && !inode_owner_or_capable(idmap, inode))
> +		return -EPERM;
> +
>  	if (fuse_is_bad(inode))
>  		return -EIO;
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1341b681d0ed3..d7070f58d7ec7 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -439,6 +439,12 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
>  	 */
>  	if (!fc->posix_acl)
>  		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
> +	/*
> +	 * Whether the kernel or the server decides who may change POSIX ACLs
> +	 * depends on default_permissions which FUSE_POSIX_ACL turns on during
> +	 * FUSE_INIT. So fuse_set_acl() does the owner check, not the vfs.
> +	 */
> +	inode->i_opflags |= IOP_SET_ACL_OWNER_CHECK;
>  }
>
>  static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index fe77934ea8f20..9256607e897da 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -949,7 +949,8 @@ set_posix_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
>
>  	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
>  		return acl ? -EACCES : 0;
> -	if (!inode_owner_or_capable(idmap, inode))
> +	if (!(inode->i_opflags & IOP_SET_ACL_OWNER_CHECK) &&
> +	    !inode_owner_or_capable(idmap, inode))
>  		return -EPERM;
>
>  	if (acl) {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77b..016eeea5da5bf 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -628,6 +628,8 @@ is_uncached_acl(struct posix_acl *acl)
>  #define IOP_CACHED_LINK		0x0040
>  #define IOP_FASTPERM_MAY_EXEC	0x0080
>  #define IOP_FLCTX		0x0100
> +/* ->set_acl() does the owner check itself */
> +#define IOP_SET_ACL_OWNER_CHECK	0x0200
>
>  /*
>   * Inode state bits.  Protected by inode->i_lock
>
> --
