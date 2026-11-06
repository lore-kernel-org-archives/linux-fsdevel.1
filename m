Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974360;
	b=IzxLdYVm5KO1KTlnj1ErJuFGgpN2TS/a+vjAgxGsbd/wQ9cR2cqv8LzIWvdtTfiGdJtV
	 RXg2bO7isrfLWmnvwBlZZH6caI2Jxwr0XYRy3Hi9ARkT0t9kQ/rEp7WfvMFLp0+a9PRhE
	 5i6uh+CuoD1RUZFsTyZDstvDf0HZJ0rFHvA7DfxHumHxBzoAJnB4cdYRrpEEJab7FBu7z
	 F6umvI1t1DB9f8jcAG1hCY+ZyPLlD5BfqAC8f1Ez3Y+9dWQb5JDYyGYBwK/D6NUnAHJV8
	 HdR+11dVlszZzC3Fd7FlkgiwEPNe9Pu/OJkH/bcvlItNjKu4vcpX0D16mxiNrABoJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974360;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hy9Nb6PTTUob6aohVhlErbLUpEbw+NLmXu1l6Sjgt7M=;
	b=rHTc29t08YoSix+N7Mx5Zcltmwh5Xr69tzL128M3ZdTp3FvBO7g4IZBtFBNJukh/kYvj
	 gqN7WypcVkxLx09xm8g59I0uwQd1J+8o3xj3fyXDmb35rus0NSrp4lK+dAq5mnFMM4jAk
	 RFhf00ysVEahakgIEGTQVc6fbkW+iUQN179G47Z4pwSeOnDRH+VjuYD1iuXtSeRSzMJ/D
	 hDukNegXtwaxrFSj6T+qVWF19p+Rikl54rQ+HBba1F9vGFLUthtymKU09Y4Mjh4EYv9UA
	 70P7s/Ce/F6LDQoADKnVIhoOUbGO6HjdyKzo1Tiu4cS5uKm42VCVCKeildxV4rlhy3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzH98RjQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B8606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzH98RjQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF9C1F008A1
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974359;
	bh=Hy9Nb6PTTUob6aohVhlErbLUpEbw+NLmXu1l6Sjgt7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TzH98RjQsHDOqeXhw7sIiddkbUl76gvevZ2XcY843kQ1SCq5N8euopxVsRxB9TIAe
	 rwaJf+Rut6RsXnRzA28n5d0Hr4+eMNEjyAnfLRu4UShUUAN/jwWKql4t47hRzpu6DO
	 Em3hWPDhvGt3eDEUiZv0euYdchAOf1WS15AgvkKqWIt8rUwgFO20KjGBGOyHxT7QeT
	 T/1dxLzTDMJZ4iJXCwp8JbYF/mKTSaTDlbBWXOI9h/pdSkxpvjI5Bz+CeW5njrLrxr
	 3L6XLS4cEveqTNRoakjgnBrNH55we73pSdMmq7UjiIHYzhXfsOpan383dscrdzvQxl
	 /OOvDsNFsoWnw==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67c05273c38so662245d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 06:12:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFUXz+v0g6lQDoMhWpERN87nJKA4vFCa4fFs0+cxryLzqHj3xrwvFgx+JjMWkypczmqMlHn/gCbLnckyvd5@vger.kernel.org
X-Gm-Message-State: APuU4Z9vR55rY7ft6P5F4PQvBPkqmpMbc29l/Y1h/zZ889xwjW+oBJUN
	PAlby7Y1LhehTxBsYCkabHd4J1V91+xb4AHxl3uwXWlUimgaWEaziRjqxDHnPX+iWXbMgHaJ3Xz
	fO8aYqYX02CGwjgoyzBaoGZv5g51wbVQ=
X-Received: by 2002:a53:e808:0:b0:67c:11a9:bbfe with SMTP id
 956f58d0204a3-67c142c4275mr1111242d50.20.1793974358607; Fri, 06 Nov 2026
 06:12:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106124553.2617026-4-wahidzk0091@gmail.com> <20261106133110.2659482-1-wahidzk0091@gmail.com>
In-Reply-To: <20261106133110.2659482-1-wahidzk0091@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 6 Nov 2026 23:12:21 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
X-Gm-Features: AclHuK_T2DQUMc0OEmrubLWb5yXs7ugphPBK2FPnifKmAkfBBAp1bb89FaW0bos
Message-ID: <CAKYAXd-68oCuAU=x0TV6BMsNJZkmBcdVZTtOQXh3iEm6BptJSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ntfs: do not convert a named $DATA stream when
 making room in a record
To: Wahid Khan <wahidzk0091@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:31=E2=80=AFPM Wahid Khan <wahidzk0091@gmail.com> =
wrote:
>
> Hi Namjae,
Hi Wahid,
>
> The Sashiko review of 3/3 also suggests skipping every AT_DATA
> attribute in this loop, not only the named ones. I'd keep the unnamed
> case as it is, for three reasons:
>
> - Converting the unnamed $DATA from this loop is what the loop already
>   did before the patch. The patch only stops it from pairing the length
>   of a named stream with the unnamed inode.
>
> - The lock order the review points at (mrec_lock held while
>   ntfs_attr_make_non_resident() locks folio 0) is the same one used by
>   the direct conversion near the top of ntfs_resident_attr_resize(),
>   before the loop. So it is not specific to the loop.
>
> - When an EA or a stream grows in a full record, converting the unnamed
>   $DATA is what frees the space. Skipping all of $DATA would turn those
>   writes into failures.
>
> If you'd rather drop the unnamed case from the loop too, I can send
> that as a separate patch so the two changes can be judged on their own.
I think making the lock ordering consistent and using ntfs_attr_iget()
for named $DATA would be the right approach. Please check it if you
have the time.
Thanks for the patches!
