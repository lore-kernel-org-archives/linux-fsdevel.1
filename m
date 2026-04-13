Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036F30BBAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 16:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097759; cv=pass; b=gETrRndsWGf8ZXafZgdLsRn66Murp3Pwm3rhxUtMiF/TsiWFlyxYMHLSB2apqjlGP5mZZXJB5PICkBA0PfSKUe8Mr18TKwHnTNccBrZ+wfyrk+1Yhcw0oLxNA517OTuVLrz3y7bY5yJ/o1DlJIbi4NqwNlKsGa6B61aEBaTuEdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097759; c=relaxed/simple;
	bh=X5WxGS1gx5dlEQaQJN5plmhIxqyJbgfkfTMwTS420T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCgPv5HsJPUqJvlxkeG8fdsBXn7ndLmZkLQUyJM+bqDpKIHy7tjKUPa/azbKfGMNvIOYoCzi/CS0XdZDTdBq1r3xxXYZD/NzEcrD+InG2Bksvlz4/8zOEKh+ePv0oVl2BGaQ9nAmtrMrJdOsIHWeUc5rnrnXNRpHMZUdv9GqLBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs+O2Dwo; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs+O2Dwo"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9c04152730so699994366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776097757; cv=none;
        d=google.com; s=arc-20240605;
        b=c+Phj43pKw25ddAOnpDpCglpE0pQOrINoGVkby+ZzskB/unHqKnsoGq8BAkF40F+Q3
         WnWhF7WJvbwVoAdaHfWxUy7jH843n9rO57/N4f+ORAELnEtZVaMATmN0hm4Rodv3/c9b
         f9xJb+C5f91QcVHXycHzbKfqJ2Y48C33n0C9nVna8gQQxoUf84ONSE3skqVajE5YiK4f
         9Y6ErT6rrZMJfNbcJOPA+sSMAAoaB3B0mmFpzURl9NsVl7dHV286GG84gZBR/3KR4MLk
         ChdGBnMJG/yrEJuTxzRqi8qP5iJZ8m1cX5g8ESTPNFSSBLe0foqwnw5weRec4ThpIrI2
         xDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NfGR3/JoZh1LLlI0sYWrmfBZzbJ31Iznfm0tL9CgGr4=;
        fh=kFALhtYFpDuL32/6oPbqV069c4BwtTOWb3nrCg1XAEs=;
        b=j+1Hoc7g3awqO+LKKIFwzzhkTmoSrtQedDYZzTuVtK4kuNM2N8OF5YiRxSc9nl3qTF
         JnwGnE9UZ/x6D3ytOh6EtFXcZgfBtz/ViINlajjDFNn765Db1d7jBSMNMFva8ErAIWiI
         F39XkahE5AQvSCGPBRLFMwbbglXg9oVw61LhF0EfXxoHAKb3m8/DrPXJBT0SdWTKOXkj
         Tr90v6zlGQM6Ox6aGyvfo2ZvX9UkFqa1lOx9AXqWd3HDfnuNMUO+IjLJaqBjdCes2m7f
         wZLL8P4POFWA56rj6ZYY5jVv9vQAN3fyLrhXRljxncKenuxUwDyntG6AZHQ2guALdk9F
         rnjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776097757; x=1776702557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfGR3/JoZh1LLlI0sYWrmfBZzbJ31Iznfm0tL9CgGr4=;
        b=Vs+O2DwodjvfU8s5GxTUL0WQZUbOkFEYKBcb/WKEyaVdpTvtzY41Ymw5xjnTniGgMo
         mn+sn9FRILbLQVok/MpK2HV/htURK5ZvImNJveXeHttSj6K0y7NHkpzbrwsSb3At9SX4
         5vvV6ZUpMmzgW9O6qY3NByZsvw2xBwu04+sXamu4LkVVLYlmK1zEWMWlJo3c8zr/H36H
         0iKE1CS1DK+todszRbBQv/VddspihOUceiMFAatTnwcsFyvgIK/8hJOXkIVDtbMkeexj
         R2AyJJBsKH5sz6rzt9ejN883zyBpjPWWkFGeriTdtyw5UgEUtLMzDNtmieBLjcEhdLHZ
         v1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776097757; x=1776702557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NfGR3/JoZh1LLlI0sYWrmfBZzbJ31Iznfm0tL9CgGr4=;
        b=RTN0DCT6Z8bzZQabHf4e9HSc8kd19MtmyPvY4xmLfzKfw/Vo+55/lgl7Vs865UVYYU
         uoXJPISUmrTEuZ5Qx4qo2ZAqaXFf9Cxt/e8jrUr/yF37vlvv1S5964kHFKBBE3K1CkwE
         ivV13QSK7A9ogUPE/AnKcqh4kQ5GMpnn6pDQu0qXhAE6Niwt/XW0c8nTLZHyIrBYPjgv
         DZPTvELTu6UXnuNRTYEvJ8tm0NyPpNhWRwSHsREK4Ui1wDPSYpEAxLw1UwZjnHdubg1c
         LQXo3b2TTu7O+DdgSMgigP4vCxa8iV1mbq0Nxzpl5Cyd18DjimXtJAS2oZlpK8ntYuos
         oPZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+yVKpahNPEA3x1Sl9oko4mOkzLlVBy1hjw28E+Xkg0Hv2UsIUnzGOs0k729vNmTMy821rouo/9jqeGFjoX@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxa42p22wqxXmRBy8onCGiL60tsRHwW5QhbRyv9UBxY9IFC75
	dxsbpTHicZ0eeKwnErZOUu3vWJ1gm02UPU3fNoC/rgnXMEiTk0MZukAsrFnZYPQK8pPHtHg4RTC
	94A7yHdpU4lMl9M761u99x1I7z8Gpkv8=
X-Gm-Gg: AeBDieue0vDMV2Io7V7ozkZG60+imDEb/+ckNyhnJSaKUHxTXkUkpEwdcMH2YDxUV7O
	7JnDxQ1LUlmyYzUFBll8jPWApGqbKw+0GpB7A3V0Cp+6gLpKvudDg9/2sL4FpWV2aqmwGjhw0Ko
	XOZQSJjGoRyfPdROXiGqCMTgolgdrY1abxbNZSqodEEQjhAIiPYEn/R4JmQMz/RijrmkVmr7E2G
	iYLAvxeODH6COk/VjMolj/H44336KfSWRI1Pus0kxfZapPFX8ZQpdE2/WLJ/BF0jYpXQfcoRcTS
	rl+luj/EvgWtHhh1zAJXkfG/3W8KGrdAn8Y7CeDaTg==
X-Received: by 2002:a17:907:1ca5:b0:b9c:b3b5:bbf0 with SMTP id
 a640c23a62f3a-b9d724995a8mr801125966b.6.1776097756510; Mon, 13 Apr 2026
 09:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410144950.156160-1-mszeredi@redhat.com> <CAOQ4uxha9ki24wyW1z2AtQJ6kSPgGbSiTaPw7DcBWkhDeABoDA@mail.gmail.com>
 <CAJfpeguziBrBhr_iXXsRCkw1G1iOx7NH9GUDDsCrrkr-9th0tQ@mail.gmail.com>
In-Reply-To: <CAJfpeguziBrBhr_iXXsRCkw1G1iOx7NH9GUDDsCrrkr-9th0tQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 13 Apr 2026 18:29:05 +0200
X-Gm-Features: AQROBzB_c_j6nHFeQwnxwV-OwoGBTsPPYmaWwqWWH36FbR5yanq9HNyrBKDWAMo
Message-ID: <CAOQ4uxijJ9X5uLTjWz1jVm1f7W1EOVGZVyB+O_zXhRW0UttRgw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: fix false positive on permission events
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 3:23=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Sat, 11 Apr 2026 at 15:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Locally, for mark iteration, the fix looks fine, but fsnotify_mark_srcu=
 also
> > protects lifetime of destroyed mark and connector and I have the eering=
 feeling
> > that some of that code may be relying of the detached mark to either
> > have a ref or fsnotify_mark_srcu.
>
> The fsnotify_next_mark() call in fsnotify_iter_next() does the same
> thing.  Why do you think this could be different?

No you're right. seems safe.

Thanks,
Amir.
