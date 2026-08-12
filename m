Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DE2EEE80
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550612; cv=pass; b=TrzVBgyn/NoELy5OS7IjPnhUi8s6ZOMzZm5FgvSF8GxcF/PMZ/YlpH9SpHzf2Jcc5qh4uwT9gEgYibPsEN2/kqhKALzyDKydhElvs1DZyrDIZLq6UMo7HL1ewYpUF1NvBF6mqUlxm2KLwPH5LQJrFd9gFj2OA5uXCEBuyKD1rjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550612; c=relaxed/simple;
	bh=wNpezxtdDBl5EMOT+ytifcvWFeQIqun78MxlgqImMO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVAx6PwzdQ+38rDKIJmC0wdKUtzkH6V4jVqM87K23SZheVGjRBDllF2yBoxztAgK9k2xRRft6Qwn41y67P4zoQhhkzgnKQQe6ww1glZokH2y/QujRd3IuFgf3UDp99aeaakp6wAvJ1RqWuTwPIoTFf8WXiHDiLNvuJ/DNq2Tja4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K12oepm8; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K12oepm8"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2caced6038eso485905ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 09:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786550610; cv=none;
        d=google.com; s=arc-20260327;
        b=CAWZrTTZZ0d5Qxof1RIbWKp4wZ2bikYvGqm5KSp0AyJg05TNN6fPQPZ7lVkIInO9eJ
         1Q4E/Yn10q2XK6omWzkKDBQVDpiE/Gt/+mx9Jxnf+Omixy4Htw+tUAW54tkMzXLbhmuz
         OoFzF7azJejhuDxVbmS+VV+x1WZ3EBviBGpCBwmcpRkLDc9kscpF5DEcCV4fHfo5UdsH
         Kp7zaDm0kXHD3MTDzCxUYlgCmyHJSYcr/8/MqcK+liza25ZDE7S3ttRD8M4+pTzM9akZ
         baZmvlvS4KqmVf3xGT28psX/cmlakUlOMAYJugQlNgTiiaw1z7DasuAV3mW/qKveQUb4
         eooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        fh=k8YyWih7orQBH6U9DSbCQAmJehhnx7u/O/VNS/4VCms=;
        b=QkufYX79Tvi5maQ19H1SlZR4+r8IPjR0L6YoFkiBtFLGdTGxNfxFBc2i4J2oLwTE+G
         +xzuNhnUhdIfi/wZiO8cYTsewnuc9DTWs+CBus9KYLAMKeKZBQ3ECPv6nba2QIi87JAz
         9xcvKZYGA1xt9pBD7QhL7tsx6maXoedLxNtfSnNFzp/buSnQ0Fav+3cOnh5FtsBctMG7
         DUegUkqlhtctg/U/axVMwk2u2Mu0/8lhlLnpkppT7c3q57BdukoHJ7BOSI+id23xIxzf
         r2bX0yn2JHxmx6rAJ33AorDjnsoYvx9/hyzlVUv5s+nlmLUzgkohXb/7j3N4/qmyls8N
         1Uag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786550610; x=1787155410; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        b=K12oepm8Hso5ErMCFq/oeFTzdsTsVb+37LNWXMERSbHlBeF3ew9I+1g6frtzhsRf+G
         /t52VVGW1i7/yqhzGYg5xQ8hOAxkKVQPglIhP1yvq1TESe1GZ8x5yBdgWJdDIhGSfvwg
         qKHdMp8OVZS7lPNrQCqNih2NeQwaXoiwxZKJwbjrYqaKO115Hi2RV7sDOCzPWifYQAM/
         stsRuVfOVoZmsKOQyPvE8eMG+mPMfdmcEpxG4WidNZwXPSxGYuE5VnZMpm3ztw5oVomu
         25nM/Zfw6gTEszl2zrULR+NV//TY2LGEEtNl5fCKu7N/z7pzqOwB80HVr2TK357GOucJ
         tKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550610; x=1787155410;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKmWzRJvOljwfQaEZUc8zLqQUxlcljt9EthQ50hPWFA=;
        b=A7/goCdpA5dyqFCidnmmXnIahyCxy7SkafYi1186Q0RmvZdmjVkXRt5MaDZ2RgY8/t
         n9Ctg6K/833kvfe/t7g0arINkASHGcuX7I3IAFHqT6PqThkBdS4v1Dx3/vyPcYM7lewj
         8Fj8/RTdRN7dxoaVNYOQJer7EG5xXXC1tAgVGWefclRRui1j3cttHzOjMI7J49wTKRGc
         QQ0RQgNhfkOzSJ8dAobnWyVH45zNOylGNy9xDDlx/7/hC/tvUrr/ASz7nOWIZ9GnCxwh
         x4BsG8Pj8HCfvwByw+TquT0u+hg/dfO0P7t/xLSGutdEQsAj3tTFbRfOeDwd/NDsPK0l
         XGEw==
X-Forwarded-Encrypted: i=1; AHgh+RpGZE6If7wnAm0/Lggo4Ujl5jIzTQU30TkG9LgqJaFNxB/5hdbbMhwqsM0kGxc5DKt376Dfr6iYjNLB6C/P@vger.kernel.org
X-Gm-Message-State: AOJu0YyRp9S3oHd7+igVd3F9+qnGOfFaRyVGhYtFUZKLzYiMNxGf5rFF
	EeShgwTrvfuBTYgFXa6f07WFqKGH2Ut+G8GtDo0Lo/VQ3stFSZO9G/Xa4qkskFnYpfNwysuoefa
	468AHqKNslw21B7Exa8fKma/UNsT/KiyS5P/4ltaf
X-Gm-Gg: AR+sD12Ayg7e17mbNJBBxy0DdAoceZhbQnNIHxrAO7jSnjjdVyBcPbrsGlVphjIm9NI
	jemYie75YASBc0COEXV8RVBfTkyS4nyNzly5WV8uX0kcv61BcFYBI9zclFHGBPlzMC3QRopB+/8
	W7V0LcZ4NFjpOX+y+Wn1vLtRQ4whyJHZodDZHbYDTn05fDlDckpec/Biu/3n/HEA5GA5XvBDYTm
	Ymgcse8u3a/3on/vobXbMCpWW7kra1qr/HoQ5qIars7KR9riUfoey6luZRHPIic+g0qdNuQWmFl
	CbVzcV7IyB+T3//ZjviQs6sZgD6ADJbHzbDrE2YlPron8g==
X-Received: by 2002:a17:903:1d2:b0:2cf:b9f9:18bb with SMTP id
 d9443c01a7336-2d371d22985mr1478265ad.4.1786550609193; Wed, 12 Aug 2026
 09:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170035.4073532-1-rrobaina@redhat.com> <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
In-Reply-To: <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 12 Aug 2026 12:03:17 -0400
X-Gm-Features: AUfX_mwiwqszCAmetnigrG5TMa1Btha161pB3d_JtGdcMZO3xyeWXyv7fX211o4
Message-ID: <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com>
Subject: Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 10:40=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > >
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2=
)
> > > syscall. The generic SYSCALL audit record logs the move_mount syscall
> > > but does not capture the flags argument, creating an audit gap for
> > > mount relocation operations.
> > >
> > > Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> > > to move_mount(2). Pathnames and file descriptors are captured through
> > > existing PATH records and SYSCALL record arguments.
> > >
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ..=
.
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Df=
c:00 ...
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >
> > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > >  fs/namespace.c             |  3 +++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 13 +++++++++++++
> > >  4 files changed, 27 insertions(+)
> >
>
> Thanks for reviewing this patch, Paul!
>
> > This is because we only log the first four syscall parameters,
> > correct?  To put this another way, if we logged all six syscall
> > parameters this wouldn't be an issue, yes?
>
> Yes, that's correct.
>
> > I'm aware of the argument for only logging the first four parameters,
> > but I've always thought it was a rather foolish decision.  Perhaps now
> > is the time to spend to investigate adding those two missing
> > parameters to the SYSCALL record so we don't have to worry about hacky
> > workarounds like this (to be clear, I know this hacky workaround isn't
> > your fault, you are just trying to make the best of a kludgy thing
> > <g>).
>
> I completely agree that's the right thing to do, and I'm happy to hear
> that you'd be open to it.
>
> I did a quick check and there are 100+ syscalls (~18% of the total)
> with more than 4 arguments
>  --around 67 of which pass audit-relevant scalars (flags, sizes,
> modes) in the 5th or 6th position
> that are currently lost.
>
> I'll look into it. Please disregard this patch in the meantime.

Thanks Ricardo, I think this would be a great improvement!

I'm particularly curious to see what old/existing userspace tooling
will do if we add the last two syscall arguments immediately after the
first four.  If we have to we can add them to the end, but if it
doesn't break anything it would be preferable to add them inline with
the other parameters.

--=20
paul-moore.com
