Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215137;
	b=ialwAJLvpoW3I3IoNv4Is0KMY3HsPV8PkTKReiwhtlUDFjw/5cBDbaOrNNAr71bD7dqx
	 7CLU6isctA8tQWUvSbqnUeiBb5QIJwsDhnpiBv1EmT6nZjGJH1mwH9z7Qp+xsv7q0e4Tc
	 NfQP1U9nJIOM9X5m2oPIyVkZv65qZ851vKKBrDNZWYJjw8WMwiF2X85oEZfeqam8BXNjL
	 HjuXW5g/hRi35DuH4lKzs7EOEOmrjIM6mqw583OwRvmsw4pLiA8uUZQGbt6WVSpBhwV8x
	 kINOq16srupXKtZHNueJVcEp3rsjp4P2hvFBydVYFO1LDmtFpMvMnoPx379mv78ShBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
	b=tHa61StMzcbo199rOE3PEV8UUx6f3GC/ZQaOFmfFIrBuH3tcY554VC1czlmy8OBRc6bT
	 QWTHftimKZMQUGi0ZoPqUJ5ay/YK5UVkX3ja1NojuaY2i13aQQo+jpTF9lrgKcqNOLZ4P
	 0/1AXmayeA7zyqk44wHx4b09GYr1EdtXbiCYaKfVk3cwwB30yfAFOMYlG1EjmcBRy13PF
	 yGXtn9avIs1U82JBc/tOUUI312ai3j58YA176WNi6tSUHkQedBsJ6szQkvjW9plIRzZ9t
	 EoewH7+Au9+K6BCmOOScaveu+6b090xsIzGQ6FBOgQhuPO8YS6F5E+fKw0KqMZ+ucPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21408606A323
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 09:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21408606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso239801f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215134; x=1794819934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=lZU8SnwL2d5NASFMGtKYuHPElv2TmETKWdr//7QajgisC5jhB4njc7KUHt1Fbm/0jf
         cfmuSHMKQJQCQmQVkYHt2/OtvJgkZWIllal6QuwtZyvb8oHsO/BCvtJG3MfUHtWV55bU
         ogpiFdegi07uEIhxazGUbvrwtR7T3CJuRBAki5nh0zyy4CFC9HfCFdfQ5JpdeAwscKk9
         apZ5LVAXNN9SxZtNPbqS08FcN1VYKFalsQQdogv77SKD6Hk5IXW/dVxgzJo13gHpqtMa
         5twU02rNCtvBDAkFC+Z1uo+EPlBBMek8UflGEOFFl/GpGiSd0MlsQmutcvYiSvuz912d
         BrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215134; x=1794819934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=QFKtfeJu1n8iOGz8aA1f6BNvVG0b7uZqwuT3F8cZe5vFpRDfdHo+mqhLeryxcenCa3
         Q3qbY9niYit0xq5vDBT7qxz9jnkF0cj/UiBmtxxhUBzE1MIAu5cu72qSWDP84auH2mnr
         cAtriORazzk5S70Vo7yYG1vJaDEEeJUsCL33CTca3iWAhRAU4MGOduLHzn3wOMZOa4vI
         kLoYYwCeC41Z4pbYZdq6hoSJlfzMBjTukN9iP2Brilv6OuHfotvdT8DlyMc+BiLzcYI5
         d37lKyYf3tOpf7jhNMxl2iJw20RIaNbYVewoQv8lxnQVg03x8+DFYPRX4eZI43ksMh8v
         bfxA==
X-Forwarded-Encrypted: i=1; AL+hErEMhW2L4zPSIuEAUX3ON0iTbCyWmyDz4VX0ApF42wBK9O5scz1o6DsEGNH9lrkpHFJym/2aSNBBH84x6G0+@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ea9e8KVttHl+CGOHJOFAT1PjD26Bh6bcQJkVufUQ/3feUIhFX
	kmwtWUpqc2aT73P51qBXQJTMIqyFnbP7EsbS3eYw2NjMMcy7nE3z3GRf
X-Gm-Gg: AYBFou1i+I2VpEcJ7hfnoxH0NkW1FU3C9panFxhBtc1zo6apWdHZcKd5ucmQ0w/WWZD
	DcVaj5CuviTHKKB9Wj7wUFLLAyb8iUceq5bLB+2X/88WcLg+xVzfY8MN3jqfenu9MWTjWlSOmup
	PRrdxOENEsHKULtUvayQ4aAx6FGYJgDryRrDBqC2z1YHCAQ66rbjtu6IP6vKRA43RtsQsZAH9hw
	gIlBOtc6mIGxD6V0tbn7RLUGDee7gi22XlDleTg3ie0ZGgJDrGtjz4mGZIJWRtSBLKtAyR+/oB6
	bp+nZpOS9uT1EsoAjNuRbg+8986pnSyO2NUw2j7Ows9C+mlL9eVB2FA+WdtxtC9Xp2gBStYHfqV
	9S2c3ST9aJmiQD/4Ume6ddzgLgsz7uqSuAZXrzzI+7dS7yjusBqz4/zkhNsPUoLaYL1q8LpUATG
	OMVRCbI41gZ8pLqwKgFUwVo3eeRF09erV6fqlKD6p3m2yVES7K009/aSfWZzUJsyv+S0qqnpBkS
	eL02R9xk4fugctQ8oIZCzEkphFc8cAR+lciyB+pQGrmvRTARBrd6/TvXktnjDrubfwDNDQ+mBbe
	TvqBc8Dp5xrIeVNpFSCIJzQ=
X-Received: by 2002:a05:6000:2210:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-495844a3a48mr6683329f8f.41.1794215134134;
        Mon, 09 Nov 2026 01:05:34 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596ea51cbsm9541323f8f.27.2026.11.09.01.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:05:33 -0800 (PST)
Message-ID: <8ff83fbf-2ecb-4f9b-ac8f-ee88fece67cb@gmail.com>
Date: Mon, 9 Nov 2026 10:05:30 +0100
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
Subject: Re: [PATCH v2 5/5] mm/gup: limit pagecache folio refcount when
 grabbing references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Let's add a folio_ref_count_over_limit() check in fast and slow GUP
> before acquiring additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Don't check capabilities with IRQs disabled, as even unaudited capability
> checks can take locks. Refuse access to the admin reserve, so GUP-fast will
> fail and fall back to GUP-slow if possible.
> 
> Also propagate try_grab_folio() errors when grabbing additional
> references in __get_user_pages() and in memfd_pin_folios(), so hitting
> the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

nice!

> Keep the existing invalid-refcount warnings.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
