Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035082C0307
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599521; cv=none; b=FPGZ7SDu9dEewhouU042pFn/5255wVJfaIxN5g7IKxtRdlCAXUhgFIcaJlhqBVlbCJ0n6oU3anLXFf1lWS1ESsoxVNJlm4TMQy2FdQXmKwdqiaY65sgkFIvru7lp/M9PQWHFbw9IHjxaYSU3FJ1avS6gZURiI5Cvz6Z3dPG4v+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599521; c=relaxed/simple;
	bh=PduxhuYscMfZoZGLmxiLCztvS+oLGHn00Q3DD+xBxrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyylDbnCWMLVykGl1mptBpucaVxWBakgUdv2YtEdZT9KrIWTsAwhOMUI7Xj+zZlDy+LKB2J6RYmsZi/Klk2ZX4NJ1IjjPL/RZXExewkrwiIOW4Fm6hw0oNP5VwvbfeyonXrq41TdlzDu5sdHBO0wuqnukuUpuiteLX3kEiuFnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=unknown smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=J+7/3y6O; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=andrew.cmu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="J+7/3y6O"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfd44fa075so703382185a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 15:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1775599506; x=1776204306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI+XxUh08LntUUnQET4Q65KhQLEFrlWDIGp/StKsGLQ=;
        b=J+7/3y6O4erKj9XINe8crW7QV0sBK9K9rPXMBZh8qqfoLe9hFnLtRMhABRLxbDqWwp
         X5Iq3pJDqens1FpliHRxztohA/+UW+rOR9dMcPGQYqSbfFXe5kAVPye8DRXrr6ulhw4m
         /8O5DLkCIHozPFAn/8hse/DMZMkx51LOPPJhfnvoh5JZVQyQbcRZ+RmQ+SZKvW5+Bdyh
         M+GNKoc8uT2BAva3M+RKSbpPc5Pxw6vjjpW9XAakYAMOWtv2wJmb9Tgq6K/8iVU50iml
         ZmPWpIftRiEzkbYfrKx23enySc/+m0FzcD81w60AAxjW7O9j0W5Qd8E9AESGQVQsKFne
         uDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599506; x=1776204306;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VI+XxUh08LntUUnQET4Q65KhQLEFrlWDIGp/StKsGLQ=;
        b=NKpfLBx0y5BaZk9bGYdwC/6tJXLoh8lMeUMyFv4IzsGkQmbgu8tT4O57nX1IIJbOKn
         6W2HWCKl/v+AKyISfWALh0rQWycoCryynJxuF0IAMHgk7oDKU9ETrA48E+UOpgjWVtF/
         dr2yXQR0lcvymTyyIzlwLO1azB+FBC2CiOnTCG2+k5zuG4k4xWnlvS9CCj7GhtEFiRsS
         gfvA4TZKj+0e9DtpGyK+nuOxwwzlOfg39B2od29+TcutElP2SjZ9IPks6ha7o9GExuUd
         7ylcPaCpKD44HlOjjtXkpYebArNM+ttxWavbowjlOXBQw+W+lp5lwZRS0JexEh6ag+hO
         JU8A==
X-Gm-Message-State: AOJu0YwABIpu0ArrsBE79myyTJmkzepvhqEWX1tLJBO8MfyXx78htJsJ
	ZUJ3G0TnBQ2uJQ6xlx3UZ010DSwaO7czXMlV39YPlUB0I1sfTaA3czXyJyYhtP6U/uNdXi3IP6J
	II84=
X-Gm-Gg: AeBDiesBUjCIoRqwk0ql35kcIOhiCirajfnOmaDDSo+TiiyQarWBbSjgg+dnFWfUoSD
	gT0hbM2D/n5LoveC1r6QbEcvau+pzw2MTowd4z5ChcOXv9z1gxRmgDTYzuiUysDJ9dK5mOqFSxb
	jMzGsAdKZuEKiJxWKZxBjoaNdVIj+TnI8bQFIp1fPPG8l12EeHr4QSen9+B0yy6Gx6R1bbrgSvJ
	vS28yduae84YENoYnnLgj/r+TLMJpDHt7hcYV3lM/Mn15XQGTHTw1x2jKkLre+qB9WIYFK1dBPY
	om8WfRnMx9LFaB8frVJeQRspfJuV4d3QDdM0jAjbsYioHLIRRecVeAg7mESh1+aEozsv+R+DV7W
	89XaOk0QN1Z+Sk+QfZMzhIiHuGIG6l7SrgoeeGB28tiX0XcdKnEluvPbz+ENH/H0eJzgfVdegcF
	pzwdORPr+XNdbpVSJM+a6/aCA2IyKNm4RyvUrW+FG4Pnc=
X-Received: by 2002:a05:620a:21cd:b0:8d6:838a:c98c with SMTP id af79cd13be357-8d6838acfffmr1440965685a.34.1775599505844;
        Tue, 07 Apr 2026 15:05:05 -0700 (PDT)
Received: from cs.cmu.edu (tempest.elijah.cs.cmu.edu. [128.2.210.10])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8067c73sm1332500685a.24.2026.04.07.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:05:05 -0700 (PDT)
Date: Tue, 7 Apr 2026 18:05:03 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] coda dcache-related cleanups and fixes
Message-ID: <20260407220427.326lgx22n4jgsy6b@cs.cmu.edu>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405021515.2866402-1-viro@zeniv.linux.org.uk>

Thank you so much for looking at this.

On Sun, Apr 05, 2026 at 03:15:12AM +0100, Al Viro wrote:
> 1) prior to 2002 coda_revalidate_inode() used make_bad_inode() on
> failures; is_bad_inode() checks used to make sense back then.  For
> the last 23.5 years they had been dead code; let's take them out...

Ah, yeah, didn't realize that, "if it works don't fix it" is not much
use when the code we call has been dead for that long.

> 2) coda ->d_delete() appears to have been hit by somebody overhardened
> back in 2021.  Useful tip: if we've just checked d_really_is_negative()
> and it had returned false, dentry->d_inode is *NOT* going to be NULL.
>
> 3) coda_flag_children() is holding ->d_lock on parent while iterating
> through the list of its children; that's fine, but that does not protect
> ->d_inode of individual children.  Hold rcu_read_lock() over the entire
> loop to prevent UAF there...
> 
> No preferences regarding the tree these would go through; at the moment
> it's in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.coda
> but if coda folks prefer to route those through another tree, just say
> so.

Your vfs tree is perfectly fine by me.  Again, thanks for doing this.

All the changes look good to me.  I'll give them a spin and I will let
you know if anything goes bad, but if you don't hear from me assume
things worked.

Jan

