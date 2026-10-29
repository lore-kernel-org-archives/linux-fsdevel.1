Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232124;
	b=bOlPlbO51qmfV59lQdVTLfEp/ayYcmYybQN+EOA97ESaYab+bp1/5YGe1Ph6NGYFKFka
	 tYiNn2T9VnaDoxwiYBDXYJOEPQE8gORYIb6P49ZMSapnWlCnY56gF/NDmWML2C9tihIrx
	 jgmTyk5w1B4Rki7so+nwK40Rtgh6ZcQ/FBc7grQXpIHCeP/nWrw/d3Pk7HqvXB96RUq82
	 9RlA4nAH0RtCWjP9AZd2jowpy1zArIjlFjXQWE3pGUjc8ArOY8U/1zj2yqVFb+Fy5eDYU
	 qvOj0u1QGQzHmrwjaKzxNJKnswvtBqga5EHlM1euEtHhIfU2ROc1N4fyeOnopZeQbZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=;
	b=FYxejlVJ8zC9WL4jrSAzpqfQIGgreVzPZ7M0Ymd4wYEphZRuuAiRMMrqfOTss06HTe1E
	 Ap2IxkXHuJAaVNhbz4Mdth+a8gCwIbtYSc3lVKbNFij/ED7ySAoL8Z6TBpqQ/vUJbOnJ0
	 gmiDWdUtztEq6ZGrBMeavXbg5u+pYKjBQ/b+LzbDoXWRXHZ2Y/Qg3gje/qvaciELQf1+h
	 cmIw9tfu0kL0H6RwGCIJvSiqiuG795w1qKC4jjYS68a5aCGh9lKqni2nUzWzPCRLN99L2
	 yu3UBO1EGZBJbQi2iy3x9bqLvffYo9Ag+a7kG5/GH93pO0SvjJ7ZXmSzAuoZ85Xmhqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=EpKoMwgE;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E388606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 00:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E388606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=EpKoMwgE
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eab93a9862so509905e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793232122; x=1793836922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=;
        b=EpKoMwgEEoHgtRNLqOsrFbza9ayjknIjZvpEUcg2luJkviGEk3/b3r07STY/DjmLA8
         /XkGfSisrwYjJB+E2qraZr1BMSiDgD/mg+5mg/Tbyv3Psv5T4MFMXGB11oiCZAUjJa4D
         zeL2ENfDoV2R1H++PE0b/6NBGj4qTP2FN6s7uasK/3sY3Yoqyf4ZXjosooinUqF2Pipm
         UquXeuIIUMX8B6YMwPoqf5sckl6UKYocL3LgFsWmqoKJ7qyRraYqUx/7MVvgXj0mYg3x
         8fV5AvWQFSGxbCvYUTrUD5HebiEPYTH/yCjpVCK4zWTJDFsYQmsHf1SS7tyFh0xGotDs
         OoKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793232122; x=1793836922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UtW/sYsNMYd14q833jtnLcBy0iGbA94LyKtY63+yQks=;
        b=lKf4yqVmQ+OS2Hmum/+u8ngfKkBmUaj1gYn1HwqlHsFpl7CfuneRrJJVVXf0PLhTjU
         lmyLLUdHo7/1gqwcKKbPHxy5S8/YnPezLmxlIzHylIIG2hS2lqR/DJ8HwGpfB1FO8Oua
         ttwRQtQsRQmzpzcTgjuqDR4NWwtlJ0ul7FZTznIoDjVHJr07SAflXW0lFy08gFMPni6l
         zyLxG6Ic0QLx5c6Wj1NCSINxw6EwHBaim51yA7zq8mX3/b2KBVmmQxVRm0SYzLt5Frun
         N/hBuIOjZhEF0Gujs8CP1GT64lplOeVaR0zKMFGglmSJiDvV2Q3Wl2jPjYHGC5wWyDEc
         h7xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqrKEYer42DrGVeX6uhk9ooizaj0Sw8d5+53Ff3Fu8yTdZQbB3LHB6WzpDiIcBTpRakla7g4nOMDZCiacg@vger.kernel.org
X-Gm-Message-State: AFq9FYJlLO4QVK3s7kaAveS7tt2XRnf3ziuJTctI3gk/czSvpIHV4fkP
	Ewi592OqI9XUYyz1zDIzcTjH4SmCrMQJOPjnk0q5UfwHK0H/0UNhNJoxyM9WCrykIxE=
X-Gm-Gg: AYBFou3Aa5wRbe+quE9F4PoEWJjx47AZoTpudVbpmuIrT4C+0oM36ZI9BIowmzTgfwW
	Eq1PiB/tVQxO49ZbIOSXTyQkbpO3VXSoYEC+Psf0ClKaHYDaJChO7sClkXF2nHE5KLWLlrenxXz
	evR9x2l0TCJw81+skyFVYhl0cCLUyjktS3cgazGRLaZNbbIBkCOAerjHVPGJEAtjSfI4MCW0ovY
	nRlOVlnBMDjzVnG81ZzFy5POqKuxNmaEXDTqqVLFhkXVzk2oVt6GesT4uCiQS8T9t5EFVksSRTj
	iuwWrBeg0VmN49yoRzlGZkpmv0XOinm/attDGqY7nu1nqbumut4fkj/RiZCKOei5n7nv6rdevRB
	gLr61w/x+xE3DgPn0akbGNz0lhZpBKEkITDcp79rWA9vdvAh+jh0PUphexXD8IgOw5rzz4qBUcd
	kJu3kc103NI6fykadm9XsZVv8Hp0Na7VB+tQSHAtJWXOBiUCIyPxYT/3X0zfe4mRj+GkzxT3B/V
	2dof/l1zBNcvCwrKEH90iik8x+Cn6goVipz3W/J0ZW/s+ZHowvT6ZbF6tk8dD/dm0FuwQZJaIKj
	J7bgZXxyLwBW0/Um4tPFNXKYBxb/znkkn50EISUtVFHIZrxdWLHJfjX9db8kXNrt+yuzyUqOFGd
	9hcUBEjnKhU0Pj7z5n/nsKlAceFYoZfhv
X-Received: by 2002:a05:6122:1c03:b0:5ea:d14a:ef8f with SMTP id 71dfb90a1353d-5ec4cc14f21mr1861192e0c.4.1793232122251;
        Wed, 28 Oct 2026 17:02:02 -0700 (PDT)
Received: from google.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f931911sm3523257e0c.10.2026.10.28.17.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 17:02:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 20:01:59 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/3] mm/memfd_luo: don't use memfd_pin_folios()
Message-ID: <auKJXHWnNMzju7cv@google.com>
References: <20261027173031.763213-1-pratyush@kernel.org>
 <20261027173031.763213-2-pratyush@kernel.org>
 <179321872100.1775665.6881420026761127422.b4-review@b4>
 <2vxz4ie5o2ak.fsf@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz4ie5o2ak.fsf@kernel.org>

On 10-29 00:04, Pratyush Yadav wrote:
> > Nit:
> >
> > I would suggest adding another helper, memfd_luo_get_folio(inode, index, 
> > &folio), that wraps:
> >
> > - shmem_get_folio()
> > - The !folio_is_longterm_pinnable() migration retry loop logic
> >
> > I think this would make the final code a bit more manageable.
> 
> Sounds good, will do.
> 
> >
> > Other than that the patch looks alright, feel free to add
> > Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Once the nit is addressed.
> 
> Thanks!
> 
> I think the MM side might take some time to gather reviews so I will
> send this out as part of a liveupdate-only series. This patch is useful
> on its own anyway.

Sounds good. Could you also consider adding a patch to that live 
update-only series to extend the memfd freeze from retrieve to finish()? 
That would close another gap that does not affect us yet, but will once 
other session fds depend on the memfd mapping.

See:
https://lore.kernel.org/r/20261022225035.377445-8-dmatlack@google.com

-- 
Pasha
