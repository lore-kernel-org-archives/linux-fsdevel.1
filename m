Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C43D9DA1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080944; cv=pass; b=AXG1mbkJaTFgd3Lkfo1fmrXutaWZvxyEOFm72AXN8mVU4xycx5eoCkzBaSy9MzYhAOM49T35j9UYf6sjZ8buLNNqYADxLEEHQqbR2ZzcdCH8iblTHclNsUiNnIyYxEnN5MHaOgferTGxM+VGYo7NqYlK+X8QKIXaCYB1Mw11Z+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080944; c=relaxed/simple;
	bh=glXQUa+Y/DatHXeZD7fW80kJFjCOEtx1CgYnVJJw6Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vlmzs/nLn9fWeE4zB5G9jClmHv89mSKYWHY6yUHw32fYl+raaFOlJnBfxeQgbGYnIylUMwQa0AVeDJjkQPzuENVK+k2rKQp+rDfMRnvm+B4AWuXrfmx+LChrnVB82hV/ak2fMt0n6nCKYtd2qLZYRPk+1wVmb/QDWjgnYoqnSV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OBhH4KeK; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OBhH4KeK"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51778069c31so51366281cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 01:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781080941; cv=none;
        d=google.com; s=arc-20240605;
        b=KYW9uoXmz8bKGazViRkTA145wjcr7k68U408pP2r2CTiW1HRMp8NFidT3SkKONhgFl
         Qzvgg8wPjF+8wS/9dz3Ae4b5cyLPP5yo+FWlbn3b/4Sn8EJ9NK0o4i30f6zCVf4E1Ayp
         ox+HhAIh7pzF8mw5XJf5a08ya7MbYqFLK+JPWpVsrKdqac64ZQl1JRJF+3eVxuMSfNRR
         XdniCMvVt2wxbu/T345AvSAWV2GMQfHVuXxa0HCrQS3J6rwxv//mx6LSbySoF4SpO3oi
         uFs+UNO1oGrpZSXonVaIP4erbTnnkJtEabM/w1iFCffiQwiH6fTPvbx7S0x+daQRO9Kj
         iysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ED/QJ6ABfSnyR/f8TkNH5YZmLu7z8QYXHSgbyRBn6rA=;
        fh=UH+xgvhoFhANuEzjmYm6a3eEygGLgpOb2Q5rPzAfBw8=;
        b=Mkax24psQqymW5dchb5GQyrLTkQs5IFpEEBH/LFoaknUagTOIz8/YNkpOa7ZJ4m1EB
         aKPMNP5X7tISw+T1U3z4rlBBaHANkStaQeFGH+C+z0qC4VDoOSBft6+tqkKfb5Ct2FGQ
         fpyTDbeRCHZ1tbZyrZaJvRfQX7QUixu/xamkGmknIgh+L41YTiy7VBr4nOQipBOuoNvB
         Fj9tP9WjuC7GmuHR0WLAsBrhwBERDH0XEAv4CFbqm2zsC3AkX9M5hyASHnnUnkDp/k9I
         d0S5diHl1HlV0AC1OJzNZXpuTj2Xm6iQqUgaK4gtln7DXtzCi7QYqMK3PLleept//KVg
         U2TA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781080941; x=1781685741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED/QJ6ABfSnyR/f8TkNH5YZmLu7z8QYXHSgbyRBn6rA=;
        b=OBhH4KeKMsTZcRsFmvGRUaMeTZTzqnbcD4zejrnQvpON47YfcJmLpOpiUIwLLg2e5e
         AdWUOqGv26Ib4AdDzFCIPzBlOYKRzE+1Jx6Iy6NQ9cOhHwmydSeRP4YjRm+ynRYxeaUP
         Se9huYq/g9gQcJe5BtsgIob3GCwJ/WIJaKQ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080941; x=1781685741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ED/QJ6ABfSnyR/f8TkNH5YZmLu7z8QYXHSgbyRBn6rA=;
        b=mcUSgjIA8tq94s/HyIb4369JHuwhUBHWPvQjUpv/zUfQznbOSSjbxezd7D4ETRiFJ/
         +cyVjrW8IjvUrNLAJDdhtRF8MqNQ0JJOLZMM4X4b7qhLDbE4hdFqUMtClmoFeHaEicK/
         qIIDoBEcX0qQmtXxRyekH+rsu+/8t2O6sjpi7TFugQo6Kb42cefSFPssd/unCfu9F0l3
         npIUxClmuPFngwbDLQMeGZI6afEkLd4PEsHI95em/NoW/f3SgLOSBiJwVq1TXw/wLMkN
         PF39tE7nPj8yHCGLH+UnH3k0+2eMUWcNJ6NMcIQACo7dYILM2U4PG/vwwUJk3Bc7q9b+
         0Cjg==
X-Forwarded-Encrypted: i=1; AFNElJ+G+DdpzgqA0BpXxOB2WbI91Pec9zlPez1uX7bb3kitOwSJmcd81oIAaLp9YP5IMpurOynN8KVYVx/bMYAw@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlfk/J3ZFzFnnYaTsJ1ixxjj8z16hHsEZkXIU8/xsxwYadZ+4
	WNFoHcFydiV0DlaLj4J4/03+n9BgDCsd+2fOJgp3HhVwVSuWul/7JXZ6E51R0pTFJvbPzVDw8Qn
	Ui/22OMrYPqIsU0iao6HVsfHdPwU5KA1SnGhYQr5xHA==
X-Gm-Gg: Acq92OGDTJAOEth6rLlI/832Nb0yhTKBCzv5Px77IBMJC3ycpM0x0efd7Tew6B6rPxm
	7FdCbv84j3epVVUCCYubuZyWl5TPWDO7mp3d/pgDFZgHvjdKdzHRj9ZxlNMuvL68buNp6EGX72U
	QNhmK1V6zxcalqLMfOp3jk/TVyHpDWuO4k8BOnk+2C7JIORXRfP2m9db3uocqHaamVMeQbFKWaB
	v9A/YGyCvatKSbpCK6FmvB74yf44xEc44DOedq99CPTw0sCsbFCuKlnuHc8G9uJoC3eIAJ0GPc1
	qfFTB6tOBpPdxOKIpsvA0uw/qfDIb+GcZiyNUSprS7bLJY0PAfk=
X-Received: by 2002:a05:622a:598e:b0:517:29b1:5433 with SMTP id
 d75a77b69052e-51795a48088mr322115091cf.24.1781080940521; Wed, 10 Jun 2026
 01:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
 <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
 <CAOQ4uxjJ0eF0vE0hgsNoWqqD+UQ4r-1-b7493cYNPUGSUR+tcA@mail.gmail.com> <20260606045414.GK6095@frogsfrogsfrogs>
In-Reply-To: <20260606045414.GK6095@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 10 Jun 2026 10:42:09 +0200
X-Gm-Features: AVVi8CfbqDw7vdXcHIb2UID4p1vvU8AlAuzASaoRQ-cjkWHX9R7KMBWVkvcWtWw
Message-ID: <CAJfpegv9SeV4xciMyfDBZ=9CTAk2_=erhBvZs6CMk5MZZZfA8g@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jun 2026 at 06:54, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, May 22, 2026 at 12:03:38PM +0200, Amir Goldstein wrote:
> > On Wed, May 20, 2026 at 12:29=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > In preparation for iomap, move the passthrough-specific validation co=
de
> > > back to passthrough.c and create a new Kconfig item for conditional
> > > compilation of backing.c.  In the next patch, iomap will share the
> > > backing structures.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > Please add
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > and please keep in it future postings even with minor changes.
> > I realize that fuse_backing_id_remove() was changed in this version,
> > so that's fine, but I only know that because recent revision still fits=
 in
> > my ever shrinking context window..
> >
> > We discussed the fact that no one has lots of spare time for review
> > and re-review is a big production killer (in general).
> >
> > You must know that very well as a review and also that having
> > a "what has changed since last patch rev" is very useful for reviewers
> > and also very expensive for authors to maintain...
> > ...unless AI agents can help to generate per patch Changes
> > for the post --- notes?
> >
> > I assume that Agent can do that on a patch set after it was created
> > just by giving it two sets of patches?
> > For the very least, producing a "No changes since v.." should be easy
> > and useful.
> > Letting Agent go over mailbox and verifying that all RVBs have been
> > applied is also trivial.
> > I realize that patchworks and b4 review can help with these tasks
> > but they are more tuned for maintainers and less for authors
> > (I think).
> >
> > Obviously, I could do that with an agent on my side, but that is not
> > a good use of resources and not a good model to put this burden
> > on all the reviewers.
> >
> > Worth a try IMO.
>
> How about a range diff? e.g.
>
> https://lore.kernel.org/linux-fsdevel/177758364789.1315233.15610945404741=
826500.stg-ugh@frogsfrogsfrogs/
>
> I think I'd rather spit those out than either (a) try to remember all
> the changes (esp. minor ones) that I slipped in between two patchbombs,
> or (b) go all agenthappy.

I'am open to anything, but the patchbomb thing isn't helping, that I can se=
e.

For trying out a prototype posting git url's is perfectly fine.   For
review we need to go with single patchsets that are manageable size.

Some general suggestions towards this goal:

 - leave out anything that's not strictly needed (e.g. tracing).
 - add only minimal functionality to be able make it do something
useful (e.g. read-only, DIO-only, etc)
 - add to the uAPI only parts that are actually used, leaving reserved
space in structs is okay

I can understand that the additional work  seems unnecessary and
overwhelming, but I don't see any other way of sanely integrating
something of this magnitude.

Thanks,
Miklos
