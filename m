Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF993B47F9;
	Fri, 31 Jul 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785486443; cv=none; b=BEQEcfiW4lQhS1iCSuAZ9nckYjGvBuJJ9VGUSS7ORm8tysIlIyy0bxNfmTSh3ZPOm0MF6a7V/Lsdws4LiWZgkQd3elKL3sFq5c1FS+X7YMeLIiP35R+VaIT/35msPB2urkRyO08tclgYgzClzSZwIFkjiVUHj7sSXl0CyH7hQEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785486443; c=relaxed/simple;
	bh=qPx8l2vZs7aQLW0N/GnN2h0tl44uplIUI+xx69fAfiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSDRgubXWqeRfhRAAA278LiMK53fwLTuT0IDT5HyDPB5898uGrzoC4osf/97DQ3eMtNk/VxUy3dahHi9jF65F1+vCnqNGQV+H67yOH2TGrDHjp1w00caOij+eGsVLPaZnxLZQKFnnYguDTSSwiHK1JCoZOemNH+jlkMJURmEfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Nn21v8Zh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Nn21v8Zh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=tMcTXZW/Ce3M+CAapCCi6h6iG/V0//3pfbcUsN4Xnag=; b=Nn21v8ZhaPRU7RtPhnism5dIPC
	801huLMfZAb0jZ8iwK21lLO4NDlepzl0M2hVreKVMKY/3CMxjsQzvSJj4/MO6PxR3qNoqxNliz8PH
	XZk4KPiOS7XzIOl0mMePk20S/FG+gt7ltCVEFofwHL+rl1emgYCISxSemmvn6oCguVMDYkp4CH3Fs
	oNCdbSfXF97opUEWWc9pMCmRt5aVkwy6YoyMAPyzqAR++JBzE7Yxp3c5WU6JfOlGNj3zNw/Mh9fX5
	YH6e9ny1zZ/yd1qZr76xY5r+4LLDtNPtKCA4ospzTsOBPWactGZRSmTm8w4PQ4gIoWSb5rZu5JEnY
	bd3riaiw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpiaC-009sgL-0w;
	Fri, 31 Jul 2026 08:27:08 +0000
Date: Fri, 31 Jul 2026 01:27:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amxZw69gHKLDmfKX@gmail.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com>
 <amth6owVUdVOmyAL@redhat.com>
 <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 10:01:56PM +0200, Mateusz Guzik wrote:
> On Thu, Jul 30, 2026 at 4:38 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > What exactly do you think the comment should say? I agree with anything in
> > advance. I thought that "edge-triggered" provides enough info, but I would
> > be happy to improve the docs.
> >
> 
> how about: There is userspace depending on the extra wake up, see
> commit 3a34b13a88caeb28 ("pipe: make pipe writes always wake up
> readers") for details.
> 
> or whatever else which refers to the commit, no need for anything
> fancy. the current commentary is definitely lame.

Agreed. The rationale was non-obvious without digging into commit
3a34b13a88caeb28 ("pipe: make pipe writes always wake up readers").

Having an explicit reference in the comment would clarify why the
unconditional wakeup exists, rather than leaving it to appear as a
potential weirdness without clear comment.
