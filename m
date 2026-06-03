Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2448179A3
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480860; cv=pass; b=PVV41KxLBYpHvChitNsQwcL4pIcjHMsV7Wn/fjMTb1+4Uz4vZc3qtuad/ETIxeuX3WL9AuiwbjKXrdpObrviouaReJuxXGhwUSRue/24GBq4c3psZ8oV5YNGHIHTPB4EQFV8nTiODOHNrHpjNkwxSQImr6urNv0nNzoHvSzb5NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480860; c=relaxed/simple;
	bh=AuznTV/Nkxe3iNmqbl3yqHn/fcmWlUfIxOuSOS2q5+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poqUR934smom1D432aGg6wr4UGM6ctipO6WXcWNoatBkSV14A6vrfut+YHKiPDXwP71a9FMef4uc4r4ODL8bXJljKTJKut6oiirIAXK1qeY51pWH33QDPAKADac2XvDoyDnN5wz58KXlOGgZ6T6OS5wrKQPkC10d+m+vTFyiZgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVm0mP5A; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVm0mP5A"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c76fb8009so6793802a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 03:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480855; cv=none;
        d=google.com; s=arc-20240605;
        b=dsd5pPvp8HRYQJ5XHpBkcxBctuMXUg6wULze5q5zWTZRJsgpEiMgrl3CxMAwq9YVt4
         JkTaRRhvF8v9xFcFSNWgml+D0LgA1Indy2GDoTN3v+v+C5L9U4LlC43UOgh2r25x6JBu
         g1AUiLtBAhEp/T6YCstOLYb8oLnoa2YJnwIF0SSQ/1P/eQkOi2IC0y8Y9A5G3OyxFXcI
         FtYllPFmtNsqfXLwjc7CsIfzQq02JbC8OlOffTAeDpnMOEC/IaDww2VP+wVux7qhzK3N
         FzFZ/W/925RpULM7l5Cbzqrdv+fuAZLPaVmhUqhGYztW1Ao+J3QG2B2ZaYHn3sBDtOJG
         nzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AuznTV/Nkxe3iNmqbl3yqHn/fcmWlUfIxOuSOS2q5+k=;
        fh=IymUZBuc8Nsrplu+LtC/4qeRD8q8+2Y5Dd1F6YIWM90=;
        b=VJK7iHbOdUPUmX3SWA6yccHD4xnyQhuFMBhy32rE+DVybFAdwWa1kSxG3ISuYsT4FD
         GzGCmISSBxSW1ocpUGjjdZ9TQzawyMq4Q1Y8fhaPjihrs0ctYriJ07wXaeYlubsmQhIk
         hR8h07Zb7wvtdeSOuuje+tTbaRaEKZAscTwwQTReyq1wx1o6wKisJ8yDpu6Qwg7Tddlr
         ZR7Iuc+Gnpow6xZjwZpMldxyTsYWUJKRowBUcROx9pLhEJSYmTsPreQqwz+JSi7sMF4h
         bbeBF0a0GaAxhUNslylCd4h5G0TcSHv7cvcIqsiTHMkBMeQMKhGbMKd1mNuso2XnXgTx
         f6PQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780480855; x=1781085655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuznTV/Nkxe3iNmqbl3yqHn/fcmWlUfIxOuSOS2q5+k=;
        b=UVm0mP5AO8VrYkrQ38f+OBEinRmQfGq2Vk7HM1gc6RD3RUQVUvbY/oFvzeWmj9BjW1
         052y474X5JD55VDIh66IWr3rCqpbhRf3yLEuCcMrzXmK+hH7BHxkZxDa0+hI1FpzUv+u
         D9TYFiXJokkuY8CiFhhdXt2XFxyX2kC+KuxTYghZurY+ouqPeFpleeBG35Sl+PFDfUpQ
         /vSVN71igR1J+U+duGOqAzJ/7DqSyO76jp+QigyhuldI14NT0cd8iFujku1LpaZp5Pcf
         D2uRLEq7aCbJs6zP8s7zP+2LVPFoC3mIkd638jQRWBAZTX3W/M/xjOZsIVdG2DzK71yb
         g+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480855; x=1781085655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AuznTV/Nkxe3iNmqbl3yqHn/fcmWlUfIxOuSOS2q5+k=;
        b=P/ASHzj7+3EuXlH7x06txhpxPzTsVJzfPJc88/2RD9SFcCbwdRs85OIO5hWppc03B2
         Nz+Xwr8c6nMagWKzngy07Aew+7Qc8q2F7ygcQmm4w0fjdj4GqoKf7Z+tN6kQ48jVXIM+
         btp4FUicHivGgOXsZzqakG83dnZYnZIhtbr3G5qZHGdUxUBd1cbQ9AaNU4ozxagDsMFh
         zCbGlQ1CyRMRCrbkAqC4M3wwDSta3i8MTI5d8tV8Tp5mZlum6HFV5FwhC55SI4Lyrjyl
         NWXHlBv0XTLaDsv+yYxoCgDa2Uqoh5DSsNWY8QlUFLQHjc2VZrRC83D6WDzB40cCGd7E
         Ye1g==
X-Forwarded-Encrypted: i=1; AFNElJ+qA7kLCaAA392xggsfkcmmsyvav7r7DjArLmj14M26yIVYbWnhi61cSjvExR/O/N/Ongl5iMzvTT4MU/Jt@vger.kernel.org
X-Gm-Message-State: AOJu0YwE4G1VvCwcwA9YZT1vq+9JLBDLHu0QDQzs66ARFe4KF1u765vk
	ioA7OmSsHvby/A7KDqv/e9ro4s4Haitez1iYJwqyRvotaUr4E2cyZnxup35K98n+0layWcuOFJH
	igZDH1QPweDqc5aDd1p0Th/2gJAtXWC0=
X-Gm-Gg: Acq92OFGaOoGeycTpC/y3V8dAOGEWYTaUDfytvdgqvZQXQLyc29gSFGFoW+9AjPKbCF
	P0DvpSuAUoY42hNK4n0bvf8SQHRY2UqOr0ykZ84S9mPdji/Yrl0fYjynNglS330ZmsT4KVBMJjy
	jcMSQxfv426OouYErJ5wUTNUYTYEqMPg5tL3dTCwvLc8kzPxSyjZeMDZvjCIHYCpQsQfmQGCn1W
	KVbfSe8uUL/guhrnNS+5kkE5jNZ0VZek+BHLztVgk7dcHYsre5BtVnPsuhUNCtqIJtRkhXJYQqY
	b6oxthxOT+89xkEXtkZQ2MkOHlvhYVEQwsj90LPL8ScgSkomd+h6
X-Received: by 2002:a05:6402:4487:b0:678:edab:6f40 with SMTP id
 4fb4d7f45d1cf-68e6e647a93mr1181749a12.4.1780480853540; Wed, 03 Jun 2026
 03:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-3-anonymemeow@gmail.com> <20260603031117.20950-1-anonymemeow@gmail.com>
In-Reply-To: <20260603031117.20950-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jun 2026 12:00:42 +0200
X-Gm-Features: AVHnY4LZVPNdqusJWb47Z6ISRXUeCJZ4jR8WNAxJVVyHPAErMCdPXuDTqYi6wcY
Message-ID: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 5:11=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.com> =
wrote:
>
> Sashiko said that pidfs_register_pid() can fail under memory pressure,
> since it allocates memory using GFP_KERNEL without a way to pass in
> __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> the event even when the group has an unlimited queue length.
>
> Should we make pidfs registration best-effort instead and still return
> the allocated event if pidfs_register_pid() fails? But IMO this will
> make the API semantically ambiguous. If the kernel guarantees that the
> event pid is registered with pidfs when pidfd reporting is requested,
> then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> invisible within the reader's pid namespace. But if we allow best-effort
> registration, the event may still carry a pinned struct pid, but pidfs
> registration may have failed due to memory pressure. If userspace reads
> the event after the task has been reaped, it still gets a FAN_NOPIDFD
> or -ESRCH due to failed pidfs registration caused by memory pressure,
> IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> currently it seems we don't have a good way to register the pid with
> __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> approach to handle this situation?

Thanks for noticing the oddity and explaining the options.

We could fail the event in case on ENOMEM because the system
is likely is a bad shape anyway and other events are likely to fail
allocation themselves, so I am not objecting to your patch as is,

but I am slightly leaning towards the semantically ambiguous API.

I don't think that we are going to change the man page to say that
FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
add a NOTE about increased likelihood of getting a pidfd since kernel XXX
and mention the known cases of pid namespace and ENOMEM.

Thanks,
Amir.
