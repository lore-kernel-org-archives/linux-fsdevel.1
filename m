Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF545000
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947197; cv=none; b=hxSJ9/k3jB58lrgy2azo0/r1quQQZgmHz8eAzuRyxM3fU1ygkCTXgehOV1f1tGbsCvZZLvSURGI0l2qePS4SF59p5xSpLL5KcJ46+s/HqFB7TicETEqCgeTlXjNPawZ4ZtGm459SpQBEfjRXvu4AYgHrfhvxnbzcbAcwptAM0Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947197; c=relaxed/simple;
	bh=/opBjLlEq/vgOmiKIUQcrBbSGODGSv1adznKRq2Thqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hXQD0CSLQWltN7Q18e+KRgPdhJJBY+WV63VLdb3zX5ZVilkarOGhZVak/6Xl8u1xFw3IsR19nm1Pzda2aTlq3KC0zejyiOFIx3ECRN1KDOVPqeWMxOLKKqZdCa6vtZ6hIJdJtyOymY3GeMXCYbfErPValGDbSVpMZ5P9PhlHKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvRZizpB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvRZizpB"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c81db32393so126265ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 16:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782947195; x=1783551995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1f3MKShOfk4iUfvf9qLIvTdXvweDhrev1tUtGTADb3w=;
        b=nvRZizpBilvph0tnHDR/AsIfUT9PXr50FEprrwXsdiYnjfuwY9eDTTBX72hPZ/RVoT
         2fFMzv99HlmOmB8uuyZD3ZiaxMMltOsfVVYcVbfaWfvMB7RRneM4fESRCptuGfZAzep5
         axL8i9Ogflz9TvKAHnIVPE2+YPHoaUUhdCoF67lHJeKhiP3XcCtSYEW/gGzaJNzIPBFR
         TZ65gt3XNVSRJck64Vp7+ZGT3eqew8Z1UJNrcyZAUAAahe9Lem4Mpewxx5N+DWKeeOzw
         dlFcgQprbkCZeoIbFgk7qrO5s4bvzRlnJDLe1I8T7zJ/kfEM5dSblALabwDz6yphKXuz
         KiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947195; x=1783551995;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1f3MKShOfk4iUfvf9qLIvTdXvweDhrev1tUtGTADb3w=;
        b=WvR8nj16c0cdkXEJ+U2f5v2NoQNjIEAZ9A77pD17HBiB4Vhb+WkgQ2TukDqNNeetc6
         N6yPYZeu0VffhDOBA+nTlZevjumV7yfXSh/rx7t/PD3lVPWuS7Nuq+7wuMoj3jCptP4Y
         2dyTVCdTR9cOU0L68nxojoyr/5C2tiQ5hWTlrEgX8TAKZ+xeZ0hCexCU7J/X7yGn46RO
         d1aQyiit5WIknodRQij277q7dWaQbgHtieL/nZVlitHFH1/65qhA49yp2d180BiI3TCG
         N4I76edlroMXcxTUsyNDXlI0LzvfPcaFIFkB+6euLa+3C9CQak+rY9VqYxY47YbmIVE6
         QMjA==
X-Forwarded-Encrypted: i=1; AHgh+Rpgp6QnBKSN3BEOxdMdu8PgqM8GH2pizqaUnWJRi0/qbNdCxvR2T8/rPCFVvxvfCGrM2Uxeszn8csk2n6NS@vger.kernel.org
X-Gm-Message-State: AOJu0YwCp0nO8GUUqrtPPKZleD3PG/r55DVhxq2ZdUPZBv6+ijyO/lK8
	Zs5U7jRJzzMDx5gZrPI4VC0KgerIg0aycfoOo1Lf/grjGP9Pab9smkRRxmlUy+sMvg==
X-Gm-Gg: AfdE7cmlH4xMMh9sQcqR+gQXsoiZoN623k06YKxb84P4feJxwOWHC4FPexvPNT5IKh/
	jk0CDafjUuwV3RwOt5KXa+D2PGjxwYMKM8WeLQOkrgxrxPDKKEV0cMkIKYo6ft5Vj7Vdy38I0FL
	x7PhRu73G/kzEBvfs+nSB8FWmN7H/zAglLQmAaotl689cOHn1aW8uQn4Vbm+nPnHX5dRinJIlg9
	b/ufqKkgB2IVvE/H8NI98OkG9VfXwdAT1VkaPix/mQHDVuCpFZ1qJjq+Wa1U7BaQHIDxbaMGeVm
	qxpKgdGh8wDXUEY3s5/shr/sO+n2KmEQ9WPNiqH/3e72IlOxMDGSHoQAYGe1wyk4zYQfx5SPuKH
	j/W+In1uLiQ1k0bwOtH48EMZ7KIqogDCIZnctMdERjbn7pKQ+kUaJHpNo9LDBV6wZOAvGqUhjw8
	q9XeMpgdjV8qcESCgOOUrN7qhUq2bsdOzXO/TCQMDjlO4dkQ4u8GPG8xAEvTnRgPFN5ufYvfp8v
	9B4hSthyw8YvtyGOLaIdvqvXhibIhrp12E=
X-Received: by 2002:a17:902:e884:b0:2c7:f6ca:2deb with SMTP id d9443c01a7336-2caa3d72afbmr254205ad.22.1782947190924;
        Wed, 01 Jul 2026 16:06:30 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8fc961sm4768155ad.22.2026.07.01.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:06:30 -0700 (PDT)
Date: Wed, 1 Jul 2026 23:06:26 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH vfs/vfs-7.2.xattr v3] bpf: Add simple xattr support to
 bpffs
Message-ID: <akWdcp6P0FkNDzBk@google.com>
References: <20260602074012.416289-1-daniel@iogearbox.net>
 <20260603-abwenden-plagiat-abtropfen-31bd59c3140b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-abwenden-plagiat-abtropfen-31bd59c3140b@brauner>

On Wed, Jun 03, 2026 at 09:07:55AM +0200, Christian Brauner wrote:
> On Tue, 02 Jun 2026 09:40:12 +0200, Daniel Borkmann wrote:
> > Add support for extended attributes on bpffs inodes so that user space
> > and BPF LSM programs can attach metadata, for example, a content hash
> > or a security label - to a pinned object or directory. BPF LSM or user
> > space tooling can then uniformly look at this (e.g. security.bpf.*) in
> > similar way to other fs'es. The store is in-memory and non-persistent:
> > it lives only for the lifetime of the mount, like everything else in
> > bpffs. The modelling is similar to tmpfs.
> > 
> > [...]
> 
> Applied to the vfs-7.2.xattr branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.xattr branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.2.xattr
> 
> [1/1] bpf: Add simple xattr support to bpffs
>       https://git.kernel.org/vfs/vfs/c/a146500e1144

Hey Christian / Daniel,

I'm getting a regression with this patch when using genfs for bpffs. It
seems like calling selinux_inode_init_security() with !SBLABEL_MNT will
leave the isec->initialized before doing the EOPNOTSUPP exit.

The genfs path is later skipped because inode_doinit_with_dentry() sees
the inode initialized and I get denials in userspace.

I don't know if this would be correct but doing the check for
SBLABEL_MNT before marking the isec as initialized worked for me.

Any thoughts? Should I send a formal patch?

Carlos Llamas

---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0f704380a8c8..9cb1724d2bbc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	if (rc)
 		return rc;
 
+	if (!selinux_initialized() ||
+	    !(sbsec->flags & SBLABEL_MNT))
+		return -EOPNOTSUPP;
+
 	/* Possibly defer initialization to selinux_complete_init. */
 	if (sbsec->flags & SE_SBINITIALIZED) {
 		struct inode_security_struct *isec = selinux_inode(inode);
@@ -2988,10 +2992,6 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 		isec->initialized = LABEL_INITIALIZED;
 	}
 
-	if (!selinux_initialized() ||
-	    !(sbsec->flags & SBLABEL_MNT))
-		return -EOPNOTSUPP;
-
 	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
