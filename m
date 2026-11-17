Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914162;
	b=uPhuTLDQ1SWBYDLnFG0tH69rzBOoKOFmf9BmSNw6dm9O5u8kdGh3mVxvqMju0Ehvam5O
	 avinWiOsy4efvJuollSSN2MJm5nR5xHXUhNsOk88wdvY0GVPbQTFt2/yuN8mx16UA0fct
	 gI0oJgfvMoLXNdN7pj8XK02aIUlK7H0apMCiO3m7NUcObqrqEjbWVUppaMKhZbA5Jim2K
	 O2xaE+uD+IPb0NTJ7DZMsnMRBuj3I66bY0LKdqRdp/LE7vvd7EXM8NEMz8Nmi2CgmP3eC
	 OLozRVOJrPYKflSZ71ioS4z1VZ5Zh0SgXsqApfSv+xZN4E+VzsUPC94f0Ow++P+i2zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914162;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bfBKw5Dqe7/QCgl28CEIM4EiUR1wvD/Rw1mMg1W1wSQ=;
	b=OT80uJifXfS7kKB4dTYOPvi//g3z0bnD1bKLjngb5LFGXhvFMWfVAnBS8EBYzkflhERl
	 Bvq5YJjeQasnmm1Ca7zGj5wsWavP18UdckIWw3qLAjmiVFuklIhCozATpSz1UYj3eOHh2
	 ysVwMclyerlcukrbEIEHhJ0YaCa3///L1ySvpTdriQt1ugTmTUsjHeB5+nBtoL6h0Ezp3
	 PMWYpme3cSfXGBTndfmvmV46EPPlX6RrQmMrbFnMFcFDLSxpnr/dUXwzohEyLjSo1bUjz
	 ReGhqBwWM4wF7PqQxJynUQp+QVU5ZfFD4w0G8kGscDq7/6b/P8reoVYgwUg2SST2aog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlkbXgUU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9A606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlkbXgUU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC8A1F000D4
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914161;
	bh=bfBKw5Dqe7/QCgl28CEIM4EiUR1wvD/Rw1mMg1W1wSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YlkbXgUUQRhyrxgpsJ7Qvml07CSWbgUu8B9MBcv6Rb7T7SWdq8Aq1SQrmZk4EnAhp
	 TcmeQ1ddK4h+Pu6rPK+bVxj9nTENOoMDtpxr/d7pzn6PP0stPZXXTCeTk/x9BdxWok
	 By92sXJDNTF9T+YZxDMLuMMgthIA0MZbqwOtlsHUtiyjq7qF12Dwctp5QuSSU1oZ62
	 3mIGTmaU9HYjlOR/Mw83mXoVkeR8viHwpqjJvVoFTQ+3NlPR3N4Vfq12juTxVu4Kvy
	 pNy7xoR8tcMopGP9TY5NVo+AKp8eALuZYTDKFnCrTCR9bJzmyt4brkpbKPdrhEUdpo
	 BZpOOnX6mFrCA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c40f29667e6so793284166b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 03:16:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEiR07gFjRnPvKOXWZlyFVI4sxQpFMfd0+1NqJhjobXQzIFBSlJyNs9RvuZ944Rl4fqxZUJwIk0o34i6KCa@vger.kernel.org
X-Gm-Message-State: APuU4Z8UZ5fbRIwvvKmq2axcsVx5H1xXztmq+cOsAAkZBbGuf+8+dZr+
	ty5cWjWs3JL01d/Deao50t8GBxXAakV9ZBkDKO1++orM5PlTKWwW+GnfhG/HLhJq2MaQLhL3H9z
	E+JAn0iQOXK4A7VGdVoM4urSUJPW7t/c=
X-Received: by 2002:a17:907:3e9e:b0:c40:4848:f7fa with SMTP id
 a640c23a62f3a-c50965421ebmr1168834366b.44.1794914160376; Tue, 17 Nov 2026
 03:16:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116085752.3908082-1-chizhiling@163.com> <20261116085752.3908082-2-chizhiling@163.com>
In-Reply-To: <20261116085752.3908082-2-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 17 Nov 2026 20:15:47 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_wMVWSp1OZox-dF+G9x3seF1pTe436Y5dhR8LAqjtPdA@mail.gmail.com>
X-Gm-Features: AclHuK_g651WVLWBvZ3JkfDxJ0juXOGnsif_vLCZ2PuPoqhZPKjOh8aIm_6kPfQ
Message-ID: <CAKYAXd_wMVWSp1OZox-dF+G9x3seF1pTe436Y5dhR8LAqjtPdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iomap: export iomap_bio_read_folio_range_sync()
To: Chi Zhiling <chizhiling@163.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	exfat@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Chi Zhiling <chizhiling@kylinos.cn>, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 5:59=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> Filesystems that provide a buffered write ->read_folio_range handler
> need to perform the same synchronous bio read as the default handler.
> Move the declaration of iomap_bio_read_folio_range_sync() from the
> internal header to <linux/iomap.h>, together with the !CONFIG_BLOCK
> fallback, and export it so that modular filesystems can call it.
>
> exfat will call it from its own ->read_folio_range handler to zero
> the stale bytes between valid_size and the end of the block under
> the folio lock during buffered writes.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Christian, if you apply this patch(1/5) to the iomap tree, I will
apply the remaining patches (2-5) into the exFAT tree.
Thanks!
