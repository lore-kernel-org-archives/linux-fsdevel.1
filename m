Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB83B52EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464731; cv=none; b=ESSnbfI/gTS4AVOs+LNxO837imfHtdVCkqby2lzc2FskxFUoyUAyA/oRqVjsvfQaEBPRiStYAaqd3MqJrnRQd5W7AnpYHtr3ThXBAn0N83OIXc1eoApgubogmOOS+qvKKmJMJxAI3Fmol2KZjtGVf743IqK8C4TjQ9NTqkRh2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464731; c=relaxed/simple;
	bh=WriJxDbk2IysumKzSzDVxQ2mc9bJz5djrs+IHj1nPv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gglQlLRQWaJk541q6K3VO71GKOY1C/J/9e7c5dGTOBPpk8nJ315owkCuYy5NA9f1+AP5U2SOy/uK03JJzc8wiWirCIPP0T67hntzrqCuwYfAzMwAJYYpexP43MruVjRe9RTfoRffrgx0Rr14gMmkZXqBMS1WxeH3Dan72w8ERFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9DrDGuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9DrDGuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2521F000E9;
	Tue, 11 Aug 2026 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786464730;
	bh=HSnn0MPq99CU28zO6gTTV6eheUqywHGvJpVNl3p+JTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M9DrDGuctQ3D4NFi1sRnvhYyHUuTquH8FssbntfsOz39lghpKYh7FYhIaMrtGrmwV
	 Zr4IGlf6rkAopoSS7A39kWT+VW2koRi6zdM9Bjv/JYQLyIjpimuNoZQ8PBeNFFo6P9
	 ZLeOfGUVv0nyzf8BYRmgrEhZx1JProqnsI5HrfOj4ihEquUmzeDsLSg+upLjPtBkcn
	 faQRbzEEvcSR88UnmlUb/JGjA6Bahy+Ag3C8v10Zuo/CTNlGNI0Ab8Jzemo343bGL6
	 F7X8SbET+YyvyrqfoSxzmiAQElKpCUgbSy1N9XSoR60mTSq3RlIRmb/ZIssFg3i6hX
	 JchMW4c9RZTzg==
Date: Tue, 11 Aug 2026 17:12:05 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: vova tokarev <vladimirelitokarev@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, akpm@linux-foundation.org, 
	security@kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <antHw-EHZL1erVTH@gremlin>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
 <anlOGOmO1HWVCMdF@casper.infradead.org>
 <20260811-knieprobleme-holten-palmen-4d42742b1962@brauner>
 <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>

On Tue, Aug 11, 2026 at 02:16:31PM +0300, vova tokarev wrote:
> Matthew, Christian, Pedro,
>
> Lol - fair point, I'll keep the reggaeton references out of future
> commit messages.
>
> Agreed on severity - but this is a
> killpriv invariant violation, and the kernel has treated those as
> security fixes worth backporting before.
>
> 1. The fallocate killpriv fixes (XFS fbe7e5200365, ext4, f2fs) are
>    exact precedent: same reasoning ("can change the file contents [...]
>    should drop file privileges like suid just like we do for a regular
>    write()"), same one-line fix, and they went through the security fix
>    process with CVE assignment and stable backports.
>
> 2. CVE-2023-0386 (overlayfs SUID preservation) -- same bug class,
>    CVSS 7.8, CISA KEV.
>
> 3. If permissions alone protected SUID, write() wouldn't strip it.
>    killpriv exists for POSIX ACLs granting write to non-owners,
>    group-writable SUID, container shared mounts, and chaining with
>    other write-access bugs.
>
> 4. This path is reachable unprivileged even with
>    vm.unprivileged_userfaultfd=0 (UFFD_USER_MODE_ONLY bypasses it).
>
> 5. Pedro's point that MAP_SHARED faults also skip killpriv isn't a
>    counterargument -- it's another instance of the same class. We can
>    fix them independently.
>
> Given that the fallocate killpriv fixes went through the security fix
> process (CVE + stable backport), should this follow the same path?
> Happy to send the patch either way.
>
> Thanks,
> Vladimir

Please don't send what sounds exactly like an undisclosed AI-generated
'summary' type email.

https://docs.kernel.org/process/coding-assistants.html
https://docs.kernel.org/process/generated-content.html

I really wonder if this summary email trend (never ever saw it before LLMs
came into being) is just there to workslop people into providing the next
LLM prompt...

Please don't send top-posted email quoting everything below it - at least
put in the bare minimum effort required to see how kernel discussions have
functioned for the past 3+ decades.

Especially if you are looking to assign some silly name to an alleged
vulnerability.

I _hate_ how this stuff has impacted the mailing list.

--
Cheers, Lorenzo
