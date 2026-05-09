Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FBF2580D7
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778341455; cv=none; b=DXfD4jtVmL9DlA10cGYccCvDCchurW2zGKuFxLjKV52oRvQ1+5QdRXKKlteAbCHJrNtWyZm8yuoLte0/6F+iovN03GcWubUNAAkHQjdqo/LDphAr2mbnG7LO1xwhA1pcrEAjWV3txbV6seC9aHWrsLqEj43CdciLHCBicCDZgHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778341455; c=relaxed/simple;
	bh=zx+jjfeM5N3AHqyz2ClYPMSgOXQnk7sBsjUVRyJxx8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLeEZgZKeb5qAuypGmyEzxMTzMmG7G6dBLAW/COtawcTT2hn4KOUOICQp/LfuIrUwH/8rYRZi54Edm6y7+gY5L3E/kk4ZKII9Rzv65u2HhqpNfHUYnUMSQNO1n/ghIvGPW2qQO7awsL4gATkWT+LzgxX9ULkFJnnee5Y4x5BQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5CyvHbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5CyvHbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094DCC2BCC4
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778341455;
	bh=zx+jjfeM5N3AHqyz2ClYPMSgOXQnk7sBsjUVRyJxx8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q5CyvHbWwThf9robCewkgWsRzHDtQBGdeu2pt59mlQzpSkpGn9hcxRnZnNN2ro1D9
	 9WXW3KTjc3V2XOu/oqsuLZpcoC2TTWY3bqkVcWuW2jEItAMRfCUToxqMtbe2T7It7y
	 XW3mXZkiYKFFxu4VrMZh5Ozc1WxJm2dT2ULSv28EN2xvIuckTTC1Yt8f5uHMzkMv0d
	 TLsTEcvYx1784fG40auoyo6nVVAH4t+cA8filWEgw8Hf9p/R63xTg38vyx6xBElmtj
	 N7qdF+5u5ELgHp8+8vZg1rtYNVFrV7Zut3F3wii3mq8awoeLFpCG1vY0QpMybhdkpd
	 xd/YyN4Md/EjA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f97c626aaso508769066b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 May 2026 08:44:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+4OEviJ+VZgcflr72YnhV8EMKWtSycYcvs6MvvsUZ4cslvhP6Tapt5ILqpJfBie3EmumhdJ8DChos/GhMg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rzk5XEzuxkME8ES/IwZBglBJVeBbTTWuCMZoN6nlRPhgcZ1n
	282xz4TqgeDvW+p8craHZWeFyZ1pwM4frV9dwUK5BfouFZjD5zaAeQFrP/6JXvig4byqOSbMtUN
	wnqNXSukjHobhU7Tl4Ca2OnrWNiJr20Q=
X-Received: by 2002:a17:907:3e14:b0:b9c:7dc2:e464 with SMTP id
 a640c23a62f3a-bcaabe3423fmr414966866b.21.1778341453578; Sat, 09 May 2026
 08:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508153410.2624801-1-charsyam@gmail.com> <20260509061237.3233714-1-charsyam@gmail.com>
In-Reply-To: <20260509061237.3233714-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 10 May 2026 00:44:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-A-s=FZx+98N_6rfi_zR5-wUdWm55G04mpeYm+sx=9iA@mail.gmail.com>
X-Gm-Features: AVHnY4K93qo4iSt4VRhRSTSX8hvzPiaKTanrhYeWmlN5FW5L19O_yEvLqh6wSvQ
Message-ID: <CAKYAXd-A-s=FZx+98N_6rfi_zR5-wUdWm55G04mpeYm+sx=9iA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntfs: harden MFT record and attribute parsing
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 3:12=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com> w=
rote:
>
> This series tightens fs/ntfs against malformed on-disk metadata and
> fixes one off-by-one in the MFT bitmap scan.
>
> Patches 1/3 and 3/3 are complementary: 1/3 rejects MFT records whose
> attrs_offset points past bytes_in_use at record entry, and 3/3 moves
> the per-attribute name bounds check earlier so it covers the AT_UNUSED
> enumeration path that hands the name pointer back to callers.  Without
> 3/3, two enumeration paths can read past an attribute record: one in
> fs/ntfs/attrib.c passes the returned name pointer to ntfs_attr_iget(),
> and another in fs/ntfs/inode.c copies the name while building an
> attribute list.
>
> Patch 2/3 is independent: ntfs_mft_record_layout() rejects
> mft_no >=3D 2^32, but the bitmap scan in
> ntfs_mft_bitmap_find_and_alloc_free_rec_nolock() used '>'.  Bring it in
> line with the other 2^32 boundary checks in fs/ntfs/mft.c.
>
> All three carry the same upstream Fixes tag (1da177e4c3f4) since the
> issues date from the initial upstream import of fs/ntfs.
>
> Changes since v1:
>   - All patches: replaced the OOT Fixes tag d3ad708fecaa ("ntfs:
>     Initial commit") with the upstream commit 1da177e4c3f4
>     ("Linux-2.6.12-rc2"), since checkpatch flagged the v1 commit id
>     as unknown to mainline and all three issues date from the initial
>     fs/ntfs import.
>   - 2/3: removed the OOT-only "#if LINUX_VERSION_CODE >=3D KERNEL_VERSION=
(
>     6, 6, 0)" guard that surrounded the folio_unlock()/kunmap_local()/
>     folio_put() block; mainline does not need it and it prevented the
>     patch from applying.
>   - 1/3, 3/3: no functional change.
>
> v1: https://lore.kernel.org/linux-ntfs/20260508153410.2624801-1-charsyam@=
gmail.com/
>
> DaeMyung Kang (3):
>   ntfs: validate MFT attrs_offset against bytes_in_use
>   ntfs: fix MFT bitmap scan 2^32 boundary check
>   ntfs: validate attribute name bounds before returning it
Applied them to #ntfs-next.
Thanks!
