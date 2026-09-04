Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52339332EBB;
	Fri,  4 Sep 2026 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513350; cv=none; b=Kv8VEvZmQ0KAQG2/aMBgJyJb9sMQID8Fv1J888CgGm+bE5vtrg1bcWTXLztFg5ZdakVq+FYJBrC5d5ODRKtzXtGczlayhZ9zEbHOFQHCLo/1okl0nekcM3PguoZE30XykBaGGDXPPmCEyNaHZNY3vfeehRNSR0+ZGZQvKlqTDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513350; c=relaxed/simple;
	bh=0Kjz+wSEcdot/Kp+frqf0GhQv33OLZIVvwXtWAhVB5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBwouYxYfoxZ4hnYP7s24ceOxiUHXWgWSVSCn/GJjYmgZPC8qUgP7DbaRQPV/vpS2LXGwU4f+N+SgRSRyit+zTT2wdCo+yg8SwVz4+QL6dEbs+xrkomMohKKdkYqKrQO7w/KVlniIBmoFw1ugOl7IFtg7zMwdv+gDtLmEz+ACjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VufFzf3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VufFzf3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031B41F00A3D;
	Fri,  4 Sep 2026 09:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788513348;
	bh=0Kjz+wSEcdot/Kp+frqf0GhQv33OLZIVvwXtWAhVB5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VufFzf3Cilbm8QtKx3NZr5yYaHyhMTKVokK/7JAundphZYwRJZyAo6texlJnLQJqv
	 0fvCDCCOIVb3jI6uaP0ILqKvLG9T78RTOyIAFsuMHsgnyPijzHoRFRRH6DQ2StiC/3
	 sH7vQ+ZLgzYJDgBDjOKSkfPwiqGFsosDZvbfmwZCP7Si+SvxBLGIojDr0IlwCbKulZ
	 f9zPR8PI9gm1tbspmiVQz4qHraB1WqCV60hXJT0rY4w4G/8lUxsiwseP80Cg38WaQz
	 P/s+D4hWHjAkILDLihL2QiXOz1ytOJPa+YYlmRwU+mUvvetZVXXljSRz0hn9gYQry6
	 sOBg5ihVyDPaA==
Date: Fri, 4 Sep 2026 10:15:37 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tigran Aivazian <aivazian.tigran@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hisam Mehboob <hisamshar@gmail.com>, 
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Howells <dhowells@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Theodore Ts'o <tytso@mit.edu>, Catalin Iacob <iacobcatalin@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew@lunn.ch>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andrei Vagin <avagin@gmail.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Wang Yan <wangyan01@kylinos.cn>, 
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, Malaya Kumar Rout <malayarout91@gmail.com>, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <apqHhmRD5rAeLivO@gremlin>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK+_RL=RHfRLDc=Ldjx1p8KTHSKeELjnBpxEqYjwWX_8ur1hOw@mail.gmail.com>

On Fri, Sep 04, 2026 at 09:51:10AM +0100, Tigran Aivazian wrote:
> Hi Ethan,
>
> On Fri, 4 Sept 2026 at 09:30, Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:
> >
> > BFS (not to be confused with BeFS, the BeOS filesystem) is the
> > filesystem UnixWare uses for its boot partition. It has extremely
> > limited functionality, only supporting contiguous files and no
> > subdirectories. Even though the bfs driver is very small and is
> > unlikely to cause future maintenance problems, given that the only type
> > of data stored on such a partition is likely to be kernels and
> > bootloader settings, there is very little reason anyone would want to
> > access it from Linux. Other old Unix filesystems (efs, freevxfs) have
> > been removed recently, and bfs is highly unlikely to have any users, so
> > remove it as well. Retain the UAPI header to be safe.
> >
>
> You are right that probably no one would want to use BFS for storing
> the actual data today.
> But some things have didactical value, rather than mere pragmatic
> usage. It is the didactic
> value of MINIX (and its limitations wrt making use of the wonderful
> capabilities of i386) that
> has originally triggered the creation of Linux. But back to BFS: it is
> actually used in Steve Pate's
> book "Linux Filesystems" (2024, unfinished yet), which is a sequel to
> his excellent classic
> "UNIX Filesystems" (2003), as an illustration of a particularly simple
> filesystem implementation.

Oh wow! :) Nice to hear a new linux book is coming, as a fellow author [fighting
my way through the editing stage atm :)] that's good to hear.

(I also learned, the hard way, why people don't tend to write kernel books these
days - the modern kernel is too damn big! :)

>
> I remember when Linus accepted my patch with BFS on 28 October 1999
> into 2.3.25 his comment
> was: "this appears to be a particularly simple one".

:)) nice!

We shouldn't be afraid to remove stuff that is less maintained or that
causes maintenance overhead or other headaches (e.g. blocking things from
being developed), as I have often pointed out re: older architectures,
nommu etc.

But I'm not sure if any of that applies here or not, so really one for
VFS maintainers I think.

>
> Kind regards,
> Tigran

--
Cheers, Lorenzo
