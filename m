Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6D3C10A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310602; cv=pass; b=jFiqVwLiwvOlUbQLDVww0uJRv6F+hEsVgzWB3LC4yYk/gXT43jOyJEjCZlEuIK2DdJTVo4dN/6kdpXaqs7nCNrYUAeVyfuRRps5i0i4o4mtZejOyk3UL6ltgVb/9IOrx/plMuVb7LqGEp82WDWlSTFWMGbPQh2p48Q23f19XKKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310602; c=relaxed/simple;
	bh=C+gNPHz4KywkYN7bRW5o/LIam8QAzcc06RneqyLy4Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6vWqXs40oYhTbi1rK5qFjAi40jqyPhi2TO1KrWTnH4jwWPDhXbJ1zgQe1yOjuyHbkVdxim23174DV9pkVGx6zA0YtAaELftsmNX5H9KwCPkhAt/xHzvlDKeLAFnzCCcwSBFl/+Y/HaZtqmrl+P4RH84cWgECD5SSm/RIKo8OQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp7WPDsx; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp7WPDsx"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c0b97e268f3so155526366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 07:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782310595; cv=none;
        d=google.com; s=arc-20240605;
        b=Cyv23NpqOTQNkRRkLb60YowB4ZZRo6OHUkgFLwO4dC/H3X3lCWJ8d44IVGmvOdDkj3
         plpSXhcHmgDGjdDNVLVd7nu55Y/lwBRNstI9MdaBHRHU8qi9BIBxA0nvE5m8EgkAVhn1
         u0lKImEmXcJL9/B9qhqsdqy+F6mMHs8Q3nO9THsfoQQ783Vp6jFctZ4gkz4gmWQdMHen
         bra3HXy9KIA47KT6Ub2veorc8kdopHVEZYNeLEh/ZCJQldBdUdC9BwxiTq3A23xInoTI
         iLYwEt5UkiIK8Y5FO3iEDUW8lGo2b2OdLzfq5S+Su5/cWjyFrcnJKBVaqGHsZ871W2Vc
         kjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ofp3hEpmgBuA2Xl9gZnye4TILLUrjr4efPci3kviMPY=;
        fh=GDM7MDxdYyO0mDbWv78LfS5FHDcwx0h7MHbmEDGNJSQ=;
        b=SI0YdiPHMp3JKVAnNQhh9araLXw8IYCMpFK1bVxrkqV214PmpLB9av93Re0706cpZ2
         rQ92Rl3Wpl27vVsLeu6nsX2f7npQ9D84zAR1/AmeUPpH1rnxJY032v+RPxm7rfZHVGlh
         8iHPjfKr+09/53ojZTJ2HbGAQMD0GUNc2Yz/l0SEezfTcl0vEwF1QfNXTO1MdrxqfLuY
         TqIgC0mWW/Adx4OkdHJlt8hJu6VzGm9/NjJvEFjj08a8CIor1shSbh1xW+Zrxn5w6Zww
         RUs7qBNYNqcGPFFZQtrmqYvxVCvcM3z3JjJcejOnCpIMyVqRUpbQselZs1bAp1rLISZ4
         Nq2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782310595; x=1782915395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofp3hEpmgBuA2Xl9gZnye4TILLUrjr4efPci3kviMPY=;
        b=Mp7WPDsx9tx7+TGBJpV5bdT+0V6Bvluay+GgAv/yVjk4WJxpnu7uJ1O9gE2AVhNjNt
         /SRvJRBDTtePlHTO1CYBZ80lkuvdeLV8Ik5ZzxmQ6cXXcRN1JyEUV4KwYar2q26ZS7QN
         6IgAjj4SdBRTGQYZCYkVhdVXBBRD2gkZ3NpeF/JCjVn9927EP1XdbtwG/gjWy3OiLYzN
         2yJ9kJqbNff012wpaNVw8CBiwu6fNfbof3rkMFvXb8yO6qIsM39l5d8x9uA+PbybiA2L
         Gjxt1Gz/7d+SfdOzfkIjoQX+NQCeyfFUYNSlqeNxdGTiOvH5/tBtOSv9KMgdepqMHz7+
         R4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310595; x=1782915395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ofp3hEpmgBuA2Xl9gZnye4TILLUrjr4efPci3kviMPY=;
        b=UONTVe9uA+EkbQ87QQlfwBiTcdQI8oCNMi74PC+HKMCuvSvNu12CqcABeViAeL9p0Z
         pi9ngq0eQadAsxp2Vuu1M9SEQgE2ooeBfzbVlBBr6QPTCGqXNY7G/zCen8FgeiFgVYdL
         m0kELJ9VtbtAA0RwrNHHDBlI53pxhg6jQGNjx6SD1YsvG6wOATDTp/Av3Bys0fjU35qE
         j3ChViycTuM8l6RG1zpr3QkU1/4qJoZgKQQv4Qw0W9bCSjk7BzDgHTWoEjsXwEonr8pM
         6edZV1V1WUXRYpKwiPtWzaEKaCTz/QJkgFcoypIhVl2YK4hZKIlhO6gq3Dw9q4V/fJfu
         J4NA==
X-Forwarded-Encrypted: i=1; AFNElJ82QM5jHXclmkn6JZtbHM+R5jGK7eezQyJ45Q1P3JWbKZWkqTYQHwvBgphsoUaAZZSQgmGiTHap7jycSrwO@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBX6YCLrMI7dmgt1qAbd1tmtMdieEGkZfDUR9u7K1IgA4Zxxy
	+wGO3z3yVpd/O84CBa9odENOmohFero4YgjJrRDG+d3BkzbNaGv2dREGNSyZ1MH1UQfKfBRAJw7
	UKg29X00uIcY8fz7CeEZKaBD8XA1LRHg=
X-Gm-Gg: AfdE7clNSIID4a8NptXRsTuVVtFTQk9ihLpNlji/SVC2UAcdoNwpmQ31eT7WgqNiNEN
	cx6Ejj8m1i1k+6XKQ5TowGgNt601jtaVmE193Z0uw2k6AXLCh+N/GU19oWErgUmNpxQBllGLo0w
	Na9T42S1LbqOIbsGAdvZziwMgkJqIkqQ2nMFHJIhjz/2AWJarpDXXHQExwP+40YqIDhPx4dhpHi
	J+GtvKq1/TKysZB2RWjpa6ZMPSUIB7v8WeiNN3hhyd2nN1Ihru0dhtvSQNlevB8AoAgaKiS8Axe
	Amr3DfzohCiyfCkq5WaoKk7TgxGs3spGXBiBUfyscQ==
X-Received: by 2002:a17:907:6092:b0:c08:93fa:2a62 with SMTP id
 a640c23a62f3a-c119ce79d5bmr206413566b.2.1782310594693; Wed, 24 Jun 2026
 07:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-3-ptikhomirov@virtuozzo.com> <CAKEwX=OaKTfNqzwa=djLxZDeBbR1+DKdqDnxdfPfZFKB-K+ECA@mail.gmail.com>
 <c390081b-7b2e-4b83-9bca-5f93eec6a939@virtuozzo.com>
In-Reply-To: <c390081b-7b2e-4b83-9bca-5f93eec6a939@virtuozzo.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Jun 2026 16:16:22 +0200
X-Gm-Features: AVVi8Cf8pFFkEx_V7HqzrhdruZGs8cQ3Zufmxz4l6Wlncf8175EfLgSWMtHkhw4
Message-ID: <CAOQ4uxhPROaeEyYceKNsL5QVwVPkTjGtbRr1P_TYXTA0fHvRoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: support cachestat() syscall on overlayfs files
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 1:45=E2=80=AFPM Pavel Tikhomirov
<ptikhomirov@virtuozzo.com> wrote:
>
>
>
> On 6/23/26 19:12, Nhat Pham wrote:
> > On Tue, Jun 23, 2026 at 4:15=E2=80=AFAM Pavel Tikhomirov
> > <ptikhomirov@virtuozzo.com> wrote:
> >>
> >> Overlayfs forwards data I/O to the real (upper/lower) file, so the pag=
e
> >> cache lives in the real inode's mapping and cachestat() on an overlay
> >> fd returned all zeroes.
> >>
> >> Implement the ->cachestat() file operation by forwarding to the real
> >> file via vfs_cachestat(), the same way ovl_fadvise() forwards
> >> for fadvise.
> >>
> >> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> >> ---
> >>  fs/overlayfs/file.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> >> index 27cc07738f33b..a7e252a91ea43 100644
> >> --- a/fs/overlayfs/file.c
> >> +++ b/fs/overlayfs/file.c
> >> @@ -518,6 +518,21 @@ static int ovl_fadvise(struct file *file, loff_t =
offset, loff_t len, int advice)
> >>                 return vfs_fadvise(realfile, offset, len, advice);
> >>  }
> >>
> >> +#ifdef CONFIG_CACHESTAT_SYSCALL
> >> +static int ovl_cachestat(struct file *file, struct cachestat_range *c=
sr,
> >> +                        struct cachestat *cs)
> >> +{
> >> +       struct file *realfile;
> >> +
> >> +       realfile =3D ovl_real_file(file);
> >> +       if (IS_ERR(realfile))
> >> +               return PTR_ERR(realfile);
> >
> > We're propagating the error of ovl_real_file() all the way to
> > userspace right? I think we need to handle this.
> >
> > For example, we might get -EIO here, which is unexpected and
> > undocumented from cachestat's POV.
> >
> > Maybe handle it and just return -EBADF or sth like that (with some
> > updated documentations, etc.)
> >
> > The rest LGTM, but I'll let overlayfs maintainers check the
> > overlayfs-specific bits :)
>
> Yeh, we probably can use EBADF here instead of propagating:
>
> Man cachestat(2) says:
>
>   EBADF  Invalid file descriptor.
>
> not really a bad fd here, but probably close enough not to rewrite man.

Please don't do that.

Re-read what you just wrote - it is ridiculous
Because of being lazy to update man page,
we are going to send a confusing error to user which tells them
that their fd is wrong, which it is not.

>
> I'm a bit hesitant though, since in other overlayfs operations we already
> propagate, maybe that was by design?
>

Exactly, plenty of overlayfs operations return EIO for unexpected
conditions, often accompanied with some assertion as is the case
with ovl_real_file().

Even though many man pages don't document an explicit EIO error
code, it is obvious to any experienced sys admin that if EIO is observed
they should look at the kernel logs, because an underlying subsystem
may have reported critical errors.

But in general, man pages follow development, not the other way around.

Thanks,
Amir.
