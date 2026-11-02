Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663400;
	b=QQysk/M52d5qoOt8Z0+ybNHCe6HXvE4oTVa21QkR2pZUthjwIiGBAL3I/9dYSQyxo3dS
	 wPU1r1I5B78Z9u7viOMEFyBdv/sVbmHfJ1UdB9CI0Ndjt8MRDEBlUSV6e0ibqeENYeCsY
	 EPmajTJxOlerKV03bsVGo0ksbsaxkbj9Qr10thy6znmL6aYJWFFCxqdK6LJNqAf9wNGmy
	 +fGcedx8iwL5/yMkZlSemlskX1DG5grOj8yiJ4DxhkeP2UFoM+tV7/isfmoSsJo/GQIe8
	 9fIDw7UHQRDjwhzg7vN0jY5ToNJdWoss4tB6ZIW+zCtRVIFBMMg7AMgz/Of3liBaMhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=IXU9CQOa1FKGKiuXsLy+IjbxJFQKGgpmyBaeXrYbXeI=;
	b=PPFGELB9ZYJOwitmQSMigCTk/FS+sE6lLr5lg1g3FXpxB9dMWmVQilILzlGCypHLN5sv
	 bhpadN2SIfpP6SY2t3GMDwD0yDFrE6K1K2Bk+H0tjbbhtb4VTW+xvfjXCXaAEAGSyxbkW
	 FN2CDET4nG0+DpsN8WkGCvXce4ZQCibJ9rWdjMcmNWosIeBDRUoPQk3Nb/EU0GCxxL/N+
	 pWMiJ1QJZUmtXWalDzy/7HLqfDliyKBVlDjEfn1vAqo6w2NjkyPehOMSjVYVfpk/+e999
	 bc6hJcUpqA5QqXl+NP8no5mJKrrGgQN5Yr4B8xTYpyvhWjLL2IJaoxPaqv3CF3Y6+/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hWmE6q5L;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D1606A331
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 23:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 135D1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hWmE6q5L
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab37e44643so24533547b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 15:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793663399; x=1794268199; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IXU9CQOa1FKGKiuXsLy+IjbxJFQKGgpmyBaeXrYbXeI=;
        b=hWmE6q5LeJa+kXUPGLyJalIveKRVbt6EOgIs/OJCYvu7SCDbHy8QQ6dVhLxAHsP48z
         opztfEnNt6RcPwsbrz09eOKA0FnOf1Dl5NwbNr5fsuXkCZuVRwW78wazMWf+zXiP6wpS
         SibvkvnjyZ4SkDGgspCzxdgDAb8qymfkneuxwsUxEI/cdNygAbq3PFA/bMxMeZTSgxTt
         YTo/1An18RyYRD0P8CwCBST98tcBkZXxmNCY1uPi8VJwf4UsZ8mtVJS427/nivqCcFOP
         0b0xhOcmkHPLsE3wGDimqtRY5Ry1bJz2PJ/rh2r4VqUvSRGPft0+hnJW00TLUBK/P9wP
         7i+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663399; x=1794268199;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IXU9CQOa1FKGKiuXsLy+IjbxJFQKGgpmyBaeXrYbXeI=;
        b=ZvF1U1/Cu0kLzvZMxmgCWaV2n1y3q5bM1yud/BkFBEZle/pnsgaE5K/CCcM5wCcWjs
         4cs+tMi29RMu1WiE1QswJFyzjVdo+6x0oPnU4loCjxJdfiDQPw1fC8R9cI5a7UD5l1D5
         OEOl2qTk2M4jYBNkFuzADK7Aw5Vb3+dxNMytVP+wV1ortogi0v94FXda9kb5Cq3mrF9T
         Lnh7S2xCnWxeO2PIvU0Kbo5lGCbGL3nmbrYnJHR69pRmdBU5vzTtnuiJYbkFpwRXUaa4
         5F3GKcAMS0b+kimUH8/VS6LeiqIjA7psl+/7xi0GBXxNf7T0VDuPGJC2NNJhZMZ+GzTi
         E82A==
X-Forwarded-Encrypted: i=1; AKwUvBy/O7n0VmmtUju0foy3EhNUrQ8aVHXKOgs4+w5QyiiNJVr7rM0njs3t8EOGgOmfR2L7eDUdvR8plIKCfVUj@vger.kernel.org
X-Gm-Message-State: APuU4Z/QmaVD0E63umMJLHjhE9CR38mpakb3HF4N7YWdJmhi9+8rtlUo
	y2vadRZqojG7pKzq2VAceMefJW98G76iOcCWY/51QnAT4F72dE+w5bSNrmLdHb5Jxrs=
X-Gm-Gg: AYBFou2ZM7gz2jERqSqANdPVrjDFvFyST4L8tbNkC3TQDQuKND+PC4MhRdmHDiJ7ckh
	+mkMDRyNy6bIEHHALaNu8A0PSqTEdmVNFdbRB3EPGsm2Zfwv7+7iiSx/befwLLhMQSjczIaJIem
	tcvQLKoQSvD09xyxDgtBAuwqSHG/VVmHpCX5ZwAyOjzos3w0PiNU4AsqWHUyD19/TcemRym5BUJ
	wgEJgWO67QuquT+iR1UTI6RQBaTNYOgEC7oOLOga+4GL5dwPsJnS/2+iZK2oYbXBwsz0MpHmrrD
	RpS5pmnff1rDQHTUyGY5SLyLedCoEVoHVJsbntmcczHjEYcOYppNugoV48pGTt/xfvLvyQXBl/U
	VEEPYVFOUNgJopE/WB9TNgk9QqvtUz6ux6dep82OwghB1HWdMOyeHOXHCGw3kHan3RsaB60lJvd
	uoilijspYyLoGIKSQ/e9fv2ME1PZE9gYKlYU3R+LgEs9WtBeU7wQKdNcrsmqXsLpD+uOiZ8X0uV
	jmyr+/swlqx+DEiyXQby8WyxTsq2U1c2Jj/jspBpziXL5zaenxcmtMXuvj75ODIt6b8HZSxBklU
	qra6VzYWNEneQNWSgGzid8877pqzNpQktNDX0iw9LiMnld7k7gvzBg27a5HyLpHuCj+ze7ICqu4
	0aMbhKkJPNVzh7HLs/oTy508ZummZFh63MB/QE4Cy4Z+hDYQ+zwnkJ141aCdkWvcfDSKBkcOOIZ
	AHnkYP2GrRXhuBYQ9d+pX+J/AxrLFFP98HHI/qrg==
X-Received: by 2002:a05:690c:6605:b0:8b0:76e5:ed0c with SMTP id 00721157ae682-8b2b66f82dbmr68974937b3.39.1793663398847;
        Mon, 02 Nov 2026 15:49:58 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:2f9f:a96f:bcb:6021? ([2600:1700:6476:1430:2f9f:a96f:bcb:6021])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67baf3700b8sm6086486d50.23.2026.11.02.15.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 15:49:58 -0800 (PST)
Message-ID: <ac84b2b863415779536a98a0d0b835e85d2976c7.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: avoid reusing occupied CNIDs after deletion
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 15:49:57 -0800
In-Reply-To: <20261028035919.733823-1-hengyul@cs.unc.edu>
References: <20261015110114.1649059-1-hengyul@cs.unc.edu>
	 <b6f1cb66778d09015ad5862ff273edc37c44ef28.camel@dubeyko.com>
	 <20261021153141.311425-1-hengyul@cs.unc.edu>
	 <1797b66dee80c9553748d4a961470894c917bf5f.camel@dubeyko.com>
	 <20261022120658.1328124-1-hengyul@cs.unc.edu>
	 <cd6cc32dd2aae90b88b4c3d19e1fb35a5be6f4ac.camel@dubeyko.com>
	 <20261023173259.3275078-1-hengyul@cs.unc.edu>
	 <e2ee251e8ad47c6f1e2faf9ed1be787eccf5215c.camel@dubeyko.com>
	 <20261028035919.733823-1-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 2026-10-27 at 23:59 -0400, Hengyu Liang wrote:
> Hi Slava,
>=20
> On Mon, 2026-10-26 at 10:20 -0700, Viacheslav Dubeyko wrote:
> > I am not suggesting to change the on-disk format. All modifications
> > should be in-core metadata structures only.
>=20
> Sorry, I misread that.
>=20
> > The algorithm only solution will be inefficient and it can hide
> > bugs,
> > anyway.
>=20
> The table below is about efficiency. On bugs: in both variants below,
> a lookup or walk error leaves next_id unchanged, so it can only stay
> too high, never fall onto a CNID in use. Which bugs did you have in
> mind?
>=20
> > I am thinking about adding to the struct hfs_bnode (b-tree node) a
> > special field: u32 max_cnid. [...] What do you think? Does it make
> > sense for you?
>=20
> Yes, it makes sense, and it works. I wrote a prototype (max_cnid
> rebuilt when a node is read, raised on insert, rescanned on remove
> and
> after a split) and compared it with the unmount walk I suggested last
> time. Deleting 8000 files in KVM on v7.3 (KASAN):
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unpatched=C2=A0 max_cnid=C2=A0 unmo=
unt walk
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14 s=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 7.0 s=C2=A0=C2=A0=C2=A0=C2=A0 0.4 s
> =C2=A0=C2=A0=C2=A0 odd ones, then even ones
> =C2=A0=C2=A0=C2=A0 newest first=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.1 s=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 3.0 s=C2=A0=C2=A0=C2=A0=C2=A0 0.2 s
>=20
> Both are correct: no duplicate CNID in any run, including the
> threadless case from my last mail.
>=20
> > If you believe that this approach will not work, please, explain
> > your
> > vision of solution in details.
>=20
> The unmount walk, on a delete:
> (1) do nothing unless cnid =3D=3D next_id - 1 (your step (1));
> (2) if cnid - 1 has a thread, set next_id =3D cnid;
> (3) otherwise keep next_id, which is still above all CNIDs in use,
> and
> =C2=A0=C2=A0=C2=A0 set a flag.
> At unmount, if the flag is set, hfs_mdb_close() walks the leaf nodes
> once and writes max + 1 to drNxtCNID. The walk cannot run in sync_fs:
> hfs_new_inode() takes a CNID before the catalog records are inserted,
> so a walk there could miss that CNID and lower next_id onto it.
>=20
> Your max_cnid
> =C2=A0 Pros:
> =C2=A0 - next_id was exact after every delete in every run, so drNxtCNID
> =C2=A0=C2=A0=C2=A0 on disk is right even after a crash or remount ro.
> =C2=A0 - Nothing to do at unmount.
> =C2=A0 Cons:
> =C2=A0 - A delete of next_id - 1 still visits every leaf node (about 3000
> =C2=A0=C2=A0=C2=A0 here); the per-node max only saves parsing their recor=
ds.
> =C2=A0=C2=A0=C2=A0 Checking the thread of cnid - 1 first brings the first=
 row to
> =C2=A0=C2=A0=C2=A0 0.4 s, but not the second.


I think we need to reuse the b-tree mechanics here. Let's use the index
nodes for the search of biggest CNID. The b-tree has this exact goal to
speed-up the search. So, we need to keep the max CNID not only in leaf
nodes but in index nodes too. Do you follow my point?

> =C2=A0 - max_cnid must stay right on insert, remove, split and node read
> =C2=A0=C2=A0=C2=A0 (hooks in bnode.c and brec.c). A missed update would l=
et next_id
> =C2=A0=C2=A0=C2=A0 fall onto a CNID in use.

We should keep the max_cnid always valid. And b-tree operations can
guarantee it for us.

>=20
> Unmount walk
> =C2=A0 Pros:
> =C2=A0 - A delete never walks the catalog; the one walk at unmount costs
> =C2=A0=C2=A0=C2=A0 17 ms here (cold cache).
> =C2=A0 - Only catalog.c and mdb.c change, not the b-tree code.

It's not about small change. It's about correct and efficient solution.

> =C2=A0 Cons:
> =C2=A0 - next_id is not lowered during a mount: after deleting all 8000
> =C2=A0=C2=A0=C2=A0 files oldest first, the next file gets CNID 8016, not =
16.
> =C2=A0 - After a crash or remount ro the high value stays on disk. In my
> =C2=A0=C2=A0=C2=A0 8000-file crash test drNxtCNID stayed at 8015 on the e=
mpty
> volume,
> =C2=A0=C2=A0=C2=A0 more than 4096 above the largest CNID, and fsck.hfs -f=
n asked for
> =C2=A0=C2=A0=C2=A0 a minor MDB repair.

We cannot leave file system in corrupted state. We should prevent it by
any cost.

>=20
> Which do you prefer? I can turn either into the next version.

I prefer to elaborate an approach that will be correct solution. I
think we need to re-use the b-tree mechanics to improve the efficiency
and to deliver the correct solution.

Thanks,
Slava.

