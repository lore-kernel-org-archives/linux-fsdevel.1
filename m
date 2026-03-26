Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3634D90F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554020; cv=pass; b=Zp2dm6fDoaAxcQ79Q3WZg+JF7SmdDzYVDHt+mk0z5PCf8RJfSZ/Oo5g9ldhjtuhdb915WwfCcNAhGExvP2wOQiABsm+KBc2oQ4KBc1EGeLKfBhH5NkuoYLWc+pOi/q4t1JzOCQBZKy8uduhr/RehJJR0DpZNjwEEVUMAH1umpnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554020; c=relaxed/simple;
	bh=T14abehY8VeKfFoZhSc3VYDg0CDKqmTM9HxW8fyrcKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPxuAIzNcWH4MzF4gkoLEMQXrr++nVu7hkPerT2SV8nRYgd3+hDyNmKboBQcIGQ2OY/fvxk2Fraoa6gTzNrYfMrrNDtYlHy98/BhQ+048unOoMWvl/AV+CXqklvxsk4WbEUYJ2CxZ0aL5nDKTwJWTokl64XsecFV/j3I9xJH/vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHLGk6rN; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHLGk6rN"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6628cc1bd69so377a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 12:40:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774554017; cv=none;
        d=google.com; s=arc-20240605;
        b=f1pFm5cqkGUQNznP6pGVvQDNFRudIClzi4PfDhLQyJdEr0ACIIJ1IPU5R9CG/93AI/
         2J4I4n2kUEimdvZ/n72W2SVhgoJA0a7Cj21W0PKXND01as+Gvqc3BvS7M9c4GJWT9Enq
         Aw0NU6NsyPn/nUrFPQgKkwZhytqoeBEhYjMdeyUiCpD+Y4BqvDERu6o+86/PjadLDNwG
         kluLB/O7zYGk+SQ55On5P/zR3w9kM9l+S8rhMO+vqtNH+54frTSsaoUuWqClQDj+I/x5
         mmU90LxGeWwO3hSJuM6DeMXDwSkpVWVX8Lh5dHNkbYDjitwFVksDIojjbF8OHX/8+hlL
         IJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=smG5Tg0EOyJh6ryr2/NdAiIXA5c3CAlpXYr7aOjiALQ=;
        fh=7Mg4T3cOLYpbr08BvqdyaTTaIRWfI27DeI9DwSGbW2g=;
        b=bpPHO/cN9lecdWsRIO6A45gczKtYp7/sdMn+LM1ytHEPr990ftDkTMgeMyC+DAxrkO
         Tk3O2VkuZg/3K41UbcLaygs4JOne/3zm6zASE+XAUo/N60XybpxgpNbmkIWZFcs4MvZD
         CeKzJjdRdGdkQLLSUgdTFxDzeNugNfyjUwAAm2pfqQhbDpFxoeiaaRfWYmQIjQfaZxQO
         E3IPU7fGHA/2f6qTe5Z9Vtz8EOls4rhNcek6SJ9x7kA0a4S4W3Gu1EFEt4MAk2CgTz3Z
         rdkz2JZ9DV83KNja12T2WgCJPDZDRg8ttlTGQyDKqlkg8RhjVNyoTEBz8uaqO0xI9+Ev
         ZAew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774554017; x=1775158817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smG5Tg0EOyJh6ryr2/NdAiIXA5c3CAlpXYr7aOjiALQ=;
        b=bHLGk6rN6EO80bINv6dN8jbCZIXHkcoCkcA6xUGBQ3rkiU0wRLCSu/1o4mA6n22v6F
         K0skbK3YTc6KTq6jq/D7h3ueLe+lZJ30OxyIP3ckOGenOd0xewg4Q4JPAjjCAWpjslMe
         SMtcWZ5tuxeIF+FYnUlInn0c9eWJQQK0Dy41sEQqTDXDZUswfBF5gysOhqk2Nb5YozuF
         ttB0SZPyEJwW7LATJ+sig2QHbJYl5EXNg+Ff+OakAOrbJNE3j3R7n0ZQlklg1FgEEwzr
         3VvQFJeFoVS5Smx91xaINzbSbgmLtAo2wldMo6d4aCae4BfC3MEPU+BvbhklU/MDc0N3
         nrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774554017; x=1775158817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=smG5Tg0EOyJh6ryr2/NdAiIXA5c3CAlpXYr7aOjiALQ=;
        b=dnKYZ1ZxMKW8gE7XqUROgwk1YhcWxjkQUsUp+infYuVDSdGdOEPft1QQ+6YE4Qxya0
         6P3G7sVkk7cY0AwrLf0MNWWVnlEolV4I/6Rzk3a6XkTguIe82TCgNtEcOCqrLQXDJB2k
         eTbwE0E3jyyp2a7xcc9xkj1/mQDJH5k1kZpYBPuqK+zq/EA8CAifLoKCOtCamrkLCedm
         zJXhP9pGAZFD6sp+jcBp8zv71whMc2NiiMCdHWzuIvMEXO+dPBXDntFlHtLTTGEDke1/
         v+8wAhfaPzMGPGu7E2TmGUzJyD3ihsWemGEKd80StAlBsrj3tfuZdfABvio6sMD1HoK2
         SzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWE7RaLvs5BQvNMQVIlLcprREMAvQAZ/MMOu3uKlNmfCjoC0UufffJTpEMPCL9IgnDHbBgCfNOSnU48na2/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6P3jpTkAgZKfVVFmGh6i1NTSI+OF2lO9GvsRxFjR462Aine7G
	sRiFJE0JojJho4S7jeHiAonxnr1O3EWch+gCIdXtySXPrZIhRdtJ4AevfLn/niNVcqSB97OYC9U
	YhGm0KQLsSdQBbPEa8cDnX7EfjkIhIBnixYIR6mmn
X-Gm-Gg: ATEYQzwsHdVWyuqmCT1CTlYuM9kdUuT/AHsQmTQroeZDA4oEYAlpBfNlikyI9K73qEo
	u1r63REjqcoVkHYKyAabTVq3lHEhVNC9f7D2jcT0/1QRhHjcWXOKhSvExUioBgcB9OM2YA2vS4I
	HEeyDm/Sbsn15iZjP+ptQGerm5e2SquAPjqo586iFqxVih42tIGVOD2BdJt07MwfEFz3QKpx1up
	zRkfILxPnksWAYIFjVXSD6/rRpjglnjubbPdnZmKfOA2MOyFVW5Iljpdw1kCgLnobuRgIAaOGu0
	XT8uGTxJubAOTYr/8u182v7QyHHPbv7jxcox
X-Received: by 2002:a05:6402:524e:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-66b19d7cdc5mr11420a12.10.1774554016932; Thu, 26 Mar 2026
 12:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com> <20260306003224.3620942-3-joannelkoong@gmail.com>
In-Reply-To: <20260306003224.3620942-3-joannelkoong@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 26 Mar 2026 20:39:40 +0100
X-Gm-Features: AQROBzDzwqdBTqpXLzNjW79nbt59mFHqUgS8x2u6j3haKVdwU9v_EeFhzu9nPcg
Message-ID: <CAG48ez1QJZMO0+6FHBU4NHb_jp3appDWaw-KBzvJ0vzHWmXMQQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] io_uring/kbuf: support kernel-managed buffer rings
 in buffer selection
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 1:32=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
> Allow kernel-managed buffers to be selected. This requires modifying the
> io_br_sel struct to separate the fields for address and val, since a
> kernel address cannot be distinguished from a negative val when error
> checking.
[...]
> @@ -200,9 +205,12 @@ static struct io_br_sel io_ring_buffer_select(struct=
 io_kiocb *req, size_t *len,
>         req->flags |=3D REQ_F_BUFFER_RING | REQ_F_BUFFERS_COMMIT;
>         req->buf_index =3D READ_ONCE(buf->bid);
>         sel.buf_list =3D bl;
> -       sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));
> +       if (bl->flags & IOBL_KERNEL_MANAGED)
> +               sel.kaddr =3D (void *)(uintptr_t)READ_ONCE(buf->addr);
> +       else
> +               sel.addr =3D u64_to_user_ptr(READ_ONCE(buf->addr));

Nit: For IOBL_KERNEL_MANAGED buffers, "struct io_uring_buf" is stored
in a normal kernel allocation that isn't concurrently accessed from
anywhere else, right? So no READ_ONCE() is needed in the
IOBL_KERNEL_MANAGED case?
