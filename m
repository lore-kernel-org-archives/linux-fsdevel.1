Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD8A43D50F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525414; cv=pass; b=NQqZawlflI12OyvdG5oLBKck8TMbxZf4WugPVGOwpCgQC5xNWAme6wBF5GFco97zkwIrMz9DjFUU6QdKqLF+tMv32HHSQWVWcyCVC0gyhGDl0uIwVktMxyoW0oQGUIldfry61iV4XeGOjDOEd2vh/8DnMw+Qq/fEtfh0suAS7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525414; c=relaxed/simple;
	bh=qdFVVpm9+qBWydzXpCd5rc442R2RuxPVFhAYWPCKrjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxccStyCPwexmKpVJeweKZFMwWA/5N49A5zmBHoNL2OlfvatoJla1//wyBRqajwk2Gi13J5ay5s9cLta/AP1XMH+qthjwu4Z0p1JTIyD8fonTbFHttqTF8dhbgzaSsJ9J/1jH3f+bpUpxQpJx9Sfk9zLzYTTOvukHupdswpyNfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=RalLSyzg; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="RalLSyzg"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so12007e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780525412; cv=none;
        d=google.com; s=arc-20240605;
        b=GBsFkmDRHi889PqaCHoSuRRNI7s2cdzoWU1HiF8WqCpszMt00I1ct9UQ+teXJujyHx
         mPFfvmlWTSYYCcU58J2fhAGy9mRJmNi/8g1NA5fE4ijKM93K9ivgp7GX2b6eXOBc2Tmm
         awYfGtEhJpx+C7g4+jHcjbfBzPgXzUdqBSY1Rp2eeG1lU1ivaMnq6V5yfd/lNaZBufih
         7TKVjm7H3aVcRU2HIvZW/4qTWSdN0QuWaSGZLn6EDIkiig8tm0jGhffwcLJ9J7BDXSOR
         Dze56JjueW8ijx2gR8t64PLz3FbUxv4ZeyUkEXGc9kzQl5pXP+MMOxPmuIDEtDSWQ2At
         LEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        fh=j6SGyJ+I6Deu5/744sP8luDOCzHJUiHK7O8JxnlXuXE=;
        b=b1KMb7jjF47TMPgUrXCwAtZhTO/USu/JrYfV6L8D2LPpACEPkxRwUb7H8bd+EG+4jV
         r5g4ocfhVYchGtvG2VRbVy9BaA0RronpsZNxoyShtAiJSDu98WD+YRZdOJmET+YRx3R+
         7caqFrk01Tttgh6nHKV2xWZs4QE66DbFUGZfM0zP8Hk2dbt3Atx184/hRez3UMcVOf96
         UbB12VHlOlL3zrLW4sl+Ujs9LQ5OhnRnz4MmaPTEzoY5lz6wFmok8CK99hCPIOCI8A1/
         REechLKMXhzYCWHcVw/d0u4EV7hnqZaY5uc9ISsXKTUULbbiB36MgU9o+6diefJWHVcq
         8WxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780525412; x=1781130212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        b=RalLSyzghTe1qbss1gZP+U06ITu7Qli1Rj++bTkIVnXwpKefNu46FFxyo7Kr/kG5cl
         48wD1gZfB1caHQ+1YK0vW5j4bSW4pSdrDVi/EJjmakvyuXR0UucKyvVAZ7jTFgSPgo0x
         rUe3+Gf1VWUiTvfaMIDkPzwhTp6Mg9aKah02vrYtLNc3nxSNWj6mrhofr8SichYncx/G
         kxmRgrLIgDY5kojDZ6IOX0Vx/QqOenTv+Yg6aP2K4hm7emQFwJFcuIKOhgo6wRUCRb9O
         DZZTKP38zlm/cob+oxXI9AO2hDozRFDe+wn35z3kQdZKAuzOpanyRX8Euc/584Ew58FC
         bHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525412; x=1781130212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        b=HHtqiV21DYLY68sN1FY6eVbnWlWH0OQNRTUD9tPl7nIwT45XEXSt0VRBObVQNe3//I
         Y5qYpi6G+oGJk+AFfXOPLOGc90RC3JuqCm+bWQ8NHWvgV0Ftu8XJTOQ+14g793fy2RTh
         mIHgyTjiF0uHmYyehhcSBBc5mQ4oEV/bvVPfukLJAAntWjK9/I8f54BwKaGm4uKV92Su
         1S8fi3f50EWQj5DGWMgRPejdGdTq3PREsW5+mRlmksPnkbojKdwzI4lEat1fGO56xfj6
         1N2MXfq9xbgyYYj82hSHzyCHQY9QyPV8RMTOinOJKxMoaSldGKrPaHX7G48dZKwVfi5C
         Xr5A==
X-Forwarded-Encrypted: i=1; AFNElJ+0QyJf4NbfzaRwUd/sOBBOXWwqbfvYafVWvY8yWTIpalupBQVgEx4LUfdmSVe933FxeLZZS6uADD1quhJc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8gPPS/ET+fJ/IjPe7R/nFqXV0Lzz8WesJbCAqBvhw0MGo+og
	lkyqXvyPcsciYYVQmbZrWUwd9f/U9PCgbyGfKiWvjeqsmD//iG1EhLF/VydNevfny7EXwFifxbB
	pMHmOwEXtVDpyWKgGf3hqH8WGKz5IZL6QgUKZbAIY
X-Gm-Gg: Acq92OHbKDTeLRBHdHbo5w+md5AF7OQa76cvhLJixsOyZD5TQEBNdNYp6qZj/Er/Y0/
	ySfQ8n3TQsmbSILynQN92/urlWXkQ7MpFcywAqX0UUt0nrOoPfZdLtr1i+MZwB0IeX2DeB6WnI2
	dKxRn8GMlON+FBUNK/EYX7AajJnzrSJwAKZbWAPLnLWPNxoqidupjruJhk4vMDKqZgS/KmXYqZ+
	YV6nzGTVcIvFRmwFcJ5o0nIk5x3ymEHyAtHfKDjWSuGlgMzUmHUwwp2xCDMWbCN+EIT+UmoNbA6
	2D5Y97YJAvZBfkd4hL8=
X-Received: by 2002:a05:6512:3d14:b0:5aa:7126:c645 with SMTP id
 2adb3069b0e04-5aa7c088c90mr1762489e87.2.1780525411782; Wed, 03 Jun 2026
 15:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com> <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 15:23:19 -0700
X-Gm-Features: AVHnY4Ikay6WVUle1y1S25sIv6i_k8jcErZspj4ec4V3SJVcTGqkjlXJTjro2bQ
Message-ID: <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 2:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jun 2026 at 14:31, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > I think I buried the lede too much and you're arguing against what I
> > was trying not to say.
> >
> > Maybe we should keep an API that does an optimized copy, from one fd
> > to another, that can send from a file to the network with at most ONE
> > cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> > for one.
>
> Oh, absolutely - that's what my completely untested test patch  basically=
 did.
>
> The user space interface was still there.
>
> And the networking side still continued to use the ->splice_write()
> thing for writing to the socket.

So I'm suspicious that you've possibly make bugs much (MUCH) harder to
exploit, but the underlying awful code and opportunity for bugs is
still there.  MSG_SPLICE_PAGES is still around, and there is still
(AFAICS) no actual coherent description of what it means.  There is
code that checks for it and apparently needs to do something special.
Foir example, some random kernel version I have checked out has this
delight in af_alg.c:

                /* use the existing memory in an allocated page */
                if (ctx->merge && !(msg->msg_flags & MSG_SPLICE_PAGES)) {

Grepping for MSG_SPLICE_PAGES come up with all kinds of terrors.
Check out the lovely comment in drivers/block/drbd/drbd_main.c, for
example...

And even with your patch, I think checking for MSG_SPLICE_PAGES still
matters: if I write to a pipe (using copy_splice_read or even just
plain write) and then I tee() that data, then I splice one of those
teed copies into a socket, then we hit ->sendmsg with MSG_SPLICE_PAGES
set, and we're hoping that the code does the right thing.  And maybe
all the bugs are fixed by now or maybe they're not.  Most of what your
patch accomplishes is breaking the connection between the buffers and
pagecache, so you can't poison /sbin/su.

It also seems kind of unfortunate that we can have skbs that contain
data that isn't actually owned by the socket in question, and, with
your patch applied, I'm wondering if the only case where this can
really happen is tee() and a handful of random drivers that send to
sockets.  (The ones in drivers/nvme/host/tcp.c and iSCSI seem like the
ones that people are likely to care about the most.)

I *think* that what I'm sort of suggesting is to drop this ability
from the kernel as well, or at least to consider it.  skbs would
always own their contents.  And something would get wired up so that
at least the cases of sendfile, nvme and iscsi to TCP or UDP sockets
would still works with only one copy, from the source page cache into
the socket buffer.


I suppose the counterargument is that, even if more bugs exist, it's a
bit hard to imagine a real attack involving tee, and one needs
privileges to set up nvme or iscsi aimed at an unusual socket type.

--=20
Andy Lutomirski
AMA Capital Management, LLC
