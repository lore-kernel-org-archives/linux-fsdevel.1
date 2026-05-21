Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6A43ABD9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365959; cv=none; b=rnzI3204sR77U308WjvPUwtT+qDz316GfFK1uBPvxm1lnmtpfHnFzoKLmWXogJISQHR3U4NZv9WVGfYNGviNww7vsuwTMxLErdT/LfUzM9xhGwwdX69ynQAEJdOoV37hjI3hiOI7pWuYUlmG4gWmB1IvSoYy7plYqWoNVFzjaR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365959; c=relaxed/simple;
	bh=EFBp4+FRTyV05dvUMa8nEhUzqS/w+rF+fNGau2MtgGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmV2RQYj0+w99BRf7LXJH5sYgSqBvc9CFfb8mhLTxIJRB+QFr5UsGkzfWfJBhIhmRqTDTOPZBE3DeVBldgPybSH3XhLn+fLHoPWzGhhwaJLrQwgmnMmzShUoH4qUMkWgQW4UXCXkpqmLWE5TyZ3ISo4aiI1r0flJUWmaWCjJHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKUSHoGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKUSHoGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4C1F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779365958;
	bh=72Dlrt/a/jpMiirI3D3JOcmIqUrcjOkuCcPEYiaZiro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UKUSHoGX8qeVFCMynhA14hHNE0XZ5wZj/2MP5HTCmoK4j50yPQPl9ChY3rB0CU//B
	 jV/UkeQ+5/OO+eh6qLZuCfwjvloDPeUSueArg38wl6TeB9u8j2eTf7WqSDe7DfNsMW
	 dCZys/BuOuGAvSwSq+94ScbywItpF9M72BxjWDPpUG/XCE99NzhHUwkmDl84u3W2G2
	 bP2EWhzNSz3fQTjw+o6X2dnC5RI9rPzYP/1H310TCcvwEus/L0p6vNtpK94zsdjrps
	 nNj10lhW1PCaEU1gA3etRPxF9Sc9jkqQQoxh2h9+b6rDj6t9iCNTY/OGz4g31wsV6e
	 9zuHCXY9wXZeg==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b37d84a6b3so54280497b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 05:19:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+bw+iGxQEj6CcxxBtK27kN4CRoP6uIwinprp3wKYFjJlTHBI68AL8kHdz6/VWS6QtqWbyjWKBsmtNKGt4Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqyrukhNzC3YgngqAn5BcUROnF5dENQJFHk5JXEHrahYpXLsN
	CwnoXBI8giVVW7MgrmBDBfBPsyJhw0kJdcNSCdOMLA0144URMnq6CZOWY9WvDF3Ws7HNgkGreou
	V77m+NM0bhksIhmAsUl6jPdXKUBWnNcA=
X-Received: by 2002:a05:690c:368f:b0:7c9:30f5:203e with SMTP id
 00721157ae682-7d20dcf95bcmr26915597b3.45.1779365957527; Thu, 21 May 2026
 05:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com>
In-Reply-To: <20260521101751.591345-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 21 May 2026 21:19:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_usY7yTjFt92r5V4HGn_RTR2mhu7JFbVxSjttYivzrSQ@mail.gmail.com>
X-Gm-Features: AVHnY4JYtPhI6Y8Z6Wgljhqfx-zxTChoBQ7MWimCYKZgXpDzs3ZTqjmOSJ3o29c
Message-ID: <CAKYAXd_usY7yTjFt92r5V4HGn_RTR2mhu7JFbVxSjttYivzrSQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>         /*
>          * Convert the number of bits into bytes rounded up, then convert into
> @@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vol)
>                  * Get folio from page cache, getting it from backing store
>                  * if necessary, and increment the use count.
>                  */
> -               folio = ntfs_get_locked_folio(mapping, index, max_index, ra);
> +               folio = ntfs_get_locked_folio(mapping, index, max_index, &ra);
This patch causes a build error when applied. Does it build
successfully for you?
