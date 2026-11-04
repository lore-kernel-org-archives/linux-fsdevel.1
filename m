Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817828;
	b=DGeoTHbzW/QbMmnEExeAUwbjY8z9Yv7HN0HrAfklFkOhlBHxb6Z7iz76IDpbTD8AKr48
	 SjgCULtQ6Ihgd6//UM+jFeHJHwD1dQlpjBJBC9TY3qEf2TajIskbp9AYHuv1ed0Dtmrou
	 96szLTt1+s+zd2nfmLkCxOQvoIxBenVNBKcM5qtrRpZhboDJzvOrBefAw3kYJ0jQt4a0k
	 Y7dUG8jJ5Qn09smRHd4n6YotmRT+bKSH2GI0457mADvxBe/qsG3NZZqIDIWrcyrWb4zds
	 8fJY/Bv1/T2u24z1NDZ21nxvtwEYKwXnghtfHGeAEV+IhfVD5fPQy93YM1cVa8AnRZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
	b=BLDvB8rmrZ50aJEZJKvINP+PJoCWQHytZtDC/pCspeMHPgWU7xNEfD0aLOq8BTuqa1TX
	 R/GTpTAjUWTtvo8EpkT9ETBt38dutyU8wRb45RC/d2PJw9yrgYItQbpL3aimTn+nnamhM
	 5HNG0HOc9j7ORHzaHu9/aBrfXXMmrsXUG0nZ+bq91HKSqrVQSTZkIllHuxg6B5YvkADWv
	 c8ru+3YHu9iMSM5qaILOQXgcnL2+ft8ZE0r33g6x0YWqvNJuXSgKLfjO+nwcAnuo56sUG
	 165k0ooWd5KZ0McBcYDCPw1IqlJyk96pQfZQDSLsUuqXUtQke03TbckWy6Os/+C/xsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k30JlQ6o;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FA606D814
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 18:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E29FA606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k30JlQ6o
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so11238815e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817826; x=1794422626; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
        b=k30JlQ6o7repyugxA9okX1WWvW6FN3Y4mpdmzV+MGsTzBfy1md0wkJiqBfaFhJQURl
         FPHzitUXV8s8533Fr9N0pYiIPkywsqJKruic30k7FjbCgSU//FVm/XcJ1jGjZ+NH4Ne+
         SAYUaE6aeRgyWb2OpIhhH5493oL2UgWIgEpT34XZNaZ2+CuxKMN0zB8j/nXrzuH3/kGB
         6xWN8+ZyL6SySKGXH5J+vL4ImsKy+7SUK2I4orbXlmYwjw+9veZiHToJQDfvIChz10oQ
         BD9Ly6JywQbVg5LoekOehym4uYx3pFxXWW14Ka/xum7980kpSXVffYlyoiaBRmEYyJmX
         Bu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817826; x=1794422626;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3mQu+xhKOfrx/Y3Mf7/3+aL+zZ+r3DgrMalP1w3JA9k=;
        b=B9NZGzii6j4SQhBzE+W5v3xe0+ngutqMxMVmJp1OGT9Slrl4qPhriOwPpKq5t9mdF8
         nFVF5EGfJP3v+AV+MrXTmGKP0+gcwZCgnE+36PAilMgqpDmQAA09qSkprWuFaBrDHD5I
         uva51zGTTgOmPtiOJ/bl58tWGDlLV6/G3D58C08F1tIg63gby+6VPRL9ixkusI/i+Hje
         U1rV1IOMwu8m+yVt+HULfnxnSjz7jgzIK+74KWRC6y3ajitpvMwlAuBzo0aC0Pxt/RZL
         3rGo9bufqtDNlgXwVQ4/3RNKYparUXYLbYaqMU80MwW6utXniazcMTrq4SvFfWmKUUJI
         xIUg==
X-Gm-Message-State: APuU4Z8uLRut2NrZEczbrIjMCkDjQL5HsfKbtRj3PS4r9UCyTRfKOqS9
	tH8q6ppSpu20fBw7EkC11FPJ2mDNZR739PP9b7858zGa0c3qYYnAYlc=
X-Gm-Gg: AYBFou3Ub2Glx8rMDcLpunH2ozaxhanymeSoFKfDyAPWZiRdpo8g6UZYiN0q2y617Rr
	Q2bWJSHkrl/v881o91qH7HfuEy5WZTD1g98yJ06RzWQhOhKgSt2Ah7NxV2tfCUWk9Vzrc9usuXe
	sxgCEWc8bbo2r5PlXfwt0635frAWnLbuQOpRdPOVqzgJhixIcvfIYXUP19Gb8xCfpRgZIZjpE/J
	B8b7/Jb+0ip9DxcXoKAz3gU88iLZGsZ7QWsR6fa2NQkYZSZut4k9ybr/1hpv8WKZUCedCgetJqw
	JFKbd2gPX7jeN6tg7i6yL/v+HRuOEMnbwYMdvgZdZnTbRcLHxM977KHhOE0sCp2+OkkLf0ltXgC
	EEDYKEqixuW5QlWX/Ws9vM60tz9QCq7iL+8TDN9ZBQfoRKC45ER4AgH4bdnn6uktf2M3ebW0+eW
	WhEC9GXEAZlJLUvxhnzp2BXcY9FjsRH7g3Ojxz8CfqnsZq0nwBwchSLcrfxZdeqFpLcbRq+XItv
	hAzTb97wTrwcQw0+bgIkwOJFxB3z5veahQKEno2FWIIIlqC11Hi33AmNFyn8XaAlm8X7bGsmhg6
	G/U5Kj8CzL4zvU0=
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id 5b1f17b1804b1-4ac18a8911amr379507765e9.34.1793817826186;
        Wed, 04 Nov 2026 10:43:46 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed552afcsm5320098f8f.41.2026.11.04.10.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:45 -0800 (PST)
Date: Wed, 4 Nov 2026 21:43:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Mason <mason@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH RFC 18/38] proc: don't WARN about a name that is already
 registered
Message-ID: <9cb48eaf-72f2-4e9f-b979-1ead58deb22f@p183>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -401,9 +401,10 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
>  	write_lock(&proc_subdir_lock);
>  	dp->parent = dir;
>  	if (pde_subdir_insert(dir, dp) == false) {
> -		WARN(1, "proc_dir_entry '%s/%s' already registered\n",
> -		     dir->name, dp->name);
>  		write_unlock(&proc_subdir_lock);
> +		pr_warn("proc_dir_entry '%s/%s' already registered\n",
> +			dir->name, dp->name);
> +		dump_stack();
>  		goto out_free_inum;
>  	}
>  	write_unlock(&proc_subdir_lock);

I don't like this patch.

WARN is there to make bugs noticeable, /proc entries aren't supposed to be
created randomly unlike regular files so deleting non-existent name or
registering twice is probably a bug.

Now, some names do come from userspace but it is up to subsystems to
find duplicates and return errors (and sanitize for dots/slashes!).

In userspace mkdir;mkdir returns error second time, as well as
unlink;unlink. In kernel error is BUG/WARN (like it is now) and it is up
to subsystem to evade it.

	/proc/alexey
