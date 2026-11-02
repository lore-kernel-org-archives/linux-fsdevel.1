Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649263;
	b=DhzyK/6jhY2lQLLd2GVtpG8ggA5cuGf/qRBiurzQdVGGjQ7aKK/5ieticfeCDm53nEoo
	 IJceeBB8KQ8QyiMgi2RhMjXvfl4Qkcvh7i84UpFFan3ArFIHljDhaAVJtlXnejYtO0NWJ
	 pFRv3ERdUOmqgtjPvl+hkXkmE9EmdooweDQbam7RpWoCFtyxxYgwCtyGMjARMIf7YQOqz
	 mgoahkaF5JhVq7OfW117uqrSMpBmz/3gcb96bDAh5KIblwfIhNmDTVgro6+JZb+zzQuJL
	 LcVlF8gWcNm9gvS/jeDxJenLBhg50RXrt4iIRjvS0IvIgNXs8FALTZSyqzUdv2zn0aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PXm/uwD24jlxN0Wbjq3NylUh7A4E/RjzDePOTrROpJo=;
	b=H6F7+kkYlvcdMVYqCHk5Z5tbkpSNUNWPt+5SVEckrzFnKnAxkDjm3di3WVbd9of2nucF
	 S/VLu0mIwdMDt/PeFCuQsU4fUH1dlcm0mC8cWo0C8wLZCCQxHd5dPxxwKeKRwg55SmSur
	 6J8Prqj2bolsh9vi09ziztSFrvtkxQd9flhqz2dmWDNEkutUygG6IpXnhb+2RtjovnKVy
	 arF2cEBag3kZUEjDFiEZC0t7B790lKrzSC5PTSbuDlQCxr01Dc9k9+Iuq2Q+nvuertukT
	 2F7Vg8RyoBevNKQeiIYcALUmJoZBx48wVV2gS1BbxWh5hb2aWLchQEs+xshzlu9gedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=HxMoerxs;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C104606A327
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 19:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C104606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=HxMoerxs
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso28229167b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1793649261; x=1794254061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXm/uwD24jlxN0Wbjq3NylUh7A4E/RjzDePOTrROpJo=;
        b=HxMoerxs9ftVA4frKuy98OSQ1rbANNYtqCuy6NAd6YMcBMI+HRmaU9GrksVobzn5MC
         IuphsQQC89Rk96z0yUPY+xpQ6lsFl3iTsK3QgesKAw1/72nH9hOJaBhzE0JyD8IKXUj/
         fEVAHsGI/Lxp3SjMbftTpWbsErjcQz2RWWWhfw6ejtzTJClr7FINCpLvPLNOf/L7unr3
         mdj26xq5UHsX2N+v3KJtmnxuRX9g9Pjdle/r2/NEVttUYNDLj2vbm+VLczltKwwGckBD
         a85EXBSTiIz2jyf1hHJY74c9NV0+z1DVCzcJWBZG2FtloTfNAN8Wos34izd5FHE8mriT
         oYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649261; x=1794254061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXm/uwD24jlxN0Wbjq3NylUh7A4E/RjzDePOTrROpJo=;
        b=kxJrVz4SN7KG0GrmTkCndEuMeQXrgtgGG9I0HgpyDezf2LGDtuNuX3HZfazLB+bIBC
         6qTfkb86VqR5I+tReA/q5FQLZKx7VVJHli9vGO2+Uw/yUmDMcd6uCMmMAffGwdXr0amS
         xqg+HlEnkriOEjm1/XBHzCCVvMJsM9ACxOrQ9msjvqC5doVZttziuHcURPZl2fhFNwzI
         7wZSgQU1qJXwcUWbgyd8GNZNmQw6YieiyZZtlQIgZfZXtlw8WfjNS8+zai9TCogOiNP7
         O8pYKdKL6tGVr4AvbKAHSbkJtSjQhBBzBAgjco1CjPHO8WLFBVFZ+j7/fBVrWNElZB3O
         /6FA==
X-Forwarded-Encrypted: i=1; AKwUvByq0IHZMlQ5wq3jfG5QS2mk/aiwFifV/nPu5PUpPMSIAJg54P6kDPBSfg5BI5QnrKxoZ+QJG48m+MXWC15C@vger.kernel.org
X-Gm-Message-State: APuU4Z/Tpv7ishXml+wai9+wqR08X91of1bbbCRBSm5szY6iRBT4KvyD
	pr0xIE/wWnuelq+7OMh7OeBb9AHymtQ93d/nB8ObdmC7rNLAj1WUs+KNgLEPb4twCBtOAFm+W0e
	m7cc0
X-Gm-Gg: AYBFou3O0jgVu6z9ba8uaDN5/0sFiiaMc0jIeqfsj+Mb8L1QMBXI8hBkjRg3SkEXXeQ
	1zQ0CWjdRxiYF7XV5dBeVA6oVRkyE0PJe4Mh/2IUxkbgJLvBZYmjZKJWNampui+yMaiLGHBAJCQ
	1y/0aCOpAmu1qDpovaXocyMyjQ1buCCdkNPRXumhBLsAD4H5x1BvAQCMlEmI070qqdB64aElic2
	gMx+Jl3AsZ8M6BEh9BuH0pS19WjUjuv8Qru//etd5JcO4kyyz5KkFMGJZ1N8IwEuoOLKVkl8Bud
	Y6srRd4LEumsSajUfRGluhEszoCUvg57ih/bICYP3D6dyWxq0jSkSb2MJhOCmM1ebajWfTkEuA3
	DeY+tnVLJuKu6EhfecA/l/xjeyP1nB8sF4prgBL3kgwZUbI3Qu4LRlaN547J9MSNwyR2qW08KIc
	m3Nsl5i3Yammz3qSGbS8paW0qxOFuy73A8EEVRn70yzPbTjdMkYLfnjWYmfl/S1u4IKy68ms4Mv
	BzMncCo6LG+l7jIeLQ6wD2IJ9Zx/gT9flebe2R0tMf8feHiI+enndpSflGJNT3UtAtHTnLrYbP6
	AK0oJUgywHyfqnAtch1sNhnCFqY=
X-Received: by 2002:a05:690c:348a:b0:88f:df4:1c8e with SMTP id 00721157ae682-8b2b66c5d61mr71635247b3.22.1793649260825;
        Mon, 02 Nov 2026 11:54:20 -0800 (PST)
Received: from localhost ([2605:8600:200:14e3:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7125371sm58207037b3.11.2026.11.02.11.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:54:20 -0800 (PST)
Date: Mon, 2 Nov 2026 14:54:19 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
Message-ID: <aujqa-dA7Xa5SsIa@cmpxchg.org>
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
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
In-Reply-To: <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>

On Sun, Nov 01, 2026 at 05:34:48PM +0100, Vlastimil Babka (SUSE) wrote:
> Johannes is a long-time expert and reviewer for the page allocator and
> has agreed to step up to a co-maintainer role, so do that. Thanks!
> 
> Additionally, page allocator is joining the MM transition, following the
> MM core updates from David [1].
> 
> Patches will be collected in the mm/page_alloc git tree and integrated
> via the mm/linux integration tree. To signify the change from Andrew's
> mm tree, remove Andrew as M: - get_maintainers will continue CCing him
> on most patches via the catch-all MM entry. David prefers not being
> added for mail volume reasons.
> 
> [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@kernel.org/
> 
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks for your trust :)

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
