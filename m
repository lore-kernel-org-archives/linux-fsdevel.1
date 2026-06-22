Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F30135A53
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148530; cv=pass; b=NsGW/OzRiyj9HtcjvyoVlnWpY1FAj5IamSXrKS69l/eshfMOYZjn/eqhmKsUsz+FgGWev2dWiRhWV/sQzF9ii/bGvzqYo7avtyGUnWoEIFwtJiTtlOx+FS8CJdovswBB8vfPJ4is+w149nXXBsNkFJYvXIK1X9MVv8khciiIs0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148530; c=relaxed/simple;
	bh=jsOJdEA7JTwepZ4HyFdpCTUsNbIqQicD8iian1/afmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbNSbFbASq0BplG86XF4e1EtWBoE6OnlGGnI2BoqLJ0D99oUERmWYBk3g9O0xBMYVQnx9WjTYmfc9JYePrWG6NdXLNMvuHSs3vDfotc9NoR36KOsB3o0blGIV+YQyb/UD/lSm3uYy5MtEDZRepkxAjqfngGreh375Nk06+Fiidc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNe1LjQx; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNe1LjQx"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-48751bd4abeso1692916b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782148528; cv=none;
        d=google.com; s=arc-20240605;
        b=UFcL6t6aU2uNzLITsM3HrDIeFZXvwiiuCHLqmab+hwsaOiDjROqAjG4CCfda2PGeQ8
         Z/bz7Dy6/GV725BZlphG09Wyw0kJyhlH0ajHmCxpK72EGGIs1t+8IvfXNHVbaWOEjsZD
         kh+P5nSpsk25FApP4+/M5u2gw/41ggXW96IqxUIvPa1ThRc1nEm2T1peWGp8q0+Q8CTK
         lbqHKvbRJBxG9SkGyJyXdQFyW0HBp3qgyuHn7wjDB2U5gfilj1H4ausOpIveMX+XfWO4
         H4sMDfpTu78w0xiGqv4OIlMSOaLk/3Czc++ktINj4MgVdeXwcS1CrWJTkgPzFopNNgBv
         cR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5y3USGnElGMdKgxAn2V/X+lCqw7tv4tGIpnPXtqDPM=;
        fh=Vzap5ycBRrc65gFemyw5JuNgr4S2F7ZjhprTrpm7/r8=;
        b=OWG2K7jiSJXVEzWh3V4lpZ7bs5ZvVTNIju4BcwPgVSrax0ul1mcrxkQ5RScHLZC9wy
         vfTL27HoGwyuH2YKoBgUx3uwKjDzT1nyVzrzVb/PY1xAusA60t1VyPHGqAHoCGeI1WeJ
         VIeDYxSzplKZuDM94yCdvVXqoFpY1eNpYs1g8TVHUsQTgjWfTQ825Kow1yRidS2WJBjl
         y3oaf7wSvE9tmovrsx4oo/CJnQ0ANnvcgQ5tYwk75RQ5nc1rp0ZehjSCLhpS4gZWwDx8
         iFjy0wes4o80A8i7JelpCk5Z44H3SEJSiNvp2b7kkBt9qgVv+exWdDMdur96rK/W6REz
         Qzuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782148528; x=1782753328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5y3USGnElGMdKgxAn2V/X+lCqw7tv4tGIpnPXtqDPM=;
        b=qNe1LjQx7nztNMKfVohqoIkxDI6p12YgwuVYGjdwCexhEQq4GRX6509F2WEfeRPh9H
         mUB7gSrrOMSQS9MPfrohD9zV+L+dhrW0nekG9zQtD7QMO3l4rU3fTNg9kWvLMqviH4eG
         sh+CsJkL3v2PNRuqIuy2j9XeDIwLe3145HIqGFgYN8/EiVZiUm2rvO9DRNYvnPkuyDf0
         EeKrpfiQnpz+aKInC6EnCLJTQMt+mLRE7oKv4qGl1i3yik1xVAZU7mVc5IrBIICiiN4T
         +K+wyrJG+ZV/J3z1QC0bWKES3prdh3XI9aNC7zN9MciLQjseP80O+PdqnkNPdiRDxa/O
         cWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148528; x=1782753328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5y3USGnElGMdKgxAn2V/X+lCqw7tv4tGIpnPXtqDPM=;
        b=h70nAmuwyj947PHpBmKEDVtfs9zJLyFoEJUWo0+x28eRA4Jkb3Lykf9iw+8v6qgjwZ
         R6W4Lx4l+KYiTf8cxH8HoG1R8Qg/nn2ovjtCM8o62lMqUp7o5kTH6Brls+PwXVgwRdD1
         p5qVZp0f40mn4KYZRRga0Z6hngDmLG552mieYLG7y/8Mhe1YICA1KuAD27kg3wyR4ENn
         DEmni2YvnpI7xFUYuvRvebUDuiP+YNflg6UC1zg4AaDRRHAMzT8XFraYmV69jjufxUi7
         DF4EPkaoCZIYRsXiKBVXBsNQ1JtJmn3nhwfXMxPRgxRpEx0LAoWk8XRah+W1hB/sMWYM
         wl8w==
X-Forwarded-Encrypted: i=1; AFNElJ+IUrB/hCUPE15g3nV9wKlM2fGzIp4V3B4j5zAdUU+HgV9EEI3/wHNJbxfSOJuQTz4FOOP8MOs9pJvJMC6p@vger.kernel.org
X-Gm-Message-State: AOJu0YwPS0F5u9HSgvGRqtlYs0rthLJTuSgBNxBoHyAeImbD86qWlDy7
	+ETYjf54AHOy/hpA5veMdaRNsLuzQ/VkJ6+59ZV6nucZcCgcoOQ0Ql0we9EDu4RheYhKtHPXj8u
	6bhuys8hVHAUaNZjtjcnKGkz8s5+li80=
X-Gm-Gg: AfdE7cnFGsDr2j5IvmLpO+V3dn5UlFd66Oq1ODyh1/bR8HK41/VII06xl3PTnh40Orx
	wmdEYqAYG5A1iQ1Ixen4zfpIZsWA36PqvepQ+QBKlpXt/qyg8/gDBJ0xMMiIlEW0BF2doYtO8yy
	FfiZNJH1YO5HUqtI89q2NHhLNSn64sam81xB4iVDfInRrU6cARtuF1rzBH7tahihwdCWiYsa0bx
	OfWXIUAKwR7zxvshrOV2BRx0W0px5eaf2dt+qL+bV/Zb5zKsvTIY9xWY+DxiMIBLgAc27HCk0VM
	7kzJVwAuKIgAb+G0PPaXfjPEvvyC
X-Received: by 2002:a05:6808:3442:b0:48a:c065:6fc9 with SMTP id
 5614622812f47-48ac06594fbmr9330170b6e.40.1782148528126; Mon, 22 Jun 2026
 10:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com> <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
In-Reply-To: <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Mon, 22 Jun 2026 10:15:16 -0700
X-Gm-Features: AVVi8Cc5PMYcnmdUaPpm4OauvSyD0_Ly6wyUiTL5YPonWZg26gteXmXywIU7NwI
Message-ID: <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
To: Jan Kara <jack@suse.cz>
Cc: kees@kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	shuah@kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 3:40=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 21-06-26 21:39:32, Farid Zakaria wrote:
> > Currently, standard ELF and ELF FDPIC loaders require a fixed, absolute
> > path to the dynamic linker/interpreter (specified via PT_INTERP). This
> > creates significant inflexibility for relocatable dynamic interpreters,
> > where binaries are packaged independent of global system paths.
> >
> > The primary goal of this patch series is to support relocatable binarie=
s
> > in Nix, where packages are stored in a read-only store (typically /nix/=
store).
> > Allowing the ELF interpreter path to be resolved dynamically relative t=
o
> > the binary's location via $ORIGIN enables Nix packages to be relocated
> > without needing patchelf or wrapper scripts.
> >
> > For details on the design and motivation for this in Nix, see:
> > https://fzakaria.com/2026/06/21/nix-needs-relocatable-binaries
> >
> > This series introduces support for resolving the $ORIGIN placeholder in
> > the ELF interpreter path, bringing the kernel's binary loading behavior
> > in line with user-space dynamic linker origin resolution.
>
> Thanks for the patches! Before dwelving into implementation details we
> need to discuss whether something like this even belongs to the kernel.
> Frankly to me this looks rather arbitrary and tied to the particular way
> you've decided to setup your package management system. In particular the
> usual answer for situations like these is to use namespaces which you
> discount in your blog with: "If you are using tools like Bazel or Buck2
> they likely already employ their own sandboxing via namespacing for build=
s.
> Integrating Nix into these ecosystems becomes incredibly impractical
> because we run into nested user namespace and mount restrictions."
>
> I don't know enough details to really judge but it seems to me like you a=
re
> trying to workaround a mess in userspace with kernel changes.
>
> Anyway I'm pretty sure Christian will have more educated answer than me b=
ut
> I just wanted to express my skepticism about this approach and that perha=
ps
> you wait for feedback from him before spending more time on these patches=
.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thank you for taking the time to look at my patch.
I'm new to contributing to Linux mailing list so receiving feedback
and responses is welcoming :)

Having put forward the patch, I'm clearly biased toward thinking this
support should exist in the kernel.
If I had to think to strengthen my argument would be that the kernel
should not be imposing how the interpreter is found on userland.
Finding the interpreter relative to the binary would be useful for
package deployment scenarios similar to app-bundles beyond systems
like Nix -- which is the originating reason why $ORIGIN exists in the
dynamic linker.

To me, the gap is that prior to systems like Nix, the idea of wanting
your dynamic linker to be part of your app bundle was not necessary
but Nix models the dependency chain down to the loader. Such
functionality would be even more correct for these other bundled
solutions as well, making them portable across userspace glibc
versions for instance.

I see Jori Koolstra mentioned that Sashiko found feedback on the
implementation.
Is it worthwhile to amend the patch now or should I wait to hear back
on whether such a contribution would be accepted?

Jori:
I'm not 100% clear on your question but the LLM assisted with some
code generation and brainstorming.
