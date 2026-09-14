Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092C49481D
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405558; cv=pass; b=mHSROVOCRTOWfXyKc/rAzhxJ2OKhm1UFvhwC8K9atg76J3VmZwzthwW8VfIR7qDQiLk6g481ZkdA2eDrBEgOSlhsjpGtBGxXG2AMznDyMf+YMdA8hBtA92YYcWOMLegUdPZlwFtL9OiHUF7DWB51YD0HSROTEdWqcoiJGjmhqK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405558; c=relaxed/simple;
	bh=jUNXLbhXWn3k3vtDnvsdLvoggUO4T9CBTRnFjm1YrVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea+zgpkzoWfCsiK6M9E7jdU0N8CZcWd7ySCVaHTWFSEZdhEeBCPQZ1HT0JEg1MpkiFreM4lUwxGUwESOWr+R6EZ2GlJm4U7SrXq9NaJTJEY6M8Axt4K3K5tIXIeEEBTZLDZbhfIzi1XbEPS9nTyPIxcx1kEbLaWZZVH5vP8NhTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a1fBxC47; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a1fBxC47"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed1368so21425605ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 10:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789405553; cv=none;
        d=google.com; s=arc-20260327;
        b=h5SvCYQNQ7TqxW941xDlvoefPALMi1QwAbd2SfQ3WwOH7DoAMsSjCVbOuvWq7NYlMO
         TEGmdi8yjEO1BNmb9IzUFT3tyDbVgF0bmN0ldpmM9hoH+DLfknAMFpGtgeESrVpNO+UO
         PALvuHibC3P+Ftj5Uga/cLu3RSVMTT16LyGpy+q0BcdhQIIGIjj9YAmpm6Bxi99bFxSc
         8cRbrWbfD4nY1jSOG1lJl4gyr99AOlYduCsIFo7gHt/ujQjVNgYjedcB2Gn3TiDwl/o8
         6GKGZgMwHEKdysRLk3wxCJ/DFEuHFzp2N9NQVaMbibgmrZubJN6H55sDAeCibWlYAJyL
         ASHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        fh=XYdeeGtKYJUbc4XtXTLqmmIgSN5HaT072R6wFtVijvY=;
        b=W+3SKUdzyQ1ubpYXOoDWPy4LtiHSF7s7R2qQF6tEaWBTM5034E5JhLvj+anbHoK/Hq
         yDtytdKS6MPde+FICiBeMZ/arfJbaSt14R8EbhN7PYJwtGAk5KpDjY+E5IGd6dThMlPy
         BmUh3ikZbji5B43C5FRNXFRxG3UEjgDZXbiFpTuA6w7NeXHccI9ldvHOUc/9aEiusAdM
         FedfeiWsSvQRv46WEFl3hY7IVtSmq2vvai8Z1tHoABtwyx82BKjmoju9yfbGz2xjmDjs
         HYvhfLHGB6/YAcbcG6P9uVGjBBIqAq4ZVMeWwKS+8H3ahbCDNr06ClNcrMs5KRNy0vFP
         qHhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789405553; x=1790010353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        b=a1fBxC470vf3gxUdvMqxfHcMHafJCFiwxvZ/34cxN5DMhy5NefppljZG3+7bfXsvBp
         kTcTa71VdbJ9ubCpfuDGkg/TmTtaHiWP4bLh5MTjx2JUpl+tcyOsVsdzJMUknGwxAih2
         mDcxs6pqVHw6A6ce0jhz16k9evy5J/1vGA39mGNoMWGJavGmXv0VyNqJkWVYqQ1IdWef
         o5yM3BsjYetzoV0xWaA6d5iFaMmEFxsCNch0sgNZbQfF8RCQ+Xdte8v7OmFCq5Dl9/oL
         c3FShJpn/SiNI6MH3I9OzvW29aUWIxa5d5SDLSHjcrxoRSSgKOXMA0xjkmy1dRA32cKU
         f9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789405553; x=1790010353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=avx3LuQUj0eIvtk4vMhq4fafE3JrorX2BSEZUs9YMHI=;
        b=H7vbJmZulSw4NxjJqqhwSfsGIJqXvI2VUzpHmDeKPI5CzPmtpmpjsM8jVHeyMcoD2B
         0CvEzjTvBIPvUsrtV6KldIq77wpVL7swAn2yv8CAixdq1aLcnnWtgpV31js8J7+p4NBp
         f4o8aCdjBb0oT0TM9dPZ2eSekbn8F6JL9BA0DArokFKmoNrKk96rq69HDmoDb/7xmDzj
         xIXGGLNzskBy1bA9j8j63djKrrg+0YOkdte0vXVA+q3acRFHzzIu+no5ZZLwvLr7XrCW
         eUOjXWc+491VcJjUA0cQTJcqIRnnfqJRawL9mTAEPSSpNrgJiS50TNM5QG4IdeQdAF37
         OOzg==
X-Forwarded-Encrypted: i=1; AKwUvBzcQmz2nXVQVK9quc87mEKgNR5yuZVCYVv9uYZV9IexRgDGrxfix8SPmUlP4tR50xU/Z52F2qA6gU5g7DcD@vger.kernel.org
X-Gm-Message-State: AFuF++m9+2/5cULYEOw/erwrS4vXN2ZYrt4TkYhsg91MLaZ0iYZA0OY0
	8xXlNejHwTqp7yKW0Xi67RtBUbX5vIIt04JUJpH0BWJIkPRgWCs2rKgTjKE7NP5/S/i77jqs5qY
	p5l7qnlU5zGLmuNf+vpB9KCvqSEw9dVpVOpKGFbXq
X-Gm-Gg: AYBFou0v+k0JbBHQJGTA1ja0XRFBgpZC+MK4AMde3j9SyYXTFlz8JUhaVU3jsBxb0t5
	I1azxfT+7MkciOnCKCBL5MqJJvz5I7GmgvRb6RSgy8Uy6v5sEfZwiRn0wkrBW3CpJiJpVsvooEm
	TBQR88qtHeLN2EpqBL44GPr4wTmcT8CU6MtJqytrOlhLsVRWQZ0X2rsG70L9J5UmNa2bm/sRuoN
	SMYbcFpBxjksc9cGW2Q1o03aveL+1vRnH/p1M9wZ9p+mGp4dI+PcIZPUaq81kuzxAu/O+GPGEid
	9mnYlSIm2rz+5mslsVIKs7Mfj4wRFshfKWwhH1vv3c1XKhjIC9tQpl9Ml7cIff5y9Iq32GSFXYK
	pXBSfobg21cY=
X-Received: by 2002:a17:903:2cf:b0:2db:56da:6a0e with SMTP id
 d9443c01a7336-2dd6c5f140dmr73526135ad.9.1789405552920; Mon, 14 Sep 2026
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com> <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
In-Reply-To: <20260910-wohnbau-bezwangen-wegziehen-7a32dcf237b1@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 13:05:39 -0400
X-Gm-Features: AcwNN1Wk1GrQXU1YfDdXmUukQFqj25lXZKtxh5blfh1kI19p2jakplNL0VfIjvw
Message-ID: <CAHC9VhTE82bRRSXSUuMOdrfoMh=xOb5hDvqiKWzBKD1urab3hA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] proc,security,selinux: let SELinux block
 FOLL_FORCE for /proc/self/mem
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 3:48=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, 07 Sep 2026 23:00:15 +0200, Jann Horn wrote:
> > proc,security,selinux: let SELinux block FOLL_FORCE for /proc/self/mem
> >
> > The goal of this series is to let SELinux prevent the use of FOLL_FORCE
> > when a process writes into /proc/self/mem and the system is configured
> > with PROC_MEM_FORCE_ALWAYS (which used to be the default behavior, and
> > is still used by current Android devices).
> >
> > [...]
>
> Let's move this on a shared branch that both the vfs tree and the lsm
> tree pull. That's the standard way of handling dependencies between two
> subsystems that want to route code that touches both of them. Branch is
> stable.

For some reason (/me looks at gmail) your email never hit my inbox, I
only noticed it now while reviewing Jann's patchset.

Christian, can you explain why you merged LSM code that I haven't
ACK'd?  We've talked about this in the past and I think I've been
fairly clear about it; I wouldn't merge VFS code without an
ACK/Reviewed-by/etc. from you or Al, I've been expecting the same
consideration from you.

While I don't have a problem with a topic branch for this, can you
also explain why this topic branch should live in the VFS tree?  There
are more changes under security/ than fs/, and unless I've misread
Jann's cover letter, this entire patchset is focused around enabling
LSM/SELinux controls and not necessarily anything really new from a
VFS perspective.

> ---
>
> Applied to the vfs-7.4.shared.lsm.foll_force branch of the vfs/vfs.git tr=
ee.
> Patches in the vfs-7.4.shared.lsm.foll_force branch should appear in linu=
x-next soon.
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
> branch: vfs-7.4.shared.lsm.foll_force
>
> [1/3] proc: refactor /proc/$pid/mem to use struct as private_data
>       https://git.kernel.org/vfs/vfs/c/d5662602d178
> [2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_AL=
WAYS)
>       https://git.kernel.org/vfs/vfs/c/9f90f96af73d
> [3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE introspection
>       https://git.kernel.org/vfs/vfs/c/5dac8c291d9b

--=20
paul-moore.com
