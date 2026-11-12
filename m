Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503704;
	b=2CWln176IG7ZYKwmrduEVKFiGJboA4CQ2rfRULKEFdDv3QXjmHx+0wU/IP4ezlpnVNvk
	 4zdRhJucC3eXTWYapqKNvS3R46xsLBKunkKUXN4pbnk6N/oBfiLLTybY1dqNXmW1MBgYq
	 qbhIGvzEjuHIKvvRrZTQh2L++5JA51sF47l/lbFaW2CSGJqdnUWzPhAN9RhFKwYEzzA/B
	 UcHTbgy4VoHNeDQoWOcsCM0twSErNwav9h8TbyxxsA/2gzjxBkW8FVWiOtfeT/19LrkZy
	 D/PWexAabXS6cnRnrcNnnsFZ2XL3SL9O56AnR/L8vstqg2flrLFUgloo5WGR4mfYiEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
	b=Fx1dMyoopqkyRgGoM86OhDQalpc1M3zjQouycdxC8rTrwOS0gczBrVYzZODDc6aR/rKY
	 iEb9g2hvN6hCSsD86rA45YF6t3rtFgpqkR/IDec++Up/MAEV6jdB5lwt/wCpYtuc6Wyjx
	 L7/KR0rtLwkmKI2qUy6/pkTNzSSjUg+w7Sx++u+YcwDEbBOPPeoI0fDZKPuIBDGsZ5eTT
	 obB2+nRVMVjAljyeTvCvYZYQeCOKCDjZLU9EJKwZhhgLdfgMHsV2AsVAeBB5kDD2n9dEB
	 wPL79NQBk+nPXO1y992JZVWWM0ej5UcWraHVoCe/yy6nD2kqdXOVoUJO6UgQPloQi1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=pmyoi0DA;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33B4606A887
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B33B4606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=pmyoi0DA
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53669f7b518so45421801cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794503703; x=1795108503; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
        b=pmyoi0DAQQlNFzltCnW5ORgDwnPgssF9tc5Yb41egpqJgqO1bCD46e5CH1aNeekBwW
         zNHDZbnO+IlIj94erHAXPMOAM++MXQqoXuZCMU4A5rLvl3ueWGShLAmTxgxlGbCB3/gG
         ZHjvXlyYIqd6r+/SuPQvrTTCMPGpgZUnR+AgV5/jt45EQ2tyGvJM+kMslERvdjYJbMT1
         9TMAzYgSYsdtz2+/xGf4uEOHM3MHtE71s0/etNjpd1b+uuTHQYTAfstQQM6azn5B8XfM
         Jrp4nZhrib4IHL3HIQOCPoXU85VZDXpBpYjP8UIEY8bs1f3sG0zr3OlkX5wrMUEsI0qf
         ujQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503703; x=1795108503;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkUNJy/G/i2yr1NWN9oiSB6swWvpLvuFtnABa0SM57s=;
        b=KkgpOXnO815EXv2Ulu13wdTxG8+8UfaeTg4w3Oc/aTt4FkmpCfsTLfMqrEqa5xs9+3
         fs3XIw84517mXbKKXS3SIHpxYj4+5pZY5Ijd8k6fnKE6GUET0vGzA5DSiVs3EmdLccgJ
         14PXCp2+JrQ+WtWElX1QQhtzAyZQkSy55U44jVveJZ12e+iqUmbW4oqDA5TnQz+LOGml
         S2KX2IQldxHtkm5U55zrI5q6aodsl45bdFw0MznOgdytm+6B8RY2DZW0Kkc6QGw1sBSR
         ciQlNDpvcTb1dBYDnD2l+3QdcXaYkNG87X6S5e4b8WgX2quxWsjt4C5GoXmQcEtzqxvu
         FDiA==
X-Forwarded-Encrypted: i=1; AL+hErGJBlf73ITUtJxXhQSWCjDi5cBocY7PPjZ0LKhf9Z8CnxSkP3ta5inE8RR9cnV0x1LjkNT1x1IdUkbMTWE7@vger.kernel.org
X-Gm-Message-State: APuU4Z9MbamOkqjUEyroMsqS4L6LPQmQ6seUfVdNJguj1iyp9YOnEOp5
	8gcSLUyfuPXnPcXamqeggAAMVaA9S7y7yvFJHut4yj507VznWDU26DcbZHzm/6nTY5A=
X-Gm-Gg: AYBFou3LbRWdQQnUaKyKK7cVKVAIy6qdRn0TRM2DzVcASVsdjoaOnypKs94e/v87FhI
	ZWNxi/nSAUZworb2s0Uf4otj/ePYDqw+LOTjawPYRk2lzHl2cs5w7HkbwBT44mEI3tQpILNWU8F
	2fY5mihSEAWwU02zV4fVWWcs4g60K61QP8K8uxCr6Gq+o0xm4bBZxSXJwp74rJctQrepce+W+IE
	esiw/sE38/oq1uHbR8HFJ1ALBjw/AzQlynJzh7bUlhbwCX5g8Ty7r7yfZtOaDyVc3hRgNWU+X3a
	l7AqlbwC8pR3oVsjA3NgsLXkJnz3PVkYAlWBvoPVq91OLBb8G91lJa2H7LtshYu2FwDHk0QlsbQ
	xecOf9g/6EZV4tovkubr2CXxvHhN3SRS+Qeo5O7ckG7hjvJ7UvGaFNmaBRGPO0QV2z/La7Y3EMp
	9ssh90hFVOR6kwLbutKndx5YJaoTcSX5HiV4tsWZZAfvDYrE/2vEa/z2VPLSJaefUznHw345UeU
	3Txtb1xTiU4OS65DcY55wypUqV+6x7aFuWPKWd+qrCEvoPdks+7oYNk4xRkyHa88LvHu2yBIqxK
	FRkE1DzIqxJSAMVT+wdkz9DyjTcaZUgRgiAnWPMINMEa0ol16sJy9/b0bSSDnjMklsz2khFv4b9
	St0NavmM=
X-Received: by 2002:a05:622a:5793:b0:54f:863d:92c7 with SMTP id d75a77b69052e-55ac786019emr462181cf.41.1794503702764;
        Thu, 12 Nov 2026 09:15:02 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af5f339sm78250641cf.9.2026.11.12.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 09:15:02 -0800 (PST)
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
Subject: Re: [PATCH 05/13] mm/migrate_device: don't collect a range twice
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 "Borislav Petkov (AMD)" <bp@alien8.de>, Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-5-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-5-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 12:15:01 -0500
Message-Id: <179450370120.482102.8019443935242743968.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> migrate_vma_collect_pmd() drops the page table lock to split a large folio
> which it finds in the middle of a page table, and then starts over at the
> "again" label. The entries for [start, addr) are in migrate->src[] and
> migrate->dst[] by then.
> 
> While the page table lock is dropped the page table can go away, in which
> case the restarted walk invokes migrate_vma_collect_huge_pmd(). However
> this is passed start rather than addr, so [start, addr) is collected a
> second time.
> 
> This can result in migrate->npages exceeding the number of pages the
> caller asked for, and therefore in writes past the end of the
> migrate->src[] and migrate->dst[] arrays.
> 
> Fix this by only handing over what has not yet been collected,
> page-by-page, and flush the TLB for those entries which have been
> previously replaced, similar to the other returns in the function.
> 
> Fixes: 022a12deda53 ("mm/migrate_device: handle partially mapped folios during collection")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: cleanup commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reproduced and observed the out of bounds condition with a KASAN kernel.

Fix looks reasonable to me.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

