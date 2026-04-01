Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C7247DD4B
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069924; cv=pass; b=nT6c/HcbvZpVs7qKjDOKrhHdjhr3/U2kvJTsKF+f8SN5Quqedjbpjf482i5vml7+9P7dycBcBPQHLGRAcS/VvUvFHZVrrijyX5S6eALBC5cByKDA2Ow8cwW68c8oD6bEuGe7PtBdqEUYbjbfY7LvK6xs32E66X8t7ec/CAP3wQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069924; c=relaxed/simple;
	bh=bJmCBKXc2JAQBVsA5jqvqmYpavKHKXABrYqrXi9g1B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb41V+ZKhtFLctDEecCPdPOP1pRcjH3juOkQN3mAa0vaiv94PDb4lLHOFiewVLizkqHKiJtF5/gDD2BPNl71GRoc4VaUHNuhtjSuF/Dgp6XXtlxT9QDFNn/jIUrVzUpJ0fR3p7mtcGQA/IjJmbUnAMFyEOO6QO/okAiklD4U2+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0UnKfZf; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0UnKfZf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66deafdcdc8so184742a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 11:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775069921; cv=none;
        d=google.com; s=arc-20240605;
        b=Z9MsRNhRIemxRJaU3KflFD1gEgHPBQXn4zGSj3bvKn9Pwbp2Ic2mejYkgscgYi9wiy
         ZRFhMthlVl5JlTtzzNt5DUqAhSNwaOwlo6pQ89lSBo32EQOoJY+p9ecIKl2t84IsaY7t
         mVBNSs7s5xXDngL2coLVpwCctNV5uC7722ba4vM4V0nQGf9qe6Ystn/IdbGrVgPsTIyv
         u6mjTE1pG5h4NyMxRCCRB1qW/vHbH98JesNiHloBli/HuRO5BC911dgGKgaLi7pQcjkl
         4Nco8yUxCSiNWHhKQHCkNTAY1U4DHRCPmv1laaQpHDehjLS0XSKZfNAYZGTmaFcnSQA7
         zhtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuWf2GurnRCDVCOErqdamv05apNlqYHl34+PkEANN+0=;
        fh=IKQr201nZUu+vB7MGMaoZl8ckJjjP/OBA04ORyN0mjk=;
        b=D3yZgNB+yA2doyrCPhtXJja3ugnYeNwOqcmpv0agbZ1eXIqHrkKDnmuGvePWNSZkEK
         iBk7rwHd3HCCanEC+95S45QHazAwuVDNBhlfTypT+u1IapGZx1cj2WRF9Tnk+37idrKu
         KXqz1EA/SHPeOAEMu6TT6FLJcjV/nAV11u9S2xIM11fM8qF/L04LGrf9orAbEMd4dth+
         lDdLhACz0LFAleCUYtEpKwl2zDXDUGOcSvQjvfpXga3JrCngiePDRjo8dVfk88W69aIw
         zpFOa1BommX1Y68FVrBWMmYwxwQMV5rgSVCcHq+dAlAC/yLVKyNX59WDVfkj4kLyrUTP
         cDHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775069921; x=1775674721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuWf2GurnRCDVCOErqdamv05apNlqYHl34+PkEANN+0=;
        b=L0UnKfZfu/A/m4sn0nvdJgcYNpjM5o+WLR4SdSXj+kqTgYLuoi4HEZGaGNWAcYekRK
         9hs9d+kxwHJ4MEZr0vkI9kNykr7g8RuefaBTZUXRxAhReouRKf2LhvMW+8KmIpteatum
         K0MjT/9fYiywYF15HIELoH+6STcM7XSnSQfOt+LY0DR6yWyxPmY9M5ERlTAi0HTUjlu4
         AEQBtpeaKVmkAJ/JBFgh4LeZ5tlyia90Ap7m8zhx3+kIUFG1o2tpCPfFhC6ncsnfSXUe
         WLsD26lMpgHW4M3/VW+3lws2bnfjDuIYTi//7EWl8ttdQaYAZzHauAkJF/i2pgXcr35D
         KKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069921; x=1775674721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uuWf2GurnRCDVCOErqdamv05apNlqYHl34+PkEANN+0=;
        b=srR0fuMnAObCQ3JLec8x/U53bUbAVtiw9U+dXbxIl1gx9Hc+fOCX5vcvzlwVwnJdES
         zKnPS4dHOVX+6MjMaNOyYmpMePvcQq5kHoZq741HFiX3saDf+GxQyZN2CITVTIXV12Gu
         Cpfq3uNsaujAwNnEJdVl+/xAX+AfdGre2gxhKSihczjODTejHV5M9Hb3GaozqQAHq4nx
         vWIGcuYpSCNjdSl2ZGFVW0kJOzC0fzHn62lqxX2tGoz3EbaSeDfS3ktl222E9lMUrzea
         83o9kfDyQtxaf6frPI3D0cdAxaH+fK9c694EqSS2jTf3k04PuLuNne9kBGfzPhprG5v7
         mS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKfNaR0TzdryzfkJbnt6i5ScRroEl/tfUQlLcvftSa99wBcqJxlOPbTel7iEXFSisSTqlMQujw0xKJI7AA@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwWl2PZ9nKqmHTDHRkskefd33cT4cmGDsIQlqYzOA0pn6RdBe
	Zx1eMisZtDpzz7gcrZwNDRsY2LhVmo7k8VOIx8jQ1RlnNGxJsP9v5h7Y8N5JPJaGEaMs6hbS8mz
	oscjBdt/fxxzqERXuep/3xl80YpXKE9o=
X-Gm-Gg: ATEYQzyd01wQvZcLtL5fOHLXRXHUguifpXOes1bXgFdHxvXR5Irc7XXHA+3aZPNAGE5
	r+5sRUSFOpxf+iUwzro4FhiGfZaprJ+8Xgal22b6w+PSu8rtr8KL1mBMbmnInOpVIqJP41BvFWd
	MYj8yGS6TMDBWYJK9u+/Ts3H/Q3QE7LcqtMM37RnCvk6BvFcz9vcZ7Thz4uytT+nSerGDijIE1w
	wQ6DSYQ+EGzW+7YXIN5tQC+dltysH5mUMWxdnkXOFox+IIpcVBbNWSnvfW1e6BFjXZMTrT10C/A
	KGgAnwcRt/UY8eF42Nmmfl4I7En0J3kQY3Y09JvFvZJcNA89Qg==
X-Received: by 2002:a05:6402:400a:b0:669:ed35:e47e with SMTP id
 4fb4d7f45d1cf-66e03d9a862mr261663a12.6.1775069921323; Wed, 01 Apr 2026
 11:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401131226.4011156-1-mjguzik@gmail.com> <ac1psq0rx_GOWyYi@home.goodmis.org>
In-Reply-To: <ac1psq0rx_GOWyYi@home.goodmis.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Apr 2026 20:58:29 +0200
X-Gm-Features: AQROBzC231hOMt6txTY2UzjDGYuaqIOTN7ZqPtmG2YhQULpXGJ8GSWKeOIzqBpc
Message-ID: <CAGudoHEe6yYJX_qUsCk4EhWDQQuM_4c9resO5WRJ+yix-6=hPg@mail.gmail.com>
Subject: Re: [PATCH 2/1] execve: only smart people should use vim
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:53=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> To keep people from getting stuck in vim and not knowing how to exit it.
> Make running vim a bit more complex.
>
> They can go back and use emacs, of course that will fail too, but then
> they have something to work on.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/exec.c                        | 11 +++++++++++
>  include/uapi/asm-generic/errno.h |  1 +
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 2e954b31e3a2..ecb425388008 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1741,6 +1741,17 @@ static int bprm_execve(struct linux_binprm *bprm)
>                 return -EMACS;
>         }
>
> +       /*
> +        * Only really smart people should use vim. If they can't figure =
out
> +        * how to circumvent this, then they have no right using it!
> +        */
> +       if (strstr(bprm->filename, "vim")) {
> +               /*
> +                * Learn to code!
> +                */
> +               return -NOTEMACS;
> +       }
> +

I would consider extending this to nvim, otherwise looks good.

Reviewed-by: Mateusz Guzik <mjguzik@notobjecting.org>

>         retval =3D prepare_bprm_creds(bprm);
>         if (retval)
>                 return retval;
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 1a8fda40cd8a..4cc4ae653cec 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -123,5 +123,6 @@
>  #define EHWPOISON      133     /* Memory page has hardware error */
>
>  #define EMACS          134     /* Editor too big */
> +#define NOTEMACS       135     /* Editor used by smart people */
>
>  #endif
> --
> 2.51.0
>
