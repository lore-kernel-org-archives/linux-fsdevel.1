Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48F41D22B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787822225; cv=none; b=th7mz4L18cgX17xlNV0PHT8o9GtBwaR+Qe00oLRTyA1KvBK66Y3E7Jjm8x0JbbpHpu12xfdTNvuUDCNIyUSOoUSCRxk0vjgDhavsaS36kuJf7Nn5BzslP7QXvrCy8rxVlECd4CLJr7bjyQ8Oa9e89bcVyuDlaHQN9zSFncshvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787822225; c=relaxed/simple;
	bh=5VfrgZkKynHJykbnugTUAuRm/lIC9QY5cTmsrhtNC2k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VtPwLrpgC1pKUGwV8SAm67lyrY81ipda0uDIFJqvBVS3cbfK/FsumD23DZ59EMp/98axhtz+MHDQTeFzYpwBPhOgHKamEj6XNcMeYt5qFYvhEQ2INdFBye3u7lteT8oBppqHTTcKx9DVozTuSmV/nW/NjUk3Yzw1HvIWsTjXRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSk8urBN; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSk8urBN"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c70f69d3fso2534327d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787822200; x=1788427000; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wURAAqpmYnRm70wHLRDHhfOf5KYKWGXPLGAT3tMJ/w=;
        b=fSk8urBNEAkuiCBeBo8SyIw8Z9Njl+3rvjRUdLpXZytpltL9YV+ApmncSKJhsSTULG
         awxP4kNb1tC0v/GgHEJ8NHFcrKguTgEpwcSQIDOVDuObeIeYKLKUi8XJIwexy8hpI2gK
         Kat4E4FaIkNe/iXENpa31GKKX7YlYUcZETZ6ee4B6yKAUxtYXsewyisIQt+g19oRS8JE
         TZBLa0XEmUzKL0Zf7vr86YlY1fiVpj5inj1R03NWQbH6SRB9QMoa7+/xNyLNr3ed+B72
         zraFmfINVpNZyj6K4SgVd0fTzSaucr6SvAA/OEBfxcbMchrzTSvR/4VNgW98MotRcspY
         PgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787822200; x=1788427000;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/wURAAqpmYnRm70wHLRDHhfOf5KYKWGXPLGAT3tMJ/w=;
        b=nkFw18iYMd3BPFHR0P4wkKWhtt7DtRdmxAJWi/RcPQy4LTcCmIDwGpTCW4BfSkRFhr
         9DurP+Ptk6ouSvJ1XgWlEt3AH9JB7eFh88HJ/b53PJ02xoBVYyHQWXZyLL8Fjz5mj8dU
         78n99cMuy1ItRVQfKpzZUBOSQmNJCR03gzu5UtE4saZjJMYZlXZ3iW+f0SticBgdULjg
         fV6838EbamaV04WQOlmzlRI2S+dmU7EmOi50fIYEj64JsVhblFM66PTcV9i0FAk1H0Ng
         s21UtBU0jOTBrhunWtyXv4CWJWYhOvq8DvNBiSBbrhTSnPPXsidMPwJGv+zJ6SfoAd9b
         9Jbw==
X-Forwarded-Encrypted: i=1; AHgh+RozNRMtlo41fd85rr6+TG+7GALTEFybFk2JkUyYbALZEZ0XkKVRRwKF2Ic84+BmQbUUbixqTD5/PeFZPMHq@vger.kernel.org
X-Gm-Message-State: AFuF++nJgdtgv08g2EVvlxVxEABO/spIauRxECMbtsO6ZcsGVzCBgRNY
	wrjFTqsO+PjZRzyph+JzAI4epNsrjJcQZrHdALzPlXD3FXsj64fXzm8t9DGMt/qr0g==
X-Gm-Gg: AR+sD12vmGHyF/O5Ix/7qKxOGmBBkcs0l2OBV+lpuOHPjO0iYRzJ5aNkkNMSfI0834c
	Recy0we0e7q3CmGhRlCL7TNXDgnieTyfAHEkiI5ETqpxptcQEgaAe8Y80GA1IGzaTgqARyuXt82
	8bN420gQ/pB8CbZiEUUcz8wyOiD8TnTEk/FfIW8bURw6HR9zXMrPUSKH0aaVsFIxsDZyXc1OGRe
	zNSIrzjKNlMoJ6ekKSMmKTHZUktPcHQze4c4dnofbW8+8AlHJHiqkenkjk8x5J/Uwmv/XO03WZG
	7gHIA3xvtJSOpZtMs6Uabx0eueR/+Tjveio8aMZI65HJKCBWvJuvxFFhrteymqrNDnGFkDM0A+X
	bzJxerPH3vBv6UAojFJcfYKql6iGjB5FzkWfLLRvAPxR14iSfrAWvPtiUTYQbDDduo9padlTU45
	xeP/QZkOTzfn2K/wdGHCXIo+S4DuW4fr0LaqTVfqjxTeChQryBBrYAkRWFinTvdVt4J13ukon5N
	ba9zMfyt276jh0va/IugsWVr4vmcsOHlp+/YGbRZMH+6dL3
X-Received: by 2002:a05:690e:150b:b0:668:568e:8618 with SMTP id 956f58d0204a3-66d256571a7mr4352551d50.1.1787822199153;
        Thu, 27 Aug 2026 02:16:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d24721e47sm2631290d50.13.2026.08.27.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 02:16:38 -0700 (PDT)
Date: Thu, 27 Aug 2026 02:16:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH alt 13/25] mm/fbatch: no lru_add_drain() to
 collect_longterm_unpinnable_folios()
In-Reply-To: <5d42fbfa-1cc3-4161-8ba0-7318267576a1@kernel.org>
Message-ID: <e10bc806-f995-e48d-a24e-8872f0a71689@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com> <333bb765-a36d-e07e-d3c4-5ea2f1cadfcb@google.com> <5d42fbfa-1cc3-4161-8ba0-7318267576a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 24 Aug 2026, David Hildenbrand (Arm) wrote:
> On 8/24/26 16:55, Hugh Dickins wrote:
> > collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
> > lru_add_drain_all(), now that the per-cpu fbatch references are gone.
> > So remove the recently added lru_cache_drain_for_folio().
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > Alternate version for use once David Hildenbrand's two commits
> > here have been pulled from mm.git into linux.git for 7.3-rc1.
> 
> For 7.4 we expect another user of the helper in KVM guest_memfd code (the
> primary reason why we introduce the helper), so depending on when this series is
> ready it will just remove that user as well, or we'll need some coordination
> between trees.

Yes, I could supply an alternate alternate version, providing an empty
stub for lru_cache_drain_for_folio(), so Ackerley's and my series can
proceed (or not) independently. Later. But at present your patch or
patches seem to be in both mm.git and Ackerley's series (17/46),
but not yet in Linus's tree.

Hugh
