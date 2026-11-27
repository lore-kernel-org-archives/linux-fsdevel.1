Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795781098;
	b=mdqFvI3pPZlI/r4cegY78DGi19oZuimksiURVScVAqcdjKiOn65nrLxWDiW5TGtpvPTi
	 +pEBBojorbg1B0m2l9YSPiSFb2PeDQV14OaeTyYFrWdNjXwJAFN6MAXpTqUtqkwD798WL
	 kFa1mMxDW/biU4p2dEIHBFs0ronTmItc10P6tXu3lfzPHzyhedu3O7M/HQOSOHU7SICVe
	 G2mlr+qLxXZ7+hS5sSQtckC8LzZzx8nqo41DUB/ARa+g5CfnepFFGfERvex1ABZR/1ELK
	 tnN6pvXB8oSOKr2jx7NCk+8gP8HKuniKVtzp2ZqdyOUOBgc0RAt+xFpt1bto9dfeFkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781098;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ftbPRsCQ0aqf0DRrrjwD4Al8a/o+mRVmt2zUH0Y6zDA=;
	b=MuyIEqR2baq7kU+i7PMgRd0w1s6SmSImHmYoxfSn7t0vY4ta0HakgsYGjW1dhQq86VLQ
	 xRYrt205xEn/qmVn67C9GLa8xFrK2pMU96AZWy4H52EZUEUgoFxEP2hTjhf56drObU/F+
	 5VWFlNjc1cyA1Txa7eq6K2WesYR/N5jUg0RbCrfi3lmZ520A3NJx32BGG124rpu8Rs7Yh
	 Uc12t805ByE2NiwuiXnbDfbqxSOHnjTIM/xmf2cWRnsWgBobxpAdbHM4M/hYT/0YYkH7C
	 Jj+eel/Muhtdrp7WxGt44WVY6UqFqKix0Fqmbk+aohGZtxPZcjC7EyKO+7F2UUGrpnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a/faIOem";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D10606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 12:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D10606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a/faIOem
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso10613047a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 04:04:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795781096; cv=none;
        d=google.com; s=arc-20260327;
        b=khhj6jUs5tsyGTOeng2MPQcwDK5zxqrOdCAiQicaBVAckO+iOf6BqdR/XwH1Gg1/sm
         kvk8QH7Sv7fhsyljtUPx2zutCPucfEKofaOC7NDG0Mj+EruEkgoCrhYCqVMf/gAVfvQo
         FW4Le3goxBbDscygPfd4QCu9JTMdW14bIdZbyrNbifnvx3m4GkQN4bngjycN1NPaMkiS
         RgS/1c9AERoUlGMp0Z0oyJn6qII+BE8EKxxnCwrQxq0VPSkU8nV59OuihYjYWi6mGTDa
         DUeaMfraMCcFSIkn+E5pCr/pW4esK5J8FOmT9FoRaOAGhp4IiKlrbU7ohM/2Wf3kj7uh
         hcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftbPRsCQ0aqf0DRrrjwD4Al8a/o+mRVmt2zUH0Y6zDA=;
        fh=vFcGk7Id9KYEzBWPYPpIoKL2wVyDKc8dBqZZqPffrnc=;
        b=VzQEZLxuJPe6WUpyyOkiGZT8x+D3/cA/DRAeJamSD8RNZwBwjDSQhpKuJubgW8xH1T
         mFAXGudv91adjJfFD3Av26M05Ij4JeG3DDf3Ay/WrDp6KLjcBud2sfwqcqYN7yShb3KQ
         Vc6Kl3/j/B7gCvFxUkiXKI7N4Ey20XKY07Qk9QL9807kQNicGwUcL2WRizUZ9NvFAEqA
         isVfCdUEvOSUuYlmy8RUwyraGY4IsfqjWV9Eau99R/kBzO6QKaqS0BC+m7EGK2dKaIZm
         zYurFq5c3Hn3Kn5dmguS+sFyW69XIhxGePWGgr45yvBXFL1qOhgTDk5UozcK8NIZky8E
         4EQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795781096; x=1796385896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftbPRsCQ0aqf0DRrrjwD4Al8a/o+mRVmt2zUH0Y6zDA=;
        b=a/faIOemKG9XP9oN9nHZ0RXKAJGUuULcrj5tlG5oW/VxoETGk/czdvSllhhNf3cLZ9
         QZfgoKUPAO+lxAeT39SzbkiTrobrvkwTRilpOiRfynBTw3Dq4mQQOsaPpO2q3L/eNCw6
         75tG8Way+N5Y7kNdc374kxwLxPpgXrf4M3aS8Tkoc7ZPyjzg6Rzr+n+Pscq1n8ZXh53X
         8gOnoWD+dlS10yDPmY1W05uiGKpWUmd1Zb6pGB8AYpx6o/RFlMqxj59WZhRkFmmQMlzf
         d6R5FFbL3Np6vQDGcBL5tFUkX4TUGEgF/3bqMPd6LQvhH05HX1jyMVN8C3RNkqypH2BI
         RiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781096; x=1796385896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftbPRsCQ0aqf0DRrrjwD4Al8a/o+mRVmt2zUH0Y6zDA=;
        b=GPfOTkW3yjuzCSlIgLjfiz1HqOnLCp+BRS6YmtCewahqSFkO9DIbudwizkiR3RnAu6
         49x34VIaa9Blmb5AnQyWNdkob+O6nuinSoeOXXu4SYYYWvarPL15bv87H19U94QnIECq
         t+paVovXjSH5r6MCM7lpkVFwrHE+ZCKQCp10KfTvg1tfMFwxB6h/9Mgb2KfLF65+T810
         5voopIIdIF86A/VFy5Zqg9SE9HyjAywmyLYDHC7BCgJrr8e3fDui9xVCweVa9mQXC37g
         PoRRMb9HIZFUznTxkk7HuhIbr7C1e8/mmS80g/gnvH0nXxdAggM0gPOMl7g+VrGXI/kd
         vQ2w==
X-Forwarded-Encrypted: i=1; AL+hErEMwj7mK+TDsLxwOlW8+WAjhknyNRtYAPeKHNe8NH29XH6K6wydXfqe9keKXhL4NT7MhDv0hPivJ385Da8m@vger.kernel.org
X-Gm-Message-State: APuU4Z/H2Pwt5qsZCcYWOJCZc/O8aNogjG4HfoJ911LoJvExJAfz78bw
	Jzsz+oNoMmFsF/5arLneY4rJqp3M1DH1+fCvAB1ID7FDCleBrI8Xke5VP19cJ8nJNcLe/FvYLuG
	bHVmY6fOSZTtsgYVEf8Qr4sVeYg89s/g=
X-Gm-Gg: AZFdTZeHUq2MwLGf0J0iwhimyd6RqxxpVOoXAx6AqkdexhQTSA+NX1DIteTtyCm2gta
	7RcaEqwvFY2pDq2Bz2+FnYlxwdZXRJOf3FGmC4CuBibQWlUG/GgQcEXgVYTNXXq2QTP3XNyFNwB
	mx9rCF6FNyT1EtoDxj5sH28heFbYhROrFMisT5mMfMkEHQ9HLFua8+UU1q9gBwKuXpbT8/8qqzS
	iUwnVGkhIICQhfSAw6da7DUA7r4EJcc46+kQZAJSEy24uqGD+HIqQa24hBU2xtAZXyqKOMPCSYp
	aRR4Y+yvD//KESP4iRR337YquUB6TWRxx+FHK4BehvdMdP8fr44gydBF4kGpqmh9k0CxcaaxJQ2
	flElTb/no3QOB4pE/cXPgPHZHgiMHYU7Qy2N6rHK/K5lbASqCebcMF9o=
X-Received: by 2002:a05:6402:320f:b0:6b4:59d0:7294 with SMTP id
 4fb4d7f45d1cf-6ba37e9ec85mr20367582a12.31.1795781096175; Fri, 27 Nov 2026
 04:04:56 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126163114.403846-1-koray.fra@gmail.com> <20261126163114.403846-5-koray.fra@gmail.com>
In-Reply-To: <20261126163114.403846-5-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2026 13:04:44 +0100
X-Gm-Features: Aa3M54qEfB_iTiJNZjGRc3XRinkgqc1ntuigIkhA7BS94_VSwwZ4uoMmp26Q3TQ
Message-ID: <CAOQ4uxgJjy3TaORBkMOdef-JvzX2uA5K2sbMDEcLqmpkedsESw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ntfs: switch to the new xflags fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Switch ntfs_fileattr_[gs]et() from the legacy FS_*_FL flags to the
> modern xflags (FS_XFLAG_*) fileattr API with masks.
>

This is where the commit ends doing what its subject is saying.

> Introduce FS_XFLAG_COMPR and FS_XFLAG_ENCRYPT to be used in this API
> upgrade.
>
> Following the FS_XFLAG_VERITY example, put FS_XFLAG_ENCRYPT in
> FS_XFLAG_RDONLY_MASK and in FS_XFLAG_COMMON, since it's read-only for
> all filesystems.
>
> Following the FS_XFLAG_CASEFOLD example, put FS_XFLAG_COMPR in
> FS_XFLAG_RDONLY_MASK but not in FS_XFLAG_COMMON, since it's read-write
> for some filesystems and read-only for others, to avoid breaking
> existing filesystems.
>
> Also update vfs fileattr_fill_* helpers to include these two flags as
> well.

All of those non trivial bits deserve a patch of their own.

Not only are they independent vfs changes, but they also have
implications outside
of ntfs which need to be spelled out.

With current patches, I think this change now advertizes COMPR|ENCRYPT
in fxs_xflags for all filesystems that have them set even with the old VER0=
 API.
That may be ok, but it needs to be spelled out.

Do we also allow to set COMPR via VER0 API? Do we want to?
These are questions to be asked on a standalone patch.

Thanks,
Amir.
