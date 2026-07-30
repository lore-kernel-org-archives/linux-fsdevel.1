Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD83CAE80
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 22:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449239; cv=none; b=iu7UgsrjYdpvKC6SuypRccwafbg8e1D3AldTiAVIXFduXgqMV3VwTDuRQgPngYC34idsTeAb7ztaT9h/Z5h5MmNz8UpAl3sfaOT8qMpDxYxjs0GTQJt1OVW0SBpZMIoNNMGgnxRpE4954RPRAy4CHQeRnh96aBdmE5HFLJY88tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449239; c=relaxed/simple;
	bh=hUl2zOVyzUL8lT3SiYapCjovg+lHxQaZIYKJ8BlXglU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVLp4+ZF7/Ta+aDcLuw3jIrJYtGxBRTFZ1hPXIkTcDGECkO41CdhVVeGiSzzyAfiCtq96J5IqmaHwaA9tFEHr3+AZS1le+o6ZxDlAZ9ybNAnBbqE9goz7b4DzDjOxcnMJYCfafntX5ziedMDdkjvq3CZC18ENgzO30am74821ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXKviWlt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXKviWlt"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cede6375caso37385ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 15:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449237; x=1786054037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=VXKviWltygZBhIUkoOLT7VHl2k2xtoKQag7xfM1vfgUpf7y/3JnAbcn8oJKtYJHmN5
         LSyJKaTY32D/ChgDDyundLtIVjDPBtF5NBEqkABNORv4UQeqQE3YX8/tZAKalcxLYzpr
         7alRMO8gO1XZn5M3o19A93TKYIMJotzA8LwitqV8Jup8QLj13ohXkbOVfMhdRxHzRzA+
         PNMJ9GZt9s+rfXJbrBV6xjuffXQgg3J3RwWXMBLKjKRuT7BfzuSX05+jsoK0OkFVChtR
         LKzgbp8Yhx+pBDrGvKqCs6hnaqMuUSjsdN/nSXbm8ipuTNbYWdd/7Jnz+jAAX4Msc+iL
         Te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449237; x=1786054037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdkvtQLWpcWGFw82Hi5kFN/C9JuaGxTc6QXo/A4PB+U=;
        b=n1Dkj0YIXxmpNKg6N3WaeTi1GTZ+9HmHrJtFRfjIeNX+mJuYaQKwrXAgWRS/+GqLm+
         yjqvDWEy7WlzeNu4a+IcNAr89x/2QeAGHiWIpjDRK80IJ1+PCSq0kfNzPmKWywWqqdQw
         StD/jGYllO00XcY7m1CIzorvbpzbneyao7xaTbsuCjY9A+zdi43MsGKn5Q9evkOkkbvr
         /5GdXPvd+4qyRXglJqDvmuF2L/Rw/6/MdGEBFdAU1MBJNlgJkQSKqEmKQ4wR+n5obBh4
         p9wuMrVz7g7ZvAYq+7tWYFhB+mrF87fuZSqVovRhUuU9FB58OCOsf0JUxvt0AB+yIZk+
         JnCw==
X-Forwarded-Encrypted: i=1; AHgh+RpF7CTCNbJjspNWa1yo7kE9LBCAQAGQj5rJO0kmfxA1tEwFzvMeint852T/cw2FWeLqDZiXm7F7ZmH77qWv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pmC3gWtVxCTvdsokkc8aTr6k50A3QG02gtaevJULqFs/n5Cz
	N2No3SIA/Kc//CEJnh7+rO7CpCkA+nJt3qM8ldGNyloQTe0ij8AIqkwTME0HV8aSdg==
X-Gm-Gg: AR+sD100eERv2JQ4IKUZhJ1wSIK8E/Lx4+winxNTYKrReN6ENqbvTveKBVB4voIvxhB
	iF7d5CbXLXLobfUqlFEsazIIIHIfPFf8nOs/07R+fXVngcl8/HVAf67FwG+CWd75aR2wPmVv31p
	VEar4u7gpNOh4ygKS6vnzB4q5+ST17/QvwdY7XxQ+/Bgyem1tKQ4IdF/FNbbX3+XtEG/nFiZWZu
	H++ju5tXILg35xKW7vD/copHUQm4ApDri94gPk53+JllBqeuZjq3npeKcF5senJMiEjTvbgUzwL
	JVEIjUPMs/4vaslYU4parEEvY33cdAuV4P69/IXqOPuDvu1wDI5M1YrpFHI7SQv0IZZigTq9Spr
	r1f7ovhkif6Lxxw4W8R0WvB+nECNQbgAFRFNR775Py1eJ+DClHgaeebQLNyl6urB+nSrrqptPOd
	EvAk7Dfaa584KqngLb67uVVTFcX71/SL/0Bgc9Vwc+Ujj28u40yUUAuQlPWME6MUpFg6BqGBkV4
	FTiLvPArtNmHFxF/kfIdRAAsCxaPXLfokNgJrLZItLMkyMbGOAEJlvDnymmc8pgUo/zTgiI8IT8
	dp0RXhnZ4Pw7gnu72w==
X-Received: by 2002:a17:903:2385:b0:2ca:e0db:3cc with SMTP id d9443c01a7336-2d043edec5bmr1360785ad.11.1785449236599;
        Thu, 30 Jul 2026 15:07:16 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea00507b0sm3691939b3a.14.2026.07.30.15.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 15:07:14 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:07:10 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	"open list:SELINUX SECURITY MODULE" <selinux@vger.kernel.org>,
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] selinux: bpf: check SBLABEL_MNT before isec init
Message-ID: <amvLDoB4g7NMlf4R@google.com>
References: <20260730181008.3654413-1-cmllamas@google.com>
 <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db6fe5d2d4081f20f85abc6020b831fd@paul-moore.com>

On Thu, Jul 30, 2026 at 05:10:00PM -0400, Paul Moore wrote:
> On Jul 30, 2026 Carlos Llamas <cmllamas@google.com> wrote:
> > 
> > selinux_inode_init_security() marks the isec as initialized before
> > checking if mount labeling is supported (SBLABEL_MNT). This was fine
> > until commit 9722955b5430 ("bpf: Add simple xattr support to bpffs"),
> > where genfscon bpffs mounts fail the SBLABEL_MNT check as expected (no
> > xattrs) and yet leave the isec->initialized. This breaks subsequent
> > calls to inode_doinit_with_dentry().
> > 
> > Do the SBLABEL_MNT check before the inode security is initialized.
> > 
> > Cc: stable@vger.kernel.org
> > Closes: https://lore.kernel.org/all/akWdcp6P0FkNDzBk@google.com/
> > Fixes: 9722955b5430 ("bpf: Add simple xattr support to bpffs")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 8d6945edae7a..09a12eb8652c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2980,6 +2980,10 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >  	if (rc)
> >  		return rc;
> >  
> > +	if (!selinux_initialized() ||
> > +	    !(sbsec->flags & SBLABEL_MNT))
> > +		return -EOPNOTSUPP;
> 
> If we're moving this check, we should probably just move it to right
> after we assign 'sbsec' at the top of the function.  The calls to
> inode_mode_to_security() and selinux_determine_inode_label() aren't
> doing anything useful in either the !selinux_initialized() or !SBLABEL_MNT
> cases so let's avoid the unnecessary work.

Ha! That is a really good point. Let me move the check further up then.
