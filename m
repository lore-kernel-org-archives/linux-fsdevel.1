Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19195397338
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251491; cv=pass; b=Q0rCn7pveCul4qfNhilWXKKujUarB2tJ4HtGxg4vD6dYHB8ipnD9d6aLTFuGkcUv/A5g50DIWQ80+DArDV1rxpqWf+YjxsAQoxZlE6M6Fxx4pnXmcxAdyawmhbgQu/3tGhvlQQ5Uule7E+kl+Iy8EszVxR4rGVcBBP0khzNoj2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251491; c=relaxed/simple;
	bh=1BUl/L18VjoyHto2cVeOh6hrwiaVF2vC8ns+kaLeyMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+pmOm11bEfioDG19a2fWJo2ZzUyG7JRoHk1oDViq3Ry5q/m2RXKjowCMTpwuaab1Ymmf91V+2KdkYuQEPFehZ0Tr77m6yRcX09TBoBH85WirFGsGSt7gufglZrNcX4bgwP/nM5FdnF9RmANWMem6OV2laXZw4EhDOZkSXFFGKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcEQf1Jf; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcEQf1Jf"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d3b440b97aso13385ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 11:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251489; cv=none;
        d=google.com; s=arc-20260327;
        b=SvRa0LJMsqjvyYgTiP4GUGH9/O5vJN4zRZkv2bvDJlqHl9Ju2BxApVjhTEIh9EeUFK
         nYlkToyy3+5EXVeUCIcVxv90G1dtFDrzlCQYar/HUPwSjBBz1+Uyy10NkZ3FBQHIkAlz
         iA3k6m8hFGUf15BvjjqgUsuC5WY2OcoEJtMAlpB6cRM1xB6HVwFFqEm3EdKw9dxqLrGD
         TF2Kx/j7m0wpgLxy+wPFbVwOc9vJxMN2NDHXtwE49Xw1leeLv+xYGSJwrudCC/T79Jgu
         PolgCNKZTD+UnfrVa07VvGIu+iqaNNX7fKExoG0HhDDMIhR+USg9RJRldzGtw91H88lG
         D20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        fh=r6uDVpC93OuEfEyN1HjpbJBYui1WZyuvZ5FoTh9a5eM=;
        b=jUKC7GK7LG8OE+VaIAYJLV/Z816gwkvA62gS6XQufWqHk0PzO41GxPj2FFfyAxdM5+
         8CHXWr2GqcUv6AHa2JEg+tmx5+N2A7AQrY7Jb6wcj2Sidgy1o1LhWFmqvc7HsDDauTdZ
         HDcgHONMkU1m3QyiXRiC2y/OK00nIZLA9gikyD99PFVSMiav+N1E6BHRuweuAeqCHWNe
         KY2AuI7bdAov1qmJWNb5QnfCSNey993AVZhDtl59pnB3VjUzo2QH0xtpgw/EhULFUedL
         0iUEsctY2tXfIPDUf1jkef849OsdcYf2ty+EFYF39v4UYyC4Y5mH64k7YPJwJqowIqBQ
         TmUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787251489; x=1787856289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=dcEQf1JfkWtQKZBW2y7hJGbPS0z3rtQhMHHnMumkdEDuG5xKqTTfSFlfpDKJWAvsNo
         GeGUDOCIcKgYORGaZxwEVxUFxnQbEOo1Uk3H3R/2SecKGnktgMIFpXipPoWfiaMOTsZZ
         JOxtqIbtd+PulOvFb+6S13QPQXLZ3miLwBf62Hy6yV5Z/PC9n3C42kdhMrGEZvgLzkxn
         dqi15ns7h9w6ogFAyccb4BSKtizbWBFxP8GbkT7GgFEVFg+CgVSi9rVX8B1PfSmaK71S
         YBeAKX8dHnbmZAC5yO6RjDUH2pXT1eUwiNdkYV3XscblaanNUG2SQp6+uZOV6cgiOEtP
         /E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251489; x=1787856289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ra+u2k+WGBbYHMuPstN144hB8VFxEn7aIl8UwdTV5yc=;
        b=q50A6vqzaAwRVJ2obdb0fsmDu5Fqx7xGFqByZZhXWFACMMIgto2vl8Ij7jkpMldfoT
         piuR5vy1rHDYueobB+jACwDIPwwpHEOGohF4ACuq814y6mb0fTReF/zSfJMulLqezHXn
         4WNVEB7FKzcp50me1i8LhSEbw47M/0lyWvOCJ4MUcajBncbSX6C3JmGfaV5P+qZd2eY1
         UCK6YnoeFNxAmUPy/buNKZuRzMfMhM3xAvV/HtQZats71RGNAtgZu533g58wY+BhavmJ
         F/GIFrUxEn4zoTIF+vtnzV1wmr4ikK0ns+EEej6U1rv+vcT3iAJT1kqvEQmwhmIaTccz
         xrRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoK1iIYWq3h3xSmA3uFK9lNwk8si3QbWxyh8optyu4askJZNQo4xHHtAq2LyqQ+f+J4C4HjofuOYc1YfTcM@vger.kernel.org
X-Gm-Message-State: AFuF++nwu9AC5Hug5UDjatedUpJTVVkiHs16f39S55+98g6UxfkdeMpg
	vTeigcCskeSYjqgHKp4s4rFPy7ySNw4ys+7FCTFLH7E8O6MwgYVbckXp7/IKZcywYib30EKdsRS
	lB3wRi9AFqBigCe+ceGtP/OOj37eS8azeRFNVT8Mq
X-Gm-Gg: AR+sD13rcoMZiXP094KxetfdKxGXNaqfOIabYBxAW3Jn+3Dt/fc9cMlbTimUKswlJGZ
	ZtmfHJLE1yDtMd/JdyAw4mqMP0ngV5Q0Io+NteCa3DQ7urHIhL8X5ryGJBjpVNsHMrrFpBA/TIo
	4n8tWD4LiMu97A69CB4KeVLD1/qotdtylUbYtV83kmkQRgCO8Q9XmNtKwW3FBfmjD1c24PcshUH
	wKUvpFjNgjFJRNNpyARhZa7k4FXg9Zof0CAPrjZJIiryJGob/AInsJgsE4rV5hIffDRimcHXdzs
	ieF1kDW7Zzu82YN9WvwsgbjTYdnid7fdUD1lGu+7+ElVbjQ1CKQxaS9TKL15lA0iN9l56HGZ0sD
	u+vewGFAUbwVi3ELjqcXKeF8YHqUnnA==
X-Received: by 2002:a17:903:22c7:b0:2ca:cbe5:c3af with SMTP id
 d9443c01a7336-2d64b50af9cmr824745ad.7.1787251488719; Thu, 20 Aug 2026
 11:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
In-Reply-To: <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 20:44:12 +0200
X-Gm-Features: AcwNN1WPc46lB25I9dlQYQePR9UcO75mKPz3cBjmzriG3esMrA3mvmTFFADdtWE
Message-ID: <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:22=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
> On 8/18/26 21:51, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
> >
> > This causes a hole in SELinux EXECMEM enforcement, which tries to ensur=
e
> > that a process cannot create executable anonymous pages.
> >
> > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > accesses are only possible when the LSM allows ptrace() attachment; but=
 it
> > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > environments running lots of third-party code, such as Android.
> >
> > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically fo=
r
> > such "introspective" accesses.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  fs/proc/base.c                |  6 ++++++
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 28 insertions(+)
> >
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index bec6197329dc..3dfaef49bb70 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -851,6 +851,8 @@ static int __mem_open(struct inode *inode, struct f=
ile *file, unsigned int mode)
> >  /* private_data for proc_mem_operations */
> >  struct mem_private {
> >       struct mm_struct *mm;
> > +     /* Was the ptrace access check bypassed due to introspection? */
> > +     bool introspection;
> >  };
> >
> >  static int mem_open(struct inode *inode, struct file *file)
> > @@ -864,12 +866,14 @@ static int mem_open(struct inode *inode, struct f=
ile *file)
> >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> >       if (IS_ERR_OR_NULL(priv->mm))
> >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > +     priv->introspection =3D priv->mm =3D=3D current->mm;
>
> Is the feat that the fd could be passed to someone else that would then n=
ot be
> detected as introspection?

Yes, exactly, that's the primary reason why I did it this way.
