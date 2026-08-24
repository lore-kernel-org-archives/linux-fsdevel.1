Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A958429028
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591909; cv=pass; b=cJi7JqHWYJYnwrm1gSzYVpqeqQ5cDMiqN1sA6lBJm8GzRGK1pQpr/i98AOwz3ySxMpmCx/dVNE1GnuWni0RjzZdPYhNf4CHiG9vVwcrou6dI5TPaNSa2M4I1euLD/v41Ms4qKEmkBO6f5S6HkqIY1oiTlANHRneypriXJumVYko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591909; c=relaxed/simple;
	bh=serqGqnhQOJKmR83TgtyVnBK/4uQ1gpqYK6HutXP+Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WP2xHAzu9U0MOHEYobhVSg+p3yjsdow5uW/Jy2nNxQWJaLcKF0ZOjR5B51e6R5CtHdALhfk3DMlL6+RGkr7qRuRSuigkE9D8N1MunHU2NXcro6qJ9Fn/l4nTE8g3soORiefqbrG8qHQd1ULQzxMmqzLh94UuskwqFnzGtmgPt2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=elqDOT1W; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="elqDOT1W"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d3b440b97aso5605ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591892; cv=none;
        d=google.com; s=arc-20260327;
        b=g5K05seicOno94uOMjoXGwsRkewnXRv1VYTsi9ryZDV+3sY4tcLt1FdJvLrvehnMuh
         TAxMUX24PHhKpOThURKiey4/2j8eMhmW5adZxfM2x25tMzdYL7WneZMiHnS6JTXsMoiv
         PlZ5sCju9eew/6Mh+OvkqQ2haPKr11yRCn32O5ibFoQ5HTxiYx59L0P05q0VWeiY7p3C
         wVnNSTqBMXxZfE1Ly0b0c//2wwuqe14LCgICgq3Z2HxoT58F/9KMW0RGa6cf0zCzmjJo
         1cbOhesMs04Dc0zpuO1yCSfm81JT08AEWK7wOaKKazoUMdI/h+Istl9qH0+HDZuJWDmK
         RdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        fh=SEpmYRqcKwaU6ZZD3oONChraDwp9KV9iMenLCUQ1LxY=;
        b=Qin/vB4vOYd9JmPETtS+A4jfPCNGbxokXfQ7odt5FPM0fHIGNNtbmV3kohqJIXP/Or
         T1e8tWa1yphJnjMZlGHEzpCf19Rbk2GYdzd0pvt9bofR6Er2WFGEbi2pa+WKPnc1R1Ju
         UrV0fr3WOQ1RRBpeKR1C+LC9cblIm4nXptCWHKqP5fzq3FBX+w28FHF09EX2vranLHaT
         hWi6Yrd3db696HWLjmrMHYuKBAjWpdSBiy+XtyG5XJkEzJ6Hw7+0RVmNTKoY+8Xe7Yfn
         ToRkpIktM7jhg/ON0RuxAm1BNHd2fATmto91Z4RQqIOx/oX30cn//ofJq1YNbQUroDtP
         OW5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787591892; x=1788196692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        b=elqDOT1WJHok1OrUeSMqRj7eiFO4ujaXdBbaYs4kLvy55WJ0bTHg/Ysj289mj78kfE
         VtdP1KEj32nqcz5pq2CZPREePzBb4W4Smrhc4QOBmKSO7Fy8zkxyaUmCBvdaZ4Pt0UYu
         AdjKvYBEkmB2k/AOIr9WGVt6wi5abfY4M97Jee0TFFWUmORwltSYXJrNe6s0cuiz9w9g
         KQr7XzCep1eRpCQ+U1nXTHdSX1/9EgGeQrNpH25kF+TY58rXDt27KfGOi47xcKY4ah99
         dlkkZaULmDOwkjYczlDGn33y6VbpwhN8tc1WNz1L3rI7AGhsZLvTxrmOblfnhaxsQK4I
         1UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591892; x=1788196692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohGszV6/vVpjIqIrVyQqtCXHHbkO7EBoByFIi57pbG4=;
        b=FAIETOVGT6eQL8Sc82xTzP+TmoXwRuGLeSytm400wycBgNWZhRWkgumWhQmTt0DGRG
         DzUghLHLneL+buSNP+bIVYt1JGlk8wjKYgDuXOifM8VWshtuW2hssvp5p0HSs1DoXgGS
         vSIYrJ405+75c3R/Uz28XPjVw3Cs/2NaruSyIepb2u2uX4o3OoJookMit5s9H4yzMqZ8
         5rxKZr3pNmRfrjtr5BPW+6rB11aLbe4zmMlcatka5CQ6fZYIqqzzt6tfg6C/v6M6IZ+G
         X5za4Tqab0nH4mVA+NAO02zc2WghKJCKgYaP25I9ELLvSFpWavK2Yxl7jPOG+pCnO0rt
         sVCw==
X-Forwarded-Encrypted: i=1; AHgh+RqWVQKaOjHY6hHtu5bRcUzMx0WuCg6TJ+HI64poZYQROU2u+7Ptm/SfDahRyvxswZ5OFl3fW4kXcPFYBvet@vger.kernel.org
X-Gm-Message-State: AFuF++lXs8a7Jepu+THJOosTtNJZVspEdFSvWpJerUN4nYA2KIaQKAOp
	3jVbi++2niZYeZsoH2lm6XhzjzF1mBbyitzvqzKpvHtjGDwCGQ7xR4OJm7o4595mTHTioi8HD+b
	qAQdjAfAvNWlAi65Xe13+UjKa3V1PV3cqlWRI9st/wSACRqI8ba8jGxH5aiQ=
X-Gm-Gg: AR+sD126ZlBkTW+3UEHzGMf1sGz3NrN70jrfC0D4Dkg6aLtDVRXPXAFzjavBQo0VLX7
	77c6pHWyAF+6h03WAr5/UYRVPCgmUNT9o19cqbwreiva6g75aOOtiIRP9ktioL9WfFKpNra+7nX
	u4BV8ff+cGsHlxiJtJptg5zDcnJb23rzFYyXL/ALZwfg/7CJKWAnopBWlbMjZPL8y+s9+BeP6fb
	GhFAF1mllsFz93cL14O5iaYwNtSql9BFmhASEMmRmUfmCBjqzLqb2KvBk+dxYVtJNRN6paCUlFO
	rVIQJUQs9Fy7ipowGYC2VfsmcrS6NvyUweAt9pWC+KE39vbcdnsQNTEauqnAgL1eJr3VugBvK4I
	ZlYIcMnNYg8V6EUVBES+jPrLcYtkxKc4=
X-Received: by 2002:a17:902:ced1:b0:2bf:1000:d3ac with SMTP id
 d9443c01a7336-2d673bdc43fmr10817465ad.11.1787591891683; Mon, 24 Aug 2026
 10:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <aoie0oyojqdHciKM@gremlin>
In-Reply-To: <aoie0oyojqdHciKM@gremlin>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Aug 2026 19:17:34 +0200
X-Gm-Features: AcwNN1WIA9RcA5rfP1casTlSYpI1XYrEXxEhaejdTW-7MsqouUyvqUL1sH-5Z8w
Message-ID: <CAG48ez05-BOK_SZCKimPuiP_WRB1dFrzvcL2bHmOR-bChEu+Cw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:56=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:07PM +0200, Jann Horn wrote:
> > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process=
 can
> > only create anonymous executable memory via /proc/self/mem if it has on=
e
> > of:
> >
> >  - EXECMEM (like for other methods of creating anonymous executable pag=
es)
> >  - PTRACE (like when using /proc/$pid/mem of another process)
> >
> > This closes a hole in EXECMEM enforcement that Project Zero has used in=
 a
> > remote Android exploit chain:
> > It was possible to use a memory corruption bug in a service without EXE=
CMEM
> > permission to overwrite executable code via /proc/self/mem, which made =
it
> > possible to load and run shellcode with a kernel exploit.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 18dd28b2bb13..905137c47321 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_st=
ruct *parent)
> >                           SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> >  }
> >
> > +/*
> > + * Decide whether it should be possible to read non-readable VMAs and =
write
> > + * non-writable VMAs via /proc/self/mem.
> > + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS,=
 and only
> > + * triggers on accesses that are not visible to selinux_ptrace_access_=
check().
>
> It might be worth mentioning may_access_mm() here, and obviously propagat=
e the
> suggested name change introspection -> opened_by_owner or fd_from_order m=
aybe
> even?

Ack, makes sense to mention may_access_mm() here.

Ack, I'll rename this to selinux_mem_foll_force_opened_by_owner().

> > + *
> > + * This allows a process to overwrite read-only code in its own addres=
s space.
> > + *
> > + * Creating an audit record on denial doesn't make sense here, since w=
e can't
> > + * tell whether FOLL_FORCE matters for the accessed VMAs.
> > + */
> > +static int selinux_introspect_mem_foll_force(const struct cred *subjec=
t)
> > +{
> > +     struct av_decision avd;
> > +     int rc;
> > +     u32 sid =3D cred_sid(subject);
> > +
> > +     /* Allow if the process is generally allowed to have executable a=
nonymous memory. */
> > +     rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM, 0, &avd);
>
> But does it make sense for the shared-by-fd case? In that case you're now
> updating execmem for another process's memory right?

Since the existing check for PROCESS__PTRACE happens on open(), I
figured it would make sense to also check against the open()-time
credentials here.

(I will be changing this to check just for PROCESS__PTRACE based on
Stephen's feedback.)

> > +
> > +     /* Also allow if selinux_ptrace_access_check() would allow it. */
> > +     if (rc)
> > +             rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, P=
ROCESS__PTRACE, 0, &avd);
> > +     return rc;
> > +}
