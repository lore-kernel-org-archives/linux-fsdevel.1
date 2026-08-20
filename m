Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A163B5F63
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209165; cv=pass; b=fwe2nJDpwHMVBK7CdUZdzaf8t+oRYtkmxs+oScOuRAJEKRRvjHJA9HEu3r2vRqwAIGSkkThTrjCxlI6R19Hn0Hz7oIxZ6OocH8ujGHAup2Stk7WSeFhgcVFJiAXgMoGMRdwJgSJV463+pT3d46p/7LlozMTzsQnmC+AWG6LoM7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209165; c=relaxed/simple;
	bh=BnQ9yMrNXcpD0g2SmJQxzQFpSVQStOKyAolWcIPq8Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0qTkJD6VAXj3KDw5/e83a3IVwpfBOacdsiQH5l0wuPyCkHR0Td88CSNNY61/+bFAFvJ7MvBXCcQoWde/l6xE75flKH0a07d4aKZKA6EuRg5T/U9SrH2h+FHYVNv1sLJ1jf/AOelfRwxb2XJssql5+6ykh8HcJY49OHigr9l990=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZC1QuA0; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZC1QuA0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2136755e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 23:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787209162; cv=none;
        d=google.com; s=arc-20260327;
        b=KTaLGyt6utzAwOnie8ckxQo98XR4MLb/ybq/K5QppT5A+X8NsFEUZWCdFj42zuGmJr
         +Mbp+nPomiooun0ortwsXhCRdLN9S4UZbIMmu53D6So42e9Bcwv/gXXScl9SCEup9Jey
         PlYsgax564hhErMaUSKahlfm4A1In4rv7MUf8hzN5WtbkBsEXF4HkIt+KSKv9ZWeSQNT
         D7YNSr4EmAvKkPhSzLiToBeN2IeuzXmIwY1+8gbt6oTm7+V0wJV91pCYK3Tir1DfLegt
         T8qIQTlsJt6XBhBVfLAnvdybN/NB7ThCtgf8l+HgB9MSvjVKAwqCkBl9Jg6OE2CU8ND1
         4NRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QGZ/wYQ0yt53cfgTWgc/RvJWplWSy6jA7q+8/eD1I+M=;
        fh=2kM0KDiCdvpNEJNIz4zHIro6mM0ZAcnGOl09+wl6dLU=;
        b=SgAT24+tSnim1F8gOIElVfT9naY7fi6thyKd1xNgtwqkZ83MJomtn7FjlYgi4fzAQ3
         u8Ub+kjx0KAa4uY7zVT2n9WD8Je/UqQjy561CGzxrto07P1XwHUBPT6I7ynEp1W+DgaI
         iWrwWyVIKRc3KpRgUNrH4aynRJR/XDBUK707xn9fXwg3oI/nbVAx7a8OHHvv590S4Anr
         BNJoS2plvvM7xd420s0BfUDFyckV3sCM69CRRZLw9UNqw/9yOJHy8jURDZsTSREilK8R
         s350Bc7dEs97O6lhc3/1gyaB5feT94fHR/QNFnxpwZZbyKfeOKgyG2vRAPVjwscmVVB+
         d6fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787209162; x=1787813962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QGZ/wYQ0yt53cfgTWgc/RvJWplWSy6jA7q+8/eD1I+M=;
        b=fZC1QuA0aXNYe8k8fNCadioRDB6gUc+e+uSlvFDJtZXkupehUT3wlIQW6xsJbpxNHI
         PnI0cMPyhm/hx4TMQbtS/u2YQS2RXuIvDTllJ3BqTPLfTypIAQ0wKc1vqnSiXB3Lupbp
         soYOEwLGSXh0lu/DeM83xC1fyMKebSgr/hzpCdP2CHldZC0RaP40L9DyHckfW7T2iRL0
         15Dp2kE2hmRvpCo5F2MJG7RODku2NyNw3ytwRiLbTv/D09lI9jOltOWT7e1F0VmJQ2o/
         qE5G5KUL2SxhUYDfxFRXeM9e2T9yYMo4Ew0ew9cqHyKELrkqsAe88IpQKJl1la8q7z9s
         jzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787209162; x=1787813962;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGZ/wYQ0yt53cfgTWgc/RvJWplWSy6jA7q+8/eD1I+M=;
        b=JBCb8ka1dtcLK+K7v6rlg2Co0YItX4C9vJMQNUi0HonE33WBRCvwf7OjbuoyLGWhuV
         hC4Ktd/9dWnM8o/F7ZahOl5BW7/u5gSMwW/Ea8EY+ir98QRIQidgqa8CrGcIbezt5S5A
         RgdFilvUWFCISrfvAzgjUHrp6Ij6SfoB39gpjXYYGnKZwcU3PqchmLBU9IuruHHK2cbF
         JQc+Ecjl2XtoaOVVGYbx479LtIte93fTXehvEWLWjpQvZqzoQqIkZScYhdQXW+2JpAfz
         YQbfRQUw7rQbnfGTSywPkv0ptJyjxpH7STx1j5x7lGJ3sdAHeIuk9XCMHiIuQnCAB7OY
         o1aQ==
X-Forwarded-Encrypted: i=1; AHgh+RphcCRLzgY8KiZMiqSu/s6DOXMqLncHLD+HqjNGPxGs77fvEOX+wFdxcYg6gRQEqNWUDeMUqz6mUdWo0qB1@vger.kernel.org
X-Gm-Message-State: AOJu0YzscSbHNDgxPC5683knrnrvVzEQrcYW2dQs70WK2Zu052IqmVKa
	fg04XKklhHybLwJM7eeYYWq2tFZt1hwMejDlgQesRmzsrHvUOkjdwOM3eyTBVh3y3MBYtU9h17X
	gYG10Szxr3HemC1v4/afDqu7RlG9AOdh7UEUI
X-Gm-Gg: AR+sD12tk/yfxa+AimPGC3fnzNZvVzTL7Jz1vreqPmaiflnQN2eZeaszqIrqKdEOblm
	1mcUJGpTbwIyExPiJwxxFgRwHXZvjCIgvOnVkX8Pk6ZNhv1+SPvB49z+88IljSbhdM1aiD3GbNx
	gaPfz50TBHHkslsn+/zQsmVevM2UNKW6P9OO4Ivdg0U7elknJNlOvhuBSEjfy2/NJP5j9x4dDBo
	4/pG5ELpJi2R3+KBkUX0l3xHl7lApvroKdNJY86vYRWYl2Bn76LHn5Lh+kp0/5+oLtUx+IX+ULO
	6jQO2Uq9KdUjPoQAxZMfHXWb7TvMERteBmZPcYl/IHhd/yvjmeV3fNA=
X-Received: by 2002:a05:6512:3b82:b0:5b1:4caa:4b43 with SMTP id
 2adb3069b0e04-5b478926417mr3459200e87.0.1787209161907; Wed, 19 Aug 2026
 23:59:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a86a1e1.ee10049a.267d65.9802@mx.google.com>
In-Reply-To: <6a86a1e1.ee10049a.267d65.9802@mx.google.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 20 Aug 2026 15:59:08 +0900
X-Gm-Features: AcwNN1VbcZlIUwNfJQOgCD6agto_5k9JlDCA47NIcLM67uljy8wNq9cycPTQftg
Message-ID: <CANFS6bZBHLNZCONECcnns8KgiBsBmJpAmHe5wQRFHfDsgWb_kg@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: validate usa_ofs before preserving the update
 sequence number
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 20=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 3:42, D=
ennis Tighe <dennis.tighe@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When ntfs_mft_record_alloc() reuses a free mft record it reads the old
> update sequence number straight from the on-disk record:
>
>     usn =3D *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
>
> Here m points into the raw $MFT page-cache folio, which still holds
> unvalidated, MST-protected bytes: the folio is read by a plain
> iomap_read_folio() and neither post_read_mst_fixup() nor
> ntfs_mft_record_check() has run on it (both work on private copies).
> m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
> it past the end of the record so the two-byte read lands outside the
> folio.  Reading such a record while creating a file gives, under KASAN:
>
>   BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
>   Read of size 2 at addr ...
>    ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat
>
> Only preserve the old update sequence number when usa_ofs is even and in
> range, mirroring the check ntfs_mft_record_check() already applies;
> otherwise leave usn zero, which the existing restore below skips.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

--=20
Thanks,
Hyunchul
