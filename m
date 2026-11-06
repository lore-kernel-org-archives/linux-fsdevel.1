Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988636;
	b=5Zab9jY/YyD4O6ygCpT13+Wgm0qM3Nt7bkAvYJbW2oTtoqXis5uEMMjUq3mwRbQvIrWF
	 2WTntH+bWZ0KTaC9xCZob9/c5oGEl5azpXUTEa2SPZdqAejAD156V4NE7zRtMEcHpPIgn
	 1oGUURlUWzvpX/Xm9sR7nkrcA/HGTV44dvKT1LrcvndRYcn8iwkc0Cn1Sxn9F8kGSHJec
	 FM3XLMud2vh0qwmFUsr/wkBUqPaAUZdHXoPNBJtcNsYhMfn9DDesCBWgEMzEsi7OrUZzI
	 7n2xNh/VPRfrNQF0DdDrZIHbfl+XD4AkRTycQg0cBHMHkZPYX9vrTnrkXilYLaQGWEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988636;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=H7Xjhzr6DF5SZMmFJEMnASxBGf/Gmuq3UHu0ZMOBjw0=;
	b=uLM43bCKEKEPsJyvFNBQhYAOpJC2IQng0b19TOUXHzdUBtHG7Jw3gve59bIX5J/OOgcZ
	 xBh5fVySmUDLL+BjowzFWv5Li/FXwbfz2wA2O7+cDTUhjoGRQCqQG877+oLF4itcAfssP
	 hWB5d0TgDwASq3bTfpv8SSGJMeK6dltU3uuJ8FgJBrPcRAfs4P4EEMw2VVwnD8bo66bcQ
	 Bd+iC9tP9H/2+Qa4POsV1LK3NkklWn3kjL0h2jdazHMoKuN+1W/LhbNQHojVVkDetiHd2
	 SBUoATSy0YwCC2nESQU4MgYjIB6vangE9V/YXOAlUFoK0h0oE1L6pYQZvhfxBGi4TXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCFD606A32C
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 18:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCCFD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4cc89e86e4dso1102869b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 10:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988635; x=1794593435;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7Xjhzr6DF5SZMmFJEMnASxBGf/Gmuq3UHu0ZMOBjw0=;
        b=Jp2ID9PPpHSU0vOcK/RKBIFgi0vzw1giH+dQ4+SIGdPJH29YeVnanemB8/wlRGD6G+
         pSAa4hkYkvlOQlpc8I4YVFiLxQXobZ9drGdvsBWyxfXq9N/7IC1e3uAinqNpoBmTsul4
         l8e3Mtf/VHjrdPxHkoi5Jj+9QZmXZ7ZDzoLOoe8ACD0lplm/Pg6ukUExIYEpT7dDQDN2
         ZCDNty25eWBIuyN1sgHfaFW6qZEjDTRBlBD7Rjle14qxs67+dMkLd+kTKuN8ZX7ISJxd
         qGyD/z80D2gk365QZRIYdad1Lt+sXXBkCQTa7b+EsmYQ2WPEtPLF2Sjb0ZOh1sSt736Q
         VvPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCo6TDn/H7FC3MAmJnQCZNi4oAQo2ddE3b/Z6pSahHEU0xe5PO7AQwKP4xbWbHhgjjsIU8VPhlyoY2zms1@vger.kernel.org
X-Gm-Message-State: APuU4Z+o9MqG/Aen9rLq+alAIjdjymCDFjB6ispixKSp9crbuW6AzA41
	JP8QT6LYRpnA64VZans1q+Bzj1nAZD58GFWKSTQEWJZUkslq9UIAvTyq4amkRSdkwRIPU28C8Os
	D1TGuTwk/bdw3meNzr93yGqPghzajF1MgQASYWHjFDtJ14ApVIeRvnJiY9c8=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:15a5:b0:55c:928:69d1 with SMTP id
 5614622812f47-567e16594e8mr2338851b6e.56.1793988634984; Fri, 06 Nov 2026
 10:10:34 -0800 (PST)
Date: Fri, 06 Nov 2026 10:10:34 -0800
In-Reply-To: <20261106181031.1446-1-drifabdelmalekmohamedsaid@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aee181a.8be4ead1.3b45e1.019a.GAE@google.com>
Subject: Re: [PATCH] dm cache: fix divide error in too_many_discard_blocks()
From: syzbot <syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com>
To: drifabdelmalekmohamedsaid@gmail.com
Cc: drifabdelmalekmohamedsaid@gmail.com, dvyukov@google.com, glider@google.com, 
	jack@suse.cz, kmsan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
> index 1a5072425c4a..2d40d6047ef1 100644
> --- a/drivers/md/dm-cache-target.c
> +++ b/drivers/md/dm-cache-target.c
> @@ -2383,9 +2383,7 @@ static int create_cache_policy(struct cache *cache, struct cache_args *ca,
>  static bool too_many_discard_blocks(sector_t discard_block_size,
>  				    sector_t origin_size)
>  {
> -	(void) sector_div(origin_size, discard_block_size);
> -
> -	return origin_size > MAX_DISCARD_BLOCKS;
> +	return div64_u64(origin_size, discard_block_size) > MAX_DISCARD_BLOCKS;
>  }
>  
>  static sector_t calculate_discard_block_size(sector_t cache_block_size,
> -- 
> 2.43.0
>
