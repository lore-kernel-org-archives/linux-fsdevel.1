Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110239;
	b=xF0HyPVMlADuPKD31xdCnBF9qUW/0A1Wu7OL81fHoFyn1GRi3PmNhLHOe6g4jXTYH793
	 EcArfBDThtqXq4osJpcsTt6iOgLZA9NOtB2zmzCiSxkx+dajbaOPDJnhulxFqmkulYp8w
	 KCavFeF/smn5VywAoFGOExgry3zlcxC70eIGkxLdXH1K+ERGUoPbu+1jAY5iVR7StF4lz
	 txX/DxjXUND6E13FDb2g05i3VwmhSBCSghIwnnH/TfCh0ai1Pe4p4KsY1L0YBT0StsnXd
	 AEcWSukgLw58CT9avOLrvFXJ3SIx0o7aGKl+RJudury2y0lL7eYblSchsoxvMOeKLdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=;
	b=I5wOEuTcTD1fHS9u6b/GOyG1xC7zzLaS9/6uT7xYiBMmJ22RIhNA8iNpuGDtOzKRXjN6
	 P7tQM5RPy6v3HMLYcJhxlYxNHfqaOHcdUWVZydBhd9q5uIxNKcQi/PjojpLuSQ3F+cR5B
	 sUI4iEj6wgx72GQov9eeTk6YugPgpJLxVJPwiZdp4B5eiXWXJYFIkgNkIzatRzyOg+xLF
	 q1XE8aY2OP6BL9TQxGwUw1bK0NafIR8+PMcXo/PmJk1fI3ubGG56heXFpawHVr7k9eNN9
	 PuD7mDIdTuKMA5Nnv/ZPS4baqrB1ApMy2e+EeSsmPZfnPf2S5jQBk47Dwo1b56E4MYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA38606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA38606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8565d77c277so34902877b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793110237; x=1793715037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=;
        b=nHbEtXvQuJ/8CywicpheEz5Jdzxi84tcFvyEWo6MXDPh4asHKIihhtID8raFmjk37Z
         dIOwkrGzjZhxvEZXUJRdwo9NVK3DnFO6vFgVbyFCqM+U4fQ4FG8QNsnimbJIyHqaW5wy
         zdmb6kGSLSm95ASDlhX+rqMiMzLlf/wpw7XJwPUNNt1wr89Tc/8R+06TYMpR+3qRODJp
         T0kDcPU38fvugHwlN3DGLvwyBfotlPqRAWV0pwds8WKmv6DVhYWhA/X4VC37TJl2YkFo
         5fgiFCeXn8wHRmX8+HCDn3P1/hp1F7XTI6c+hNVNWpzgRnQiAvnJ+DdZz1WeG3Ulo5HG
         5tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110237; x=1793715037;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5jxF6/4/W+A1WjrCqJd2E9d0nCbxdlQgcbJ/7pkC9T0=;
        b=qDRh3GYqfIdPR84zlngS2uU+xRtOIIQsdmTP4JG/qZxEWObrb6d+shDp3IY7wXeXLV
         us4H6wmA2IS4Fkb2A9ANT+MQ7DUEFkveHHGvyIZCoTfzpDGqU4ToSGxZ4yvq9bQlH4sv
         /dfRId3r1OgyO3u/vXiKR/c6Tz0qtZPCHqanlpC9UF5pA6kstQvW6yp9UeB945BcrKZG
         GqhmHmagyEIka2tJYK6aJMZnKorOxMgVqv+A9T+uAtMlrdCdWsHdpuM9ct5wm2IKlv3U
         yXzko9eiKooK7C0XueCU2fJZaOpqSuJmKp6ihhaON31fVDlfEkbzFoHdW8DLf532QqwA
         GMSQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbIxSzlYQXQu2qSUVHoz0gJRVlcfbdT3fUBqTsdcjgorlwVHalI0BAf2dyX2Baq42apUSj7jK1PfiQc5Ku@vger.kernel.org
X-Gm-Message-State: AFq9FYLSv+PfuUgi4Bt6tH6WZxWJV3Wksn6o0fMWrw0ACXkhK/+YmmVr
	5b7AmbqeVOG6+yp0bSspyibrj8HmZSr7mvofGEvXCIho/5LoyrH5zmnFtfAqJ4lSMyQ=
X-Gm-Gg: AYBFou2yuyTf9q/SIbL5k9Fw7lPsDckWUMkhVK51g93z12yFKrNtGcL8IUEfgz19Ag8
	dq5H3ueQHIUGSkmDLbP4+bKYxTuNakB9XWHApcEcpKMp6uGVZyWPobxAy3xHw9oO5uz2TbVt80X
	6U8oiIkC0YPGRyVN9aIQu6k/sxDIVblIGgSWX1Pg7FrgVeq8Z9Ym9S5EfJjshziPw5n/jDMdyta
	5C8381eK7ClpvmuU/VsHSiapot8tKzsc/gmGUO6DeJhrlR1ikLmnV1TeAt0dI+Rs9Cg3iVh1VVE
	r+mCn8kdypkvyC7XbhsRcr/5dwClF/tTilQMywtkJRo4v2kC2l8xT9YIP4wwqZZq3d6CJITc0XX
	u16SxQincvpzbUhN+oOEKCKUlhtgXXXd7e8Kbx8ngl6DNyC8ZEO8IjdpiN8eaCghdN2iwTGc8IZ
	ROj7JdR1cb9NdHUiJ+9a9ZA6ArBBrzYY0kAwRq5fzrT0PvVe986lrD8Rh1UvbEATiCojoI3LBqm
	8smQTBS7+rLfNvLJH5QNSqoU8N+E2mg+mmNQsuRNlxeRT7sif+ej64=
X-Received: by 2002:a05:690e:bcf:b0:678:907b:3014 with SMTP id 956f58d0204a3-67a6b942174mr1866452d50.63.1793110236828;
        Tue, 27 Oct 2026 07:10:36 -0700 (PDT)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a07daf6sm127367d50.7.2026.10.27.07.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:10:36 -0700 (PDT)
Date: Tue, 27 Oct 2026 10:10:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Youngjun Park <youngjun.park@lge.com>,
	Gregory Price <gourry@gourry.net>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
Message-ID: <auCw2-_yjh1_RjiO@cmpxchg.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
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
In-Reply-To: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:30AM +0100, David Hildenbrand (Arm) wrote:
> Since the deferred split queue became a list_lru, the isolate callback
> moves the folios it took a reference on to an on-stack list, linked
> through folio->_deferred_list, and deferred_split_scan() takes them off
> that list with list_del_init() without holding the list_lru lock.
> 
> deferred_split_folio() does not know about the on-stack list. It only
> holds the list_lru lock when it looks at the same list_head, and it can
> run for such a folio: a THP is queued when it is mapped, as a candidate
> for the underused check, and is queued "again" when a part of it gets
> unmapped:
> 
>   CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
>   list_del_init(&folio->_deferred_list)
>     next->prev = prev
>     prev->next = next
>     entry->next = entry
>                                       list_lru_lock_irqsave()
>                                       folio_set_partially_mapped()
>                                       __list_lru_add()
>                                         list_empty(item)  -> true
>                                         list_add_tail(item, &l->list)
>                                           item->next = &l->list
>                                           item->prev = tail
>     entry->prev = entry
> 
> The folio now sits on the list_lru with ->prev pointing to itself. The
> next removal leaves the neighbours pointing to it, and they still do so
> after the folio has been freed. With CONFIG_DEBUG_LIST:
> 
>   list_del corruption. prev->next should be ffd4000000270090, but was
>   ffd4000000278090. (prev=ffd4000000270090)
> 
> Fix it by grabbing the lock around list_del_init() so
> deferred_split_folio() cannot race with it.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
