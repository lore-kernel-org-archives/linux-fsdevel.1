Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611F13D25B6
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491725; cv=none; b=HKw2WmRR9LtbxWndh/lJMGBv7falM9rjY9kgZMYC1ziUv8/tfQJB2ncRMTtvM08DVpXTZoWrREBIsL3PEJUvJtV8QbUq+WUd0I82CutFb3ncSX732VZxOCaCeXJBluMrZuf9O3NwKIZNSFVUAIRrtD518u0HpOWlAdJ/OfgCdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491725; c=relaxed/simple;
	bh=0FY7jKL7i3nWdtV5UjM7+2QUOG8pr5+5FtouvWun+Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCG0NaQ/azYn85kUldnh5EV47nT5Urlh0bJ86UN5j6k5yPSeXAJKo976lR35s6q468c5JQyX2tiheuBR9oA3uh4ez6WzTLdEjwwzU/f+bV4ZPSXNrB3rQ3v3pMgB/YTw8NROvD91k4Lt/FkMtacOfmJhMa7ZkKDhymTYQC0y834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIsP34oL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIsP34oL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c169ae1cb26so312995566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 02:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785491718; x=1786096518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+u78jPs6mbf9nu7a3juoU6/fY5OSZEmkTw029HZ1ME=;
        b=DIsP34oLLpnOLcCADogXHmkWP94OQ+LihHCEjzS2nUWh/hLqbqC7uL/vp/cGV9Okt3
         nrOa0qnez1M1qblU81WgdlCQ04u7SmTvuFIXJQAZGcRln1snMyrnATrOt0yTvoreHIAs
         8Tjv/jJF+dw1e4/OBHKOBYWH4Kto2gwmvOKsgWEeFDFdBI6Kp3mBuAV304ECbtSiDxJ/
         jZQjC+T/mAl4Rv8M0lkI3DYN9J2/iRgpppTOfWxf/WPANgpMAwemj6O++NuGQMLZoln4
         PJk/M8b9h3PHIqerTVBBvjroMXanVYNpkz2NXY68XQyH0KFtcnAXrsdcB/25UCNO9kZu
         Hplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785491718; x=1786096518;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+u78jPs6mbf9nu7a3juoU6/fY5OSZEmkTw029HZ1ME=;
        b=hRSXzD1dqlecRmYiqNx0ZawKImRHGCPVA/ykzj3f3oMfMJ4AKlgwUjJz/JTgjNseSq
         aX9j+AVzdsyN1T+M3/QvG0drN9uboqSM6xTm0xDaOs3p6x9AWwgpfxNhLtOja2BO9Amy
         8vdR4hWvjcfBxKMuRkOmx+MrXyY/ijxcfhuaYHLoMPY69U+zI669iFo4LCYjoU7em6FC
         Ef5UISXKuUW2yXNxIJfe0THmEMzGAjbC04ZEopYoLUje4Hd0ZhUl4j7oedpt6PxZIS3/
         o+OpPU1YBIS4eL9gnFRVzrYfv3r5T0PNfhxka2y2C9AkkE5TAqZmZImSJdOI6cqZIJbA
         0ccA==
X-Forwarded-Encrypted: i=1; AHgh+Ro82/wk6FK8roWlA5nD7zySAcjwHvlFJHX0PXuTVq+w+HQ47GzR9SnT6AjVTveIibHLKeaD8xjTbvm1T8xN@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6Om56YlWA0h00aKTDF6MACV+oseekvhBNFrQsdxQT8dz0kLZ
	dZ7zzbS9qfJQjmpXFYAQbnKqgP/e51dEbVVObi4WbV+DWMS9jFDJ8hT+
X-Gm-Gg: AR+sD13E801xCOW7bFRPv6TaVlFcqLOBvyHGLzYNg9hl2HxhX5vPQUqZpZLgy+sCG6C
	Z725BQwDcAUmUChgIXfrFvkkYJ3Sztsr+deVRrk2PXFoDFt4QmcZQbKojEm39cvbqRnoI1aL9dg
	6hv/r3e6gIPMfp9H6JwN0I5vEHWK3DwxFpI3GGYCGFNU8vZ25EzFQ+Z1OnArDhYO67geLpAUQLF
	3HmWj2zjPj4upLhHQ8Yrkr9VMa/ia1drQ099blvLd5DafIB8GWSgTWxW9y88UXH6M0o/wRNF4qS
	Y4PzhbFf+lldAobGK1lNUcyH+veQsla0f4EAQKtLd1SaQdSKNrp3wt5uFWC/LyVUEuJ2C4JwfYd
	gBmdTzlsh2nD2H9y7bPA4oqWjnYVUfQksY23Ksx3bm2H1PRv5hRa+urPIkdrCMnfMCJ1R6sJRB4
	cYmitKGieJPNVDHH7x1W0V00wDZwA1k9fZDXz4ODrUW893W4aliarvUvWN/Pdb1HV7GSi6fmZtd
	dTNq3TPypixmn6S5qq51ApRJ2Wy7mkOJjdOYgzSfomSG7Qum7fC/WDxiVfCVzHGSA==
X-Received: by 2002:a17:907:97d0:b0:c1c:49d9:4c34 with SMTP id a640c23a62f3a-c1fd3245942mr80761666b.11.1785491712646;
        Fri, 31 Jul 2026 02:55:12 -0700 (PDT)
Received: from [192.168.178.24] (cgn-195-14-217-60.nc.de. [195.14.217.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd3c5b0fasm90919766b.5.2026.07.31.02.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 02:55:12 -0700 (PDT)
Message-ID: <a91f850e-0bc2-484a-ba77-2138949eba58@gmail.com>
Date: Fri, 31 Jul 2026 11:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] configfs: unhash the dentry before dropping the item
 in rmdir
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+6b16e3d085833cbf3e25@syzkaller.appspotmail.com
References: <20260730093435.195441-1-vasilisalmpanis@gmail.com>
 <20260730093435.195441-3-vasilisalmpanis@gmail.com>
 <amxrCqfgaWnoWcte@gmail.com>
Content-Language: en-US
From: Vasileios Almpanis <vasilisalmpanis@gmail.com>
In-Reply-To: <amxrCqfgaWnoWcte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/31/26 11:29 AM, Breno Leitao wrote:
> On Thu, Jul 30, 2026 at 11:30:25AM +0200, Vasileios Almpanis wrote:
>> configfs_get_config_item() treats a hashed dentry as proof that
>> sd->s_element is a live config_item.  configfs_rmdir() breaks that:
>> simple_rmdir() leaves the dentry hashed, the last reference to the item is
>> dropped right after, and the dentry is only unhashed by d_delete() once
>> ->rmdir() has returned.  configfs_symlink() resolves its target holding no
>> lock on it, so get_target() can land in that window:
>>
>>    BUG: KASAN: slab-use-after-free in config_item_get+0x26/0x90
>>     get_target fs/configfs/symlink.c:128 [inline]
>>     configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
>>
>> Unhash in configfs_remove_dir(), while the item is still guaranteed to be
>> there.  A reference obtained just before that stays harmless, as
>> create_link() rechecks CONFIGFS_USET_DROPPING, already set by
>> configfs_detach_prep().  Both configfs_unregister_subsystem() paths
>> d_drop() after detaching, so this only makes rmdir match them.
> Is the claim that "a reference obtained just before that stays harmless,
> as create_link() rechecks CONFIGFS_USET_DROPPING" accurate?
I believe so.  Everything configfs_remove_dir() will now d_drop(), had
DROPPING set on its dirent beforehand by configfs_detach_prep(), and
once detach_prep() has succeeded the flag is never cleared again on
that subtree.

The race is closed by configfs_dirent_lock. create_link() checks DROPPING
and incs ->s_links in one locked section, and detach_prep() set DROPPING
and checks ->s_links in another. Either symlink gets ->s_links++ in 
first and
rmdir fails with -EBUSY before unhashing, or DROPPING is set first and
create_link() fails with -ENOENT.
