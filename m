Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795130854;
	b=RN55D0n06Un9rLnNUcO+uPLJ6AQv76daU6kO/GDGcbIWfbpUJeXDBD/rf6V9d3oIQeRC
	 WNFz4yLk7tfIEmWU9tTcNmzr4we0zEVAONonBcdOWg0tQ6RfozpSKrazIMsp1v38linem
	 a5q2pDhmzdY8SUD+W9jtfAFf4ENpnRZD7C8jQhdF0isxb8e4B44oFqOKfqGKnCGSx6qt2
	 QLRApZfR+R8b4AAL2cfx997GMw8irsvtIskffRgg5Jtpnp8k9TSkEeWjOnsS4zXwNA6aW
	 1EKDWqMdn0BjGlB5becFhIK29XslBS5a6xM8v4fuwK0ocMW/toaBEfN8s/HttDE76Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795130854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
	b=WmfRUa9xg6A1mvfY+KrM4pOx+khYjMLY6bqVEKufb2sPvienyrBTpYfZDxbWYiX/T+RS
	 WWlY5K+VY1zjhCNaaHjC1wZl0S66Hgnm+RG8vtf9CzZ9SvNrqtl4vLIDE+fPs/rflzwdT
	 uvuAfCsWIn3mU9g19n6VqvjAfHlKAR9JffJeQyFuf3q+nqYvza9BVj0tIutWdouoaFOMo
	 dGrufjkCJSTOLHarXoDL6e1PY6CzgapM7EgXQmoO7O2rl7zzUn01z0cE2FVFxDnJhhm00
	 diRMXZ++lSiuaGuoOuXTYtCw3Iil6J5M2GnkABzgXiu5XEffN9nGlYxRGg1FbFM7jFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hjX4t2Xo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E7606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F2E7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hjX4t2Xo
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c1593fd141so228318e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:27:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795130847; cv=none;
        d=google.com; s=arc-20260327;
        b=CJXLcARGupI8tE66Hl+B+7eLUIEZYLBdH5INY51T9PtuNXvW+0akuTdh9/ELgLu5yB
         hDG8gj8xaYgidBbV8gyUX76+EAmiPgEOqZMNju0ScVmuRH4NdXDjNQQ5s9kk+Dg0MPlH
         4VBUONpp8iM0b15Ldukoa2JWI05Ofoc9qOTrGGJiZOWVnOffR/OsjcLM/sczVrwS5R99
         14gic5+gtHURyMjDY/bxON7Wq9/jU0GP06VS13TxUuunhVtiz0Yj1b4EOG0krVKdKCAn
         YRNWQXDMVFH5sNYToxL6VOw9chiKqWisKKS8y4T9K1f9plxg6+vkwbBpUtEIyachvpTn
         fElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        fh=bF2EwxIJYiuaaUlcJs6D0ysrfrquiWSuaDkjzewbzHI=;
        b=cx21hO8EjHC1J2wJMLce564HUhU0WDAJf6JtvhGWXp1fUSsMKXh1ZAdj7WIYWuohEw
         8JTcKq077PRI1QN4lZ9BXp5+MBJmz4+m9R6Zu6SW9bB25DN4t+FT9it6SvUAnvwvPrDM
         ZXqyHmT086OMiR0h1jOwDMIv56DucDF0t6DYMQ1cQKufxnazFQGdoHvT47p6RSszFyzf
         WK+sReAcWnK0lkRCnbQUjRkSbjrtut4gUbJqJL9Nykob9KfsIkBVTpVnZPCCWz9H+ya0
         GpQxRA33mpQAbRO1MOuLZ7eOZGKbzuoBFDGsqb8H0s5bqOTVYm/r1zewT7N/zuoFPDZ2
         Q1uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795130847; x=1795735647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        b=hjX4t2Xo0e4RQY2C7GXTldeqYZukwPJ0G0t0eeIIqIxOs+nv/R5cEOi7krUGHcZauR
         vqzkL8y++jDu/is0RF8VMVltWdEd0lyrR1cIBs4FTu4VVQYMJFKG/s1sz43eyqiCcrTX
         Mbg5Ry98V2BB5rY4noROHUppSerOzFFtKwmae0y2na6LMWfxzuzS7JHUleTuTmaHRiow
         9su2Gf++IX3BLOp0vRmJ0CYQlTuqXctSVrAeuH0kMwAL7Ra/++9cvRom3L2AnQl9FlUD
         fl60SeNXa2k2FkgU8xK8tCvQtyjYi99pa5QdP3Pc/FV7HKF68S1o+Utpk9RB7yjgN3SL
         Wk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795130847; x=1795735647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQjCXUbscPytTNcthMSXFUhQzfR2m/iC2VTnVjvFUQk=;
        b=mhP5eVTPMRXHvuOI+hZbvEyrS7/kgiUUoO9SLlaMffU/n393uwKqhCcUPNYkC3bKmP
         R1oKx71DUky/Zn/e9p2Ol4n4zYLzs907+/a9yWiDH/dTTLrA3ClSrKRDjIh+JCmBEhZO
         FLE/b2WDu+VNzl+heB/qr7CE9BkRIHcBbzghcYIfgqh/hLjC0EHYEcG6Dshjt40GYGNC
         GFGwHG0h7D5GKcQzXlgbEVFY8prRuhIJ/Bpr8f8v9vqrjEFdDKgljoXHCR/laWL8nO5A
         HQNqiug79BsoHB189QNK05tSiztZMEalv1YSBhocFaX4d/5eaPPgmMHv0bgAnWtHYC0s
         2yqA==
X-Forwarded-Encrypted: i=1; AL+hErHpt5YzXaSncvDqTU00MSwY3qi4zDH8hVQkwDh+h7H02YHTD0bceOGISF6bm1jUzAG/OFCdF/qxOEzP4WVb@vger.kernel.org
X-Gm-Message-State: APuU4Z+JHkUFHI3kVuGx7Zj6fGZ8zJgRKRm5Jv9bUXF1KUVSK9SJfPBA
	0mQcYZ6f4Qz8qqnL2RAiXAPI/AnWikEkwI4GofN2diz6spvAxfd0gY/XmMgsmdidqEQfqeCEscH
	nbAk1AObAqCKNjS704BvvKEJ3iLP20JZEpHYzin8uKHhW9XHLiRI=
X-Gm-Gg: AYBFou3pkD/SgC5W/A96gQSeQdKyF5mlvgeXtoUXVs8MGard/Q1m4jfsSUdfAMfPENz
	DLLYW0VslevZ63q9Bt9O0cr/20ZO5KeXh8m7cJyBHX6rlquI6cMmYmvxCO1zO7d1T3Gjn2hOv3h
	d+UGjsxuZ+UeKphfIigKrXndCkXHhfWIwYh53JGYJuYG3xb602VrlLWdM8jq8L0Kljcc0J8fCV6
	jOodJjHdAunMczzBeJJAmg9i7f3vn/uwe/M9P/LmfpkesqT0sNOFPuvrnDwonAS3PWRMd+PKmKx
	4yHsR2h04oqBNVC32b5CrrSbyM3VWPygD9KnuYETcNetNWYnRdPegHKpvYnh9a/xZTTNdqjThTU
	v8cXnJOy24KNdNMSIRKlBcWz5kZcNF1ARCw==
X-Received: by 2002:a05:6512:1194:b0:5bf:b365:d82c with SMTP id
 2adb3069b0e04-5c1bc89ca7dmr310274e87.57.1795130847409; Thu, 19 Nov 2026
 15:27:27 -0800 (PST)
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
 <CALCETrXPLeUgxyhjP4XuWS46FKB0TUHF5PcMkdMf+qeEXbyXRA@mail.gmail.com>
 <9463a969d35a7d5ec5a56aeb67644b94.josef@toxicpanda.com> <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
In-Reply-To: <CALCETrXt-Do28BHDpbrA98kEy-tQuorxD8c2XsW24Tt8Vspdtg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Nov 2026 15:27:15 -0800
X-Gm-Features: Aa3M54pRPzoZRQLZtE8vOKLAtvSp1jFKDAaRmJQa_mjsSLqBguq4HCe2_2_ku5M
Message-ID: <CALCETrUbe8rBoxrC+Q66AMsrJ8Fow7xt5KJKRAmobtXBvHWdqg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Josef Bacik <josef@toxicpanda.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 2:50=E2=80=AFPM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Thu, Nov 19, 2026 at 9:30=E2=80=AFAM Josef Bacik <josef@toxicpanda.com=
> wrote:
> >
> > On Wed, Nov 18, 2026 at 9:46 AM Andy Lutomirski <luto@amacapital.net> w=
rote:
> > > cells: The dance where I create an anonymous mountns, mount stuff int=
o
> > > it, and then attach it to the cell is cute.  But I think the userns
> > > interaction is wrong: you are making me assemble all the mounts in
> > > *my* userns and then clone the entire tree into a fresh, non-anonymou=
s
> > > mountns bound to the current userns.  And that clone operation is not
> > > free and serves no actual practical purpose.
> >
> > The copy buys us nothing, agreed.  That's just what the mount API gives
> > me to work with today, it's not something cells wants.  If I could make
> > an empty mount namespace and fill it by fd I'd use that, the "root" slo=
t
> > takes a mount namespace fd already.  Extending the API for that makes
> > sense to me on its own.
> >
> > The mount namespace staying with the builder's userns is on purpose
> > though, that's what keeps the cell from mounting anything no matter wha=
t
> > capabilities it was given.  The builder sets the tree up and hands it
> > over, so the cell only ever has what it was given, and the mount code
> > isn't something it can attack from the inside.
>
> I don't get it.
>
> Using the builder's user namespace means that the contained processes
> can't be ns_capable on mntns->userns.  But this solves very few
> problems unless you also deny the contained processes the ability to
> unshare userns and make a new mountns, and if you can do that, surely
> you can also deny the ability to modify the mount namespace.
>
> As just one example, a mount namespace could have a little flag to say
> that it's *in* one userns but its owner is a different userns.
>
> >
> > > cells: I find it *incredibly annoying* that one generally cannot put
> > > new mounts into an existing container using most existing container
> > > managers.  I hit this on a surprisingly regular basis.  You seem to b=
e
> > > baking this into the whole cells design.  Why?
> >
> > By design.  Allowing changes to a running container is what causes the
> > problems.  If you need another mount, tear it down and build it again.
>
> What problems?

I'll add:

On a non-container Linux system, you can hot-add a removable drive.
On a Linux-hosted VM, you can hot-add all kinds of devices, with or
without the help of the hypervisor.  (The hypervisor can hot-add a
device, and the guest can mount network devices or newly added USB
devices on a port that was already assigned, etc.)

For some reason, on Docker and its sort-of-clones, approximately the
best you can do is rbind in a directory and then mount things into
that directory from outside.  This is sad.

I get that there are plenty of workloads for which this limitation is
reasonable, and there are more workloads for which this limitation is
silly and people have learned to live with it because everyone
imitates Docker and Docker is limited.  But there are also workloads
that I hit on a surprisingly regular basis for which this limitation
is genuinely annoying.

If you want to write a container manager that shares the same
limitation, fine.  But please don't make it into the kernel without a
compelling reason.

(I personally think that Docker has a *lot* of weird properties that
make little sense.  This is just one of them.)
