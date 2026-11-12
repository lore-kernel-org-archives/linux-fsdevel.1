Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492397;
	b=th7pHhv79a1p7o3N09BvR5YKlLrOb8WMX4Gf6TPAP2NHzK5hIkTWz85ZHCYjkET2VJRc
	 wsXGPLBSkP5YBcf4NZj3TMCa4l9u0GjyUfwmqzl2afcybV8UY6/TdJh52VrGd0tMtjOok
	 dMqFssIQjcS6oEvxRviwJlvPp7BhQzmiqX2BBxNISRIuEiZj89LfUA1e7R9zczQIHrY0p
	 qw+ixNi/BlRwD6dkJgIzcdKel4SXILRAVR3gZ4wBs/PCMlYoHiGDPE2FA7ybGuizwf5dw
	 1egwDH85XKtbCmrkQ0AFnBbwQ/dFZZBAb9YgBT7eASHcxhfuhp+wCl3eWLuUVB+Y/AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
	b=lLEkfeMa1y3iuQqVrQsGXZ/GWhytLdtKtN2t1UG7ccMNsHntZjVCDW6Kk6vvaH7zTA+f
	 +foQRoURl58zew08IdauTo2F07/2wwyuzU+m+VHSumq70HQb3zJ/P7apIn8XPLET+MgLW
	 +csLsuePP2wOPQ3ARX9XwBikaq6mqzeVA0kBpA5P0JC8VwRCwMuVMNvoMhMqS6do/QQ+g
	 4QdP8cTWG7T3ivQR8kTRMNercz2RTXP5NUaZFkkDATmqpIuq/VLzJs1jp8Z8ziNnItisj
	 pYrBUXlAS1hH7A4tKBon78YLZ5TqIfoYVwpWw7ma6pNBvf0RxgT4JLzemfRqC9gOaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231E960A2625
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 231E960A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iJ0O8ptU
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso698274066b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 06:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492396; x=1795097196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=iJ0O8ptUFgqzUF0HS2nnVTaNoVhPcmUF74R8wDy41neP7vq8HMRXJc7K5zqFIyWN50
         OQ2Kui+CINP4jSWel6CZfma+s5yUJ+g0EH99NZ3Zvfld8OwRHv88d2jr1L/vA3RSM74J
         HPRGuwMFgZ4DHsxcYpPV1O/i31el9yT2KWGfyqtInfS9sidP7NwZ60CxiXUOCROqoaka
         Dbs35OKCAs+OEVnFzQb2wsESoXa2IW/ATT6rBkW+P+HhV76RoMgrIgmiMR5kdb1KUQN+
         fmR3iGk+RPAT7sBQAKFNlKkqseCiRLmBwx64KRd2OABz+/XaX/jJSLMVvxItD5VFNZyW
         6qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492396; x=1795097196;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LXIm36iFMZ8kOBujPBh4eH/qjfWvYnVfBxH0cH6iwsM=;
        b=gzBRSH4oTsVdyuoPVHivFv3r5aVX1NueqwhC4Oqup2TtwuYvKJ6R7Kx5WoKFxJSFRz
         T5DXB6aoV1NVpkbBsI0EhHUPdd2iVac7OUhBBj5gAWCBZe+RoL4yO6Ii0hScThY3UZo3
         TjQ+HH/K3P1yVNjmoLf8oy7bnDdKkt2PQZUwO7QpGUGHqvdP7CstIe1/FC/qlPWaOmpP
         ovT5lv7msdEi+FenffZqg9Ss7EVVMXaGsqX4RQm4TmMSvF0xMhP26XgumusAcjBpR/x0
         nAndrDCkCWKDuzsTD/mdUO8FHwxSt1Dg3Fa8N93mCa1pAKvC9dgdVp/RAdBfqdvKZJwi
         eZIw==
X-Forwarded-Encrypted: i=1; AL+hErFDq4emVU/lRfnjkrRtivXW1y0xrdsRz4zx0HJqqkniJaAwXz6iugUn9DBT+Dda3mvbHB9cqAHZrCa+9NOU@vger.kernel.org
X-Gm-Message-State: APuU4Z9cSgZr+TaScT1DUAtqgO8rUH2saMwEdNCiEP90UIwLKTTaKn2D
	m01vDzAr8pbPOUyqqbr1JxiLMMthZzDb6OIH2ZGTgJ89TpDC+Nui9pHg
X-Gm-Gg: AYBFou3SgCL1Bmp79KiFCWLJzT+jvK4IWRoYrg2HaTEqKoDtOK8ldjfTiCPaNEL7aKO
	xppD9O5zPsZll53JdZXy3dc+xXObxApepFW6ioegnB2edXaEQY/h4XgbOCQiAWdZG3enxlFaIr5
	emutBlNTsYsWTrsTMq8q7Xyt24gBojZ5PNgzD/G937AuYzLivjhxDDzpULI10mFNO4jvYSK2rSe
	n4AXPNL95/6rZqckZj8Adn9e7/TC1yTIES/zCKfGkBeBnj15NQ88W4UiCnxrxCGmUOMV6izJShb
	6RkkrooEcFW9MzBV6w4wheKBNy9QBrWBSoV5JWKZgSOoTs7loi1hLcDitzu6WDSVEOJMT8UHmbo
	pFXwMulrr0yj1GRHrOaof1XhOeKKiaoYOif+YEIv4afgGTmOy4+lMy8CDN2V9TK32rmpO0TX52W
	TI1EGdY1qtFohc3AZendtJH/XybPwNIIka3vUBreyDZ+arRhDliJZHBQTzLHutHmrIFz/y/vlwF
	b41DuiaeyHVvWgr74kZQG40McsMYvm2jqsSRVko9gEJkMRIuZjxUrcjCyvDK+W1DIwWjzPbExyh
	Js7zaPv9xMOGJR/eVCfAKQsLFmV0Ow5YoAyTrSqNjDpnKEvCyg3d7p3z01lLN8Utuk1qLd8c9Hf
	rLvLSvuLw5nenQ1vC5XB4/X1/3EpiGu9tMk+6ImFvSvMx3sA31o9B16W+FtqqTa6bD563PufnFM
	yB2WzyhYhYx/rM0WGN3CjhVq+UO3dcAdwB4iob+AWcJP4eYfKUBvW0d0F0ntWaqj1z3Z4b3B1rr
	GL8mNgW85IcVg==
X-Received: by 2002:a17:907:1b1d:b0:c4d:31c5:e30 with SMTP id a640c23a62f3a-c5066d3db13mr442488966b.49.1794492395421;
        Thu, 12 Nov 2026 06:06:35 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593b5esm363017266b.34.2026.11.12.06.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 06:06:34 -0800 (PST)
Message-ID: <c1af6845-bfa6-480d-a240-7b918331234f@gmail.com>
Date: Thu, 12 Nov 2026 15:06:33 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <cover.1793715774.git.krystianmkaniewski@gmail.com>
 <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <c943b8e768ef766b0f6563b6085e99fe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 16:51, Tejun Heo wrote:
> Hello, Krystian.
> 
> On Tue, Nov 03, 2026 at 03:57:41PM +0100, Krystian Kaniewski wrote:
>> Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
>> marked file refuse both splice directions. Their of->mutex and seq_file lock
>> use separate classes. Read-only opens retain splice support.
> 
> Can we be explicit and name the flag after what it does, e.g.
> SYSFS_NO_SPLICE and kernfs_ops->no_splice?
> 

Yes, that is clearer. I renamed the flag to SYSFS_NO_SPLICE and the
kernfs_ops member to no_splice in v3.

>> The new property cannot be combined with mmap or preallocated buffers.
>> Kernfs rejects those combinations for direct callers, and sysfs rejects
>> SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
>> Binary attributes do not support SYSFS_LOOKUP and reject it at creation.
> 
> Can we keep the rest minimal? With /sys/power/resume the only user, I don't
> think things like the mmap and prealloc combination checks or the binary
> attribute rejections are needed.
> 
> Thanks.
> 
> --
> tejun

Agreed. I dropped the mmap and prealloc combination checks and the binary
attribute rejections. /sys/power/resume remains the only user.

I'll send v3 shortly with these changes.

Thanks,
-- 
Krystian Kaniewski
