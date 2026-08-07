Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE437DE99
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2026 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105543; cv=pass; b=XGZHe21h7M1mh7c+1w3DYAkHB6Z69YJqVVdW71xynPy4//P/oWnAXVza1qMtfUz5AIxoFgnegSelcG80eJuV3VJnZ0ybOPVujN2Ab/79vNc1fugAjC7iIiAX8Rzm6WmcqxPKqMvpykTO6TkTrq2CrYk5O3VZfKO79zLORAn42NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105543; c=relaxed/simple;
	bh=fBVOn8mK3knmw46L9mpY8gHcIvb6lpKYd3tG5GSLjvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHT7doAwHAVYP93K2HD5EeMgR66s27FosYtiOko7RQnfINIsB3ed5SNbauj+8LCUZrErGKuug0o1U4FTPlVDott5WaJ2cQcW5NXmsim/bO7WdqL4wnrUwTngTWEg0DMWhMzCBGujs3YWhtiMtrPV0S9zjbiGwBFQT+ejC/4b+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UshIOI7L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7TaLFV4; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UshIOI7L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7TaLFV4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786105525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
	b=UshIOI7LAeQj3kTBhyAy21J9HxH0dh7KfUklvkTENeFFwVmrSyt4/oMoj2XI9Z8erwggOw
	i8u72kuzBch2VzGenwY9D0ymYP75DP4uxCZwpsi2EeXFn0tCjhacrX2TVZpoUac4zF6ciW
	wy4PPaX9Iy0DJAmvZtvCXYlS7WmaG8k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-HJ5bOE0dNcmQF9iDOP-nbw-1; Fri, 07 Aug 2026 08:25:21 -0400
X-MC-Unique: HJ5bOE0dNcmQF9iDOP-nbw-1
X-Mimecast-MFC-AGG-ID: HJ5bOE0dNcmQF9iDOP-nbw_1786105521
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1c25c44d15so393358766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2026 05:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105520; cv=none;
        d=google.com; s=arc-20260327;
        b=VsgqzCsUh1OjZHT/jVU8datQDjSfrKWVCWQTWIXdF8TjkEpfbE9cMpZjSNX70lE/hy
         N8M5Iaq2gOR1+VCQwgV8At2AKVA/QEZbwquckaBg30TcF9oSiGdjhQUz8An+w3/yy6zF
         m51dpY0sjLi26ArSSZAzh/kUEN05XttBUgYkhYtIz1/8kbGIsyj7TdcB3fxQatJ6c1Ls
         +knV60rsVqq7QzXYVw5HV8m54jEWsUuI436laWH0X3ay9EBDksv7vC11b3vVs3FN02eb
         r5+vvsHRRN56iCSDOJf7BlzEDSQfRl5GU02+H+jNg6xq1MabAjYh5BgKWa8x/KNsaeTW
         c85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
        fh=v5x+Z3GH6Mn99ViOlvtInpDJExDxoRcDLhNJNW68aGQ=;
        b=TSdhzlrvi2lyfR2OkAa5wY7WIvA0vOPN3EWvKVQVJIUQBCsw4m7kdbhMYxZmJlFzrE
         9InvGnYH/vAZI1AD0sgU8mW9WAdSpMdM3WKL4IoNiTyuqhYwBgu2FoNjopV72dmyX+p5
         U6MobZw3GPwXf9I9RQOHeKAM2nGKJo6cazT+jZA+DYJ4vROgJGJSsHT8IAh3Rp2fWYnP
         ro0MG19n1CQN6NH46y7DoF2BDH+jPW90qjvVx+7CEYpCCOADXcNd6m/EXpM0HZ/MGHsw
         J+tpSYDz45S287SuhxVzzU1jaFmUbsmhvLC7yZcPakdC7kSocZPauA62wX3WTqUZR/je
         fp2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786105520; x=1786710320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
        b=Q7TaLFV4LCs1xqwFftfZN/Yb7Xw4AVZJPGGj98Sksc6moBE88rgw1z3pfa5gszJB64
         gbYOgOIb4WziYEqr+MvNIsb+6Ro5xOs5YaCo55k4XLcbZzFHRffnVOfuGn/uPJ6tP+57
         GJ9rZxHVzSQWmepqx4AVuDbFUeDoFITOyCjmcuBwrWJefNX4VpwMx9c5gl4CkE2rrj+G
         ZRbAWXJz/dp9cSVgsJ5rRQZpdlFUi1BmyWjmigw+oJsMrF3a9qNJKJflljVm6x00GHb+
         apAXCpbT36tg0Cu6M6iBn8KLI2mVsaHH4+Wy9DLawNdn6hH88wPqF2i8tz5Jjy6ADr8j
         hghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105520; x=1786710320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgnh0JW9lGf8+TSOMsKievjYM8NZFQv/RqGFuu07TDs=;
        b=LXGQ5egght7soVPR6i0d2uOwsmLPYiDxdGZBHzKNdpsSPClXvI6W5Y6onaCW3hGejo
         IXtpfNs9Bl9YB0sV3N9i2WqxsdNMoZ1/ifzerpjgS35g6/Lqs8CDGh9RNqD4DBrfGYsa
         FwHSihSYfLZUbZ2eY2Woz5qu/4Z2HXQv60rFCBXid3UO3v8mPD71cF6qjE32Thdf4ckF
         YSlnVQ4O/POQOOk5QRZNj93AwRzskkCttj3kAzYfCPwQzji4j2TzdCYHR9WVDZNc8Nuz
         D04jpHd9twBS5heRbpjeFH5IRJtbjUi6C5EHPKx7SCGiMVbuMrAT50GukcRNYoTfQkXY
         npUg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+MEt+ReauSj+s3BySHZczgB1GyTcroty2JtXy5mi3p6v66kkv8DSwOjyivYz+ecz+sbQLv2Q6TLU6XHDG@vger.kernel.org
X-Gm-Message-State: AOJu0YxEvC1r6tUDMsmKjKsVHjKb82l19LgO4Viv2eIaljr7k5AX8KbN
	1VyofpHwlpRrEbLKdHh7TVs77eSctarjIJEX7UTUfWIXA55lMAS2DVOjcsVFWM6RS8evKcMJ5hO
	nMy8q+wybx2JDb8Ywj8P5TD5PD6e+0iOSsZpiYmCa5dxWRTnpdtDDyTSa9wXzua7mH2xtey9Csl
	xsUsfKXt4F9+D/P4zD8VFPHzRWWvr1J41WPIbn3qTn0Q==
X-Gm-Gg: AR+sD12Oxka5UcO/qxuM1WeW6moyFZiYIYYOTmTK+QWuB5Oovhd8llXwL0JTfppnF1t
	m4K1W4xzoMRQsmEXMPHXpsQ2twW43mhYcThOB+nRpig18bgUM1nOvoOLjQl8jf4sHcF6R53pLPB
	Pow7hr39wTWa+DPXMRv1O4bPxNhNqtPywCkh/4yDSKJz/d2U7/R0S5HsOfOC5rwkp/O573JNbiJ
	nz1oOZhfHiaPZuO5EM7ZZIMmvvuMUTr2wdq0bAZC3/zKw==
X-Received: by 2002:a17:907:7ba5:b0:c12:67d2:3d6b with SMTP id a640c23a62f3a-c2039d2648bmr526428466b.11.1786105520518;
        Fri, 07 Aug 2026 05:25:20 -0700 (PDT)
X-Received: by 2002:a17:907:7ba5:b0:c12:67d2:3d6b with SMTP id
 a640c23a62f3a-c2039d2648bmr526424066b.11.1786105519943; Fri, 07 Aug 2026
 05:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
In-Reply-To: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 7 Aug 2026 09:25:08 -0300
X-Gm-Features: AUfX_myz0xLBSU21NiiwHaNKz0JlrAWhqLCIPB9tOEADbE79qPnJz3NgKL-BtIY
Message-ID: <CAABTaaAR4O188N6wazEuqMMUmMyWFxr2oX0WhyS7Hw_CauuC0Q@mail.gmail.com>
Subject: Re: [PATCH v2] audit: free proctitle in context so it can be re-set
 by fork on exec_binprm
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@parisplace.org>, Steve Grubb <sgrubb@redhat.com>, 
	Roman Dolgikh <rmd4work@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 6:17=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com> =
wrote:
>
> Between the actual process startup (fork systemd) and the executable file
> replacement (exec), systemd sets a temporary file name (executable file
> name in parentheses). If an auditable system call occurs at this point,
> the audit context will latch the temporary process name into the cache.
> This name will not change again. The patch clears proctitle into the
> audit cache when the exec call is made, allowing the new process name to
> be latched.
>
> Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
> Link: https://github.com/user-attachments/files/20751461/fix_audit_procti=
tle.txt
> Link: https://github.com/linux-audit/audit-kernel/issues/170
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v2: simplified to call single use directly before need in audit_bimprm
> ---
>  kernel/auditsc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6610e667c728..c12b5dfcb279 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
>  {
>         struct audit_context *context =3D audit_context();
>
> +       /* clear proctitle in audit context to allow replacement */
> +       audit_proctitle_free(audit_context());

Since we already got the context right above, it would probably be
better to use the context var instead to avoid calling audit_context()
again.

Otherwise looks good to me.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

>         context->type =3D AUDIT_EXECVE;
>         context->execve.argc =3D bprm->argc;
>  }
> --
> 2.43.5
>
>

-Ricardo

