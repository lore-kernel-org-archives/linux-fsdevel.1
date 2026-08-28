Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76543E1CE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951070; cv=pass; b=lLFvpVwHAS9nTlKImgVcE+NAZ6NOtf8x8VFtliJXztRl4uRE68a7VRgnjPWl0f+7dakmyMb+CfVO5UGN3DEYNGBlGDyJEUnx2lNJ38+uUKIwH7+wGa7RCjZrqJY1FI5ToI/gnpasIti4Y1mxnjEcez6GerQ8bzb53RLoRRYghMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951070; c=relaxed/simple;
	bh=f3w1hYLRyxFmXw4h6OezomSo5E54Q0cAFAcgqbErBXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ2g+pORFoZhSqylCoGl9iFXOWR3mbelAwt059iiGehjlRU2VS414Kz7UrGi8ot5q5JzCxmVYrL1EeIcVb9CK7PCbLFau8bessOABW+0Mlh0t/b1id35G6YOuvzmhh0kxl9t9iAWom/kvpUjZl4eRYPuRsuYhmpnwMrJAxJoyKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BLnbnlGH; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BLnbnlGH"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8557c3f270eso996046b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 14:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787951067; cv=none;
        d=google.com; s=arc-20260327;
        b=NikQfnOCIhFzPng5kcpuPRdBr2VD40G1B0BVLNZyDkTd6RlFIKtQl48G4DkJVQGLH0
         3jogT/ttYftCWXjqgfQM/4utaX1wiEHmVrCblvj24y7iISsPr9UMDOdhUJvtxoQMNvmX
         oxh4U/ZZLvFGF7Q9gHOCNKuOeb4iLPcJLXb2bO88j7b3/htMJtVXS9V4gtSdk6K7vCxw
         BzIn0zvPNwBe2Vi8xO7K4nkawzvF73Xzp65pySp/mQFuuVDYSZSAGu3fsyd4zo/KM4jA
         1QSkgax39+lHiWaY79xVRQlmXLtuG0LfHcM9mrHhmyj6NkAeN7jvFaaq5hhiori6DBWl
         Epug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        fh=STQ3oNR3T+QjvtZHcxNQvrqh3PkLTx+8DHDX4/fs4Ek=;
        b=pkgkyEZ/Ha6dpoCDK7CpbmXAuia9XmqpbR55QfEZEuapPZW7+UQnV+4Mm3SS7+sNdh
         GZWQn7eOvWQRBPn2cVBvKTBTUg0Z7xgG4lghrjcrPxDX1ZgeFDfSf/nG5R/oFOpgaLWJ
         iEcoVozE6WvS+L6DF4lkEXKY3J+5WTGWAcTFfU+gUP3PE/UZhzxurPOTSpdFA8arKolx
         JyPlD7uvwmceP2LNZklzRdJ4xjgqhwL0hM9UXCz8i8iTnSStg33TN9ZE4efcYUx63Cyd
         VkgBgL84/EhIA4RMqlj2OjfKhvaxy5JGm1SjdG6BOstC03+7mgH/SASoHaZvUgHVjHBO
         FlSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787951067; x=1788555867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        b=BLnbnlGHFaymfa5q3WzMV5GGnEsKuBmv159wxJZHyf0Uolb+tCykyVH/h9Zu2Z29Mk
         CS701HZVFMlmcNMe6v1BHi08hC6HjJBeWXMV/0zr7r5JU+yHDOn6+f4Ci3gQmwGHSiRx
         ekxz9OAyuYde38s8R5gkawMX+9EJbhCqY5Q7piiofVBPhUiMZxzR9z+ZWFjaH8wL3Q/G
         aXHVrzZQANuSTV+G4fPrPXEFa1woijb1NIrpNmvQdyZAU0chv6DAMI7Ec+AzKUCpdaG7
         wWlaN/y5+L0LBYrlSSaJYIWj9JDjU0zgIk7yqQthGa1TVwtewlsnwmpdEIEtM1BQl/Pc
         eGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951067; x=1788555867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rKm+GtqXHGkU+e3cRid3cEbHk6M59ahcc5GavJOWZg=;
        b=WRjjZu1t5mOddeQZf6SfRyAeEepAYcSVLXw6+M30N0R8OjHfrVAcgJxJsSfF9GUkWe
         AMzFEYFkShuH6+x3i0UzOT1jxzDdRLSIQKZNCuVSgutjfyAYElNeveay5sooV/iqMjrp
         x1mnEVFEqa4MEg9Q2jOCFaPniH0kATc6trWGG4uWma2cuVx9fJnExbJLJ6+0LysDZ8+N
         pI++LCqU9AYxweIu8pFsz7xIHxj1VwE1HBJ/FUCouL1D4IjqDJBYLQTeaP6FURexfifZ
         9FkhHvyCYTKKbYT2K3sbFNdM8MdT6g07nnvOq7RuN0//KO/FoYLxlsPBsKMx7RAPj5BL
         NSlA==
X-Forwarded-Encrypted: i=1; AHgh+RrqutH1svPHQXoIs/xePkHz0hPRBO1XUYDFoB86GtJmFQoLBKFJ/liJ+gN7EYpTI+vqZ5qZL+a+4Ni/IqcB@vger.kernel.org
X-Gm-Message-State: AFuF++ku4bG5ue455ELzMYeBpB+NQU+oXWRH/x3DRteml5qvOaibCSA0
	IR5aD4JpHonyx/Ldg/BElTArCM/WErLpzZDvGOfobHJrgZiI6mHteFqiwD9WQZLY+Lmc0ZvAJPr
	wTV8IVm7LJ5Rn+5UpD+repwxW7QsxakySgIoFqGbu
X-Gm-Gg: AR+sD13tt6rHP4i7GeUpNeRsbXRwSyY9sNMYbGHc2Xy+tBd12JI9T1k2L6A8mwIpZF4
	3w36YwzRcCKqByDZd7PlYKb60bURXTS8LNym6LMatCtYj96co38D1gPiFYZ5dJx8iwV+mDowMNI
	xYdFoHr+3Z3habGBq2G//BebGLIDXGotLQ4sHYf+x+YoWjj25EmNWWuOGNmp2vEatnY0lM8Ci8X
	0TGybS1+mrD6QpTCN4r/nXmcqdlub8gFvAYjG/GOOxtltcyuIWDRVpKJOxBaewSm5jWP6jyZ++G
	hArRT0+DveBR6ASFODbVlqh/yoJYGuWPxoIuagrobiyLQCJcF/an/kQ=
X-Received: by 2002:a05:6a00:2d82:b0:857:73e2:9106 with SMTP id
 d2e1a72fcca58-85773e29373mr3141018b3a.22.1787951066990; Fri, 28 Aug 2026
 14:04:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
 <82929c994076d95f99560ecc67f6cfce@paul-moore.com> <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
In-Reply-To: <CAG48ez1rd3cFhmGn7mWkaVvGqYg+cDiGUhuhH6r51dUm-QBXUA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 28 Aug 2026 17:04:13 -0400
X-Gm-Features: AcwNN1XqU7CwGOxUd2wqJF7qUgFOnskAPT9XF2uIm2MO9atgOnmbTyVZNzUagTE
Message-ID: <CAHC9VhTmRsi7mLJM0Vak=aTj+NBO6piH-9YwVX5Kwh6yGPNsHg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Jann Horn <jannh@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:04=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> On Fri, Aug 28, 2026 at 3:10=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Aug 25, 2026 Jann Horn <jannh@google.com> wrote:
> > > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently h=
ave no
> > > good opportunity to block a process from overwriting read-only code i=
n its
> > > own address space through FOLL_FORCE writes via /proc/self/mem.
> > > The security_ptrace_access_check() LSM hook is bypassed when a proces=
s
> > > opens /proc/self/mem because this is considered "introspection".
> > >
> > > This causes a hole in SELinux EXECMEM enforcement, which tries to ens=
ure
> > > that a process cannot create executable anonymous pages.
> > >
> > > PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
> > > accesses are only possible when the LSM allows ptrace() attachment; b=
ut it
> > > is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
> > > environments running lots of third-party code, such as Android.
> > >
> > > So, introduce a new LSM hook that can forbid FOLL_FORCE specifically =
for
> > > such "introspective" accesses.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  fs/proc/base.c                |  9 +++++++++
> > >  include/linux/lsm_hook_defs.h |  1 +
> > >  include/linux/security.h      |  6 ++++++
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 36 insertions(+)
> > >
> > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > index bec6197329dc..dc6fdcb47b79 100644
> > > --- a/fs/proc/base.c
> > > +++ b/fs/proc/base.c
> > > @@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struc=
t file *file, unsigned int mode)
> > >  /* private_data for proc_mem_operations */
> > >  struct mem_private {
> > >       struct mm_struct *mm;
> > > +     /*
> > > +      * Was the ptrace access check on open bypassed because the ope=
ner used
> > > +      * the same MM (introspection)?
> > > +      */
> > > +     bool opened_by_owner;
> > >  };
> > >
> > >  static int mem_open(struct inode *inode, struct file *file)
> > > @@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct=
 file *file)
> > >       priv->mm =3D proc_mem_open(inode, PTRACE_MODE_ATTACH);
> > >       if (IS_ERR_OR_NULL(priv->mm))
> > >               return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
> > > +     priv->opened_by_owner =3D priv->mm =3D=3D current->mm;
> > >       file->private_data =3D no_free_ptr(priv);
> > >       return 0;
> > >  }
> > >
> > >  static bool proc_mem_foll_force(struct file *file, struct mm_struct =
*mm)
> > >  {
> > > +     struct mem_private *priv =3D file->private_data;
> > >       struct task_struct *task;
> > >       bool ptrace_active =3D false;
> > >
> > > @@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file=
, struct mm_struct *mm)
> > >               }
> > >               return ptrace_active;
> > >       default:
> > > +             if (priv->opened_by_owner)
> > > +                     return security_mem_foll_force_opened_by_owner(=
file->f_cred) =3D=3D 0;
> > >               return true;
> > >       }
> > >  }
> >
> > First things first, we've got to shorten that hook name :)  What do you
> > think of security_proc_mem_foll_force()?
>
> If we move the "opened_by_owner" part into a flag then I guess that
> works... will do.
>
> > Beyond that, we really try to avoid making LSM hook calls conditional. =
 It
> > can limit what an LSM can enforce, it tends to be a bit more fragile, a=
nd
> > it adds some unnecessary work in the case where CONFIG_SECURITY is
> > disabled.  I would suggest passing 'opened_by_owner' flag as a second
> > parameter to the LSM hook and calling the hook unconditionally in the
> > default switch case as a replacement for the 'return true;' statement. =
 I
> > understand it may seem a bit odd, but we try to make the LSM interface =
as
> > generic as possible with respect to different models and this is one wa=
y
>
> I guess I can do that, but then the question becomes, what other modes
> of using the LSM hook that don't currently exist in the kernel should
> I be supporting with this? I can make this a parameter, but any LSM
> policy that actually uses the parameter in a different way would
> probably be buggy/inconsistent, unless other new LSM hooks are added.

Possibly.  People do all sorts of things with the LSM hooks, not all
of them relate to access control.

> If your intent is to make the hook work for any /proc/$pid/mem access,
> including when the caller is ptrace-attached, then I guess I have to
> move around the security hook call in proc_mem_foll_force() a little
> bit. I guess I'll do that in v3, though I really don't like trying to
> come up with a reasonable in-kernel API contract for a scenario that
> currently has zero users.

As I said, I don't really have a specific model/intent in mind other
than avoiding a conditional LSM hook call.

> > we do that.  It also ensures we don't have to process the 'opened_by_ow=
ner'
> > check in that case where the LSM is disabled.
>
> (I don't think that's an improvement - we have to do the comparison
> either way, but in the current version, we then use it to
> conditionally branch to a security hook, while the v3 patch will
> instead unconditionally call into the security hook.)

If we move the opened_by_owner check into the LSMs, in the
!CONFIG_SECURITY case we avoid the check entirely.  We try to do that
when we can to minimize impact of the LSM when it is disabled at build
time.

> > > +static inline int security_mem_foll_force_opened_by_owner(const stru=
ct cred *subject)
> > > +{
> > > +     return 0;
> > > +}
> >
> > With proc_mem_foll_force() currently returning true/1 in this case,
> > shouldn't the LSM hook return true/1 when disabled?
>
> No, I have proc_mem_foll_force() doing:
> "return security_mem_foll_force_opened_by_owner(file->f_cred) =3D=3D 0;"

Ah, forgive me, my mind stopped reading once it hit the closing
parenthesis!  That's not a common pattern for calling LSM hooks so my
brain wasn't expecting that :)

--=20
paul-moore.com
