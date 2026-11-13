Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546631;
	b=Om+jeFyb5tJPhDd6alvx6T2qyS5agt+Nxr5wUUyBEqanoo5M39Jih8x15Ri3fcOFaanK
	 R0gjIIvaFHK4HPwdNQwe8dL8eXmqnxVJRbiFLGf4d05aJuLcJZdkbUxmfWFquh5yg7DAy
	 fsZoPafm1wcz9Hw2qzXFj59rVBMQgxOSTu6DvQNIXBiEwNpGVM9Qn55nKNhPL/rPK7Hlk
	 4VQwDWmH8HIoba6Lnqyx+egCoK0vUWdCUidyACjFO/W0ez+FSnWvxw+uDJsSzXTCzoEE0
	 wwpjjmiLTjQtPdVvCm43QoT6gtOkihYGGpJ0oELB7jzGcc608WhXSB9iV6mvZdkUMjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=mgkN7zfne8CxcStcMwaH53uuXOvKnVLzfMEVlic0so8=;
	b=hjyoudAqOhiK81xZ8vraeh7sidByIBJU2peuCR1dTfAUlP92TWaVYkdA2Kld5KohLNhj
	 Xe66OUOf2IPMpY0gQvLIz1Gbwy0TL44yPP8GsSDUMZvWWFbWFwRQzbZ6Srl7oHRrm7cej
	 evs932ZFdzfxrtGXS9IHCnnfB8M59KTSM1lptl4ZWPNFoanF5IuwBpv8wCgc1DaRdOkZq
	 xA12QwHRg4vzb6Z5Jiu3JQdqqq6Xz2YAVNwK/WqqXms7b6eHL6/+UOobRQJ4taa3tFwmY
	 znPsF/IwmzlpGqn6vVoLEA/8f9GbzpGFxhsYHnPirJivUjfXdC2OJdT82AkepSekxxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OIjEQYM2;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6E606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 05:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E6E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OIjEQYM2
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f079a63b8so88728285a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 21:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794546630; x=1795151430; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mgkN7zfne8CxcStcMwaH53uuXOvKnVLzfMEVlic0so8=;
        b=OIjEQYM2AbvD7QM9TAR0tLg4L1oJc35+b1F4MoifxY7eXYBQ+KEPJLpPBOEANDYP5g
         kxqNKD+dVu6bAcIcU3FBv2VZxmUXB7eOLSD/Z5Qeo2WKctkL1xQ+g0Wv7nm9jP1FCDEH
         PQEgjk1nUYo1hA/DrieotJAmBd8Rat8VKIbcdOMOnxU+W3TRM9Q2TPFBlrUjJS3uofff
         gL6wsydLRY86jsPdbXHxO0sT8SWJY4iNx39eHkz5cFSKe225IdWJz9HnWUJbvRDmVe0H
         LaY/kQzdki4vuo6l2LdExbc+GG1bug0Em2JGwmzTUqICZ90ycLFTqsHNwcUJzEJwHpwo
         WDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546630; x=1795151430;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mgkN7zfne8CxcStcMwaH53uuXOvKnVLzfMEVlic0so8=;
        b=uesgUzX+8mpsieeBGojh06PXLQysUHINSQCOTb5W1gKosDIs1w645WiWEwjZwb35Ah
         1u+KN2mhWLOgiOZY33KqPCyDsmhV0eH4pjRzO6CNk3LQbjECSEZW3sHlmDtnne4DmGDB
         XZxe5tQFdYN68LTqqDe6fMdM8vYst39+HMx4onVgS5Qe0PtAig1xr6KNUvl/YFopf2Fv
         9JClGmISgjaGwAgyQc23x7A02gmU+oP22mYaW8y/xib/me1ohWbhrqPzFmP/hp1+DTZr
         7d8MYgvfqyYZKDUJ4Hn82X6WiQ2F7/JVCvqOaVAHDDwzUA2aEa91YFOd7ZbquAZiYqRS
         zx8A==
X-Forwarded-Encrypted: i=1; AL+hErGgAPzjPOPZEGxNZQH+UG1NobroVTEQqOk34CrMwUuJS7GyHR9wuyTlWib2iBNYl2HvD9O9iFumW7xJ376m@vger.kernel.org
X-Gm-Message-State: APuU4Z+8QpwbJ9as6B8Y0SIEJII+vzY0KC6GAarK93vR7SVh415EDapi
	omBWWuxh0IdLqZkgFlwsErbhCTv1xEm8B8kVIcBi9mLZwYnXXFxrdMjutU3lBydT2Uk=
X-Gm-Gg: AYBFou2FoFY/TlrDX7+ooFLEWzJCdR+ap/GiezWwzR01kelUxrDElt7a0xTB47wo3as
	ixS7nrFnl0yitUI1OJ1i2mf3z33Ioh15o8PfWFtIO6sYuuGr5nGmLhWFGgnXpmWNx8+fSFbG/yT
	Gb0zaSvOuEu4R+J/9RZSLlIjmfPP5625qTKCYpthyaE1R8ODaKx/Qq2aQCie6vMKLvd5SUk/bac
	Gu+r78WKaTq/ohUf3YxIE7WGwq00FguC9eBtUW7tG4H5O+XhX6/CkBOFhqJAh0X2K5HIjBT0dcB
	ZJR1EN4nvk2Idh0bKECAV01+EZSEDc5T8tKn+Q2C0enKVFS8bL9d9nt3Pmn7RUF/mCTuMJ5ECV7
	cW9xPMenblw+/OINcucSTSh8CzT8A2FCyHpHHAHWwsDxkxnWlZgK8+503UhiR31g2rw/FWQDgjn
	gYV7nM1eWtA3Vk4AvQawkE6+k4tKCqieSeQ4m1fU93Na3033uFAP9/v4bxH9PNt2PKaIBVwgNBq
	i7uPYgKKVl4iW+FAJNY4h9XmfFq/Ku4J4Yp9J8j71vyk5l4H6feuXDHOyOt5bsvQlUIJCsxfvOO
	W7equO8WWkryFrfY0YTV1nu9n1gA2IMQ2J+To/aBXf+nGzYwtV7UePMAY93ppjYFCQYwHVXWRSM
	YOT/c4qE=
X-Received: by 2002:a05:620a:684a:b0:945:f6b0:db0 with SMTP id af79cd13be357-9494bb3103bmr245366785a.30.1794546630191;
        Thu, 12 Nov 2026 21:10:30 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm103580385a.18.2026.11.12.21.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:10:29 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Arnd Bergmann <arnd@arndb.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
Date: Fri, 13 Nov 2026 00:10:28 -0500
Message-Id: <179454662851.482102.356362894816988437.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
> make_uffd_wp_pmd(), which handles a present THP and a migration entry
> but does nothing for a device-private THP. The PMD never gets the uffd
> bit.
> 
> pagemap_thp_category() reports a non-present PMD without the uffd bit as
> written. A user tracking writes with async uffd-wp therefore sees every
> page of a device-private THP as written on every scan, whether it was
> written to or not. This requires a driver that migrates THPs to device
> memory.
> 
> A device-private PMD must be write-protected like any other huge PMD. To
> fix it, pass it to set_uffd_wp_swp_pmd() as well, which downgrades a
> writable entry and sets the uffd bit. When the THP migrates back,
> set_pmd_migration_entry() carries the uffd bit over to the migration
> entry, so the write protection is kept.
> 
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

reproduced the issue by observing we fail to carry back the write
protect bit after migration.

Implementation details i'll leave to Lorenzo's feedback, i don't feel
strongly about it, it's gonna look bad either way i think :\

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

