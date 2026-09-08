Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCC57F72B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788893062; cv=pass; b=F9uIJHyKtsqrQZjkCXrTf9BuRPTpF1FKTWb/CwNe3PsHna+pulsG/uVef34BukaJaBv4bszFFBiXaAMIoxcFvGwe8R3LkibiK3Gb4gXGxxS36wf7VKe7+9AI1DaW4nOo8bf2CQG95AOb/dNMt3TV939srXWuJZ9eHQMlBykMJNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788893062; c=relaxed/simple;
	bh=OsDw25i8jpEbYW2EpvGnqzyhoAwszWF31gBuwQJREp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/MaKNSUco9sxINkuV5Dcybk6hHkJT2TAdJNCM6FUp6Xwi0i18sjYWazgKQw4v8omOxFl1QWsOV8J2Bqx4s2tHGoXXO7DPsnp2DqjzreIiE+Qi36er/zvHk/hQ25tNca4cDE3Jim/klYljbLvYzsdouvPS9M4j6CbpXPr4aYx0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JNoaDU9w; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNoaDU9w"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-398b3d66515so4836758a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 11:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788893060; cv=none;
        d=google.com; s=arc-20260327;
        b=EedniNbFriHewXz0jGdh8zlblLbjR1jmYexlh9Il5qYA3JhXpOlKZLQb6hQ0NpUZOr
         cN4lGFzNDss+CCrp5Q9aWDBz14/zHtu4tO/w2rXg/Pw5fB/7GHKGz/HYq7jQ4XjkEzng
         5y4ezT7gx1YnWeUA7tBG+sBDjTHywyHnhyTbiMq/ib5FaHJJud1N/HjkQomuYJootahM
         fvk9ozzVxo1Le/rYZcp0iWAX0VeZ+pOv3Y7HC9yEySfuDAOSWlh9blr0Rkb7R/MykFnj
         gqXPGjwRuEW5CNcDzP9EkyIfDvwatXaUgr0yHJgpd2XHHcRIUaOw/squ/gsSyX1KxjNm
         tFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cnl3GmlLLYG5ceBDI4Lx66CdV8zxBJuAH6tk13fmHxc=;
        fh=yqhak0lS/Dk1jVNFpDSvT72NdSj2QD9paXFmh05LGUw=;
        b=AfQHRnVb7yxPEwMgfg+vq5FqPTqiXtlRuo9dY2Zy+8IXFJWvC4VFD/Shz6GkkC+ojt
         UKQSgI/N4um5HHoz7lUHhtBj8vnIR6Mg7faH0DDmUO8I6GUXejNvu560Bs8RJbacU6PD
         qNfeSY0Xvsr6kBJfpNKr9OE84+EObmYzzc3J8osMSVdOFdwCDHkhPNcBAgvdxNrnioA6
         G4aKy82otfKO0uFFtTgnhpqZmBnI/2Rm2Hism6koK/bpKu/fghXBxUDOD5wuxSLotiJa
         mZNHoy9oHA4Dst5BzUkRRKefc541XuAlIEr1MJ9QGVHjEWz0I3eqRKTADXMcCawXvJqZ
         H4rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788893060; x=1789497860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cnl3GmlLLYG5ceBDI4Lx66CdV8zxBJuAH6tk13fmHxc=;
        b=JNoaDU9wEJwT7H0ruOvBy/WfqCK9RuyOEQGeJ2mXAJgpcJQHpzjpgJgy2B3YsFGVoO
         K5AQKWxeSk5erdlKCcqZf6xnsOG3Q86O8W00AW3+xV8WO9q1OIW2wJ+OsIaYRSh9Wv8/
         l3FCdRGpMeaNHlRtfQuou9ZlqULPbn5MiXsRihTM9sFRimtcHYQXlqgvF7a8aP1AWonJ
         zdR0rPcWpNQTi88vqSlhMl4y8pkUz/PwGd2xcGTiVG8ASFFzO5vbniBqaExz2+uozfuU
         ExvEyAHcJzouBTdl5taUJoQvVTqTnZP2eUaCIZPsErh+UtIhTDpWxR7vdJD2UpeS2CfR
         Txag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788893060; x=1789497860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cnl3GmlLLYG5ceBDI4Lx66CdV8zxBJuAH6tk13fmHxc=;
        b=kwx2WuCU4rulCS0jdKFPZ41s4K9Co+f5R3517uSS4EMpjo3Wur4TMeVq6Njc7tCVTI
         /zt7fOZqOEOy2g1eTBUSLKc83Vn6tyXGmtzlNpu4OVHM2qTjC8P1fW9YOMA3ShG8YLNN
         x8NQM2cwZTELNhxmdXsuEShHm1vwzhn4euYd+0nveYbZyXHfoReVT1U4VBEZu8iD+fJJ
         9dENb3fRG1Ph6TWofKZsIS0hu5z6OUA+ksQJgDfQ6DLFCBD8QFbY5jwOAw4ZCMRuz48z
         08ugMcnalS261bqS1lQNHDO0vx4b0befDJNGGOVYqvFSQGLN5S8z6THdGPckCko87KUS
         j5Ng==
X-Forwarded-Encrypted: i=1; AKwUvBxECN5DLqVfcresG3cGvR9bOtbNdLPbuCii9gW2bJ2toy8VvtYtQoHQGd6GyT2/4gbZklrwAfzZHEo1MHMk@vger.kernel.org
X-Gm-Message-State: AFuF++k4+ToQpGA6rFb9jq9UF7u70z8bdX9dXHq0eybMgF5e5Vkx+8aJ
	E/agWCqjTeqne9LGYFYp3PP8d2uPkVhbh0CiFey9oguW0GZENT62z8wv2yhTIXBQh6gYjv3YHrr
	ciJ7ix0XhnzgCxmZ86VrboVXe0K7f1tTaIXk3vQ+D
X-Gm-Gg: AYBFou0+wioBtJTYchIbpIfUhBm4sIXvV6TzXYi1NGl0ABDyUp3e3ViNc3uJONugojc
	l4rQn4dpkETrtfLpR/+a8ih9wGL9hQHrsuxYIc8tI7TJWFlu2AhkGrS4ybyaesNaOA2iJwC2WU2
	21ovt+c8UtGb6JdZL0snVwPXDWyW8EWtSBNbI8nkEzOXu972o9D2j1+Vv3EgZ7/Hd/6Is4d+Scr
	BKWhu8SQwv7I1tw0oH00VFsbRf/pL9iour17NckOOEEWvwEHi3ybnqmCPWnh3NuKzdGvivvKC1E
	Beuvw7khIyEL4sjv+K+jF9ddkyXJEmqAX3p/BMOHdfzR7CeH4GtXavCgG/MwQUTd8rFLfzxozz/
	bCIyACaEAyhcWjCGaxNe5CQrZAu931OjdFDd4AUaEo/KaztOWa1BD5VZpl7EghEJUzL0LQSFbWM
	cW5/yR5YwGCPUXRQ==
X-Received: by 2002:a17:90b:2e0c:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-39b26169b1fmr45958928a91.11.1788893059447; Tue, 08 Sep 2026
 11:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com> <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
In-Reply-To: <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 11:44:08 -0700
X-Gm-Features: AcwNN1UHkN6PPC9jA6BXuRmHMcTwXRKD6v_Oc7M3f2NZNevEYBcFZsUgQT9WOgo
Message-ID: <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granados@kernel.=
org> wrote:
>
> On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> > Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
> > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> > longer applies the range check.
> >
> > It happened probably because do_proc_ulong_conv_ms_jiffies() does
> > not have the _minmax suffix.
> >
> > In addition, sysctl_msecs_to_jiffies() casts u64 user input to u32,
> > and a truncated value could bypass the max check.
> This is something that is orthogonal to changing to true in the
> proc_ulong_conv call. Please put this in its own commit.
>
> This also begs the question: why not just use an int converter if the
> range of the values is going to be u32?

I guess people wanted to use ulong just because jiffies
is unsigned long.

Looking at these users, none of them need the ulong range
and it can be u32 actually.

net/rds/sysctl.c:58: .proc_handler   =3D proc_doulongvec_ms_jiffies_minmax,
net/rds/sysctl.c:67: .proc_handler   =3D proc_doulongvec_ms_jiffies_minmax,
net/rxrpc/sysctl.c:59: .proc_handler =3D proc_doulongvec_ms_jiffies_minmax,
net/rxrpc/sysctl.c:68: .proc_handler =3D proc_doulongvec_ms_jiffies_minmax,
drivers/parport/procfs.c:369: .proc_handler =3D proc_doulongvec_ms_jiffies_=
minmax,
drivers/parport/procfs.c:399: .proc_handler =3D proc_doulongvec_ms_jiffies_=
minmax,


>
> >
> > Let's rename do_proc_ulong_conv_ms_jiffies(), pass true to
> > k_ptr_range_check, and limit the max user input to INT_MAX in
> > sysctl_u2k_ulong_conv_ms() to avoid truncation and clamping to
> > MAX_JIFFY_OFFSET. (INT_MAX ms ~=3D 24 days is more than enough)
> >
> > Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec wit=
h do_proc_vec")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  kernel/time/jiffies.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> > index 70926b73905a..4737431fdb16 100644
> > --- a/kernel/time/jiffies.c
> > +++ b/kernel/time/jiffies.c
> > @@ -187,6 +187,9 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool =
*negp, ulong *u_ptr,
> >
> >  static int sysctl_u2k_ulong_conv_ms(const ulong *u_ptr, ulong *k_ptr)
> >  {
> > +     if (*u_ptr > INT_MAX)
> > +             return -EINVAL;
> > +
>
> Create a commit for this on its own.
>
> >       return proc_ulong_u2k_conv_uop(u_ptr, k_ptr, sysctl_msecs_to_jiff=
ies);
> >  }
> >
> > @@ -195,10 +198,10 @@ static int sysctl_k2u_ulong_conv_ms(ulong *u_ptr,=
 const ulong *k_ptr)
> >       return proc_ulong_k2u_conv_kop(u_ptr, k_ptr, sysctl_jiffies_to_ms=
ecs);
> >  }
> >
> > -static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulo=
ng *k_ptr,
> > -                                      int dir, const struct ctl_table =
*tbl)
> > +static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_p=
tr, ulong *k_ptr,
> > +                                             int dir, const struct ctl=
_table *tbl)
> >  {
> > -     return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, false,
> > +     return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, true,
> >                              sysctl_u2k_ulong_conv_ms, sysctl_k2u_ulong=
_conv_ms);
> >  }
> >
> > @@ -229,8 +232,8 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool =
*negp, ulong *u_ptr,
> >       return -ENOSYS;
> >  }
> >
> > -static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulo=
ng *k_ptr,
> > -                                      int dir, const struct ctl_table =
*tbl)
> > +static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_p=
tr, ulong *k_ptr,
> > +                                             int dir, const struct ctl=
_table *tbl)
> >  {
> >       return -ENOSYS;
> >  }
> > @@ -333,7 +336,7 @@ int proc_doulongvec_ms_jiffies_minmax(const struct =
ctl_table *table, int dir,
> >                                     void *buffer, size_t *lenp, loff_t =
*ppos)
> >  {
> >       return proc_doulongvec_conv(table, dir, buffer, lenp, ppos,
> > -                                 do_proc_ulong_conv_ms_jiffies);
> > +                                 do_proc_ulong_conv_ms_jiffies_minmax)=
;
> >  }
> >  EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
>
> Good catch, but the commit wording is off. Please change to something
> like
>
>   Add the range check back to do_proc_ulong_conv_ms_jiffies that commit
>   b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with
>   do_proc_vec") incorrectlry removed. Append "_minmax" to the end of the
>   do_proc_ulong_conv_ms_jiffies so it is clear that there should be a
>   range check.
>
>   Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec wit=
h do_proc_vec")
>   Signed...
>
>
>
>
> >
> > --
> > 2.55.0.1003.g10538fe699-goog
> >
