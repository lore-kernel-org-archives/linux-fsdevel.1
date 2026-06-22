Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047593546CF;
	Mon, 22 Jun 2026 21:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782162559; cv=none; b=oTcy0dMtOWs2iwaQjF/dQWkixs7F6LprM/IFMYSlK9GDVwvYXCdPTOYevo4+HsZDn5O5Re923MnQzxbj3DHhnTMhadsL8QheOtEQGF2G5dLhQM1lmZxKg20FXLyNZIM7jYm+7UuPELZPyUGdfX/qEB+m1NiWmrxXvd5Tum/GzEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782162559; c=relaxed/simple;
	bh=vnvGl0rxCI7iftJLJm8pM9IaRAPGP3yEZnDEqnh8u9U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=daureH64uVrgpJgAEcLUEhVRx4dF1eKK3z97D5b4vQGhh4UUqAIWJZBt7V7/vCqouSnOMmh8kufn9VMjnRMChXra0GeDunQQAvcjUcsXXiUmqtRao02Hytti5Fo14sW8ePC4XeLPIdC7VmGLdV3FlpX9FL7R03GtFuqR+igV/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=JjDXNvTL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLlfasY5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="JjDXNvTL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLlfasY5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id DF7A01D000BD;
	Mon, 22 Jun 2026 17:09:16 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 17:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782162556; x=1782248956; bh=jFF/WpwMh/jCc3BLFtGeQFz4k3VdPzDt
	JzJgsPoc2ts=; b=JjDXNvTLRkJP8G4o3k6kxSzI5fI7C80VTDYCmwZVyITaGw2p
	MlP/OFM08F+mlL6r+coXorXYJdMmELrehBOFmmvIgU5iXipmG1ME/5xJeVr4WiJi
	uRcZPB/XzuO/iWuurWYq1BtElt0usel2oHHxb2Ayw02bxWEuSWb8Y0XHGn58iflt
	T2Joy1j3xiLaheY+E4ViLcQLI7Pfnvn3LtLievLNtPSyWlPpa5U3nM01ZjimkF5k
	phrcElQkYRLTmQt+GLKbmkIZRsnE7+bkTsFKy295b6sCh+UaRgCfXA20MREl4GO8
	sGBYABQ+NoSW5iBNevazW4nOYwX0ZYBTyLuniA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782162556; x=
	1782248956; bh=jFF/WpwMh/jCc3BLFtGeQFz4k3VdPzDtJzJgsPoc2ts=; b=W
	LlfasY5e7w+oscXqcB6O27BTOkksrfqZa8OlZ/d2arPYtuFS0MjJlTct5wzdwIP3
	cjENgsOkP3nAGQCGdOcdy2lNrAm11K5g9N8kRa7tKkHQz0JXixGmSWwJvEiOudh6
	h71NUBPrbvWjdj/IRebQzxRjb4ApDbfW6c5R5XMYnCITj/fW/VMmEcciq9YqqzP+
	DEQR6manN8pmfAdORjT7gLkWox3o7idAsn/llhqjHWswvWzJ/Ea/PI61EzpqeAOq
	vV8SqW2duCvWvr2Hlpyxyl83ep2MP6PgbDNKGEG1sf76EPvAjW1jRZVXuVtYXRzj
	odztZik2ezkgpPxlD8lOw==
X-ME-Sender: <xms:fKQ5al6OBAcIKa_8caFGgVAAPJJg0I2Bcjr8Zog7FOfJWUn2aboe3Q>
    <xme:fKQ5atvlD7PRXEcBcG30SWUZpepuy5MJAdFosUmjew5JibSC7hQdoncv7kX5Kmre7
    RIk0JfBG0LVNEjV93Dept7zBBJbennRnBZvoUWp7jprKX_fgiR-pX0>
X-ME-Proxy-Cause: dmFkZTE85SJkWCmf2DIiBDqyTS4Lx7ehehEXg9gN/dFnuHNNyltCkyeNImba15iNnqYRcD
    usVsuOhsm0DKJ4FgEZ33iHQitzrQDLVPbCHJa8XHAFeTpJeni0d7Qd+nfvePxkda54MRvA
    eRvTPogsdOaimkzw/J7KJ+qn92CcGFzoAOnfXRxDbA3Z5LQ/TVtSuq7OW+xrvBISc2lflC
    +hcram3W8y5GO32+l74XClWEinJ4kthd1I9l8bo3qnLJKD50e9MmIfPRCNFca4/LfyM9q8
    IzHmDHVWuHEEQY+CoqTJf2mhPExROeZ0h4bdHYcT61zf458kRCi/VIndwhRdWi08drdeUZ
    vqOWB6h6eYFW+39vy2hDBuLfjoCIRsFgfg5XEgSOFbTMypSE1YmeRYch0pknsf0AaxGuOF
    fzpweTTMhDo00Tt9dvONEPOccrorgjAJTZkZGHKeMys3zMGwR/up56Sbr1sUwu5rEhdFP8
    KGf7D6/Sw53wgAEYpbVHmci6z4asoKewTVumy+Q8YZT8jXyJqVExvg/226buNRtK99ZUUG
    MpS4p6pvP3RE8TX+IzRnshupAjf9T1BpCJjsZyB9Y1pr4KbhXTdCXYrf4hCwDkCN+PHZe5
    Aj8QFTFuXwfNrTz/UGnCVbjOD8epeFmXjHCYJSBFvYBhRhxIJ8/jBRUOD4Uw
X-ME-Proxy: <xmx:fKQ5avfGmpKLPK1pQtHkbMGK9G56tzvFyruhiymL2zmR_DyAkR8-XA>
    <xmx:fKQ5ahF0QQ8q6d5KgDYz8zM3IU2QMGGfarTEiw1fk9CmB1_wCGdV1g>
    <xmx:fKQ5aljMnNoqTdKwZx0nwmUOlqG_VAaYmWAuyQQWvO2jVvNIDY0jIA>
    <xmx:fKQ5al18q2I234xnKPB64pMI5lUioDlNJNQT9fQubXnzCIP47Il3dQ>
    <xmx:fKQ5al8QtQg2La8O0VrMSfKgeZjVi8h8SWzOBORZSXV25DaMAkgM5tlL>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EA6062CC0083; Mon, 22 Jun 2026 17:09:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1dANeNfTnWJ
Date: Mon, 22 Jun 2026 17:08:55 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Farid Zakaria" <farid.m.zakaria@gmail.com>, "Jan Kara" <jack@suse.cz>
Cc: "Kees Cook" <kees@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, shuah@kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
In-Reply-To: 
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi, I am another Nix developer, and have participated in some LKML
discussions in the (recent and distant) past, and thought I should weigh
in here too.

On Mon, Jun 22, 2026, at 1:15 PM, Farid Zakaria wrote:
> On Mon, Jun 22, 2026 at 3:40=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > Thanks for the patches! Before dwelving into implementation details =
we
> > need to discuss whether something like this even belongs to the kern=
el.
> > Frankly to me this looks rather arbitrary and tied to the particular=
 way
> > you've decided to setup your package management system.
> >
> > I don't know enough details to really judge but it seems to me like =
you are
> > trying to workaround a mess in userspace with kernel changes.
>
> Having put forward the patch, I'm clearly biased toward thinking this
> support should exist in the kernel.
> If I had to think to strengthen my argument would be that the kernel
> should not be imposing how the interpreter is found on userland.
> Finding the interpreter relative to the binary would be useful for
> package deployment scenarios similar to app-bundles beyond systems
> like Nix -- which is the originating reason why $ORIGIN exists in the
> dynamic linker.

Yes, the idea of making "relocatable software" is not a new one, and
indeed it is why `$ORIGIN` is supported in the RPATH etc. in the first
place.

Most of the programming model for writing relocatable software is fixed
at this point. For example, /proc/self/exe made it much easier to look
up arbitrary stuff relevant to the current executable. It is just some
initial entry point stuff (the ELF interpreter, and shebangs) which is a
glaring exception. Those should support `$ORIGIN` too. There is no good
technical justification (that I can think of) for some but not all of
these supporting `$ORIGIN` --- either it makes sense everywhere, or it
makes sense nowhere.

(I suspect the only reason it didn't happen was pure inertia/Conway's
law --- easier for whoever was excited about `$ORIGIN` to change the
glibc loader than the kernel.)

> To me, the gap is that prior to systems like Nix, the idea of wanting
> your dynamic linker to be part of your app bundle was not necessary
> but Nix models the dependency chain down to the loader. Such
> functionality would be even more correct for these other bundled
> solutions as well, making them portable across userspace glibc
> versions for instance.

Yes, exactly. Traditionally people thought "eh `/lib/ld-linux.so.*`
doesn't change too much", and decided relocatable software that
nonetheless hard-coded that absolute path to an unknown system-provided
ELF interpreter was good enough. (Or if they weren't good enough, they
went with static linking, but that imposes other costs.)

Now there do exist purely-user-space work-arounds, like
https://github.com/Mic92/wrap-buddy, but they are quite complex, and
involve various patching trickery that is likely to scare a lot of
security analysis tools. A kernel-based solution that allows clean
declarative expression of intent with `$ORIGIN` is much more elegant.

> > In particular the
> > usual answer for situations like these is to use namespaces which you
> > discount in your blog with: "If you are using tools like Bazel or Bu=
ck2
> > they likely already employ their own sandboxing via namespacing for =
builds.
> > Integrating Nix into these ecosystems becomes incredibly impractical
> > because we run into nested user namespace and mount restrictions."

I think it is good to see what Conda does as documented in
<https://docs.conda.io/projects/conda-build/en/stable/resources/make-rel=
ocatable.html>
and consider why relying on namespaces vs good old-fashioned relocatable
isn't good enough for them either.

(I don't doubt that Conda would find this approach more robust than
their sedding tricks, and prefer to use it where possible.)

The short answer is while all of us in the build system space love
sandboxing during the build, we don't want that to lead to *requiring*
run time sandboxing of the built artifacts. For example, we can
certainly arrange sandboxing so `/lib/ld-linux.so.*` is the one that
some executable expects now, but every time that executable is run, it
*must* be run in a root filesystem where `/lib/ld-linux.so.*` is the
loader it expects.

If you have multiple programs that (for whatever reasons) expect
multiple different loaders, all spawning one another, it would
potentially incur quite the development cost to ensure that they all do
the proper unsharing to make everything work.

Relocatability recognizes that whether or not namespaces exist, in an
"open world" scenario where we don't know how the software we are
writing will be combined with other software for deployment downstream
in different ways, it is easiest to adopt an idiom where different
things can be placed at different absolute paths, at the user's
discretion, and so conflicts are always avoidable.

> > Anyway I'm pretty sure Christian will have more educated answer than=
 me but
> > I just wanted to express my skepticism about this approach and that =
perhaps
> > you wait for feedback from him before spending more time on these pa=
tches.
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR

Waiting makes sense, I am curious too what he will have to say.
