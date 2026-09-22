Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5F38757B
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790090552; cv=none; b=hcaQQn69AoX12Alcn39u1JNJR7SolB0YZHS/6zUU4jnUgkYVcRB8oezOmDWgkyN9O+FmKQwmGKRVnuxDMKkxVM7htEwiY/ycRvAH1crRus+OAo9fZCmbEcL6Ke7uwnL4hbab6ujBYSH/qNSo0qEQ91mdKFixGMFySjOsrC7lGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790090552; c=relaxed/simple;
	bh=tGcXrBtsOi9ErAV0pqEKLxwBX3gqpMOXxrG6oKEh2Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3jqs1eTdoUho4xnoK6jDd9Ir7IwLpC4oalZNYitp0l1nRQ1ewsRdpmCMpZQPxNeYfuoQHJZ4ZDiW5zO+bWfvwJVfqoTXzbgnaVI6c982o3Uwxa4anOwa1Tqq8jwWA0yF7A7sG+DncwoOOMg8wJBU1wZf2ekIv7ihtzEBo3hD+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=K9t96BAp; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="K9t96BAp"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe207so3376d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790090549; x=1790695349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+asX9Eo6V++D4JgVVikE/NaNyUA8WkaRzRJh4cn4hpM=;
        b=K9t96BApnERLu6oHY1opqgFks85DvplnkenLF5koaXhyNVundptE1XhSo1sO+tSPUL
         pv35TZxs4L96Hk5fL+43xi7lsLjSPTnwgcvcaYXY1UjDSyE/06T2EEpXlPmZzuOMMe34
         B9n5Y8OLV+b/lG2MEtBNUHH/+NYmBHpqYeci8KPv03qJ+xD+oQeC2RdlY8X0xCpjFbUL
         dcSnh+HXiKD+/+wm9Ti0Gv7CpvC8VR9TqIR6p5p1chPkDMmZxbPZE3ysO+T6ZYTTHaff
         97XPFaCpfrKZkyZILQysQFtJjglxi3Fk5eU7FqGMuQiQWdJmS74UOyvfctc8QhfoLgln
         0DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790090549; x=1790695349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+asX9Eo6V++D4JgVVikE/NaNyUA8WkaRzRJh4cn4hpM=;
        b=MRl+odXr8nsQLmAQDXBLz4mxtTUP8MeY8a6sHP1GPMhuHv/VKTx3WDfUmmJuEkIq0c
         fhwbWL0NfVxkIrbp+yk/wotIsuxq8T4qIu+e0wSxo61N+zwufkFlzm0hKGIU5n+BWFEK
         PK2eAfnUIk362fkT8x2Lqd9pL/Sy4Mnly+E1z5EJ44QgRPbc0ASEsP/ubYjXy3Q2cYSF
         aoNZRF75QSjt5FySgugczpwk16v57Ec+nMva6/kva/kYVqvutHaQ+w00001yQK7/w6Pu
         TpnMWbrG9GjSMHyumjoCh8rMkrP5BhHm8B27EjmLgmq89rzWUSkofhqkeM23WeoRm371
         RYaA==
X-Forwarded-Encrypted: i=1; AKwUvBynvJ9a9Vx3rClJGIBbLTlT4T+gcBXDgauXBGMcIDymb1w81O4WW+2WP2YWZJi8HWeHsAcaO0FHGVUDMCf0@vger.kernel.org
X-Gm-Message-State: AFuF++l0tFyYSieNS6eRL9tc2U2fgQthVg3E5HzFdyisTkwZLvra7DN8
	I6lT+CtuXBL/gOjZDeoT2rqJCW9OokkATLrg+8z28X/0/Ws56GrxVv7Z2dqwNeXEDzU=
X-Gm-Gg: AYBFou0wqneNohPaq6PcV4BKKjhUiMlTeBi6e3d3BLoxfZWYTMgCKj6jf+f6GCf3C2o
	jQJHLAVLFh5+aPGXnGS7QTqH5+AWCm6Z9+jQttBo1otY7rs7LRqeSulAvw8G0ypT8Ohw0v/N8YR
	54ATvOtN2RIDCsmHvvtU4ha3rHnBx/qnVxtHPkoLnnhE3p4SpjKjgHNaVs+sTgPA6IuMtDHW/1V
	6no8u8+qwd7jK9toBiI9aYh1VTOeomsSy0bqqCmM+svCg385aa/On2Zqo9V0p5I3ARbK8IuiKnH
	jWZXsTt7XM881WZNs1LISZf3m9AWG9cMFhiKIk4TQLvgA/aWC6qHhguK/96H9+wbdFrOXAKNu6Y
	Yr0iSYtilJIN+M81kB1JVIoUdGTtRT2VXjrOUBJBGgn225ZSgYLnvUDKNGhhIhkyyxtSVPMFonM
	nuB0oHh40hQKJ9oJJGkEUEtp7wEGIJzhJklr1PB0qMH3DZABCi8utRBLUlj+c1ACrQnVuxaYyHr
	2xMhME8AtAjjjLEUoI2otNQTbZUVib3LoKaZFkG5C4ppGknjoTqzIQK9BK7alCtSQ==
X-Received: by 2002:a05:6214:8501:10b0:913:ffb2:e8da with SMTP id 6a1803df08f44-913ffb2eda8mr33729806d6.36.1790090549126;
        Tue, 22 Sep 2026 08:22:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140250d233sm18031886d6.41.2026.09.22.08.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:22:28 -0700 (PDT)
Date: Tue, 22 Sep 2026 11:22:26 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, 
	willy@infradead.org, jack@suse.cz, liam@infradead.org, david@kernel.org, 
	vbabka@kernel.org, jannh@google.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, baoquan.he@linux.dev, baohua@kernel.org, 
	youngjun.park@lge.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, yosry@kernel.org, chengming.zhou@linux.dev, kunwu.chan@gmail.com, 
	tz2294@columbia.edu, hch@lst.de, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback
 completion
Message-ID: <arKdGMrUixIb4spc@gourry-fedora-PF4VCD3F>
References: <20260921152449.629486-1-alex@ghiti.fr>
 <arJYmwKnEu-djZlK@gremlin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arJYmwKnEu-djZlK@gremlin>

On Tue, Sep 22, 2026 at 11:44:20AM +0100, Lorenzo Stoakes (ARM) wrote:
> > @@ -554,10 +567,12 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  			folio_set_workingset(folio);
> >  		if (pageout) {
> >  			if (folio_isolate_lru(folio)) {
> > -				if (folio_test_unevictable(folio))
> > +				if (folio_test_unevictable(folio)) {
> >  					folio_putback_lru(folio);
> > -				else
> > +				} else {
> > +					madvise_mark_dropbehind(folio);
> >  					list_add(&folio->lru, &folio_list);
> > +				}
> >  			}
> 
> This existing code is utterly horrible can we maybe do some refactoring before
> adding yet more functionality here?
> 
> I feel like the 'pay down technical debt first' take I had in THP is pretty
> valid here also.
> 
> But also, yeah you DEFINITELY need to separate out patches here.
> 

I will post my refactor today, sorry for the delay.

