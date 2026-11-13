Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583207;
	b=cyGVUbn6NFqI5+RCDTzCC6EDhcs5vzZ4lOg/5DuWaPUT1on8FybEo8XNXYXgwnVUOWEI
	 Nsa1OEKfxot8+vJOfCKtbLTF713HnFv77rJ6psr0RpWh1Ryy0OYez93jTh2FCyxzEO/w/
	 uWE/y2irpoKeJpfDVDsalwTkDq+oGSFYwdYwYm6R0bSeusHIdnfv69YUj5ZoCB1KpjyzD
	 j/pYIEfTY2kviZAl+hjS5MulEZgXx1jVwtkzUbgumqv2E1h1SnEEyHGuiDtHuPCnzeZzO
	 Pg+juKvg8h2W1HiOM/RiEONAQYK2joKnUp0ONhWRBI0dd4pl3YvEDRl9qa7q0anUvdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
	b=xtSYFRq6HmbFpstB+AhP4Vik9g96nTizi1aKpElZiyKgDGFwVEikYd7KKckIhu0DIhp2
	 0qe0/x/JqMI2hFOBUBMQs8QCMBmv9i1nkxG5kQdiWkWPkBfprN8xSSaDlhaQpwEpF6UKZ
	 LHI3ZfaecuBfuPuN5KJi9+sCWkLrA0KQCQYoafHCe4/M++/ZOk/JzWlst9f5drJriVFhq
	 ZiOkQYcnD+eL2wAT45fZJMhB+vFZaloIsgEm9L4r/vKpwNMpkA9YD7iKvomQ2vjpdD+sa
	 vEsDmXDVKhDtIuwFwgh33LsNg18fnSTXC1Z+UHpW1ZQsV9HqSDy5P+oGympBu7kIHeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A260606A33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 15:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A260606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so19891845e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794583205; x=1795188005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=sFcMT75ewHSGlHNFmaIaCzRv51RyA+AmoclO+Wvr0qj7IRgdft+YPwpD9jRP6WK6c/
         JYnz5nY7tp8rDhhxRl839jDRSaCdOFEO37y9omk6Y6bTMpvUdRVO3sHs40wFUzQoK49R
         KDfhcSnlxOwqISdXag2i2HeczyJwl3JciKS1IO4IueILgI43L1Jav1Ck2sEsLOvdW8YJ
         xsnD0k9f1YMungKWzdWfs/wgCnEVQku2SHGreep9hdKIBeljPxLy6tKl9GtdE53m1rK+
         tr1h/mPnq09YX6erwWu4ZIbwvv7uEDWKwAiALSZofPGlkAv/kiWcyL4UzspYLPPPopZN
         ldpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583205; x=1795188005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=fFX7nfVlTHer2G7xsZuex40FPqAUFinTpZ+P6ZIZsnXXks7Doa94s8/YHVnssMGyU3
         oasFh6R4ojzn3mrSrkp12GGL2NWxfmpaMLZUKOy7pe06B9+xCSmT917zXybmpkUD9vM3
         Cwv/Hc780EeBH66D5Rb19VREbcmoAu2MboZg04cbtIlPp/rTxOyov5P1YaWNTijTJtNW
         i/Vg18Unr0pKyvhIbGp1SZmv5Q3JlxlC1xMfz2svy0uTqOmcIm1c75Ny5/yO8clzepGJ
         K62btPzEOiVas9Y13NQAHWwfY4Jg0mzXw0rdUzptR+EG3mwqEe5n5EKs9HPS90Zr6ebU
         2now==
X-Forwarded-Encrypted: i=1; AL+hErHG9cD01jBP7oEkq2i4D6HHc3L3oK2Ow1I1Szt+XwY2N0OFXxiLCD2zDGmgFum6nMiX9ZvQw7c15fbD4a12@vger.kernel.org
X-Gm-Message-State: APuU4Z+fL75uw0TyVTQMBqCvYof29qUPynF3XzC9dB+Ah4yAE/CxkzxL
	i/Vud1shS5+4DL3J94jReAptpBWee5j2peNketAnrXlSKHPhQPoC//mY
X-Gm-Gg: AYBFou2R+hgoVMIyzdfPDE8+/ywNo4gkNWdCdfV44a0MHAif3atRCwSwIBwXgXwpFRe
	GTdlPCykPsrSbFHUeXVZwALm0HrCkQBjL6ayPoKk6Jy+n/lV71rfqZJDq5pAcXCecoepHjFb6DB
	Xvax3cAROHc31u/BMncErqyDoMeMDjksg9iApFDHv9BX7aefLuuaHL0CZN0epCNpAcOUyhv7xZt
	7yMdBj+CtFI+4rwvnQC2krGIAXjItR0GYcpd0EBgFDn5MEVRC20LaaaGRn55UTMdxVKU3G5Y9yg
	MM4Lyy8SHea/i+RcZi+E3F1xue4eoSNlAFSRPMxcGEeRBEPuzK5Pd8qFQ2SUjJt6w3vsPlM0R6b
	Uw9WkRqKqUU9vPnHMbdSma4JcsM0aPoxxzsHOjTx24N+dprwjEcnrcvPb93Khwoe56G/3z33Rzl
	ijnX/RJknWaWzluI4bmMFE4BRwTgamLK67n95jfxYHWsAnPcP0MFP1FqdBgiBa6GYLlokETgvcD
	a4h0nLAbW74tiL1HIvwkxYkLc57jLt4AiaHxi3AEo+1xKtqbpeFEX1+m7frWa/dPmA/k6ACkBHG
	eLWtc3eQ8v8wIcyEanA7NQr/0tTo+8zasXWMDa+o/6XtUsjWZXyRYLZ7tq0RN5hrrjHDuoPvtQn
	jU/3AopY07fs48EyWyo+2F2xjAw7Zs4+A3vbtOdK0RVNWLLWOMgc9DG95d2FTMiPMU9dcbwBGjJ
	dGDjX/yXbih5x6RxL82XL63OZmRUTc+ab9CEl0ztplxfBrQW8vYL+KzbqrcmF37Q64tgWXhNxSN
	Q2Q5OzRQb0Y+g==
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr67471255e9.20.1794583205214;
        Fri, 13 Nov 2026 07:20:05 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm159789845e9.15.2026.11.13.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:04 -0800 (PST)
Message-ID: <a0a6a72f-0ed5-4f1a-a93e-30bb99338045@gmail.com>
Date: Fri, 13 Nov 2026 16:20:02 +0100
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
Subject: Re: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse
 splice on writable opens
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
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
 <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
 <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 16:11, Tejun Heo wrote:

Hello Tejun,

> Hello, Krystian.
> 
> On Thu, Nov 12, 2026 at 03:17:01PM +0100, Krystian Kaniewski wrote:
>> Read-only opens keep splice support because they cannot reach
>> ->write().
> 
> The patch looks fine to me, but I'm not sure whether the read-only
> exemption is necessary. Is it addressing an actual problem? busybox, for
> example, just falls back to regular reads when sendfile() fails with
> -EINVAL, and refusing splice reads on read-write opens while allowing them
> on read-only ones seems more confusing than anything else. Would it be
> simpler to refuse splice for all opens of the file?
> 
> Thanks.
> 
> --
> tejun

The read-only exemption was only intended to minimize the behavior
change. It is not addressing a known user or regression.

I agree that refusing splice for all opens would be simpler and give
SYSFS_NO_SPLICE consistent semantics. I can make that change in v4.

Thanks,
-- 
Krystian Kaniewski
