Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534486;
	b=JosLRU80rbKzpZ/6iR3bYzFR9/+3sI46XoIPsrobGY2KVzDb/d4BtBD2KSk27PTO29mf
	 7P9mZgpxDvAIen+y8kXOZ/G0XOkFaEc6GG9L52CI9IlycVdOQo9vKItqfGkU3V02f3+78
	 knsP2c/Ox5IS1POz2YsVI1eJb3KLVzuLtDEF2WxyEK8kXPluUOZHmhCN2Vu4s86lwLHZ4
	 +0l/3W9ANzpKLhdr9RiKKCoaVhFZrnjoLS+z20+K7VjSb3Ku/IzWGTJgFYXVemE4NJf1V
	 JNavqAnvYxB1auP4bC7W742VdBS8IwpsPizEfe0KaAU51FiHQqlHbOsnOzMcNl4Bwqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534486;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kIHGiaaw+w7x9/tbZ/OjYKBZiL9aSPInsuX+o8D0KRs=;
	b=ZObUpv+fZIR1Af/kuViXwmHhxaBBK+0SWbUI22K4InZtOwwivSsAghWSUBSCwmm8m/k/
	 utbq9ntBmnZ+epNfwV2uFVYAXLmcgrXju594vXn5l1mgRqyx+3VMliDbMXXosm1iwrf0d
	 gpYZ2b8uP1YpK5G7me13a4hoeoU6kpD+N/C1urkd88+x7SdIZCNByaAP6w84l4yFBzC80
	 GYa0c1R86NL1tyIchH99mT3khGN4LEyR5x2OT+ZJ4zPSkWM9nr1BL8SqrwHxT0yH3yAdc
	 N3FPhR8w4UuoN//811TlSA1t1Kq3MgTb34oYqvEMdmXMHRWK0tvs2/slRjbUb6N2hHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHUYgW7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6B606A327
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OHUYgW7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106971F000C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534486;
	bh=kIHGiaaw+w7x9/tbZ/OjYKBZiL9aSPInsuX+o8D0KRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OHUYgW7AIGgFutxiMjaHHJ2arZeFjSzsUnaf3dN22QKu2WwCAXjyEIoUtO3xyDgGF
	 Lsgetcqg8fwSwsbc132jCsn2Z5oqltgpnSj7QWcufnDQw3yUWCDmNAxQQ7dAoWVm8x
	 /q/AOMYBYAeVeYi0dt++1vbJiU7qBjuenNN4PA00zVORC4kbSr67bcEeBybQpe3c5z
	 HPphIMc6Y0yTBS28i6keUBk9FI89QMrhv2ucijh61KFZF4HHbZ37sNEj7/rVr0/A3n
	 iW+tjnKoZvTl47lGK+O1EpkiOg1YfFljGMUq7LbYDX+8rZJf2qcn2Fwf0rwj1DFTKM
	 8xDiO2eMbW/9w==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e30c26a4so80540166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:48:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE3DnL8zW+MGvjC2dvOLa3YG2WpKJE5ZoIoF7ueW2fugOTi8bTQaX15CxhSixHPvhisSxhO2oKpPI/mlL+/@vger.kernel.org
X-Gm-Message-State: APuU4Z/IM1BUwyidzTzLpxlwOEkGQQptkYRKeDihj9pcVm5yIu/rDlU/
	uR4wpCLDmN2t0e1hIyjuHpSsVKycobKPfFzKrh6m9RXkHGbVGxLBYfySs3j0XMToWyk6jgzu+0e
	IMBK7driLzVua1I8jM5nhNIdM+CgdWAU=
X-Received: by 2002:a17:907:72cb:b0:c42:fc8b:6c6a with SMTP id
 a640c23a62f3a-c50963841e5mr68070266b.14.1794534484673; Thu, 12 Nov 2026
 17:48:04 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKYAXd-n+zGBq4i7rfLyX+_Y6zEMLTCCqb2vAgcnmavqKxtiHA@mail.gmail.com>
 <20261112074055.1876311-1-wahidzk0091@gmail.com>
In-Reply-To: <20261112074055.1876311-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 13 Nov 2026 10:47:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8YHe4AcSM3Ch+8PseXAXxqzLvB_njNgqGCUuyVe4prOw@mail.gmail.com>
X-Gm-Features: AclHuK9nAzXNzVpFrAKkcdAMUN1l4AwVNbPKXYvvHImRlz9ZPtI6TOIlea6DG_A
Message-ID: <CAKYAXd8YHe4AcSM3Ch+8PseXAXxqzLvB_njNgqGCUuyVe4prOw@mail.gmail.com>
Subject: Re: [PATCH v8] ntfs: convert a named $DATA stream safely when making
 room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:41=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> =
wrote:
>
> Hi Namjae,
>
> -EAGAIN must not leave ntfs_resident_attr_resize(). The callers return
> it as is, so a normal blocking write() or setxattr() would get EAGAIN
> for a "would block" that never was, and index.c already uses -EAGAIN
> internally as its "redo the insert" code (ntfs_ib_insert() ->
> resplit), so a stray one from ntfs_attr_truncate() could be taken for
> that.
>
> -ENOSPC is what this function already returns when the attribute does
> not fit and cannot be made non-resident, so callers already pass it up
> as a normal error.
> It is not exactly true here, it is a short lived "busy" and not a full
> record, but there is no way to wait for folio 0 at that point without
> the deadlock (the reader holds it and waits for mrec_lock), and no
> errno fits better. I can use -EBUSY or add a comment saying so if you
> prefer.
Okay, please use it here.
Thanks.
