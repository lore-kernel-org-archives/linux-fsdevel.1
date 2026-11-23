Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426829;
	b=5l1HGq6nP41LWgEy91JzFr+jebeBgiMEtmng6YoShWUFO8cxB7ZGHwhBrlp8dHau9sT/
	 tp6b2Ys2ER1BdWRyEXsCIulbhZ6bLEbFWUI07vQgOHHxnRmGeCd3QutAWqbAfsBfWKk1U
	 8z3I+i3y4E9taSOS8omr25JPtiIwSC659dFdankZr1w5xAKnDWVdPhJoloTHBLHdt4R6C
	 hU6mQjT5Si19q2DQxQB/ncgZAOBu5EBq7MAeSYjgXtmI7/vi6ygde4rhPm6bFD2ImjQ18
	 YzBcTMUGQ2Qo++rTYXLVvegK6XGB21nJi0WkvMpCVjLGc/aZFMTUxKbBl7sc3k1ANvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
	b=xhwqd/AsWVpVIjZrPf1jlCWmSGL6t3ntzCJNcLxFA7QdURb6K0ReKBmlcNj4e31DPIza
	 4dHEzyf6scIq6k9kA94y/xLTUnyjDIJEf9i0CZqGNWxbwkgmRKdoNbP46CBzAE9159ud2
	 Y3dkoL0nqZj/VVii2N34g3UHOCwLlGovOGj87OAavpVfr9lqyDh1FQXngsKJ6Q6dXTQL8
	 4QW1UfnPqllUvvJ8HZo9Sq06TpdJIbocMYYdosoQseMP12y4Ylgy5oflfAyqAlxWjlh0n
	 Ve0ruvpMcJBqOawWOlL0KxNoQQIuc5HMcFcfrslSJQcI0vwFXDoiOhz3UhfLcrueUrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="piDKX/x+";
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46968606A31F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 09:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46968606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=piDKX/x+
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67be9601f31so2492823d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795426827; x=1796031627; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
        b=piDKX/x+zSivG1JjCcMp0ylCzOK+uPgZfR8gWTDeVcnNbIjSW62b/6eBaPu+cMWWqt
         gZVrswxtbdBy9IVRKyGYvemM5nO7zzKrmbzjA9JouMA1+M0NsPR+0XbUbi5dRiBqU2Si
         hlt7jGC3ecvkfqTYPMEwNrHg9CUkTwgyjT2w/dbrDhsw9uzRYFaQ0tvFlOLMvULjofzH
         DWM5Fefly3gSdV+nraMLUYri7Yp/iCBXjiLvL40fOJs1qIvY05MSya4nAKjcGzSBDd/T
         QSG7C5S9MfDpIDJy1XVCxaUnN4bh3JOqlZuJ1582NshQshH+AFkpy86jJG6nrOGKyaWL
         6z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426827; x=1796031627;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=thx09sK5axuy1Mqno0O+zJDzS2jXR+z5TmxbMTktwk0=;
        b=0oNJAbSXkipVGz8qC0BF4QAFYA2T7Uk8rDT/sOBJXN0/mkE30+mmACteod60ygDsOo
         tgpu/v/GtRYBvmkif5fKCsVzWSirLkhvVTvxjYg2ABTfa8oDGZfI67UQYmBhzhOkThku
         WutT6pk+n8qJs9Boc7q6CQidsDviJNTraZAailEIR2/BIHqNq9B1mA7TCCoYsivnyGmZ
         hADPjAazbk1SrtUgPWw5E8vKUGxtTfGQkBZh9B5YekMuP+R0L/jEhCkJGQVtylyNLT6a
         DoqpMp3I5cDM0JR9df5/5LeiwYanNQP+XR8EiHZE+UM8xJAZcwJ/PmnFz2r7MShZlGrX
         SR0Q==
X-Forwarded-Encrypted: i=1; AL+hErHTX4rYUBdBwt40vE5ycnWElxcFeaJ8gfYwNj4DjPEr022gh8BdYH3qME2csYqoL4slvXcUjep/4TGbC7iq@vger.kernel.org
X-Gm-Message-State: APuU4Z8/vYltYLnYeaaaj7Udm0TpUZnnCAofCXWV9NURmLG4mQKSfdlH
	Kb0pRs5Y2AeNz2Keo8WwUOD42CUTkcwqE5fb2i2QoSiIrvURuS3TChJfXOAH0jzGYw==
X-Gm-Gg: AZFdTZeIGzXc85e1rUMssnWR27q6v7kuxOmmoC4lGnSLTayMzNX3snq6jPYDyt365p7
	jEs8d0ieu4IzgqOa/VNNa3XGOg6KcseHGopxtwHSsG+T37lmoysjl6qGjtZXmMzxW8NbV43F7jP
	YHyNySSQC6en8q2ZF9rnedEEwK6KEZ2OWM4IibfWsyj50UmD2RiVU6MZvtb9PehU0IzaeS6Kxux
	Y83Ffdc+CSAGlnAg7axDZ/5cyK6OF6iQJRRcgSZjR3/74jnLsxJbaULbyOKIRx8LICZ6YM8h6km
	cMNG3N4w9A02OBJVv4KjRdzU1StVJg672c6m8xCBcN2mmLllFmqi+L+nf99Z8msdflCrQkJp2nz
	qL1QQCVW9u1YGBw9WjruCRV5IcwTCbxg2DXnaw+wi3M3pUgY4DhscFo5KXytombY3S6cLiZYJhx
	4X0/tmhyXF28UhVAe5HRo7e3y4cqfXAnYJkbtCoWWFUAXr4wH+pK+4wOgLCvTl84cb/DptSPiYG
	H5ABefMJMj8Wk4bHRHapfaP0XgQhPcg/QBAUKND+MXtgqaL5tPVp6QWOBYh07NKFzGc/wjhuFNR
	fbC27fB+9+2chZiPXQgjbvlqO+0nO9Hp6GsUlHOc0ZVmWFX6FRQioF3lJEVd/OE3EATqUeFqhw0
	i1F3IpwcNFt8xuP6YWmQbLvCg
X-Received: by 2002:a05:690e:bc2:b0:67c:70cf:c90e with SMTP id 956f58d0204a3-67df443b020mr3503639d50.39.1795426826585;
        Mon, 23 Nov 2026 01:40:26 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33105fesm5150875d50.7.2026.11.23.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:40:25 -0800 (PST)
Date: Mon, 23 Nov 2026 01:40:09 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Alen Karnil <alen.karnil@ideasonboard.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
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
Subject: Re: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
In-Reply-To: <179492383658.1554713.9260140415931487684.b4-review@b4>
Message-ID: <db50635f-5f02-73a2-83b3-8ec7dc980b56@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <179492383658.1554713.9260140415931487684.b4-review@b4>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 17 Nov 2026, Alen Karnil wrote:
> On Wed, 09 Sep 2026 02:39:08 -0700, Hugh Dickins <hughd@google.com> wrote:
> > mm/fbatch: drain lru_add_drain() and _all()
> > 
> > [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
> > 
> > This series was prompted by lru_add_drain_all() appearing in watchdog
> > backtraces: not to blame, but blocked on an unresponsive CPU to run
> > its workqueue. lru_add_drain_all() is a heavyweight operation, which
> > we often hope to avoid by a much lighter lru_add_drain(); but even
> > those local drains can aggravate the lruvec lock contention which
> > per-cpu fbatches are intended to ease.
> > 
> > [...]
> 
> Tested-by: Alen Karnil <alen.karnil@ideasonboard.com>

Thank you, Alen, that's very encouraging and helpful - though I think
it would be too presumptuous of me to add your Tested-by tag to each
of the 26: I'll just add your Reviewed-bys to 01 and 02, thanks.

You may be wondering what became of the series: it's good, and I did
rebase it to 7.4-rc2, folding in JP Kobryn's fine improvement (thank you)
to __page_cache_release(), and Kiryl's !folio_test_unevictable() safety
in lru_add_del_folio().

But found there was already a conflict in folio_batch_move_lru() in
mm/core.git, which would make several of the rc2-based patches not
directly applicable there; then saw David's "MM: Firefighting mode"
mail, which confirmed what was becoming apparent, that it would be
more helpful not to repost the lru_add_drain() series this cycle,
but rather attempt to review the current fixing activity (I've tried,
but just cannot keep up with all that David, Lorenzo and others have
been achieving).

I intend to post again around 7.5-rc1 or -rc2: I'm probably naive
to hope that the fixing frenzy will be less by then, but I'd better
go ahead with a repost then, whatever the situation.

Hugh
