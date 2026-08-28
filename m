Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8643E3EB118
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907457; cv=none; b=e6lp3N9I5MSPm0leMpQ5h3A8/+0ngaYqCo2VJnPdIZ//3rkcXmHzB1nyyAf3InPBYAFBqkicsddxukYeKlsxrGcT5Fe0ntzK2WIossWl8Lj9eoXFOm6yXQ2f+nDSGMnq0bzC/zTpLtyB7bBMkd/8N6IDupfHv1kHWa3yqj36pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907457; c=relaxed/simple;
	bh=7+eJz+npcWbhXvT8pye6HlMH63Esl3yFHBxUe6wWGw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ICuNO3qr2bjGXHU8Z0S2NOT/SF/2DXs5LM2AevXhYKGA3foJVPlrXCHmBV9X+HqAHHXg+dQMhdCUBkgJMtlk8x+lNTkmCnNVghXQxxPrhSMSgn5EhO0awQsUkhdQcGwt44xjZ21BEhxacd9p5fD7VJb9dpdRbOIIYRNHq/piBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBVWFWsT; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBVWFWsT"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66e3d262d43so242790d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787907452; x=1788512252; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRHnAqVdyLXqgRdMi4x9m/HrY0C+uMDxYAPAdjQk/dM=;
        b=lBVWFWsTnavzQYv12fsSjuDL+NQnXz0AOq7OijkR+IkgQ+L0WenTjGZQPLtJ2SyrjJ
         o3I4JaQzCOsZ6/0C6j9YRbGKr7ZYkuWyqUrROAKjBD0cr7dA4To2kUZUyAMLXqUoWkMN
         12Sud2qisxJqCoWzT8uJck8wB3YjektKF28j+0dLIDwExKkLjuxdYQfcCI5vzuuFZGUC
         Fwhd4zX3OG43tPe0iaYWjRllOWw5XoiKdMOtV3hJXY7becFdr6kYKktgYP9K0vVOiTOU
         C4jv7byOOLiQ1kqrX/DrTS8V6ZSLPRcorsDNol3e+GtDfaW1ekVVZWL2GukjZ/34sDvU
         A8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907452; x=1788512252;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRHnAqVdyLXqgRdMi4x9m/HrY0C+uMDxYAPAdjQk/dM=;
        b=l9lpDdYrnPVRajsnyzh00nZsUc1aLkV+zOrzdAH+GTa8m7S1p/D87MGgAOaEjIqkIy
         sOdccS3P+O83cAnuy1UqIIxZENXLljcRJMEWSUoy2AVtgW6tklXiPDmfxtHUaLWSG7OJ
         qZgm/r3uOtfjgHbrOfMWq6NYbjfAu2vwCkOh0VmJH2Oz/luxUdvugGM/7J4p0wkJSfE5
         v50u394nORZ5EanBMlfo2e/YRPDSnLbOkuQb3GlNeVhLH/iUmUFhS6lIzFQnr4EgYNws
         490dweCnZve38/OfCaQIxOmwWTL2IyhBSv1j+vHebM1v50+tFdWLM88cKvYRf4fIx6v7
         EAkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAktI7wPmTKFbliz3Ek/wMGZ07yobOp123NPfDd9vvNkboKaOlXRIfjAQBAhMJL0acQXH444zKdu0moU/a@vger.kernel.org
X-Gm-Message-State: AFuF++nAymWTncIiiE3Pq19uxtsq4k6GWvYR2LBDCZYCBxCbzTFpeb6Q
	52tPQ9TIS2CwTNmwKro8hkrPwWKd2zg05T1ZW+USPn0fg2rMLozdNreCzWQUMSxU5w==
X-Gm-Gg: AR+sD12YcEdPnWQcXpMrdCMgn6UlxugwKBk1e0eyyK6/cdBl6hxDsOHaaGZTXj9w1Ta
	nP9Pzn4S0J4uA2BFVEWZ4luPSIdh4c0PrRD6CaeL1/FSTPY7FvNPER2UoFukwbXuA7wANLpusOv
	ndy6kgv6V2xCoaUbwxTK39KeNr3AS0vZBmdMHI0w52so8ar+/8uP6daV96yZ2X2BmlWCFoDM7Ck
	A6s+rFMFU1hAt91Ppk40NNeUTH4GD9+wpuiQZYpnfFZw2AB0/8nXmVrNRWSjS2TaedDDNATN5/L
	DKAaHXQq8toNvvdsBwYyWuRk+2Z3mOar8Nzh6IzxKIoxabrbf8IR0U9AhTybtlt3pmfHYgGN6il
	LVbgCdR4RNGNBCy8o+odNDiMTs7ASSFtLbulSWekofXp0Sa/w0caQhRfKPlOaJYQeTtZlmHaB1c
	ddrFgAWI+EYXS5WrvJwTnKY+Gt7bhv+B5XCAP7Mj3NU9/aByvANXeA6U8Vx6LXDoc0l18miLuyb
	U6PgbExELm4SrkmzDS2oo6bpb9rSdazPM+5V1TtQyq/NKLW
X-Received: by 2002:a53:cb90:0:b0:66c:c8f1:7623 with SMTP id 956f58d0204a3-66e4c6ce6bbmr1380164d50.27.1787907451455;
        Fri, 28 Aug 2026 01:57:31 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm3672297b3.17.2026.08.28.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:57:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:57:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
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
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260827145502.2fb4505b@p-imbrenda>
Message-ID: <cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda> <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com> <20260827145502.2fb4505b@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, Claudio Imbrenda wrote:
> On Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
...
> > 
> > I most certanly don't know s390 or that code well enough to guarantee
> > you that no stray references to mapped folios can remain there. What I
> > can guarantee is that no references, of the kind which lru_add_drain_all()
> > used to be needed to remove, can exist there: so there will no longer
> > be any point in s390 (or others) calling it for that reason, to help
> > split_folio() to succeed.
> 
> we are not using it to help split_folio() succeed (although that's a
> pleasant side effect). We need it even for small pages, to guarantee
> that no extra reference from LRU is present on the page.

Ah, thanks for explaining, that all makes more sense to me now.
I remember from when working on memfd write sealing years ago, it too
had to be able to account for every page reference before proceeding,
and resorted to lru_add_drain() and lru_add_drain_all() to help -
those now removed in 14/25 of this series.

...
> > If Barry's relaxation goes in before my drainage changes, then
> > there is value in that s390 lru_add_drain_all() in the interim.
> 
> hmmm so, should it stay for now, then?

The s390 lru_add_drain_all() should go whenever the rest of this
series goes in. It's not essential for the callers to be removed
immediately, no correctness requirement; but nicer if we can get
rid of most of them. I'm hoping this patch can just go in along
with the rest via the mm tree - and I'm sure you can trust David
Hildenbrand to understand and protect s390's interests.

> 
> also: I'm working on completely reworking how the transition from
> non-secure to secure is handled, with the explicit goal of getting rid
> of that kludge we are currently using. That will also get rid of the
> lru drain. But it will take some time (I hope to have something by the
> end of the year)

Good luck!
Hugh
