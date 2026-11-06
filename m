Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988636;
	b=PFHoitJJn7+8+HK6E3YPqg0Yq9KqqgddWYDE29RkGUWnpju3Hx5vRQfglbXsoubV6DhB
	 NNLFQMzkE3F5Sn670Qe3EsvPCGSFmRRH3kEMW4UsXH18hYX2e1o9dhY6P3qG+xctdwbON
	 tZO3ba7825WKO6MyDIV+qH9eyZOIRlvhWS7zDI6EHh83MArmHYiDuhXAACYNI2fh+v9l+
	 JvHiqf+VE/z3eNVRh5ags16FecAatFXT+6/WYApRIFEdZZoH5lwvfOBkoaFGAf8kt2Ik/
	 gJ2u1mAB4U8x/vrRdU3ZURpZ+WL8gPRt2DQaYxw05iTpuoiIGW0LOuw8G+OZqFEHcVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988636;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=H7Xjhzr6DF5SZMmFJEMnASxBGf/Gmuq3UHu0ZMOBjw0=;
	b=2Zjdveva+XfJDO4O1gmiTr85pKTQG/TV8e3AUz0FUCHRnlP52qvcnvY7xY3vSczxdjO3
	 lpXKBehFffhOxxvo7V/mdkcuXidLroKw+hBQ1yc7vPdfdS4dxDBWmvMX0/hUTPGjKfbua
	 6l6EJTKc059TF6U6CoB5YO8JegdUMiIIU8SFdyyJD5Jv1+RNqLXlqRxLzrMNTlVLDjiHf
	 vJNvmcd5jY/p5qLAynNnwxfCx4tR7b9I5zKYeMcza/CV9AYYqTBfarVrez13U3riH6ApI
	 20/vunLuHfFOl0zho73xmFxYVwCouAGtW6KNn4lCWWdwegOsOxmemcwJtoWPm3F2aoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD7606A32E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 18:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CD7606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b2d1eb484aso1036988b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 10:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988635; x=1794593435;
        h=content-type:cc:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H7Xjhzr6DF5SZMmFJEMnASxBGf/Gmuq3UHu0ZMOBjw0=;
        b=yFiRMf+BFgaP1/RgRuPrYGkR3w5zl1NCAJ90wkMMXxzZY9NGg9CjdoW31RH/8Zs5Oz
         vYd5LozSmTLqKDUd2mozAXKLDQHAXhw3df63DHkc4SyniAxL55cEpB2I83yiki06N/6E
         clCv/WYlDvDak6jteIqE9DXodICCSV+MOZicV/mXOPnaxK+i90qNdXTi9PG1c7tR0Q2U
         8nh4RzK/Y+J7pu5yUmB39YLS9WvV+WEwh6TEmEG5EYMde3H8fnxGf0/oZY8o0BQRuTQe
         xHIn4ygUumlx32nvtK9nFFO+dW+N4ZR7v+ImN+iSS/F35mXKkfsHO9NtM0PuVSBwk0k3
         QEaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFQpR4ocAcdbCdlPy8/ll2RFRTJCX3+yn6p7ChHLT0IAsCc6zukBo7Z61q8fYMTEPKdGsNiOl8RtIjVfmw@vger.kernel.org
X-Gm-Message-State: APuU4Z9BbJWBvv/L2wjC53s+d0UNj91ku/2r8+jzk4WQ5hTXfzS+gBgp
	XumrGJaYEoj3iIFOok/PJwr8gyeX9j3zy7Mqw1DHHe+YPfN4pM/E/Qa+dB4tEEc3d3NZZ/KnHV6
	3jB9TaxYbJIrYlBadbz24bAHXOzz3ZS6Ix/fg9+41Eaq0YfJ109vsekWPZr0=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3a0d:b0:4f4:4eef:52cc with SMTP id
 5614622812f47-567e16701c8mr2303497b6e.43.1793988635141; Fri, 06 Nov 2026
 10:10:35 -0800 (PST)
Date: Fri, 06 Nov 2026 10:10:35 -0800
In-Reply-To: <20261106181031.1446-1-drifabdelmalekmohamedsaid@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aee181b.dede2635.b849c.0005.GAE@google.com>
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
