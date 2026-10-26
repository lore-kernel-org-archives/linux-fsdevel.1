Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793054808;
	b=TgsxZCnLUvCn8a1iBImZy4slj6LHQLOB70iZxLk2v36jcr2W//uJzRcyTFLR9pp1MjkE
	 M7kY5MRjrlejezzzUYg1EF9NrWqi8+i0zL5x32+bN8iN5MuQr2lRPr61DgpF/45o6d6As
	 G5rJIh+5B86LK9wakuxbLQRWlvHiomvOI4ZNX8uBVXhsvWanSdBXhnQlDj33teuAn42NP
	 v8ORwIcqF09mmClCbcCMsX6AUJO4geEDPgzBRd9MpGMvaX9zBWNiG7d/CddKulClWw62c
	 ZZ57KyEJBKjYu+hpx8RfP0k5xZogOBlyx6Cg8vFyiET+T2xsM5iDOzZaPR047ZgmY8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sKnr+HaOzY7Irrp2H9F7r4w2uph5h2kmhEeFaXwyEMA=;
	b=G/MPA+kiKiP8WLoRbHgkTRros9M5AUxvmBnxdaXlG2ITd4oIesDfmMdxGJ6L/XOFPECd
	 eqG4U0sVmzarLOuBUIJ3Z5OYgaYBOkEA1GHPIA1zHJHffX8gYZOk+1Z1+ulzn2XF5FJ1Z
	 yEUMX8GORAXBIYccsYjUA50ja9pk/omNldxC133pbh/khFu2yqKDKZY3z06i5d/TApUg5
	 CG+Vu3/HsyG6OKo0xW7lqsvVV7cPM1niNSVrNIRgplrzejxFEJ7OXvf123umzguwANVIV
	 8h2ENM5hKuWTw2PTLN+WeIF68Q34vDU79A7hp4rrmCa8A/2HjchyQWK7C4QnFqrNJEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=IOFsVvG3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870B606A320
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 22:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4870B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=IOFsVvG3
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcc6094d7fso2766049e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 15:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793054806; cv=none;
        d=google.com; s=arc-20260327;
        b=W2+UPnQ59iUF9ssSrZvtIqCNhbnrzxLKbc6lPZdT44A6Uo0UzdebpxRNET6Go6ZQsj
         4pzs3MghUMKp9cUjYChQrqQSy/4xYTaD52x/VWMN1Xy6B91RyuiYE/TB2Nnw258duFl3
         mGnjoJUoXcOusqy82gtZTQc37r0WhmrBl3H0V9BAMmBpw1EISMJuf+y6bNiCbVFjke6q
         60dFfYYr6M8lg6CmYkFu02i2OOhJYDIxdPBfxDb7cuaCcRxACaNhDw+u15RGdNCBcU1t
         vqVh2RshlfgfgUNKAbYAB2iJ5FW2H3wVORHr+UxmGwd1C0s1RH9Ub7r7ra3/OP2zb1Pz
         c+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sKnr+HaOzY7Irrp2H9F7r4w2uph5h2kmhEeFaXwyEMA=;
        fh=osWPreGoLFRsG2X9VXkp9g2vkjauylV5saLwsTF92LQ=;
        b=TJ9m+W18w2Dv4Fnrkexj4dUzPG4mQ5uiFt5o2l1EhEp6hFVNjX2XbJA68qqMRG4uTV
         RpaHWA2SfVl8hMvSysif0x44xOxH0UPPm81DbYfSZRbpacveIz9tcmcLXkVF40Q/FZpi
         4/DP1rVwgPJWavnNepUgjFa6zKpDQp1yrtOW9Cxci7wTM0ajpVXNXNG+OiPw1DfAF0rs
         KRMR43pJtjKt2nn63lMLlV1Lk3AxOdIBvp+46csyiyv0vBpKyamOVH7sZs69OM0Edbmv
         NBu+Sn0lgHsG44BFg2S+lU5bomDdUB3o0lzOAHIYA3KbSGaTZLCRepP94vqJ1Xuw/DY8
         aZuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1793054806; x=1793659606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sKnr+HaOzY7Irrp2H9F7r4w2uph5h2kmhEeFaXwyEMA=;
        b=IOFsVvG3NSAD3HQiNhWpL3xOBWeFRtR3M7DeFYRGlG9024CAVL0BclZq+S6ghRSIWE
         E0Kt3NMTpMvEFh9m8yx+vpnYuCtqzZQ28yrkGkOHmwbJ+OS/FnBciKMvh34M+kcoCCOl
         Z2Ecmb6YILV0KENHnULJ6ha+jfnuhTE9OmQOtmZ4JYXTLGs8Ff0itsup6BKnrxJgen/W
         L8r30Qn2tTTSYPH+0TiIunxBTdq1zvhjrLsS3Hp9Fc6rUz+0kj+oXRMP1K7i4huM3ZrC
         CXMi12Rhds0KfLfi2+y10IxrDw+vVJgAyThh0UFHJXCkL+0SIlxgIVMgZv1LIlbPYKCO
         87Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054806; x=1793659606;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sKnr+HaOzY7Irrp2H9F7r4w2uph5h2kmhEeFaXwyEMA=;
        b=lrY6zI7cY4OkJeoS3e9Iauj5kIbEo/Bg6hXtD0d9TbYcgT5MLONKwDM6oBSRoywEJT
         HVGdP5hZ/Sdd28sacLW0bnDiyTJAg6DwjEV7N6s2I3YZs2+5UqQsECbzJotMxgAvQZOh
         3slmwmnNuLLYTvNmtRGx+mqfaha1m0HvfbEZA+NgmQhbemFoxIspmpSteMsQyu9asDA1
         HzppA0JxW9SFbuW+NEuVPOwH1dqmeHHsCHfWakVOE8t5iziEnS6GsC+UOVmK4g9qMqR2
         fqTb4nkQCDjwNIFpLGm3k7ahzewV0UGvMmYmVGzMGQA7bb5hDhIdQH3D2WJc3DBF94Sa
         akkw==
X-Forwarded-Encrypted: i=1; AKwUvBxKoJkdggMWGiDDUvXyD/NQG6P26dFvATXB3Caml4W35VRfD8kxGdHquMENbedaWuhuBhce/LckIQDwm1vi@vger.kernel.org
X-Gm-Message-State: AFq9FYJPbAhHEvUwmL5RfwF6qPQGzWjLI/A3tgWzOH8HjWfGFTrSkasK
	eM6RaPwsTqBQsuEq3ekA+5xWxDTC+dZmjAll7SujUUHIuPTuiM3j5BaFV+e8tLHETnsEu4dSlwE
	Plxz7fiscTQzdwMNiePYDWVfNn0oPpQVULe1xTpbY
X-Gm-Gg: AYBFou3cguwymuVxwn9rYfGIxXDVzAscsluS3bTIHEWpE+NLimtNSq97uloR5J402nl
	qZKi/jOFW1kMQ7UaW7GlW8mkzh+1oDRS9ib84e9Bt7BUUlc5m+gkhRIX/+LYwvsfDaUeeCtIh6Q
	wKSn5Hez/41ta7CQkKUgoIHzDvd91Y0fjuDG6vxN+DyxR/hVC6yjubnR+jE66/E1QEoEasqjQZb
	ckhFAtqEeD7UT0729InB7bwTgHxMALGIfWzoMVXKZU0SpbT8Nd3wVcRGPY9u98hwFhG/714oLXO
	Y8R0hAmcQXrQHsicsEAsL+bdU9Ndcxs2/7ekd3jwQPGUKCQslHxJx24imWsicMvJAnBYzRSBa6M
	lgiebcVNnG8WaHpKjmP6cWimkcoWOS+2nOQ==
X-Received: by 2002:a05:6512:3e0d:b0:5bc:e28c:1349 with SMTP id
 2adb3069b0e04-5bfb71fd555mr2854881e87.56.1793054806319; Mon, 26 Oct 2026
 15:46:46 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026220546.3114241-1-skhawaja@google.com>
In-Reply-To: <20261026220546.3114241-1-skhawaja@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 26 Oct 2026 15:46:34 -0700
X-Gm-Features: AclHuK_ddIvC0f7JBYWchwOFfRRqT-a0AZ_RsWY_MxD_DGe6_YpRsBjkP2gzVDw
Message-ID: <CALCETrXNEWQNPjtuHnTfVFOafeJ7APXq288Cq16Q5adDNYx9+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm/memfd: add F_SEAL_PUNCH_HOLE
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
	Alexander Aring <alex.aring@gmail.com>, Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Gerd Hoffmann <kraxel@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jeff Xu <jeffxu@google.com>, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:06=E2=80=AFPM Samiullah Khawaja <skhawaja@google.=
com> wrote:
>
> This series introduces F_SEAL_PUNCH_HOLE, a new memfd seal that prevents
> holes from being punched into a shmem or hugetlbfs memfd while leaving
> the file fully writable.
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Drivers such as udmabuf and iommufd (via IOMMU_IOAS_MAP_FILE) use
> memfd_pin_folios() to pin the folios backing a memfd and hand them to a
> device for DMA. Pinning keeps those folios allocated, but it does not
> keep them in the file. If userspace later calls
> fallocate(FALLOC_FL_PUNCH_HOLE) or madvise(MADV_REMOVE) on the range,
> the folios are dropped from the page cache while the device continues
> to use them. The pin holder is never notified, and from that point on
> the device and the file silently diverge.
>
> The existing seals only partially address this. F_SEAL_SHRINK prevents
> pages from being dropped by truncation, which is why udmabuf requires
> it. Hole punching, however, is only blocked by F_SEAL_WRITE and
> F_SEAL_FUTURE_WRITE, and both of those also forbid writes. That makes
> them unusable for memory that must stay writable, such as guest RAM or
> DMA buffers, and udmabuf explicitly rejects memfds that carry them.
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> F_SEAL_PUNCH_HOLE fills this gap. Once it is set,
> fallocate(FALLOC_FL_PUNCH_HOLE) and madvise(MADV_REMOVE) fail with
> -EPERM, while reads, writes and resizing are unaffected. Combined with
> F_SEAL_SHRINK, it guarantees that userspace cannot remove pages from
> the memfd while the memfd remains writable.

How does this solve the problem?  F_SEAL is about a userspace
contract, and if there are existing users of the APIs in question, it
makes very little sense to start making those users fail because they
haven't taken the appropriate seal.

Would it make more sense for the drivers in question to set some flag
(refcount?) on the file to block hole punching?  Or perhaps to have
the hole punch code notice that it's trying to punch out a folio that
is pinned or otherwise referenced and to refuse to do it?

To some extent, the issue you're describing is maybe broader than just
the APIs you're contemplating.  If I open a file and then do something
in thread A that GUP's the file and punch a hole in the file in thread
B, I'm doing something weird, and I can imagine plenty of ways it
could go wrong.  (Especially if it's GUP for write.  I hope we already
get that case right.)

--=20
Andy Lutomirski
AMA Capital Management, LLC
