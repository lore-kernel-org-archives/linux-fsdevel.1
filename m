Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019984;
	b=bazgBKBfADJpvaat6w4s0RpY60+zkc6iRTPRR19+paPFZeTrVk4fxces5sYtWRhw+Spn
	 e6DAQ+ubfi4u2usdSDlU1ccF5mWaTin3BjpYojnlohGl22fE+yRLOWXFhLMmv+5+ypBpF
	 FJve2Ac5BU0xz22Aw2cidEcyAzDtNGEySP7SI9Dp2IBM8XvhjxKg8gjeUlBXPlnpDSZ87
	 gQJrK88iAH3PH0fJryOSZt9+lSV+d/PwCEFhVNi9rearHBCFmZrALOuLETp1HX0AmCU3L
	 cbUefP9yGrH85sYSM0DA3LllP25LxD96YNbv1ZanGcWYwRvMk6RbnJUEQpx0BhlHLfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
	b=R59taTYqdEyu30lpkbrEOAA8BCIsv1d2uWKRHqrfXbQz2C9QWGLi4TnY4QJOO5AM0Qah
	 8MpfvrJaAbX2Y0io4YIE5cQ0MSwjvKDbzrrah1nAtvzY/+vQYdoxckhE2CeOe2tjzdBrE
	 8ikgPhVPLbnp7GUXBtuHXcoOZv8D/2H7Crfj181LEhkMj6EAN+feyWvBh35JLXpondhq7
	 x6JhCqFomcEaZ64Zuis44sa36d6iuVeY25GpmkXTxfbK/zvkIsdhi3vLqRzyoDqD+b2vS
	 6k2pZZ3S+uKOCn8VIzX7fgteykWHDQu/XDCZK+zz01aZT1CEVhrQBtIWnJ7XrxcisMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=E2MyY97I;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40F606A32F
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B40F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=E2MyY97I
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50d3ac6b51so471725266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795019982; x=1795624782; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
        b=E2MyY97IaK7EIbtBNaVLxa+z7XuY4/4AGso9YjgYYgpjkuOqR5LhFecy9cjZu0OGtF
         Mk6hujlebYW/uKXKjpxKKJrwIQf0fZyUZRa0/RRi4MbhF9bQaCHHcJ3rtmqp7P/yE16T
         5TZTuc7weUhgz++UFJKOF1s0z922xbloa8JTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019982; x=1795624782;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y0TMrCzbGMAXa1cTU4qckddvOIHma2PxgVYHTYEMX2w=;
        b=dyLquE99fh8jFCls0+CZD+lDpAc3qjleN2BocXH6HRL+WjyYylFPsHz4i9TrTBjdB9
         ZzvZ65pZ4dK7ppBLGYuih0kBd79EzM7JKW0z3xoYMhY7oQ8f15qRMQnXM8oemh0k7twx
         EpwzfH41gY6yN600xXOrzH4rI1z+EiRyaoya79dkKF9EREghVzfzRFTfqAvuqrwavWxD
         mTVBN4/OZLIPv+THXrBRvjxwResRGZyfr9Ana8/nyP5KM/k24nF+66SVILYylnf+Xla2
         on2OXFSpOSQEI00+N7Z8mLbMKI4/veu9KPd2QPM2d9Hic+uBMAAwPRfjdaw3VRUFBgzG
         fycg==
X-Forwarded-Encrypted: i=1; AL+hErEAGYa9Mb4N2o05B9UEkdvxbiNovevXhPf9C7LElZt/7ny/ktBc6uxgvdVoCQXHCLKp+sw3vtvc0ScMUbXn@vger.kernel.org
X-Gm-Message-State: APuU4Z8zGzyH5PjpwvFR1z3ou1DQm7gtOCfLt7evx9SUmIWV+1Aj0vFE
	Jvhr3Rr0YKjxBQHdHGH+iA6VqIPU6oC+suzpWyeudfUBQuFvkIYDS+wwKCiBQkNTb+oicDgc3+a
	Sp+AoVYiEuA==
X-Gm-Gg: AYBFou3fPoXEEPCP9CTKsQrI4vVeanxXXkKUNXWTuvXLsPUp7Wuk8xlak2GQxdiHeDP
	TsD6xOUuKjmdAaez4/UJ6gfSRahAOrpb9TWmlRNvxxZHXcXnJnQ6eh04ZWRbnPW+Yb8jRPxK204
	goWuBEvRUPAVPvvgl6nCf9W7Xhy7QiDs7iALR1B5+8aon7Lnm98qIwa5jON/KtqgvS6nUKHQ1mz
	WrLbMyba78PZmd7nW+VbC9JY1S3W30GXCCxwNLFveB18GXOYMDPTQDzbZQ/WiBR/jNIV6hS7U6R
	Ov2NZT7Eyp+zV8/qbjVyTEY6eMHXdOaiLAQtN8xHLuVbl6wGJzMGEZvc3/U3YOJI1qi1WGRE7WQ
	i1c2mei3EnKDVtCX5Nk3uN3ibd8p5NMcQz+LJ9AB56o70aGurgSbte97UYUCbzByz+oCEGT8Znb
	t7zvLTS7WoQ0y1UBTwiisPFUr+C/ky6Ea+LWToVkpDHK/C6NuSyBnYojB07kFIcxHTpVRidKHNy
	lzXVZTnX/gmbqfvXXholgXuvzBMnbAOsLcdq2qQH42aRwPPnyY/B0OaBzXrkHgkt0wZ3RLOtudz
	ykTnF7SmGPMLuJ84TbBfNR0CJDK1zzcuWqcnDSre15M2Nqu3KxwnZU5UfJfLFO0LCSPVW3vJK22
	j1JM=
X-Received: by 2002:a17:907:ea8b:b0:c41:4512:560d with SMTP id a640c23a62f3a-c5126175c46mr2777166b.16.1795019981822;
        Wed, 18 Nov 2026 08:39:41 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c51231baa96sm24360666b.4.2026.11.18.08.39.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 08:39:41 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c50933bdf4bso287038266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:39:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHcJlEPrgNxKBVKcHEjhfbtIwd6O3AvjmFKEC1XO5U+DgdwpX+UwltnxoQrSEVJvEqItbChRi2H8kA8dErj@vger.kernel.org
X-Received: by 2002:a17:907:1c9b:b0:c4d:31be:1f27 with SMTP id
 a640c23a62f3a-c51260bf92amr3511966b.9.1795019980203; Wed, 18 Nov 2026
 08:39:40 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com> <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com>
 <av2juQijIISJAgyf@redhat.com> <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
 <av3SmRMGDLVAwMzK@redhat.com>
In-Reply-To: <av3SmRMGDLVAwMzK@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Nov 2026 08:39:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wifUn5X6LeT+-A3mW9JtDcfx2x-5xsWpTxXzThibsK6Ww@mail.gmail.com>
X-Gm-Features: AclHuK8yADyTYfgQF-cxDlxPVAPrNzQpmw9eeowiVPqEa19tx8pNj1uFwz9vJyA
Message-ID: <CAHk-=wifUn5X6LeT+-A3mW9JtDcfx2x-5xsWpTxXzThibsK6Ww@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 08:30, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 11/18, Linus Torvalds wrote:
> >
> > Some duplication - with explicit naming of the locking status for the
> > special cases that are called with the lock already held - is much
> > preferable to dynamically doing the locking
>
> OK, this was my plan B ;) I'll try to make a patch this week.

I've applied my cleanup patch in the meantime, it was obvious cleanup
and I didn't want it to cause unnecessary conflicts with anything you
do in this area.

I haven't pushed it out yet, I have a few pull requests pending that
I'll go through first.

          Linus
