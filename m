Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968063;
	b=PdSXh6J+Cscr2ZuNhT6LspGzWl7Wu49dk/0/XdAmntpjUfD9Q9xeeG5S2fIIYaa2/Q7A
	 y7pEOTs8sfmX9tl0j3PwTm8+xnD1XOLTWtz0EGz0c0580GzUkThg1uuYIJCEQPB/8hPS1
	 MNpvaeWpcasN/9/0Htr1ZCK++nufN9skoANGNVSHjCXP/GeMeEYAbt7ager1luRF1d10j
	 qAYvWy+4GcNOCKc4D+kDoZD1aDZ//Ui/hscRrBLTncwnMWtohynWzlBbfc3emvXosW4gZ
	 eog67raRhmcTI1R4WQmUgTY9w+EEwrmkkWqU9hiqTeMhU1zIkhNnsafWr2OAJrX/XZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968063;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gXaYki6uWSOGEqG2nnwjkCld7NyYwmbFRUn/nj+UBJk=;
	b=4NNTiwQwP1yAkoy9zY6KTJGP1N04pVZ13Va3oWLaJrKMan3IlYOOC2I/Iy6Jr92MhnMD
	 ErnSF3m3f3KrQS/MvOV34fcOCgamZUI0m8fwy7n3JIkgUki6pgMPBEVwpTG5LatU5NORe
	 tSVoTaB/1cD9aKVyaVtiH9XcRK2yzPdNAz1KvHicFVqZH9W5snZkp6He+KImQwJBmeATL
	 2nhBUGI187M+pGG/7VP3Wri6OGtlJg6JWX8uCX+iVksrHPrQ8kCMiadqUNRAnKqHPk3FV
	 iB7BPu5rju7eOC/M1YBE29dnhflcR8XYcpYCV72oTCV677f0VEUf0F32JZRO/K1g/qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRCNHhnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E2606A335
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRCNHhnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263211F008A2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793968062;
	bh=gXaYki6uWSOGEqG2nnwjkCld7NyYwmbFRUn/nj+UBJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WRCNHhnjK2/U6cTw19O5vG9KnmkI3EATjgbS8Vp12vvdhMZw0bS6+u2k25MpIX5OL
	 DijLA0057PexK4ZzikC7TgmkBtj2z12XbLzUGW1HtdyFQM7tci5jDlubuBkxlYXlVW
	 e4FxoCwwLEn+FCeZwcv17e4QFwMJv7QlTSaT3WvBrn4YjYa00g/SxWMlat3hOZtwzy
	 jtfgUoSW489vYcpneHL6LHI2uSsRtrRndthhPlDUwBXQhtZt8S5+7nyTNxlEccLcsY
	 pbB7E9esK+k5zo8A9LhxD0KUVVz3dYp249aLeA2wpE2QfWs7O8vYd4C4rnePrtv72K
	 AJEfXS5X32zrw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso742095a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:27:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzI/oeW1afNDRnPDqY84Yp+BOG/3U90R3bpFEYSzsJSNe1vyubXwUu99hwrT/3ssxEJdpnqOGmhDvfFbRQR@vger.kernel.org
X-Gm-Message-State: APuU4Z9fdUQhUe0ORCEmRw+6VuidBsfL/mJ1MU+6T1Muru21wMDDaNO2
	ZOEY1Fbo6GNNOwbt0H7foVnlj4jYNZk7XzTZb+lBjMdKwd+KmoFUAMaHO06urM/NYsxUTWeTuEg
	6sPH3QD48CR4j2pfSfnrZ3IzTFSuymrA=
X-Received: by 2002:a17:907:1b2a:b0:c42:102f:15e8 with SMTP id
 a640c23a62f3a-c4d35413244mr208015366b.14.1793968060730; Fri, 06 Nov 2026
 04:27:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106091420.2461683-1-wahidzk0091@gmail.com>
In-Reply-To: <20261106091420.2461683-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Nov 2026 21:27:28 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_te6K0uKmJNQDzi9E5=-wqrQ6Vc7MP_cZpGCQZK1JaGQ@mail.gmail.com>
X-Gm-Features: AclHuK9pyTUmpj4YjLkVERCMkUy0IHDLyx8Ch1ej0-bKsscvef4Mm_oafumewPk
Message-ID: <CAKYAXd_te6K0uKmJNQDzi9E5=-wqrQ6Vc7MP_cZpGCQZK1JaGQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ntfs: three fixes for crafted images, found by fuzzing
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:14=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> w=
rote:
>
> I fuzz the new fs/ntfs driver with mutated images: an image from mkntfs
> populated with ntfs-3g (directories, streams, sparse files, long names), =
a
> few bytes changed, then mount, walk the tree and write, under KASAN.
> Three problems from that are still present in ntfs-next (e62b384ca).
> Each patch has its own trace and the reproduction steps.
>
> 1. ntfs: do not read an index block outside $INDEX_ALLOCATION
>    A directory without a usable $INDEX_ALLOCATION hangs on its first
>    lookup. The task waits for an mft record lock that it already holds.
>    It needs one changed byte in a crafted image.
>
> 2. ntfs: open the index allocation before reading or writing an index blo=
ck
>    NULL pointer dereference in ntfs_ib_write() on link() when the lookup
>    ended in the index root. This is not the path fixed by 9365c4a1357e.
>    It needs one changed byte in a crafted image.
>
> 3. ntfs: open a named $DATA stream by name when making room in a record
>    WARN_ON() in ntfs_attr_make_non_resident(). This one does not need a
>    damaged volume: a file with an alternate data stream and a full mft
>    record is enough.
>
> All three need an image to be mounted, so a crafted image, not a remote
> attacker. I can send the images (about 380 KB each, compressed) if they
> are useful.
>
>
> Wahid Khan (3):
>   ntfs: do not read an index block outside $INDEX_ALLOCATION
>   ntfs: open the index allocation before reading or writing an index
>     block
>   ntfs: open a named $DATA stream by name when making room in a record
Please check Sashiko's review comments:

https://sashiko.dev/#/patchset/20261106091420.2461683-1-wahidzk0091%40gmail=
.com

Thanks.
