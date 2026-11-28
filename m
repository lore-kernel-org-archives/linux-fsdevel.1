Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795827440;
	b=5BnCbTvOPdoTfosPjHkBrWdcMrDEY/AsbIjYNTFUgXUmONNzrksuTkhJJk5j5Bua0q4y
	 8WD5G6X4ZuRoFcDre9yPg8u98oIp3wnTO3YqiCllo8LrS+jFmTZOmCcfOt/L7rQ2Xy1Lt
	 7gCX5wgOGYzuYd+4/nEW4/EPo9Z8idzQedmYPBnw4deSJ0tRhuvf93PIyt/C8JGgSfyNz
	 GRUAwCcLCHAyERAqPBdvHJ8DV2q6dzRoeuo0KSzCN8FEHGmzG0Pr5H5EjRz5IgXVUMsrv
	 0nIpQhQSmZ1Q0Ip7FXxSfHU+XEzWxZG1h4SVgVeulKeQK6uvSB7mjqYtsRVN4XleaDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795827440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=OkwyOiCRAz5EAkzPE2HGFHWSVBJwZ9Gjp6yJVpEfm8Q=;
	b=Owlvnv0K/LBg9B6oEnccPXF1e+ol0b71LNwcmJJhNf0bHenQBDrYU74T8/FtsK1/U8/F
	 Jdr7hdKls6vcuAKjq1XYbE8o6k+ilDQ7ffscdIziQPUCGpT+P5lsN4YxynlQhFddxGVRM
	 MTSCOOwwc8zWkR2s8jKCx1iyVoe/xeJjSas+TPYk0F9IZAn6WRr7cZtErwxwXG0JSDNEc
	 WHq4ZKYTH2ae0V7rv6c3MZDnRLkpFb7vn9zwFdoEA2xwqn5ACMWtocRX/oWU6PsaLZdQj
	 Cnqtb9KNYWpRQMa9adq6S+sdr67efVcE0bJwW1jQGfpn/PhnDKBNke0B+wS1K3bTyBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=C2yVn601;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C11606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 00:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C11606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=C2yVn601
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b4e2fcc300so75707447b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 16:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795827439; x=1796432239; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkwyOiCRAz5EAkzPE2HGFHWSVBJwZ9Gjp6yJVpEfm8Q=;
        b=C2yVn6010RByzLoQdU0F2bY5TVCz2FI4O4hBokJJ5jDBRg5aY+GcCWso+QRAq5qvZ6
         rpAdyPUuEhtLk9JRl5H0jYje6dtOOVfrDgAxQLMybP9vO3ikaYNsAUIhUliub6kfm2pi
         go+MWzhHEoNKc/8q9BTKhY+BSFOr47O+aKKas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795827439; x=1796432239;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkwyOiCRAz5EAkzPE2HGFHWSVBJwZ9Gjp6yJVpEfm8Q=;
        b=SRn5C0BI+sXOXxmdmEq9uv/iMVn+EzOtMihzbssdKv+pzEOSIMNyjFMuxR5spguUjW
         2hG2NovX+d6sshk+p+JgJg7s/oJqTM9iTglLlt4GMT54FYONBtq9E8NSA8EB1cFOfzp7
         W6GHvYr9zQyd5SbbMirt2weBNjSPKSn7ogdDXVNvwHs9MeOL9f7ogH6s8o2um1bADtZ2
         6DTyfa1WXiJu7cp7Ym365SiudBg8JOmHhEoMnUU1R0E/3IGPZq1f0SA74GZgJ7B7sBWD
         qbJrXl/kLY00OFTh4sgGUg/sN8dLdT+50L/7buOUpsnrsxQsrIV9cvcPYulPdXG5hPhz
         nmTw==
X-Forwarded-Encrypted: i=1; AL+hErH3i9lqcubin8PeTFaKRX6p0tXNM5v8r/m8jV932KuV/L3YaM83V6qvuRPM1lG0o4Bh+YCDbHzDYChY0GwH@vger.kernel.org
X-Gm-Message-State: APuU4Z80v7T/yXOZBKwVAO3arXcHSv9lfX1KLuHbTIpwkb8neQkeyNQc
	amgp7FPVnwtEXXOl/qsYO4gSlE4cagZ/Or2Wj8CZ5+QoaAcQDPKuPgZ7sYxMUlrfEFI=
X-Gm-Gg: AZFdTZeFbU46Zi8ieoM3g/jfN4HLE0GDA7R2UhkWoSDWeQVmjMM7Dvv+wG8SL9vxFyS
	JA9LkA0GyEjajf68Esbv4avH5YzCkkJZG9tVhk5egT3/Ps4OB+Dslqs+g+ivcNvZY6q44vgFkOa
	YqQI++NjYMEOn9KlQ+fd6sgAeHc5o5VrNJdNaFTJc9Xl5YxBN09OUUI8d2crsZJ51jLg7hKj7xG
	hO4k9OALDutzHYLBUHXBFn1sGTCP+XiHBlRIDkupTullGkXMavCdnbriHEr71pHm4nsXW7w1WH+
	1zBfwbCHUSDA9V/ayX5rqHmKMslLGADYcm+2pIdcv74sy/1Bfnu2mrTOHJI7wvahYy3N8kv24XR
	G6IClJdeo2SFx1cXeFOGgDLWqfNlEL9lDQT1zCtBSsz6WDARRbQ1EU06yG8mKQDuvDOkdhq9Q4j
	CZTaPeM1oFALHSgHW/wKHyrj/DA4U4HSUa2Ed/7kRySuZ6l3yoyiDW+5XgoH6QTkwVLfAD+5GaL
	AcZk2ratyhUJAD1i4lbtU4FmpvMRjAt/9nE2nL7DBuqZl8rnLWNZ2RRNtyssRQoATXubFcimccr
	6RlYrKgOsVNBmr26/SUB4jAyHjssyNucHtbe8om51wfJpUWRGcdQzA305Ut7rwASVJmaDCPhC9Z
	mdI+t1PGnIUK7HfqS2L7MAD0dhe5vbogsyxJihDsrPHCVtqEz5s47M6nBV4j9bQfEzurLIn27MY
	XWRjoT8iRZMNrIsZjHeDsjwv7I/XKx2Xg3Z+7JHqXL6a4xZmLo23pL9VH1g7IcZgv2+Uy47vpWv
	4ZldxGoNuuRsR971tZnrt4=
X-Received: by 2002:a05:690c:9b11:b0:8b0:f116:1200 with SMTP id 00721157ae682-8b5204efae0mr102371357b3.85.1795827439428;
        Fri, 27 Nov 2026 16:57:19 -0800 (PST)
Received: from [172.20.0.2] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028bfa2sm100757467b3.14.2026.11.27.16.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 16:57:18 -0800 (PST)
Date: Fri, 27 Nov 2026 16:57:16 -0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Greg Thelen <gthelen@google.com>,
	Greg KH <greg@kroah.com>, Ming Lei <tom.leiming@gmail.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mm/vmscan: Fix legacy memcg reclaim deadlock
	against filesystem freeze
In-Reply-To: <20261126180228.9b672a945d480e3d3f301985@linux-foundation.org>
References: <17d0d1395c0237d201a1abb2473d51f5@kernel.org>
	<f188775aea9580f9ab2b477788503434@kernel.org>
	<20261126180228.9b672a945d480e3d3f301985@linux-foundation.org>
Message-ID: <awom7B9Evkdhq1EY@chrisdown.name>
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
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Andrew,

Andrew Morton writes:
>Can people please take a look and suggest whether it should be a
>standalone patch, or just fold it into this patch, "mm/vmscan: Fix
>legacy memcg reclaim deadlock against filesystem freeze"?

Yes, I think we should fold it in so that stable doesn't get the fix
without the scoping. With the other patch on top, the reproducer I used
for Tejun's patch doesn't deadlock either.

>(That's mem_cgroup's fifth bool - maybe scrunch them all into an
>atomic_t and do atomic bitops on it?)

Hmm, oom_group and zswap_writeback are in the read-mostly group on
purpose. I also think packing them into one word with runtime-written
flags like this one is likely to result in cache line thrashing, though
I haven't tested that. It wouldn't save space either, at least in the
x86_64 config I built (given each bool sits in what would otherwise be
padding).

>(I am told that moving wb_wait_skip to just after oom_group would avoid
>increasing sizeof(mem_cgroup), but that puts wb_wait_skip into the
>read-mostly section. wdyt?)

On x86_64 it doesn't increase the size from the previous situation I don't
think, since peaks_lock is followed by a 4 byte hole, and then wb_wait_skip
just dutifully slots into it. In that config, pahole gives 2240 bytes for
struct mem_cgroup both with and without the other patch. So I'd keep it in
memcg_cold, since the read-mostly group is for fields that are set when the
memcg is created and only read after that.

It does need an entry in memcg_struct_check(), though. Every other field
in the groups is asserted there, and without one nothing checks that
wb_wait_skip stays in memcg_cold:

    CACHELINE_ASSERT_GROUP_MEMBER(struct mem_cgroup, memcg_cold,
                                  wb_wait_skip);

With that added:

Reviewed-by: Chris Down <chris@chrisdown.name>

Chris
