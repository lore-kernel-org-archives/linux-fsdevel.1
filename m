Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A1409609;
	Tue, 19 May 2026 13:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197340; cv=none; b=lgKPv4GbVcWW4/Ico5tdAkffLXxYVepeABVOdvEVOKEmYFS6XKYe7Feu/OPw/ctt2MCKhSuGQyICXZjD+JaHplnev2Y/oYUPoctqosSnfY0vCNI7Bcuh77Sm24wUa6jVKDurgOlARGT/fzpKw8HgBa4aQpoFCkK1Dgqpx2zCZN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197340; c=relaxed/simple;
	bh=ZDJmOhI1wYlm6YK7a83UmlKGrHKheOPreLwP8qNBwc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MDOYhm8itXjjMDLX6pY4Cnc7Dg1LfY9Q1+jTEXrHeqA2fziwhGl5f7ga0AkxxskdOabS2VBvht6Rwoa1RrUuKGlmIPznrqmRdsFUc/MgmoPHsGC3hqODnzgjbaRH12j7gtu/13uwGIDutMyGb0DDmJX3mq+Lom/a0dFCUnN8gsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UWVNmJ2f; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UWVNmJ2f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1779197337;
	bh=ZDJmOhI1wYlm6YK7a83UmlKGrHKheOPreLwP8qNBwc8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=UWVNmJ2fTf3rGljtv/AqYCRT05jrMsjgLg+ZYPdr5wnVHHzjlUa5B7VyJwMkUs+fa
	 K33rZn4F6PVZTEJfPqpTPuACJriDqJXqywXKNX5bmTTeDaFCnd0Y5d50AjZAUs62OH
	 KbY9A4FOJKLz8YEY9g9Vrm4JLmYbQ+OJNe4h6BoQ=
Received: from rainbow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:d342:21e:67ff:feb4:e2e0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lamorak.hansenpartnership.com (Postfix) with ESMTPSA id BE1D21C0379;
	Tue, 19 May 2026 09:28:56 -0400 (EDT)
Message-ID: <27d39b4843077a7c8a9c4a3b2e14c480afbb573a.camel@HansenPartnership.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Jens
 Axboe	 <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara	 <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Date: Tue, 19 May 2026 09:28:48 -0400
In-Reply-To: <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
References: <20260516182126.530498-1-pfalcato@suse.de>
	 <20260518-starten-messdaten-3b8aa670ec85@brauner>
	 <CAG48ez0jbSUgT3ZxPKZP7Eu=K7ce2cX7k2NzHCHNMOxQjOGT9w@mail.gmail.com>
	 <177918418452.771415.4371785688744608623.b4-reply@b4>
	 <CAGudoHFtecdkcYpFrtM5RAAPSU11eL_ALPGp_jhtHW=WxyHE4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-19 at 12:51 +0200, Mateusz Guzik wrote:
[...]
> I can't stress enough that mucking around splice (even if worthwhile)
> is merely addressing the currently popular attack vector and not the
> general problem.
>=20
> The general problem is that the kernel is expected to be able to run
> with untrusted unprivileged users, while it avoidably exposes a huge
> attack surface. Of course there is no way around providing a bunch of
> syscalls to users, so *some* danger will always be there and one has
> to expect that even core code has bugs which will be discovered by
> LLMs in the coming months. Even then, there is tons of code which is
> currently being audited by third parties and which has no use in most
> setups. Instead it gets autoloaded in response to an exploit wishing
> to take advantage of its bugs.
>=20
> The huge attack surface was always a problematic position to be in,
> but with the advent lf LLMs any unskilled person can drop a 0day and
> the position is straight up untenable. In the long run there is no
> way around blocking access to code by default, way beyond the current
> splice proposal.

Attack surface is a great measure for making lower bound security
assertions and proofs.  I mean I've used it myself to build a container
that was provably more secure than a VM:

https://blog.hansenpartnership.com/measuring-the-horizontal-attack-profile-=
of-nabla-containers/

But the point is it is a lower bound: security is always better than
the attack surface measure says.  The problem with the measure for
something like a kernel is that the kernel's job is to provide services
to untrusted users, so amazingly enough a plurality of its code goes to
this function making, as you say, the attack surface huge.  I'm sure
there are low hanging little used interfaces we could remove to lower
the attack surface, and perhaps we could voluntarily wall off large
areas for "secure" users.  However, security has always been a tradeoff
for usability (the most secure PC is one that's powered off) so the
more you wall off the smaller the pool of actual users becomes.

I think we should be spending our time on better interface design.  As
Kees' security project proves: classes of bug can be eliminated via
various techniques (effectively rendering extant defects unexploitable)
and we can certainly do a better job of error legs, which seems to be
where AI is turning up the majority of the issues.

The problem with the above is that while it's easy to measure bug
density and correlate it directly to attack surface as lower bound
mathematics, it's really hard to measure the reductions in
exploitability potential that better API, coding and other security
techniques give us.

I really believe we've done significant improvements to reduce our
exploitability, but I can't (yet) measure it.  That makes it easy to
claim the sky is falling due to the size of our attack surface, but
doing so effectively ignores every exploitability improvement we've
made over the years (and thus ignores the hard work and dedication of a
large group of individuals).

Regards,

James
