Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12333E95AB;
	Wed,  1 Jul 2026 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894816; cv=none; b=oJnNneCWe6kp+HtRNpmw2m42mc3ah20U+icu3pR0PFvfOlx4dva52i1S930krwzWJCvV9lVmE7gLK9+p0oFC+kfwixozb5yQymNd4fErihg6D0Y/ZPsq5CY4XJiVxIYQsdIxz0JT4wvEvCov7NkjKRrtQdD0NhobJKGCsfumPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894816; c=relaxed/simple;
	bh=MV4wnGElUJ6vmm6EAHFLmYi2Tu+092OxuxR9zY3lu4Q=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BjX3y3SzDZTh+LcZgJvOUEhw9Xqn3quenRARHYzJzw+ZBTtRQAf2j7zgKEwGFYW2k0E1RdCovjmugSDINJNEx46N5S6EwFVzNwoc5+Gs4kP90dOUYXPoO4Atlo16ctOdb0x4QcLPZU96r9uiV4gAg4L92SZIsu6LP7QpVwr/cV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI/tV6jn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI/tV6jn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE331F000E9;
	Wed,  1 Jul 2026 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782894815;
	bh=VoMdYy4QcT8G7XCZKT+8dWw8RftkfHSLZMTbRzYoMvo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MI/tV6jnaQL8AuwTlWCXPP6F/z6NzUfJtYem4o3ylYkFu9ixN7MFnVW+WKeW3up2L
	 v0dejF+RmwO3SLwSOxL7ZQ4XgibfRhs5lnaZMFATz7BAqqmX4Ig3yegZdT6vnMcpME
	 8u1hXzwoyqpldovggBgyZT2Tzq3Kw2r2fLVUokx7xTT0/Gt+b1A+LeVh54xdv33Bd0
	 vUcqhd0GkY4M+awPBeKMZtdmK7JvccD+VbexLjZaqRiswQ+U5OUHfgo6IOEvtvGdKx
	 IDHcsvque4OVqZsXX0f+Z6FYHpNWLyNEN48PfSiVQYPCv+lfViHAEcDN5ETrXiJaaj
	 /Ve4VcbElxMmw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAHc6FU4E8t1wXg4MFhi4W=+fBMsrHXQeXQ1B+W3ELiLxRdErJw@mail.gmail.com>
References: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner>
 <20260607164136.2948550-1-agruenba@redhat.com>
 <20260607164136.2948550-2-agruenba@redhat.com>
 <20260630120641.133521-1-agruenba@redhat.com>
 <20260630-ochsen-neutralisieren-langzeitfolgen-f685027b7f3c@brauner>
 <CAHc6FU4E8t1wXg4MFhi4W=+fBMsrHXQeXQ1B+W3ELiLxRdErJw@mail.gmail.com>
Date: Wed, 01 Jul 2026 10:33:30 +0200
Message-Id: <20260701-beinfreiheit-export-enorm-1f81a94f2454@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MV4wnGElUJ6vmm6EAHFLmYi2Tu+092OxuxR9zY3lu4Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5XLh7Nirf/krEc0u9lbqSpxiFSn6WBj55eG4/8+P9r
 EnH/DJOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExksgHD/wx3l3pz9yM7r3Zs
 LuAINf/2bum/pLJDGTNONDoXfdq+mIWR4Ybj7Ml7jKaH2h/YI337L/P8A/evhkfvCHhVt1lNKkB
 8NScA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-06-30 15:05:03+02:00, Andreas Gruenbacher wrote:
> On Tue, Jun 30, 2026 at 2:33 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> > On 2026-06-30 14:06 +0200, Andreas Gruenbacher wrote:
> >
> > I'm very confused why the f*at() variants are supposed to accept O_PATH
> > but the f*() aren't? What's the point?
> 
> Oh, I see. To keep things consistent with fchmod() and fchown() vs.
> fchmodat() and fchownat(): the former two also don't accept O_PATH
> file descriptors, while the latter two do.

Right, I saw that and wondered about that there too. I guess it makes
some sense in that nothing about O_PATH at this point is consistent
anymore. Will be fun to document what exactly works and doesn't work on
the manpage...

So then I think we should refactor fs/xattr.c similar to how we did it
for fch*() and fch*at(). So that f*xattr() call CLASS(fd, ...) and
f*xattrat() call CLASS(fd_raw, ...).

This should also make it a lot easier to follow, hopefully.

