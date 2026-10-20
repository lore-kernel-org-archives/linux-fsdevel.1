Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531575;
	b=Sb4zBMvbKgZrmi3vVdjl/nssB+yjr4TJm7VE7NuCzj7hzWwCRXt5yNmxM+vso3kalTwS
	 cDSm3bHWN2NSvJTXKJ5+MFipoB+zC8Hz0m6DR0asX4f0lCa2itU7Ijs1Aoh8sjrqv6sHa
	 NEkrrNrDG5Zh9+8z0Ts627+FrQsWnbLGgdePr2mzN/v8RbwKNNhy+RWT5da+otxqbUrOQ
	 xLile6W4rmczQlBEjC5YfcnCI8DYs6Y9u6YDYEHCdZy6gvMIPfO+4watlca2xrXDkaPo/
	 JOuukycRDztIBnOv4hYVZ2n7dMs8MP+l240dMG93rw8hPo7fJ/19BYETW5hwkx8vYuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=chw8LHvkOCiuA9Bl9ETjtRb0/vjR44eNojF89t5j3yU=;
	b=UiTEg1I+MmPgeL9WiYb+O9ekhQWvi8AqgbkS26Yo11YlO66mMpJBP36LCky2qo9BouCU
	 qXcyQ49hH717bezdVZCrak0Q3gpN3+1ICe1zn7LJ+F+hZf+ODiI07t+8eANYi6LVIavOI
	 Zb1qfmb8gKwOJSQkr016rkFlhSRbW5oUKBim0WqQyNuUMV6kYKtbp68CHo9iy9v74tUle
	 7WTVEIBUxPqSLE9BkDMoch1twahStU2WtVMkQLTnbkWlo06p37LqTN724kEIaDAWRZ/ku
	 mtOGH2iLoPkkS1rOfNPFJVUo1fb43eo5DoAY3PT1C96zP/86fIR6wksr2KTe9r/MzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aimjW8L4;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC30606A319
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 21:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC30606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=aimjW8L4
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a9a1ed66b9so737551fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792531572; x=1793136372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chw8LHvkOCiuA9Bl9ETjtRb0/vjR44eNojF89t5j3yU=;
        b=aimjW8L4jeTfMl1aSrkNLRlXU44379zu8gzefuAT/lCoJIbAanyBzv54sn6J35LOMX
         j+CCXS4Js2f2Zkc9b+pqpzXNCpgbcI1JIG/6RDmjY2epEFpRPR/MqbQ9sDshrMQAhsT1
         UKXv208yraLySCJdobDYd3jhQXAcm9iGp+ZSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792531572; x=1793136372;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=chw8LHvkOCiuA9Bl9ETjtRb0/vjR44eNojF89t5j3yU=;
        b=vymh3B9DxLhLoSGktm12geuqATc3FvCCC8rkS3JuSYmmmDGkfYPOJ32gFTPUNInkYJ
         cAQ1f3D5s8bC42sjD9U5ii5ZvS9dfhXDTpR7ogGCtnKKT3YDnI0lOWVJion8Ijz5Eb2r
         5EtptjTVVZuLxhwvIkLPe/GPb6OiEFWCb7YSpKziqeO6bUlmag08H6le9IlwSS7DtvNC
         14FcxmgSQ5g3c1yiJzwboIIfu8Ld5GDuK4uva4V2AkAZWinlIoTeekcJyBYgJwBz9yz2
         48f6XaBXt+z6POUGGCqhwUb0IrYoO3Jq0fTJL5QXdNV1gla3kgInUABRCWlVS7Te2il0
         QJfA==
X-Forwarded-Encrypted: i=1; AKwUvBxrmDAkCkvSTjKYGl940yt8RG+zRmxV2jSnOHwmhD/E2Ln8cyS5CahAOwdW+WYlrLOIQHazHmDbThzac7ec@vger.kernel.org
X-Gm-Message-State: AFq9FYLM+Ytgs1fYdy+hpmMGZeV14FLxxfto3PiW+aIsgxk+gik+LnVX
	4V6E6CmPt+fZyjjJNS+vWBozWKrMMjyYECkqScBC8qbMt7sDi7NYLFIoUNgVemwr8Lhuu13VZNw
	4tiu6bbZFMA==
X-Gm-Gg: AYBFou2kNEPqKiMesYJ7tQodQrrnwvTZzB8orw73QKflqDWrj77f5b9gOQ8fbZW/TCO
	o3KFda7ILg8L1VrkJHHu0SmBDEZ3vL88lekkajt8BTBgBC1IPnDEvFB48njMqcxyjJ07e8VvImY
	8HKYQocPpxV7TJgl/iPpsZUg1M0ASgqgdlIVY/Hd7iLI80F4rsZVF0nkenvyF+mNSfIk+bReBF6
	mvnnoaiDz1gfWMWiiqd02eqcApDq2clLCpuviwq7b1c5b/9RuA+e8Ll20FiquW4E56hUxxJDTIo
	/duzrT3/wtKekv8rvUBUg8wBxVYTPzqJtLXQdwjnyfx2UCHQdEOeG4pfxpS9Oo8DurFBdLL0L7d
	Wsb5J9jTXuYdKBePYIdvcI0ihGq7ewqSrxMExbzAGDe2Pq1ST/4jheRa21KTVyeQ15Jfllo+Mrw
	Fsqra3hkRDDPoJz3M13RGz+sR05psDr44vpuyK97Zowm2tsNAEfhaXGMPezbpANjqLNGWiJU7Ci
	IM6iQ+j6zM4iV8lUZcu1aFuGM1mQWFQGUfOaPbQrB6p9OPi
X-Received: by 2002:a05:651c:b0a:b0:3a3:2a41:e329 with SMTP id 38308e7fff4ca-3ac44146233mr1186061fa.9.1792531572000;
        Tue, 20 Oct 2026 14:26:12 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac438165acsm1306921fa.39.2026.10.20.14.26.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 14:26:10 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bccecba199so63287e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 14:26:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwaheqPz/FsLBs0DQehCODFzxAkdoxhJ+17lNLuYl0i5pRP4x6Ie5O9VT4xXLfCE6WuNtyOa3JpdrOV2elO@vger.kernel.org
X-Received: by 2002:a17:906:99ca:b0:c3e:cb50:b7c8 with SMTP id
 a640c23a62f3a-c467959382dmr29830166b.12.1792531216713; Tue, 20 Oct 2026
 14:20:16 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019154913.1765974-1-kas@kernel.org> <20261019154913.1765974-14-kas@kernel.org>
In-Reply-To: <20261019154913.1765974-14-kas@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Oct 2026 11:20:00 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjJpuLXt5BHieXV1qBE-uoWDXKugcfGgR+DiVGVZQ8RvA@mail.gmail.com>
X-Gm-Features: AclHuK9tJ1qytK1OXr-yTM9eIoQeaSqd6mgYmdK2yrKkOU8FofcfrEV39uaS5Ds
Message-ID: <CAHk-=wjJpuLXt5BHieXV1qBE-uoWDXKugcfGgR+DiVGVZQ8RvA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/18] mm/filemap: store the end of a read in f_ra
 only when it changes
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R . Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Harry Yoo <harry@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Ilya Gladyshev <ilya.gladyshev@linux.dev>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 05:50, Kiryl Shutsemau (Meta) <kas@kernel.org> wrote:
>
> filemap_read() writes the end of every read to file->f_ra.prev_pos.
> Threads that read through one open file all write that cache line, on
> every read.  The value often stays the same, as for reads that start at
> the same offset each time.

This seems silly. That "often stays the same" is only true for the
pointless benchmark, no?

I don't think it's ever true in any real load.

            Linus
