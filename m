Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4A39F191
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567435; cv=pass; b=SO1nZmIVqFq9k2w8xe4BlK8YxcV2RVO4Ov/AnNTUkcTvEJ/H54Pn1S7C/UdhpQK6HuoZM8ywAn7WMErFfMQrP3mjczqHucFMvK13gBfatM0PUYUqVzy571WVWpDxV1RiJ4WFccADLZkmoEuKHuI4GfRY40PSCxpy1ydn7WCRboc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567435; c=relaxed/simple;
	bh=9AoFaY+agksPLxPtM/tMGqdqBKUnb6DdpxFBPw1W7ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uv9Msq7WEGThCSU2eTSd9UYYfbU22w9ncNRYlmFKwbUXKp5FwvO5Nf7hm8sPRKK59IFY52Fe+rhr2MfHhMopS/ERN4Z9gWt7JvKyFvIQ5A0s4iHms6QlWchoH20sKmxoJo4lq7UGJZ3FSpiWx5PfDku7MrrMPj+VNTbU8yp2d1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BxISqOhf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PB5M5zwf; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxISqOhf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PB5M5zwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786567432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
	b=BxISqOhf/LBQ/7QOb4mZBbVxCONYW4r33U7T7vmNJ+uy+W8TyUl7gfGnYe1SQx4d/NW/Qb
	YaQJx22zUcB7D3PK0yFp/RVDj4V02vFnsg6NA4sOAKCn/A5MaEqGdqniYbR1JudcTE1DG8
	rSdGi+u/CJEJfbO6PSWRMUr8v6+SODA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-_q9kEQa1PJeDWl9H6iQULw-1; Wed, 12 Aug 2026 16:43:48 -0400
X-MC-Unique: _q9kEQa1PJeDWl9H6iQULw-1
X-Mimecast-MFC-AGG-ID: _q9kEQa1PJeDWl9H6iQULw_1786567427
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c206d40018aso29970766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 13:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786567427; cv=none;
        d=google.com; s=arc-20260327;
        b=gnVZyBd9s0eKKBuqzCwfS1EDsJfU3RooznSyLNAvCbQA+x40BiKiT8qnocb1biAbVc
         ZP8tP+19YKbgnbCjMlSAWrxjagv9bqbQHT8M+w6y0RYwoh4r0PtjsUAMR5fnAu2BtdGP
         uCy2amNkJJ9r+DSpJiCHufPWhddLM/sWExvfp9nwEWMMW883crqEvyngsqHBK0JZkXv7
         GN+4qZMClyKVWP72nfzWYbxrZ/h6pb7BQYoNi3Lrj95ZNWV8XZ51tpZ2ZTOvHMx8zZYL
         c9sZYaQeav2+y41OitDBD2m/hbJYz0bG9fEEQj/0RVaiphcXS052hL+zX9lj/qDdqBVo
         O16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
        fh=X7G1DuXEpI2sBPvd3SACOS3PogBP9lSr8TPrqOfrtM0=;
        b=ZIVFmMbErCS5K58Q0r6GBn/5StKlRWFenRHDYrtEZY4aLyuRubMVqnilq+HQDmfeNH
         Fp5FcrlDv4og17PtEJps37ODWIHsr+NPz8fS6HHeMuz6G6kdsZVVJ6hjEEZRtptwmThi
         Vk7e/TaDBYbK7C8iYmoq5FTIAa8RE4V2Q3gmICDHfyPvwbOYnWTjwOmi1T10Mbnt04dP
         ixdB8SQbwVdCQp6h8CafEvqfoaK540EehdZ6Gtv6Tew1zQurFDYQmkFKqh6Us6hP9Quu
         d7wiNRp/mNpWjEo+hR0HLygNUWccaeCcX0iI9fsXO4RiX2X201a2mbM+gOPpK7RYXcL9
         IrXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786567427; x=1787172227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
        b=PB5M5zwfjlcwm4sp4lj1naSg7IxOZTr7hbtQ0Xa0nN/7DoEPVJWnD9jvipW+Fp2Mn5
         jUMIpl1Depttd2SRyzzY4ojWEQpWgVjE1XrJgYA4ag8/9+iKLs/MiXo9lV1zQCjX9AmX
         i+tDPVgA6VpybAajawBAun5t7YJvcUmAKGDQTGYhSX3Pixq7s9udFHPqT4BA1JyjDFuW
         3vKj1mZmssDkjbwvZg9QW86smeB3DMkVvQAzFDE3V7xyeIECPw/ZV4W2hcDwSy6uo08i
         a2yv8QFp+EhPFy2JKAY8YdQgOC5SC0Ph/Q3RttwU92+qtplcTMbZgFI729QNkf1mvrI5
         CXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786567427; x=1787172227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGTjjKiMc8SxwL/T2PxyYauPu1JB5IRPJqXHgfO080M=;
        b=RYIPX0HSZXLaNiTpeg5Cg5DWFclgyVqNNN1N+smikHqPC1IN2A9IqQrPdIib3OJUUw
         fQXS87Ylbnu77MgYEoWrqEq+hl5MCsziftkb3+dHhy96sP1VBdPHAzSlY/PkE+jrAm9/
         BnwoY4l1dLzlyvGtdY5QVf7oCFc90TX22LPhZPTDOfcHNeVvMnQrq+WA79+4+Xham01s
         Zf/KUPuRiLdRpfVjM/1HmT4KY1JoDUI5QCrhokjMZPLgLAWqHIce7x+pE/HnKOgN/Q6+
         W2BxdLJQogDZQ57SKs7c5L2j6jdmjwi/SYNeZJTpFqQkkSHSwQd87wqDtCeJkXxiLUcZ
         rsqw==
X-Forwarded-Encrypted: i=1; AHgh+RoZDbDIkOUgYzXGlFwA6yA/6XwxVn3vn/u9DthQDEW/yT3vhCbizx4A6gEExfkJNy83DB4Cy5mDWvJ9O6Uk@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5czthbd+tIwP4CUglm8RWCuUrugsJLoOPQUGrIpNGE6PUgaH
	0+eHvWWrG+GLXvG+8+oxS5HcU/ct8KMCsg9SvePUhXKHX/FnmU44ZsVaErtchPKh5Mlzds2Ekym
	DQqr6kpM+/jykoKARjpdradz0TAZL+6eBrXUlK8Z/sATsw0jpZJzMFEW/cvj2OYu419Y6o/IFpf
	CZk+SSKe6rFgQ4h/5p1/HJFwOLJ/20UXPWk+V360B96NP4ICfOj0MDxQE=
X-Gm-Gg: AR+sD10X8vfrY0+KMVnGO1kkhF/FIwUNoW38cC/OwJGLxV2DJgOL/naz20Uh/nW1iL5
	pFI3so8fFOWKWHIXkpx0xpuNdd7BKnodgBm2KzaGYs1slEHGdfx90q4iZkpXRNJgH7cme8vWtpg
	AS2hn6ROzUYPcw5VeePjEvVwM0Vb3kkfreuIbAARnyo3jzUHQKNdZFxIC17IsqvU/Stsdxb+han
	aVytWYeEaJindQf0P8ySVycnXActA5YytqCGn6pxYAeuoAT0t8gbGB98Mf2i7+5uhPyIo0CTjO5
	o24=
X-Received: by 2002:a17:907:c491:b0:c1c:2218:f317 with SMTP id a640c23a62f3a-c2109e5c469mr20804766b.2.1786567427252;
        Wed, 12 Aug 2026 13:43:47 -0700 (PDT)
X-Received: by 2002:a17:907:c491:b0:c1c:2218:f317 with SMTP id
 a640c23a62f3a-c2109e5c469mr20801066b.2.1786567426866; Wed, 12 Aug 2026
 13:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
 <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com> <gKPBCNAOSa-tEF8t5Pm2xQ@redhat.com>
In-Reply-To: <gKPBCNAOSa-tEF8t5Pm2xQ@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 12 Aug 2026 17:43:35 -0300
X-Gm-Features: AUfX_mxMVj1sOxtB69ZMEGz1qrkl3qlQqT7KNuzmrL9G0kutGzunDJnJ50Zc9AM
Message-ID: <CAABTaaC6JHSQ6GJWLFdemC_jhv-5xZRBsEoZQQLd2PVcAQDYwg@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Steve Grubb <sgrubb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, audit@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	eparis@redhat.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 5:19=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
>
> On Wednesday, August 12, 2026 12:03:17=E2=80=AFPM Eastern Daylight Time P=
aul Moore
> wrote:
> > On Wed, Aug 12, 2026 at 10:40=E2=80=AFAM Ricardo Robaina <rrobaina@redh=
at.com>
> wrote:
> > > On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com>
> wrote:
> > > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy
> > > > > mount(2)
> > > > > syscall. The generic SYSCALL audit record logs the move_mount sys=
call
> > > > > but does not capture the flags argument, creating an audit gap fo=
r
> > > > > mount relocation operations.
> > > > >
> > > > > Add a MOVE_MOUNT auxiliary record that logs the flags argument pa=
ssed
> > > > > to move_mount(2). Pathnames and file descriptors are captured thr=
ough
> > > > > existing PATH records and SYSCALL record arguments.
> > > > >
> > > > >  ----
> > > > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:4=
1 ...
> > > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > > >  ----
> > > > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=
=3Dfc:00 ...
> > > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > > >
> > > > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > > ---
> > > > >
> > > > >  fs/namespace.c             |  3 +++
> > > > >  include/linux/audit.h      | 10 ++++++++++
> > > > >  include/uapi/linux/audit.h |  1 +
> > > > >  kernel/auditsc.c           | 13 +++++++++++++
> > > > >  4 files changed, 27 insertions(+)
> > >
> > > Thanks for reviewing this patch, Paul!
> > >
> > > > This is because we only log the first four syscall parameters,
> > > > correct?  To put this another way, if we logged all six syscall
> > > > parameters this wouldn't be an issue, yes?
> > >
> > > Yes, that's correct.
> > >
> > > > I'm aware of the argument for only logging the first four parameter=
s,
> > > > but I've always thought it was a rather foolish decision.  Perhaps =
now
> > > > is the time to spend to investigate adding those two missing
> > > > parameters to the SYSCALL record so we don't have to worry about ha=
cky
> > > > workarounds like this (to be clear, I know this hacky workaround is=
n't
> > > > your fault, you are just trying to make the best of a kludgy thing
> > > > <g>).
> > >
> > > I completely agree that's the right thing to do, and I'm happy to hea=
r
> > > that you'd be open to it.
> > >
> > > I did a quick check and there are 100+ syscalls (~18% of the total)
> > > with more than 4 arguments
> > >
> > >  --around 67 of which pass audit-relevant scalars (flags, sizes,
> > >
> > > modes) in the 5th or 6th position
> > > that are currently lost.
> > >
> > > I'll look into it. Please disregard this patch in the meantime.
> >
> > Thanks Ricardo, I think this would be a great improvement!
> >
> > I'm particularly curious to see what old/existing userspace tooling
> > will do if we add the last two syscall arguments immediately after the
> > first four.
>
> It would ignore them. During search, it grabs a0 and a1, then skips to pp=
id.
> In the output phase, it should also ignore them since there's no code to
> interpret them.
>
> > If we have to we can add them to the end, but if it
> > doesn't break anything it would be preferable to add them inline with
> > the other parameters.
>
> I'd also prefer inline. That's the most natural view.
>
> -Steve
>
>

Thanks Paul and Steve, I agree that inline would be better as well.

I spent the afternoon working on this and already have a working
draft. I'll do some extra tests and review it, but I believe I'll be
able to post it over the next few days.

-Ricardo

