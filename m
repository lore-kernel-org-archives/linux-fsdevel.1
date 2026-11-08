Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165771;
	b=irhOmyaHar+vPReP+ZzbrJgrgStJf1A3deyWqRHWJWN4TafsUUS0JYQncJiA144HQKAo
	 A7PbVlAlEa2+vaN8nJdTPnXUUBrrW1TPIOxvNWdFr8NCAMSFCI/KySZ0PhoQFiDWVYnU3
	 yBQPaEXl/UKx1cC2LucLedPycnUhl90xdmTRW+Pue+dD/KY+D2zxRJRF5kUn0RgtR5Vab
	 iKdPv0OXl7c4pm5HI9qNVGpcA06+aewaLKrdP+i5x0JnHzQTwRYKL5hDRBMC/jLf7QLDx
	 ZFqk5r0qQrIekxyHYKEA1rMQT29bEVI/MQUU16t2ebWk1zfkIOggE9BL58Ljchba2bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165771;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DI5+oYzxxf+I5AkVpJRfiCXI+dYqK3qbDT75rBnUA90=;
	b=SPOKLF5Z2mnQVj0loYY1F2vWMU4VnxSF9I8UWQHHjP+U1JQiw63wLGO1XyUDeVCcEywt
	 EYAomlyfK5iA3+slj3m7v906RxzO+ek7cZf/2hdnDzcMP/d9Yne4Cx5FZorlsDkqR+8VE
	 qg/eBMRNDK6bZ64Uzry/s/MVFVdslzSiv5URG/34rfXO5s9LG/9E3Z10ox3bDGIH06iRY
	 0sQ+FH4Vc/9StyHMzxQr4GbLZfI4LG+0gUf/8bGtvup2FgykT/9VSO0AqkpV/NJRw2TXw
	 98txYt93Ff4nwlRxnEk33eTr8dzGJmiRlFisljbGeR9d6/H6h3ctB28c3MZuINSlF1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDCYfar6;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E77606A31C
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 19:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7E77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uDCYfar6
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso1368255e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 11:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794165769; x=1794770569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DI5+oYzxxf+I5AkVpJRfiCXI+dYqK3qbDT75rBnUA90=;
        b=uDCYfar6LTvsDSmd+Fo+lBbxFR2vWqrI6yXZbqkhVgCwg95kAfZmdQgvv3/xGkoFrA
         6vYDI+5qt/ahiosK5dGDX42VDeszxcMP20o1MM2zGNxCeP+E7CvFuKB7ImgvLZ44ooMT
         rHFDQT6Xq4dXg3T4Rt1Lxl1H+3cw/pBFTVGogpTNHFSIw1D6kdmWwLbGMZuT1rEbNge7
         4YJLVvFMpPeeOb4/qnZjQi7KpuzCPnWgrhvPVdeJrN+YNN8JyRMLIL1vtVf8QlpTjAE/
         zelsFdLVw+fr8+0lZst47sx1vsr0MqNwTXjVRtW5KjIvmS8Pb3oP5UT0Lpdmge72GWO7
         gpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165769; x=1794770569;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DI5+oYzxxf+I5AkVpJRfiCXI+dYqK3qbDT75rBnUA90=;
        b=ol0fXEsjPD2kfjDCwXWGPhRSjLSfIhsR98jprf68u87p1hHgL9tLBKK8AymMImFKJE
         GbLHtOfbCTeTvPnTqZzWbx+Fi8VnZzQrZzHELXWrwghVjGzAYZRbH6zQQpFs1dLkOqGI
         AXg8Wgce/N8ItXQWxljHSOVxXn3XcCUJi8wE6DaiHf7W+XeMAjFsscAonGTtuyPI4O5e
         Vgtaxc5tFpvhyJ0L4Jsl2WQr4reYh7MAMO5reMtTtn0XEf34Aytg/9CUFAC+4MppDr+m
         Eel3HQTyCcX9q8qIZCovDkQJbLbvFQV4wU8zPdrMw8z3U0H17a5xStn6MR+n4CLxyxqc
         x7mg==
X-Forwarded-Encrypted: i=1; AL+hErFl5RZUVnm+KM1cE2XMw0Oemi+lIWxnyLKwKT4ahNXG61NBmnjjZ0irrsdov0Ae6VQe7Bt5St3Dil0CJTtt@vger.kernel.org
X-Gm-Message-State: APuU4Z8alH0YGrLr91QVgoUpkhB23Pw8VmxpUWaTowNrBOct/c8vqBLN
	ZdJEJnb38C3ByCURvrNK42SEYXVXia+nqN4hwr+zFWPEY+jyFNnkijQD
X-Gm-Gg: AYBFou313uuS7CVqNqPKBidlevi9MeaRmmtkKR8FCFsR4nqU6mpJ8BfJWEySEWGJKfp
	Jbg/U2lQaaoqsYXz2Uy+gX7o1qYWlwkmLjIQA8lml8hdOckEpGXNoPVSi177m4Va0kc0Ni01z6Y
	B+r1ahJrYYP0TDVC29JTr5EyGfn1yfgEkFZSydX4gMBgmCOtl43AxupEoGv1eP2+BUvhE23adUE
	0f8iaJecElAg/Z+gwDPFdQIx/hJBKtyrL1ki/GcHuTi/Mcz1nweXmx4Z2PNcmGZkEOD3jr1ZOJs
	KbApbFDmuENmAQ/Cni1BsZjWGwBaAGjd//K6uWGVGbrDhqvX+8v8g6auGjGO/eD8UWFUTSBBDBy
	QAz6i6KOPQjpbz2USkDtjiJEvP3Oh1vSyR3WFkD4gmQX7NhpCUNb9cKGNo6DXmWIRuEuyqw+mdT
	v/nruXDWb4r6IhjYIAKmAr/0rRefc4G0uQpRYLXTXSQeq0rc57lYS1r06+q53ypECtCijDlqFnf
	MfaqrxEZB1BGmKJKuWave+v7wfFDTl139kwptEkVU78M/6UvncN55oJ2mX1sysbQ2JY7It+rSS4
	dLdDLqVTjxvrbB9cGC1U/+Do5BDFND0UFrqxzYFXiJ5fjiy+TSu2V5yeCHH3Khc2
X-Received: by 2002:a05:600c:34d6:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4b963c6c2d3mr40350505e9.6.1794165769075;
        Sun, 08 Nov 2026 11:22:49 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79501502asm119907165e9.2.2026.11.08.11.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:22:48 -0800 (PST)
Date: Sun, 8 Nov 2026 19:22:47 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Christoph Hellwig
 <hch@lst.de>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Josef Bacik <josef@toxicpanda.com>, Chris Mason
 <mason@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
Message-ID: <20261108192247.54ff3629@pumpkin>
In-Reply-To: <CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
References: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
	<CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
	<20261104-allein-bepacken-hitzig-5e517d3c129f@brauner>
	<20261105-genehm-dachrinnen-infusion-9cdf4868d32e@brauner>
	<CAHk-=wgLpWDjmcNWphCMkKXKwuZsa8KWRPvJ4j=C_ktCL4gBzg@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 12:10:13 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Next comment:  3c7a6276d211 ("scsi: core: NUL-terminate what is
> written to the host proc files") is nasty.

I've been looking at the similar sysfs code.
Most of the 'driver' functions are passed a char[PAGE_SIZE] buffer and
use sysfs_emit() to add text.
They are expected to add the trailing '\n' - even though it is pretty
much mandatory.
There is also a lot of code that loops:
	offset += sysfs_emit_at(buf, offset, "%s, ", xxx);
and then has to go through horrid hoops to get the line terminated.

But the outer wrapper code can do it easily.
It has the buffer and length so can 'fiddle' with the end before telling
the seq_buf code how much data is in the buffer.

I managed to build a kernel where the buf parameter to sysfs_emit() is
a pointer to 'typedef struct { char c; } sysfs_buf'.
Pretty much all of the changes just changed the name of the type or
replaced printf() with sysfs_emit().
Even with just 'typdef char sysfs_buf' it would be more obvious when
sysfs_emit() was valid.

Don't look in the amdgpu driver it does:
	off = buf & (PAGE - 1);
	buf -= off;
	sysfs_emit_at(buf, off, ....)
AFAICT it has proper aligned buffers - or my build would have failed.

I did find one disk related driver that copied (probably) 512 bytes
of hex data into the buffer.
That is nasty, normal sysfs has the option of raw read/write, but they
get lost by the time you are in the dev_xxx() functions.

OTOH the outer 'attr' structure has some padding (even on 32bit)
so there is scope for some flags.
(There is one flag, but it gets set in the file permissions word
which is all rather nasty.)

Then there is some of the raw code, I didn't follow it all through
but it really looks like the user supplied length isn't checked
properly.
For sub 4k buffers using the same code paths as text might make sense.

There is also the pre-alloc code added for some entries to avoid kmalloc()
during reads by allocating a buffer during open.
Looking carefully the normal buffer is allocated during the first read
but not freed until close - so it wouldn't be very different to just
allocate it a little earlier, removing some other little-used code paths.

David
