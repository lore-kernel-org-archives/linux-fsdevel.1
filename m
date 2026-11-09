Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242471;
	b=ht94VV6sTrp/GC1QSOo2/IVQSqa2zPew4pYy43uQMZqkvJ1EQtnBPJNSBtCmlV4pfkTH
	 r3QZ2+dpZi/ZuDwbN/mQLbW7L0Ep90bDHwlL7qazgGJHqmF7edEf2eUD5zFFijL38PYKT
	 kVllcUcS4vVd3wM2f/JTF72LYsGP/Xn/QNEqgONY0Ynt4gvO/cgVNYz0hPnaESPODd0fh
	 4PQI2fUYp9kDkKIJGEFyBNxAycvE5mG4gXHHhtqZbelUegn7AXs1l2SH25k/2PSFf5kLL
	 FgNIrlx3sOac4p7Kl+tycPwceZPZCwlcoVNXZ3bM65DEVXQq4orwCWh59FlIXcP5ZNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hck20NyvBqj3Ac8MLVTjPeq6/3Z/Gw267omoUWkMKcU=;
	b=wfhtSH8sPBxc1AzW9fBKQKWWOl5jRx0Y/GseV3cirXb7hq63NZ3lPNK7in/Hb1QSqT2S
	 G4z0sXrdN9uDcLNYP9LijZeHO7CY+SG9ZAkCbG0EApUuQtI9rTMxNSx5YfSOsAbZDE0oN
	 8jC+zHuSkhMeOtK2rixSJmKRQvIC5PpnJfKp9dbZyOD0eHnDXdg2K5Bht9aqdrk5MGvRX
	 YuDkqD09WksQOQnJoQvCc1Hs4zs7XhJcCPCd/rdFRi6nigNTmj8H5r6jw+IWlgNWJZdEM
	 cgTx9P8HGqzGlXSHPo8itfluY2E86611Pk+EkgjBzEVBsBUO80LrX2tbmJJag3wZT2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KAOc3KOF;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAB606A326
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 16:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80AAB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KAOc3KOF
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c14470729eso620844e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794242469; x=1794847269; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hck20NyvBqj3Ac8MLVTjPeq6/3Z/Gw267omoUWkMKcU=;
        b=KAOc3KOFsUIkTz9YDG5Tiue16ZSocsLrpbGZxplTN/gDjvlFT0kgPoKiesYIirQM7Z
         rvprYxHX+L3KY3/EitMB1i6r6rUi84NlCUYNfgo3KUyqXD7+7WZnmcgG/DmVm1Hb8SMA
         Hv3wwqD8y/7RW6U3rylF7zXiwygOCUR/f3CkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794242469; x=1794847269;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hck20NyvBqj3Ac8MLVTjPeq6/3Z/Gw267omoUWkMKcU=;
        b=Z3A+xuT5RH2qUjrRdAKBhWhTv6M/gZ5nNoADg1y6vjJndyhrjm2//PgfBNufkZWA/L
         qKAY0rC/ubGRrj4ptAvrs1QLk+S29yPfSqMC/9JATozxnq53eH96R+Nx1FBLE3aDTSQV
         GGEUcHM+66FnDnx8R2jKfFRwQe9pNmk1sg3SMCCt5ojAPeTWRyFVbRSziVGGaEhg+H9e
         ihb6OWDqvJJ0dcgGClgT+CPtIhkug2nOumJqnZXxy8Tjlnzpe5LpLbWlr4SKMn2LQUg0
         ehS5d3wrNBtVfAXgBD+QAXhXJAylIzkA+aycfT2EayMQCrrInofFiGOKBHAJcqof84wv
         zDng==
X-Forwarded-Encrypted: i=1; AL+hErGmGh5sO+X6eWCnuqjG2YfAwqkC34sOG6OfLcozxlQCS61HOjI9Pupu2p2JeO5WsjrXFfTkcr4WuWeho7cS@vger.kernel.org
X-Gm-Message-State: APuU4Z87xR6Fh+Tk345D1L0bRI3pp6d13GbO/K7ZDURYi56pPDcNouEz
	Wd+gRlfOfB0QzWm0TNA8uIwIt5UnE5nEv++PwypQWNcgntZjwCs83rQ0x2LSVp4a9HYlhjiF9SY
	3X5dqlYrrgw==
X-Gm-Gg: AYBFou0MrWYNzPS19KhwFZBWA88rGqX3Lx/bQDnWP+nc742+vKALmKcOwt6J0XlhpJC
	IDQsyI2krMvv0Cb21znwkP4uXHftxEyju5FOF65M+7z9cK7FokMZutegZpZQWnZ/yd3S83BlGW4
	jh2aO2fjMBbckOt5/5is20pX8VFJv9JaybjqRnsSjmQICgJnaKnrxDQyVOGSZ6gkQXqRgo+8gwz
	eysF8W/uvyaLL5NldizLOPnED57f4DSEI9mLM3Y/O0/Bk29dxwnEKFDyklM6T/RHBBsnBhUPYC6
	4p+NfaO8QFsKivprb4APZwctiMixKgSNnXeO78fQggXw3NF0uzS2tB13e8y1bCIxwbz8mHPd1wD
	uMcC9E/HQGXJJgmP3mXaZJXz8PgNd1OiCdVdNWBX5wXuszws9UVxU7ugx+IGwUjUPlNXyQHbe6y
	tiDsJUUjoOgsZeEj84aCba1ReGbpLyITQCLe/fLpERrNvGL5krvESWyW9qlbb1HIVXK18j9zkg5
	1S/1APd8Hpby3h1V1oJyY6OR+xR76tU8YcG/RHR4EVR7bAajJW7iwrCVjIGPw1TH9f/E9dNVSZL
	pBLb/dFw4LJgyR9DdRRv3pN8YwcX9sqwx3Ep0vck7Ey0ShzjrNVvE4NNtFQRvPDWJ1kc/ybph7T
	kd6VpTQLJu1QSpHmw64KmDCE=
X-Received: by 2002:a05:6512:2305:b0:5b8:f0d9:98cc with SMTP id 2adb3069b0e04-5c14c038e15mr1291600e87.61.1794242468521;
        Mon, 09 Nov 2026 08:41:08 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b825f7asm969136e87.79.2026.11.09.08.41.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:41:08 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5c14470729eso620835e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:41:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFk701cEPn2MFbbGN5saeSZ7WzG/9SgmC/DvzrQVzIoe+YeLa0NL85+LQ2oMknkUnmTWIaBlmNt8Slx8650@vger.kernel.org
X-Received: by 2002:a17:907:9303:b0:c41:a5da:1511 with SMTP id
 a640c23a62f3a-c4d6d58b94dmr324648266b.25.1794242121304; Mon, 09 Nov 2026
 08:35:21 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104130118.2507513-1-kas@kernel.org> <20261104130118.2507513-4-kas@kernel.org>
 <f21433af-afc6-4a8f-8d2d-3a377cd3bd6e@kernel.org> <CAHk-=whn=xc9J3qApHWRGTaBpwVRtGbvJ0LURGF=dqC9B3swUw@mail.gmail.com>
In-Reply-To: <CAHk-=whn=xc9J3qApHWRGTaBpwVRtGbvJ0LURGF=dqC9B3swUw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 08:35:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=whhp=Q8qR+wPoM9+mxYPQ_OXMOEoKmT7J0JZikFZusuqw@mail.gmail.com>
X-Gm-Features: AclHuK9Zg1YgOX8tZrGKznWYWBoZxGMj9dsb1Z1k4ney-3EhDZHB_lO5ezPS7Ak
Message-ID: <CAHk-=whhp=Q8qR+wPoM9+mxYPQ_OXMOEoKmT7J0JZikFZusuqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/18] fuse: don't move a folio with PG_rcu_free
 into a fuse file
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Kiryl Shutsemau (Meta)" <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ilya Gladyshev <ilya.gladyshev@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 08:28, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 9 Nov 2026 at 06:46, David Hildenbrand (Arm) <david@kernel.org> wrote:
> >
> > Could we get rid of fuse_try_move_folio() entirely?
>
> Please. That would be great.

.. and in a similar vein, we should get rid of splice doing the same entirely.

Kirly's patch to just remove page_cache_pipe_buf_try_steal() entirely
(ok, it was originally mine, but Kiryl took ownership of that series:
"Tag, you're it") is worth doing, but I think worth doubling down on.
I think we sh ould just get rid of 'try_steal' entirely. I don't think
anybody really uses it. I think it exists in fuse and in the virtio
console, and neither is worth it.

Removing pipe_buf_try_steal() would basically remove all of
fuse_try_move_folio().

Conversely, removing fuse_try_move_folio() would make
pipe_buf_try_steal() even less useful than it is now.

Just remove them both. Good riddance.

                 Linus
