Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5F3CE091
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648154; cv=pass; b=OvChRGSa+H+GbSy9ImLeP73ERc3xi+SzG0y/pPJyfO9ts+yw3r+coWtKWcsF80Kx6lfDLcZk/CYMapZDxVwBdzthOeDMn3b5ZPnOa/0z85S7sx3ZMEpL0TBsCwBxBOULRyKU7TcdQ62t976RzOQvC1JBdKBDLMKytrDKpHTSgUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648154; c=relaxed/simple;
	bh=dDmXIURt4ClN8zywuB4zw0pWsU+HfqMJateO0/cdLBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haq+WjdPydBTAyhEEFS0wU1k7caeyPhpOsxjKArzetIRgDmDwzlE0WQA8qdjTSqXiULjYnfu5avk/gqVGah6Xy8SibvkSCCjW66IBylgxw2qiQ0AFkEQ8JXHSqiLVPGmA3Rauk+Su8O01lp+xK/PRPVALWGmgYpqujmX5Fi7c4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRHIVdXL; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRHIVdXL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so17207175e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 01:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780648151; cv=none;
        d=google.com; s=arc-20240605;
        b=h8DphDi/xeuAzC9l68+C6Uvuk3p7JQFYeJL9KIV8YobRZO8WBMLMSnrPYUAtiZUwuq
         9OFHYh5T7IiDnD6PNVNM6iXGwHiRuXjRmLZSHX6X6lySo4PbX01lw/IAa+7ugPJ+Ck8h
         t5/1KplYRtq8vigxtKFVEsWIr6FqkMD85GykVi6A5VUNRu1tuCziN/HNgCRiwWe8Si/r
         T83gMbIkc9oNf5UDVl83OK+R8KA3w+ZwcN0TnBjwlQB77ZmLtSjTvRL8iCZZ6RkuR78S
         iMm/jHEFBdpG4RBuET0XY4hQ3Gh6weWFWKZ4n2SEkNcKNYgNl3lqXFvMh9LpYScJQRny
         Dq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dDmXIURt4ClN8zywuB4zw0pWsU+HfqMJateO0/cdLBI=;
        fh=7JyMFcdoZk1b30DakIcsZbSuXMGbFCSmvOe/gDmMVrw=;
        b=hoyEdsb5e1JyiOyvQTNMoh7EWdhC4fvyHJVT9xyi7sMeqmWXjx2CPzmSNSkC62l/fN
         ACsJHAdMceDd9aJ7Wd4desfPuqXXtrLM13hVMY0Yv1ZVpPd1ZPfourtW3yA4Q9MFQ5Xq
         p1JHjWe6FN8b72u2UAJczZPX3a7Ey4c/Td2rttjVRpJUAYQMNAfDinokcvmukN33wULi
         Av0dA9Hqln3mLPHy+cllCLK5rD3nB3/ug6L6al+mfwfb2+bEOQNCZ+dnFUlRQTxR79Hk
         9zoISMm2VXJsEhBZS+sHrpEmLn1D9Cg4OgBDNT2HYECLByh6x4yIXVfy4R8mi4M9XSvM
         JCpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780648151; x=1781252951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDmXIURt4ClN8zywuB4zw0pWsU+HfqMJateO0/cdLBI=;
        b=QRHIVdXLN2sM8m/zzrY1t/5dIGiHDtf/ruStisubDrtoYHwTKEwVXxQoYdfX8Z3MLw
         fmUPhiqgK4okK6doiyJ1YG7e6rUxz6HCJfntPdVcZZaU3TqLPbFbL2NJkRZPvRprqviq
         6Md/qQ3ntGJW3x+SBowTLT3KJ/C57HGxFavbcsEtO0fhjK7Hvb+e83QhJAZ88gFFVgEY
         zNU5/IA/uo4nTEsNKnNEKOnNBvmSTEAV0WXaoQR6e/CZJb1Gh5YGfHQi72dZptYKg3Vu
         h6bgalN0P4vdCwoOHKH3kFbKU90Phxrl3YvYTpd95WRTgPa2re+X4wBVzE/M637BGjmt
         kCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780648151; x=1781252951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDmXIURt4ClN8zywuB4zw0pWsU+HfqMJateO0/cdLBI=;
        b=FjIlwhCbfGOtYwFsbM3rHruwLPSyVvohjsHFAkk3t55uEI9PkroLGWpNWrZZ8b+Xw4
         IIk/1VATppOkNwBjgx8g+bv16ssKVXxnxRel9ZxWBa52pMkTBB0YSwsczr2/oPQbtQX0
         5eTXY9U+c4ju6zFBWtJoDS8XO82K4am2qCSKD3HOLOS1CmoXD6UQ/JO2X9rcXbw4aFRr
         f4WzrAs3MqGtFrrPfzb//f4HMKDqovP62o8Z8BNaOsPihIXDWxEtfm+0qrbmiv90YcRC
         P3YNXlJq3Y+hE5L/hxEyXpMxYUk4pCKGTDGOygh92YiUhaWUor1f4fy2V1A5UsYVHKsu
         Q2sQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uKLA1Y6X6Z36ktl5CozvUWGtH6vLFtHhH4VtwD1LGD3Pdh+lHTetJcm94629YilkaLBCsH37WcuzSq+kG@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZZ4tc4iRcUrbK6MIKI5jUNvyStlu9J6JT3QynKN0YLqi/lsa
	w1r3iyItbenajc5CbZ5ASgYmtjzx5p9d/sxV20YX+Z3a1ZTK0Ik623k53PjNZbDVIAoXZYSvyxq
	ZxzH7b90kAMlLJV0Jb9cZnxYc6h1CydE=
X-Gm-Gg: Acq92OHpxk+mLKOxKXFQMIUqZD1x+WZZ4rN6AR/UtprvySXg3luESQLJMRConDKuVii
	LhHL1/gERGB83vXokem1Y0ASr8ucTx1k3w/t/hwouhsIzihTc8PC1AB/BXd3532MjwthI4cVX7C
	GCaYiyj7buBQS0Ok2Bvf7i3Wj7l7n/TXqYrPppknH4c5SS2YuZk3+fnvZNeaDUZEM46zgHnVno7
	Qeb/uM7A04QcR46BG3F9pf17mkSREtTdZ+FlWOxpewUI8s1KbQYYnwHQrytFWJqsIjQH4Pbd7km
	xj9WQDIKq+5GIwVIv+A2Lqmxh9Ymi6ZfHU0lqS4wKj/XS3LlcZr6
X-Received: by 2002:a05:600c:45ce:b0:490:b35c:88ea with SMTP id
 5b1f17b1804b1-490c25e74b7mr35481105e9.15.1780648151032; Fri, 05 Jun 2026
 01:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-3-anonymemeow@gmail.com> <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner> <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4> <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
 <CAOQ4uxgQt8y-KfCrnbgnqsFYxE-7zzmaBYFTh03ZjfHqs2FRZA@mail.gmail.com> <20260605-trasse-begangen-geerntet-ccafe6a018d0@brauner>
In-Reply-To: <20260605-trasse-begangen-geerntet-ccafe6a018d0@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jun 2026 10:28:59 +0200
X-Gm-Features: AVVi8CforKOjkm7QXLAan_fn0PlafAMCUrKsiZ2wnGcOym6hhCvgUYbgSVOHE6M
Message-ID: <CAOQ4uxiaBnr9JRBYPmcDq4X47+5BDOXFwDZzSMY5n6wXMKE4_w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:20=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Jun 05, 2026 at 10:15:32AM +0200, Amir Goldstein wrote:
> > On Fri, Jun 5, 2026 at 9:54=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Jun 05, 2026 at 04:29:47AM +0800, AnonymeMeow wrote:
> > > > On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> > > > > On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > > > > > On Wed, Jun 3, 2026 at 12:28=E2=80=AFPM Christian Brauner <brau=
ner@kernel.org> wrote:
> > > > > > >
> > > > > > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrot=
e:
> > > > > > > > On Wed, Jun 3, 2026 at 5:11=E2=80=AFAM AnonymeMeow <anonyme=
meow@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Sashiko said that pidfs_register_pid() can fail under mem=
ory pressure,
> > > > > > > > > since it allocates memory using GFP_KERNEL without a way =
to pass in
> > > > > > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to si=
lently drop
> > > > > > > > > the event even when the group has an unlimited queue leng=
th.
> > > > > > > > >
> > > > > > > > > Should we make pidfs registration best-effort instead and=
 still return
> > > > > > > > > the allocated event if pidfs_register_pid() fails? But IM=
O this will
> > > > > > > > > make the API semantically ambiguous. If the kernel guaran=
tees that the
> > > > > > > > > event pid is registered with pidfs when pidfd reporting i=
s requested,
> > > > > > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by =
the task being
> > > > > > > > > invisible within the reader's pid namespace. But if we al=
low best-effort
> > > > > > > > > registration, the event may still carry a pinned struct p=
id, but pidfs
> > > > > > > > > registration may have failed due to memory pressure. If u=
serspace reads
> > > > > > > > > the event after the task has been reaped, it still gets a=
 FAN_NOPIDFD
> > > > > > > > > or -ESRCH due to failed pidfs registration caused by memo=
ry pressure,
> > > > > > > > > IMO this should be reported as a -ENOMEM instead of -ESRC=
H. But
> > > > > > > > > currently it seems we don't have a good way to register t=
he pid with
> > > > > > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the=
 preferred
> > > > > > > > > approach to handle this situation?
> > > > > > > >
> > > > > > > > Thanks for noticing the oddity and explaining the options.
> > > > > > > >
> > > > > > > > We could fail the event in case on ENOMEM because the syste=
m
> > > > > > > > is likely is a bad shape anyway and other events are likely=
 to fail
> > > > > > > > allocation themselves, so I am not objecting to your patch =
as is,
> > > > > > > >
> > > > > > > > but I am slightly leaning towards the semantically ambiguou=
s API.
> > > > > > >
> > > > > > > As usual, I think a semantically ambiguous api should be avoi=
ded.
> > > > > > >
> > > > > > > > I don't think that we are going to change the man page to s=
ay that
> > > > > > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we =
just
> > > > > > > > add a NOTE about increased likelihood of getting a pidfd si=
nce kernel XXX
> > > > > > > > and mention the known cases of pid namespace and ENOMEM.
> > > > > > >
> > > > > > > The pid namespace shouldn't matter.
> > > > > >
> > > > > > DO you mean that the event reader inside a pidns always gets a =
pidfd but
> > > > > > it will not be able to query the pid of the process outside the=
 pidns
> > > > > > or do you mean something else?
> > > > >
> > > > > So they will always get a pidfd since fanotify is correctly using
> > > > > pidfd_prepare() directly. But when the reader tries to resolve th=
e pidfd
> > > > > to say a pid or retrieve info via the pidfd info ioctl they would=
 fail
> > > > > to do so (well, the pid will resolve to 0 which is the global ind=
icator
> > > > > for "can't be resolved in your pidns").
> > > > >
> > > >
> > > > Before pidfd_prepare(), fanotify checks whether metadata.pid is
> > > > non-zero, i.e. whether the event pid is visible in the reader's pid=
ns.
> > > > If it's not visible, fanotify will not create a valid pidfd and ret=
urn a
> > > > FAN_NOPIDFD. This is the existing behavior, and my patches do not c=
hange
> > > > it.
> > >
> > > We can hand that out. That's another change we should consider. The
> > > pidfd works even if the pid namespace is outside the caller's hierarc=
hy.
> >
> > I don't get the idea of allowing any insight for things outside of a pr=
ocess
> > namespace to be exposed by fanotify, apart from the information that so=
mething
> > happened on the watched filesystem object.
>
> If you only hand out the pid it's useless. If you have a pidfd you have
> reliable identity. You can use the pidfd-id (aka the 64-bit inode
> number) as an index into a hashtable for example and have a table of
> event generating tasks. If the task is dead the pidfd tells you that and
> you can delete it from the table. Or if you already hold a pidfd for the
> task and have e.g., isolated yourself in another pid namespace you can
> still figure out what task generated the event.
>
> Don't necessarily discount the ability to have a stable handle with a
> unique identifier per event. :)

I see your point, but in light of the attack of the LLMs, I am feeling
reluctant to hand out anything voluntarily to unpriv processes
before at least we got a feature request from someone who claims that
they need it...

Besides we did not give out pidfd with 0 pid until now, so this would
anyway be a change of behavior (program could assume it does not
even need to look for the pidfd extra info and close it with pid 0),
so I would not do this without yet another opt-in flag anyway.

Thanks,
Amir.
