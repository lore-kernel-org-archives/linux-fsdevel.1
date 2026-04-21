Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4F3BC695
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776422; cv=none; b=BJH2PD7oUPB2S3fFBqc4IwyjDO/PlJfS7x/giYLssn+nWcrkjfyiswmlUdWz2IhXpJJGOrLB2hl0vRGkGF0FM/ciCOUG3f3hHarg8s971MNnZ0O4a0ltOnvHBQIHm7dAbS/LhuJZYOT74F3HW61tZsJOZADPxjwplunVy403O2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776422; c=relaxed/simple;
	bh=X7yqPotbiLP3hmcoreTzAxwZf8JJuC/uXJUvNDKuOQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV3fYbThxr9bzlcEdKjdWiuaqBvszerngUrgPHyyt8NKl4zpU13Ck6DchBe8QdFOuVAw90l1JOmoOUjSWkAATug7UwphmMRTv4f15RVVMnNUojzfA9FAv5nKhi5FG1FlTRsVL2MoQO5FhsMxErppClKjNeTbtRE8WPHAwguwl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCpdTRSh; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCpdTRSh"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e936caafeso42177461fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776417; x=1777381217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHcpARBD+WBEWOxUHd0dbjlxtFt9jhg3lz7vuIXHzEo=;
        b=cCpdTRShr+sMmihxE1SZUS8D22dZec7wFqYT56gyAIsxH6n15gtjBX4nooXPDNG+tl
         2nyJevN+Q/z1dH9rTckZ3dR+fnibHRNxtvZNNBPkQJiKiFKLfAvIQ3RhQlYGVEIt84wd
         /iP+YAODBhr4XsKSHPDns6tjvnT5bgOLTs+/cocnkaXnhe2cxZUkcOJi9qto3pruGSjm
         gkVwRk6Gqdz/0Gylccz6P6/EcFvp43vgfxetkGsM1Pv95dzo+fyzUEHjwYmt89AEZ5/4
         itYZGQVm4DPSKaMIg+iWHA1VOBwM4Ue8wA3usqJkI7ltYVPUmGoehSS6M93wron4Mfk3
         nSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776417; x=1777381217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHcpARBD+WBEWOxUHd0dbjlxtFt9jhg3lz7vuIXHzEo=;
        b=X081KdBU+SgG1awFisqJb9pw+3IN34iN8Sv9v2gfzHZvSUnLRdT0fhyFmhP65BYwwn
         /2Ioa+IddWxGK57SgDoaZwP/4vyY/KWCFYo5M6pAcfxTD9eFEJqZ+LOJVF13VYjwbzHe
         7lNri7wqNFDcCLTwR1OPeeGsqliOYZWI5mRBSLc+f2y/PXTJ6vHOukZAZxbVwGQkNDrm
         PNsusaKZX1kaC96lNGCrx5rM1UbUNrJLhawl8xrAnR5ycj2Ovf1PifJGVIzzP61nJStD
         nsFDeY4W+ITWOa1c8NWjeJSXKjbZ8K6EN63Crhu16p8gFkf1FDLYRrThU/nzU289TcMu
         Lgpw==
X-Forwarded-Encrypted: i=1; AFNElJ8LElyE7WptfeU4fHiGT8CzlUaUjLjWrNdvuL5yoYWW7+tI8D0cu3Z/udahRtqGqCKQv57OzKYYf7PCG/dX@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXZWb/NgeCquyHsGaafUtF4sww2wGJekGDpBzi+X9Nm0u783M
	NoGtgsatLNIfMB0TFl9MEanyiQbW2BOCtlQhZLG4jkj0yMyJ7IsNWGA=
X-Gm-Gg: AeBDietuQr6b7HMybspqVH5ZHQgOxpSGzwERGdygW3QcitgChO6+YE3PHA3sBHlCck9
	JpQdthFkYREBWOsXNHSRKbLeFZ8tD18nxttK+G7Ge6USkKasSxP2UHb+MVpc48UQxM3yEsLj9rC
	5rnXpI2iXAhGnSZw+5ICQUdI+HokD3JBAt7V6NEU8UmKWroSgd8Nmsl1NcukiRTilIZ2D3Lr5I/
	J+Byr6n/eek/UK3xnKMexVncN1qvTLxHkY+KvrO6jUxbPdCc5agQl1yVuhutufIB+rqrsnxssnn
	QLD+9+6N1p9jUkGWXrNmUdt/OSumrF4m14sRnHGr3R+2+39Gn6QcMdpRWUGYt0A/I1quv3V6OxZ
	EdYbpZY8dsfMtaMh2ZzDsE69sBTzFBKplqMKkb0MXQbS2k/0XrIAEIwSbcqSwyin3oOUybI7SJ4
	ne/PFStRQsPSwKPQsYAz+Uj1YrLA/1M/JcYgJp4uO+ORtBaXRCl36vY6b95wOpj03FB9lUxCpcy
	D8=
X-Received: by 2002:a05:651c:154c:b0:38e:33ba:51c2 with SMTP id 38308e7fff4ca-38ec7b4ed43mr50748521fa.29.1776776417032;
        Tue, 21 Apr 2026 06:00:17 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-59.brest.telecom.by. [46.53.134.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f652asm28640821fa.12.2026.04.21.06.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:00:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:02:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	wangzijie <wangzijie1@honor.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Wei Yang <albinwyang@tencent.com>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: use strnlen() for name validation in __proc_create
Message-ID: <40e8e922-7962-4ab2-a0ee-8475701b1110@p183>
References: <20260421122648.56723-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421122648.56723-2-thorsten.blum@linux.dev>

On Tue, Apr 21, 2026 at 02:26:47PM +0200, Thorsten Blum wrote:
> Replace strlen(fn) with strnlen(fn, NAME_MAX + 1) when validating the
> final path component in __proc_create().
> 
> This preserves the existing name limit while bounding the length scan to
> one byte past the maximum name length. Handle empty names separately,
> and treat names longer than NAME_MAX as too long.

256 in the code is really U8_MAX+1 (see proc_dir_entry.namelen).

The fact that NAME_MAX is also 255 is a coincidence. I didn't thought
about NAME_MAX when writing this code.

Can you just change 256 to NAME_MAX?

	/proc/alexey

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -427,9 +427,13 @@ static struct proc_dir_entry *__proc_create(struct proc_dir_entry **parent,
>  	if (xlate_proc_name(name, parent, &fn) != 0)
>  		goto out;
>  	qstr.name = fn;
> -	qstr.len = strlen(fn);
> -	if (qstr.len == 0 || qstr.len >= 256) {
> -		WARN(1, "name len %u\n", qstr.len);
> +	qstr.len = strnlen(fn, NAME_MAX + 1);
> +	if (qstr.len == 0) {
> +		WARN(1, "empty name\n");
> +		return NULL;
> +	}
> +	if (qstr.len > NAME_MAX) {
> +		WARN(1, "name too long\n");
