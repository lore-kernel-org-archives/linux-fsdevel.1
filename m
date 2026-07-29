Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7EC38DC66
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338081; cv=pass; b=GcR9HjBn3nWsnPoIPm6UxoUdTBA+KIku99s61EQsOTWNzvQ+AeK2MyGQFMjKddzvYbHRuTNwBe3JAVjcCM1d5Xs1+d96ryQ2gedQ7ERT4tqyELpqEQKcQD+AIWFiMhufVXaKqRjtjnhpBWGY+wD7hVdDLzVLoK4xnHtXXCx/x3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338081; c=relaxed/simple;
	bh=KniBoIarsC6jUfj7//g6+w0nFYX+NXfQld1kXZSXya0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyvAhGBclulIgACOHLZ8hWd2VAAjXJ0nDNE2tQnnOK9K/4D4/DizQTM8XGx+DL6/j9qeIHAyM/ne3wYGlub6MimJgMmRqi2Xyw05L82/JviM14gOcvxq+8E4u32AH7FyUH/Ks10qVZAxovFpcrCgeUvyLVHAmQdExMaC1HVYmNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCHBdVF3; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCHBdVF3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so7421116d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 08:14:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785338079; cv=none;
        d=google.com; s=arc-20260327;
        b=jsRJoCFpGsV7M3hLbo+h2/W+y4APIAe80uhIpAqtsmZgNGdb/lpxk/A7AXeEBRepK5
         YZX4A3s8g+FhYicacbwggNylJdTmlPdBUpxoK3iy+3oJmktbWx3UhuVHmNEFJD8a5vCN
         7Rk9vyzct6lq9d5YsDtuxICzhGeti8LftdkHqfMR6rGuxJrmCBscxPXh+XuAgfDcit5+
         Uc/A5xw5c49+N1TwsmRi3Y9I2E/hdj9V83r05Y6od1l1fE7mYKudcQticJNLBNQOtk3q
         aEHv9Il4gPE7vv9+VLB55FBOMjTkcpsZLzT3CpYIrnppY4dz4+4Edj3YwWDQpt3Osog9
         28Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4mL+pZBLKUHZONupNXvHwCPfqh0qQgUJdm2KEVSO+i4=;
        fh=O4HdkME5dJ5cS6iPcxnzzQctWbz1daIPLkk+jRTU3ts=;
        b=k9c/UYj9NLqTiFrSlZbaSmwSeS9oIfuCAG83eLbID1q33Xcjusk637Jir+7a1Gprjt
         MNGhLMkwTZHuHmLniui4E2SqPLV01pSMMaPsZAJ2luWpNfd4o5YtpVXNU7KpNv05FjMI
         D7nuSj4okMAAgkc0SLY2PBx1r5UOvwwUwEtDs5K8IbZjnSah6Bg+asWrThtsLVsBgMvr
         +rDIzSmQYEuKoWyl5lrjLyBMnSgARMa0/bii87nlZHc5wL3uRoVfKmfX4UtZ28V/E92d
         q+GESgt1B5Kgc7Zu2LbTbSCcha3gIWQbSyqhnSqlspHtRu+DFSKfGDvJam+cNINSnz5g
         1h4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338079; x=1785942879; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4mL+pZBLKUHZONupNXvHwCPfqh0qQgUJdm2KEVSO+i4=;
        b=fCHBdVF3j7QYulhKrn72kW0EZ0mLeVRO/W6UMENuMK1VxDY8ZM+Hwfl3NpKDQrfjJY
         eUP0/e/kkAOfxXQ1B/0OGP/QEzNbh6w76CDplFTsE61WPMBFmefgx/ZdobFcAkoZxerL
         51MkAfxFKMwIctOVN2RuAy+nQ+7XqRsGDaEfEoOIn/WdnpsTYa0wf6qihoelWsOR8Flk
         X0+akbNZ/3mCfuc6bapmCLwGMxiE00AgsjyP7cnhOsL+edtUtBbP3OlMkK/iFeJw3/jL
         lMH/Dzx4fuwaHpQIY4cuX2nRRKGfyd77L9u47pmcI+u/RxcYSy3EYe+lSghbWVJJbNf8
         A+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338079; x=1785942879;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4mL+pZBLKUHZONupNXvHwCPfqh0qQgUJdm2KEVSO+i4=;
        b=aDBSojZw778ZphY1XsbBHg6Qcpq7CUV/BWvFi6mssxVOa7l4gl/efivHuWuietG/kn
         +iiUqKFwhSDJwJt8S+OIg56PIiIU0/xp+81ZHIWtW+238efPtPem2J4fL5Qdi2f22Erd
         CQYLyLnEn4kVZxR+C3ZVQiNTYvYah3UEvSz+Cwiuq0YssIUqzTllCJdp95wsPDqZS7bW
         uN0RFK0J25evR0YM2HUV4wY8kPMti+7y2EfJwKPPiwmc9lm9fWg3pzirAaeOvqApz3PL
         ZE+VCpFf4Nf60n5y0nB+wY2jR+nPecKdTtkXjF2kek0Rx73v4wz4OXbDYHgIHpn/0Ycz
         H6wg==
X-Forwarded-Encrypted: i=1; AHgh+RpqREjudXEzYjznjRf5I0D3FqJ0WgCUrzGelMN0sYn7oBn5Wk826+ysYcW4WfSUe31DHWB5r54JUMvXR7jX@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWUyJvLZc3/3AS2xB5uWP9bQvjDf3Y6UtFyYprGQRmv5vGYkp
	sOut0ROKkRKQQOEmRyKdXXu9bHX96Jhe6otxeKUThTJZUmalGsYYTwnwCUs6HgqudHz9XoIlUEP
	rOd5V4CcJzxRJxeh6KOwZL0yCpwqSyog=
X-Gm-Gg: AR+sD10Mg6DFU/buNcKl5Jsz2b6Hp534m2JijE8AtdHm7B2HzFTmz9e7fY5Bgshj2iJ
	LrdlZflLn/8g5PCoUVChp2ag5DOjHgCobtdbk2DeHkCht+15aqrbgaa6Z3wLXiiik6TtQyos7CM
	8RjSghzMJEZiFFBfxi1GuHLyaiYlDZ9o+9uwHKwCpXGd45Crxfq8jmtMz8GF7ERSGwtvWxhVUku
	C2ZiX5mGQCuJTIHCQxLUs66ZxlZZXOR1KU8X1q4OjvD7ilKW+jWK7xQldgVXGNvm0a9d22ZBZWC
	hsIPsXxbYQC9Lg73exrkX5l/Uk5d4ZwCwIx6+NA6SPMHlIZviG7Sc/yFnDYDEKCrqiOwyZKil9P
	M
X-Received: by 2002:a05:6214:1c49:b0:8f0:9d9c:52c2 with SMTP id
 6a1803df08f44-90816fda807mr75724596d6.5.1785338078814; Wed, 29 Jul 2026
 08:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dc0f6f41-84be-4a70-92db-89890bded3ab@redhat.com>
In-Reply-To: <dc0f6f41-84be-4a70-92db-89890bded3ab@redhat.com>
Reply-To: mjnowen@gmail.com
From: Mike Owen <mjnowen@gmail.com>
Date: Wed, 29 Jul 2026 16:14:26 +0100
X-Gm-Features: AUfX_mxOsf8nR1_TDDFPIP3g1TG9HPoPWC0Uh7jI27irRhLVewASuT0qGGW2e0w
Message-ID: <CADFF-zfEws+xZ_tOqhC8uJZAFZvwMDtZ5yagDP9x7Umq6zabDA@mail.gmail.com>
Subject: Re: ANNOUNCE: nfs-utils-2.9.2 released.
To: Steve Dickson <steved@redhat.com>
Cc: Linux NFS Mailing list <linux-nfs@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I don't see this release tagged via git here:
https://git.linux-nfs.org/?p=steved/nfs-utils.git;a=summary
Forgot to tag?

On Wed, 29 Jul 2026 at 15:48, Steve Dickson <steved@redhat.com> wrote:
>
> Hello,
>
> This is a fairly large release...
>
> A number of memory leaks fixed (from AI)
> A number of netlinks fixes/enhances
> A number of exportfs fixes/enhances
> A new nfs-iostat option
> A number of gcc/warnings fixes
>
> The tarballs can be found in
>    https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/
> or
>    http://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2
>
> The change log is in
> https://www.kernel.org/pub/linux/utils/nfs-utils/2.9.2/2.9.2-Changelog
> or
> https://sourceforge.net/projects/nfs/files/nfs-utils/2.9.2/2.9.2-Changelog
>
> The git tree is at:
>     git://linux-nfs.org/~steved/nfs-utils
>
> Please send comments/bugs to linux-nfs@vger.kernel.org
>
> steved.
>
>
