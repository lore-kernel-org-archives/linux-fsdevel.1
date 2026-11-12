Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501475;
	b=lzs8jY6a7S2arLiYvoxzKjPTbxE9LG2vq+YsI7Z/ujorFQ34bbr9h2U5TodL93oqIBU+
	 4PPswA4IazN9FEmrwKY4FOdqO7h+UyA4ff2PhjG+mi3mi/L9GKa5Cn1Ru9cJ7NvQs908J
	 DkxVA4MttNe5Skqbt9fNLULmlASksVjUc5zM03XzONPDnTSQAeJ4UZ25pbFYuvoXhHImY
	 Uuy6MHGD+9U2UwASztG4fMe3eZq0WueAK66CRWTWHB4Fc5tXmDDeezrXCNmq6xmIahEv+
	 rXHKn6Kwj6ah5k6twR0Aji1h2c3F/PaGJD0zXCmSixL2hIU23DjrIA9GREYRgxikuzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
	b=Z2GRbVfaEo4APGS3lo/EJt7M1twU+SexoBBAQgi7bwnu6+2CLD4ZnVb7K1KWgekC/QHG
	 XeyoAZEChAfn1Q1hqf6FwRLZpGDNZldXcZk8WhrADpnL49fpR0vXDfPANMhqu3Dh5cVWf
	 KEuHjCfuEFGD43vuZaFJgy/MRMKWPonKaqjAXuKJsJMEMItttX1tbbz6tlsZVJjT27Eu1
	 2vK544v/UbB+3d0v/AHqVlOyvHoZ/Oe7jIBg/phUAV0f/50xlgTDv7eQMcqGO/d1UBksJ
	 DgX63fjuL5J90TzSzkjsIsouzPFLCiIviXb8uSIx6tcdizYYtcQNRqFd1/TWB9EEl3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EcWg5X0n;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4F606A334
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 16:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11A4F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EcWg5X0n
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f3c89594cso343215985a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794501474; x=1795106274; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
        b=EcWg5X0nzGoNsJ0lB6GPdQ16HEXrDhDFvoQsS0VrzVleAIoPDVqS/h2acM8q0TQYfu
         dFvoIUBys6Phs9cm9/zUsvGd4XXiUFUgl2Vvh3DVjvMRwzUYK9Q41zDGwVwWXB0/n9cw
         dMU8taq7vFkwnnEXKmC9KIXbeUMyYq40IdG0OPHGeX7lvePvlpnmLRTcmVqFwecD6gPO
         jcjjBvWRzbqYTQEOYNjHIngi9klLayXp1nffRLMV2zEQTxslQf78Eyf+TpWKysHmuy3J
         4JKN5sNVVBr3UPxXRJclimCFmHmsOm3RQFiy8w08BBtCyPXwzXvbPbyunw60CSaGFLTm
         yKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501474; x=1795106274;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvjirMgHIxC88ZUFqPd+mUQ9zs5Wq4hvPV8uQmDh82Q=;
        b=G061YD2h1LN3DH/SSsSAAlPk+WjBwhzuvoRI+7rA3kCX1mMf9mJHdU4axPgTx1vhxv
         OxJ390SpT7UXKt8Snp2ziD3+gM5FLQm/PzIe95yb2agfVFu73Y38E/ihO8FfMkbqy0MB
         3S2yqSWRI+k2U9Wwf4eJEbusLzYwdoXHNLFv5zzZMDXPplm+4HNGNJgGeud9CuY002+X
         aXry4UhLihw9ZJQxKiHNR9tG1rESiKodMG/B6Vivgxbv13A4nM35HUYHy0MardrIsZ5m
         lqa/rNU4oIRa7lWjEp86CIifV3tgL4YjgGZyIwo4ayl0rp5qOitMc/onLwPRpHpKXtjr
         KYYA==
X-Forwarded-Encrypted: i=1; AL+hErHwLBXnQyDRAChuwXQppRVIHijFiEaNAeByZXXAyGWVPFgK9AVFAbsC7FNToOjiDybnwyocrxdeGVZ+vOIZ@vger.kernel.org
X-Gm-Message-State: APuU4Z9YO5LEOCOudGtHHuIknKppNKJ3zQCR+yIUmXJeoQEE41SfvtJu
	5xgUV59MJXr63hEMeIwqNpArozY+Qx7t0dF3DX1dBuKku3MuYu4xFesI3iaTQHy1ymU=
X-Gm-Gg: AYBFou1axRwyVhFjuIXWofngOZ6ISav5krihDyaWOaW//jx3gY05S7S6dS0TDmtzKyC
	1uu7zcKkJw1mA30/vaNUI2g6vaFdEpAeTd8c+2nE5XuNdeDYaHS5SDQe+kEX/Uo39OU69wcMU5V
	fzeYdWy2prenpeoqMdx9CH2zx7E0U2fEvyFz/ks2yxBde11tSS2D58fNbYybJwx3HHQFF7nFOD9
	jxegWf3H1nRx5v3kpRnnzMKo1y6lpWTifU6AxgEr9tmuZKM9OLd2Ih0PHb6vrD6BmaqyXpBkaIb
	RwyPyZrUUCeU8jmOlx2blez1Ges6fIj2m9XxlvKZVhu/JReo+frOC3+Jd+UzZF0kY8ZTECjQw5u
	WVTAPSj9pYeD4w72TRgSlM+ZWcBgbyIWjFiUtLOIKBAGrdy9KUaQHOoWkvGvgPNVzJwdY7HtZeD
	TDtw+P5BI7eU0hWaD/wSSbFjz88CYv4q8aoJ1hkqbbz8xLFM+vbzyfL9DzVOivMWm+ZCFhyVVfX
	htOTHLcfRCHi2GdKRYzZKEOVk4szsLtZpOm+EmuAVWWpgKt4mTMBgO3L8BgPL0GGQenSroN6clA
	2kzRAYtmVnvLlLOTu6WUmfJCpQNg0s+fUM2CPxnGWP+eimE2TTz0GTVdpjVPOyfmVgqX+HpqzhF
	mj4/Wyhc=
X-Received: by 2002:a05:620a:28d0:b0:93f:1e3c:4a3d with SMTP id af79cd13be357-947aff8c925mr1038556485a.46.1794501473963;
        Thu, 12 Nov 2026 08:37:53 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f02df0333sm51261056d6.27.2026.11.12.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:37:53 -0800 (PST)
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
Subject: Re: [PATCH 02/13] mm: cachestat: count each page only once
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
 Rick Edgecombe <rick.p.edgecombe@intel.com>, stable@vger.kernel.org
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
Date: Thu, 12 Nov 2026 11:37:52 -0500
Message-Id: <179450147215.482102.15685424149106944496.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 18:13 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> It turns out that filemap_cachestat() can unwittingly return incorrect
> page counts, if large folios are present.
> 
> This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
> kernel if the input range starts more than 64 pages into a folio that is
> split during the call.
> 
> It can also occur due to pages after a large folio being skipped if the
> range starts in its second or later XArray slot and the call reschedules at
> that folio.
> 
> Finally it can be caused by pages being counted twice due to folios in the
> range being split or collapsed during the call.
> 
> filemap_cachestat() walks the page cache under the RCU read lock only,
> and for each entry it counts the pages that lie in the range. It does
> not track how far it has counted, so the counts are only right if the
> walk returns each index once.
> 
> But a large folio can be split during the walk, or small folios can be
> collapsed into a large one, and the next entries then cover indices that
> were already counted.
> 
> Resolve the issue by tracking the current index as one past the last index
> in the folio, and explicitly using xas_set() to set the current position in
> the XArray.
> 
> Additionally, add a check for folio_last_index reaching or exceeding
> last_index and break out of the loop if so.
> 
> Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: updated to use curr_index, fixed comments, updated commit message ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

