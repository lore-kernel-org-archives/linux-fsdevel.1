Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E73BAD81
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360838; cv=pass; b=IYmtdOoQs3CGBY2XEDNv8WoUz6qHuRvyaY+cLEMiJNpP3U/7sLHkckSBpBwzAkz9vn71ngZl3g6pIJwZOGWx0YacNU0dwamMOG7CPJj8p4VFb0sSBXVe7tXtCVn+0jCyxKcyp/ivo57LoD6i4RGZoHafmzesc1r+C6C2sT7ch9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360838; c=relaxed/simple;
	bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwW8LiOeYHtUw7oD5LpUsFk9saT+0Pfg96943gLuQKJhe4vzbBQl81EB30ozIc5FAd8rl8XrVxkSfk2lVrfdHDu/hEl6VvEsmpqvJY35nkQwekqDhHVgxuxczLB5a3vxOJS46wQNGuA5zTcPvMTikcvTu5KiNnTjE9rg6fZ9YQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4Y2zJF4; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4Y2zJF4"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso6146728a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783360836; cv=none;
        d=google.com; s=arc-20260327;
        b=W8foSQLLOucHYz65EAUgL5CWy8YFPOtFbgK93oAMUY18bFRbtg5dlpFGYL/D9bk+l8
         yY9iNq0QnBEf3P/cXjbUn4RS9MLraq01yfI2K8UGwv4O1Ac5kb+2cuf6Py8v5OcrJmNp
         2jezWWUQz+/Bdf4xDLJGZ4jhdmuG4PySS4hUVnG4Orc5dPDjt7BvKWPT9B2b7dpbCjNz
         6ix6JsTB4gcaB6PH1O8Y8M8LO7Na55Jf7tG/1SxN89VkpLWr52ON5knHOjmbmu6DARDW
         EUa025PjSHjQE2sOqPl2feSJn0su2QH388Tnwz7H+nT6ajNmjT9viSkQq8+8Jd1IjcXU
         73Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        fh=q5ijHhCmM9UfoLR1opngU999dIJnT4H5kUd8xsQOuFI=;
        b=c9g50OyggedGL4sU13/oiBf5qNKlV8gh1u9hxDTo3WzMyxrUd/rhrtMuTI2D2cZj1Z
         4KoR7xrQ4alJvErUQ+Cn9tj76C5Xedam8KimNuHIrtgRoMgN7hhNuFXhSiUWPuEOVyIh
         VJ7OU+D3B/GqVmFh175DgR0FIaYik1OLCOZFOTTfhiqesOW09+ULs52fP+femdZ8hqAK
         3e/cG/zW/CtlOE4kkg7cuJJxRMynnQ5cXPb2cm5YN0M9TJ0jKfGgUKRrOeSAeloK55G2
         h2dLfptE1IwZhiRkGnrXfqbRObO/QkgXamhx8JZjoPgKg4fvtfeKivjkxkRbf3eGfvz8
         973g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783360836; x=1783965636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        b=n4Y2zJF4yy1vvJ78/rR6r2s35rcoM8E1TXUvZuK+NFOYMarPRx+FoySpZxA75Akd6l
         j4ZZwEHQ4Lawu4fvxT9pGvpXhNPWuXErgjvHIba+WVlcAcX5dQDVYz3us9Mrth6fvT4W
         bxs/Xxzon83AvN1gpSo7DZdN4o6dEKaxNDsK0dtUGPkNDb4LIbTxu8LJQNjfmOvJ9OXn
         ZumiE/8ASyutgnqlEhR3KKe8XeFMNyC+bwTgdmb35vLRwaHv9ySVGVPqbGjRIctOaD8D
         Zr1Zc3lHeMaodIxzqITWTL3/y1iLBsC8KtsKQCnIGbNdyNZ/9p5bBtBOpd2vDbP3cH6y
         gcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783360836; x=1783965636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr60ISvk84gw7E2mdn+ZAgXT0Fcp3MJN+kcAT8jJdSE=;
        b=IfsxrhjYlequ/mF4ouL8oOQUwwzD0edDnIJrm9dZvqydtPe7i+hIdxpuqi+WsyVl2f
         u62+AVzXyz0FtN+GnJXSBTlggSukMvjIBL8zXZs0nDB+qWH0nMc0l6yDpADRiUF3/+Uf
         tYp9kYupfxvnMruG5kDxx49/F5zOJq27W1VHNmrJlCP+7GjZSTZLRpXt6cOkw/u9re3z
         0QKXnlXj1x3l7/Z9qLQmu3XaRzVvQFaGjEAVkihvZGm+27Q9kal+1pDolxHyPvv4zBtI
         WJQnD/U/KsNKK/T+ELJGQOWwIUFrAmoQh9ZSy0XFbz1EM2mLpr0Ar5UFYLZZWZCtvl5q
         bn+w==
X-Forwarded-Encrypted: i=1; AHgh+Rq0G7Y3/tJ9ndI5Km3WlP37JnwzCq6wVmqimRZqV1k47fpk3OmkhKfD3vk6XdZU4siiSbKF3D9Jt7Sl/65B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zqFnhOAjgd8kqkM1L/XhCCWIIYBWmzqqhVUVGPVag5MurKZu
	G/fphMbs75675ZJ34U5H94ItPFo6bYRTBYBG54wuL6afqOaOOdgtDHB7svODjJqlXkzYQth0ZxP
	84Bj4qFwiVz+snfcvi17it/7eT/7FlVM=
X-Gm-Gg: AfdE7cllNEp+MpOagbV8iTwHbXKGkXnxFpoutGfJ6uEJTst28a8ldddlNKLe9WLmCoh
	NdrGnQWOm6zALQrt2BKoDIR1iY6yn76QoPXgnxn333C0c4SMCv1Q51QAejTyIsf6GtpYqvVdEza
	XqM5BDbC8GyOMJ5hDufhBldYtbrblgXtoyt6CLnoE1TeIcHWcelI8UL7nVPpOsJMPHIiHin5CmW
	TCpvQI9V2kPchYEz8qLJAGMvzG5nc4YIvJWdtraGCyk4kLzgb7XQzkSMOR9SVMxwguMEw8bF4o0
	NPGyN01JZdubQnabtfXefyBSu69dwos=
X-Received: by 2002:a05:6402:321e:b0:698:1504:e3d9 with SMTP id
 4fb4d7f45d1cf-69a85bd8accmr1044410a12.29.1783360835438; Mon, 06 Jul 2026
 11:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com>
 <20260706170735.2941493-1-linmag7@gmail.com> <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
In-Reply-To: <CAG48ez0ebrMy8QGKLuz0Qwao_Eiav6e5pAJ5f6GrUPJLRkwNnw@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 6 Jul 2026 20:00:23 +0200
X-Gm-Features: AVVi8CcS3SKBXiRqnUEVp14psIAYY_ciJjhgFTNlSKDvmnRbNTK-HfNc6gtZ-qI
Message-ID: <CA+=Fv5R=mUW_p_AFFr-588F_b1hB=7RhMbtODya-gby=_fjBgg@mail.gmail.com>
Subject: Re: [PATCH] proc: protect ptrace_may_access() with exec_update_lock
 (part 1)
To: Jann Horn <jannh@google.com>
Cc: arjan@linux.intel.com, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, jake@lwn.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hi Jann,

>
> and that is wrong because previously, the ptrace_may_access() check
> relied on "error" still being "error = -EACCES" from the
> initialization at the top of the function, but now it is 0 from
> down_read_killable(), so now a ptrace permission check failure causes
> us to return with 0 without actually having called nd_jump_link(),
> which I think means we end up staying in /proc/$pid/ns?
>
> Sigh, I will send a fix.


Thanks for looking into this. That explanation makes sense, and it matches
what I was seeing from strace: /proc/<pid>/ns/pid could be opened, but the
NS_* ioctls then failed with ENOTTY and strace disabled pidns translation.

I'll retest the strace pidns-translation tests once your fix is available.

Thanks,
Magnus
