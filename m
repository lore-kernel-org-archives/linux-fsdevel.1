Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795128624;
	b=20AKVn19yASZjw4h2cE3npstnrybw6r/3rEAvYiOcmBwxKAfw6yvYMPMepLy62phC9za
	 Y+XAx50mlhUX37Kt4GleLOWxXjsDE4aYyZ1Dki/Kx2o6w2oTdQIVBvzZPnxSySrG5b5gq
	 z1FH0bg9Xu053nMqvLP1vB7H1n8m7UjGc1O+z/N91Cj13kWAFNc2wm5A/lxSYDfJH+GuC
	 bansPZ7EQliosjnMwQVRoMyU3sMlp9m/MEeo0hzXkepAwIpzLEbwXTtZBbH7PjRvk40GJ
	 wQdyqWV5YUK+xDjvdFlYqNUsOrPb5FNGig823HezArE6ghfQEghrRacxbXvf8UxppNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128624;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
	b=A9FqPPliEDhBYIF4uMI0KfHO5jLkssmuaNKZEgtzvMhSs5tOn2eJUBYdtOvosUrrcya+
	 Ky6Odd5acR3aaMSMIv5Eg8m8D4xKh/UrB5GvZwCc3kaWUQy2s2JHEHbmLcvnkCwfjB9yZ
	 DU3mo/Gcja9+VaoQvvA2IUwlGqE2f9x9x+CP+X8j2lWfdYWcmuWFDqeM0LRoaMaEN60nY
	 SZJj0OEUmLxmaiDRYKR6ONGmkFOy1hFFmQjHv7blzx2KYVdgFS4kBjE6ZalBz4y1Ud+fH
	 a2lgjgaBQtmvZt/DIuZWaH/Fji2UcKhxHI7m3To9jO+4u5MMNxipYCLVsfYhWvP2ZkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CnCiCFWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357E606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 22:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D357E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CnCiCFWV
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c102ad8420so124720e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795128622; cv=none;
        d=google.com; s=arc-20260327;
        b=Bcf6+AAmB99BpdXmhS/pI+SHxpXJ6QkQfGuSiyHrpQPS5SkmYjn2hwp8wUibZ60uN8
         /REuTvigdjJpiXlSpdnp6iDMVcSJ46isMtWo38yH79Wu3OHCJ1Ivka9Od23KQn3l5+v0
         F5ekk15VyvuUENikGY8crQAZJYDMmXW94Q482pwfEpUVRbhIQMEAjczMYO8TbvJaD7ds
         tMsdp78Fy5NdeDxsCZFMFif1rX9nfxorIP/97XXtKdJUOAMfgvD0tX8PVeUC3ydpv5qe
         6BG4Z6NR+s9KtcXks8W5zi2noknbpIgFaugHSSQ3FLHAJJ4ZP1wIDk5XhhAFZ8XDFKg2
         8VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        fh=ldvdhlFJzm2Wir2h4Ji6oJ9XQkV7/ONBijhF84qzVbY=;
        b=L+v6Udk4baA4LTddPn6EW9z2qX/I7SzY9900Ld7uPu4RXf66lKO+E0FEBR+LQmhjTy
         h6BTgknA5uTkzpFpLS/EPioU2O2OzWexLdMsf8+0qrFW51+oJ0hsZARFifXIGd4EFwf3
         mGgK2fr34Ln4k62rmKqg4Uz3m9+j7GfSCDNbVN98S5QqaTY6GkdDjRoQn6ICm4TNcb0X
         IeNhjZHNFBU4J0v3OLfJ0kIMQK0hrXEivlPO24WszjWxCP4NQ1RRQxdeyAY9qeM9CQcF
         YvIecLX6yAADPSCObKAQZfQAvt5uTk3E3kZJR22jUB6WraBZiO5uaYojPVXiMz0t89w6
         5vug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795128622; x=1795733422; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        b=CnCiCFWVdqrTol4CcpbrSlDlLA3fYAIDBwcdFh6d/8N9Al+d37Kz1pAOOAx90UY2GH
         RwYwOhoV6CXoXSA7CUTRwKZNDbbugHPiviw1ZrlJjOT9eUFGc0CH+hNOe4LM76Uo99WI
         P6DX/zlh2h7WDUsD45YZT8C+yOypQZE14pxWvAPwxvGPdkR0rsUQVWvZNIkOeDQqf1cS
         H/e2Yf2FTuVfpTJ9Pqe8/BMESdOeaRtqVNs8ZsQxV9qkxEPSGBEQoNPDU9l00ioRVU1Q
         yxzIE0LYkdOSEIRca+sVlkRgMIY4FpacTm8jEYXcDJ3wMRhmrd7u6crYQQV5v980MITl
         EpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128622; x=1795733422;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e5/dl7hyTqZEbaIFwuAjfKmRpl1SUl3FSpNrpJ9d20Q=;
        b=QmU4U7YbAiAMNjdAcPjRzhoMn85XiyLI+c8MvRaOVq9sICegqtvuzsQ67AMKR4GsrP
         +iEZwjffY/mo7tjC2lkv5GWqwlE+yFKprPRNjxDh4cQ3pg1gJKLq9a5YTWZLq460IfFu
         mB0kaliDJRTTWCDvlRa2kXBCIXM+nNzR/4rTpMgTMGHqZNTg45zb/O6NX4pgoNeylb4q
         5cIq4b7F7wpb4+irv/uZ+TzE8GsuHc9nv2HoY1GgoXSL/7rIvXY81eS3hj342pC+tCFy
         SHNIkBMqgWsugijMzRTcihKkUHthElrPcMn40yHNmCGOjB6rDIiqNd8qcRoi22dNn2tW
         42tg==
X-Forwarded-Encrypted: i=1; AL+hErGCSJPjh43mt6wX8iwlQgFMTHKanl50JfEU/bNr5+0AVVrGH8UfP+joHVFW6OxBnudT64tEJ56Un5CIk7mw@vger.kernel.org
X-Gm-Message-State: APuU4Z/VhC1foMaJlheGqvIa9RthaDBofqMuyKcBZSaClhTeOZLY7SUd
	alq1jZfFHihrjAb5clN7sBPyAJY9obSMaFnb+TBJSSRxiHVzlTQj+Z/pdkQITpwJNAQvPi5aRJy
	k6iA1njo/dSUKd+Or6zVOH9/6RQINjpuqmGbG+6FI
X-Gm-Gg: AYBFou3GP5ZLUERVZQe/JhuAdP/1VVapobMOIYz+tgwHTUuu7b9Sk9NQr5zucEXNT0F
	OL1lnd46xuubUYPVHbf1yIArn3imgJtt4rg11hEoCdNpJAg2UZfY0aC+253tuXNkvxLNjAMu/cP
	3kuK1cF984KuHQj0+9WLT/yybYVRqCIfAFXya/BxhxRHyr2iWMe4PQYKZT/fc6ZCs/eecxe9XEP
	8Bo1zpAoUpTosN7k83cDouC85zNBEdtWtn139SuqEXIHmWQGzyjN9c6z7UwJzXy5/BKNCzF8LNj
	NNzT0cqTVCiYXPW9/iAiDpf5m2MYZfI55LCS4NvQ8vNVyHeII/+zvMDOIJxgClyl++aXgMwX+hM
	/6CoZYZQWiLVzDLgwIk3opUS342ORXZSvyw==
X-Received: by 2002:a05:6512:3e13:b0:5c1:4793:bf31 with SMTP id
 2adb3069b0e04-5c1bc8495damr319148e87.58.1795128621989; Thu, 19 Nov 2026
 14:50:21 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org> <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
 <av3akYFOYaeQZauZ@kernel.org> <av3bkDnwmjunTleX@kernel.org>
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com> <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
In-Reply-To: <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2026 14:50:09 -0800
X-Gm-Features: Aa3M54r1P8ngsOHB8Vhj7FvubBRj99w4Go1f1fZhV4inbefIYqqcV1gzmh9n2Fw
Message-ID: <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> wro=
te:
> > cells: The dance where I create an anonymous mountns, mount stuff into
> > it, and then attach it to the cell is cute.  But I think the userns
> > interaction is wrong: you are making me assemble all the mounts in
> > *my* userns and then clone the entire tree into a fresh, non-anonymous
> > mountns bound to the current userns.  And that clone operation is not
> > free and serves no actual practical purpose.
>
> The copy buys us nothing, agreed.  That's just what the mount API gives
> me to work with today, it's not something cells wants.  If I could make
> an empty mount namespace and fill it by fd I'd use that, the "root" slot
> takes a mount namespace fd already.  Extending the API for that makes
> sense to me on its own.
>
> The mount namespace staying with the builder's userns is on purpose
> though, that's what keeps the cell from mounting anything no matter what
> capabilities it was given.  The builder sets the tree up and hands it
> over, so the cell only ever has what it was given, and the mount code
> isn't something it can attack from the inside.

I don't get it.

Using the builder's user namespace means that the contained processes
can't be ns_capable on mntns->userns.  But this solves very few
problems unless you also deny the contained processes the ability to
unshare userns and make a new mountns, and if you can do that, surely
you can also deny the ability to modify the mount namespace.

As just one example, a mount namespace could have a little flag to say
that it's *in* one userns but its owner is a different userns.

>
> > cells: I find it *incredibly annoying* that one generally cannot put
> > new mounts into an existing container using most existing container
> > managers.  I hit this on a surprisingly regular basis.  You seem to be
> > baking this into the whole cells design.  Why?
>
> By design.  Allowing changes to a running container is what causes the
> problems.  If you need another mount, tear it down and build it again.

What problems?

I get that allowing a running container to modify *its own* mount tree
(or any other mount tree) is a meaningful attack surface.

But the whole ongoing discussion about cap_userns gives a clean way to
deny an entire container the ability to modify mounts (although we may
need to augment it to control mounts if that's a specific concern,
since CAP_SYS_ADMIN is a bit overloaded to say the least).  And surely
cells can find a clean way to lock down the container.

--Andy


--=20
Andy Lutomirski
AMA Capital Management, LLC
