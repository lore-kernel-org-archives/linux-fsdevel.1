Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C344607D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633609; cv=none; b=oWmM/4cgs46DhXPDgjeCoXFe+UoKXUoljDY51uhKRIhtblnAi7JIyCdRBAJ+CbPPRe/0ghBT71BRll1Zv/+4xz42N4o3M+3sirxOZ/OgcqeCWuiQQD5NBzikd2FvFmAcoKFPn/S8fldmYQqxIqIf5VPEDTGXHqEc6zL45dLeCbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633609; c=relaxed/simple;
	bh=sHvRopr1Ypm5jQAY0ZfOEkqr7Mdr23aY+FHbuYWUkwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR5hkN3ebBTBnXziqLEfjrGZe1xpvbWAvNdjT2WmDSoLS5OBQkM9lrXqikSYI8cyffSqLIViOCRXGyVoaqPCvTK0muzlUNt/CPIkplQsSpwNcU7hTN0bqk9eHdwrCkElL3/oRUSE+9PBP71UDm3KFd0PMUd6qGGhX84kkj1s20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=DlyjcD8Z; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="DlyjcD8Z"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92f0b5ed131so710217385a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 04:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784633600; x=1785238400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ClK9kZgJgn1pv+f64kpoxUD+b6fg3ben0ahgbGiQz4=;
        b=DlyjcD8ZL09b+nDrY5TZLF1ThL5qWPyutaobOJ5+PMg3QgRzJixvWA/EU6T9LcZ6Xz
         QpfQ80DUEbgeqnE5YPwYFaHue/zNz4/TOXFFF0ow5HrduslcFLOXZS76axde6qvZPUCr
         85APb0Vos/GxXAAKHqCJibKhx+FdEycZZ+wY1wBSJ4D41cE11oL4Fn5bqOTBQ0XO3o/8
         TU2MejV2d/jr6R44d0nYn7mnSHpby1K4H4g4qnuik38vC1Ac2u+qXAn4q9T1rI4Gohm7
         W4XIyc9BnJYv721zgLD+33OiwGOaOQZ6BvfiQBbSmqBpZsKmAME2kTqS06pIFePrZS4l
         nVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784633600; x=1785238400;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ClK9kZgJgn1pv+f64kpoxUD+b6fg3ben0ahgbGiQz4=;
        b=EtPVZ00g7SZi00yk6w5RnsGMj799P6Q94+uGg3WjbgI5RAKAq3mSwdk4cNsfeIO7s6
         SnOmfPDd601Ydpv99z9SpKDviBzotJf9n+nADpHKfHnzBwI+gvkLc9h3fQX/lZQOZpyW
         hkVYuR/STLcba3L1fr0r5x8MDccL+xJ4y+L/oHgCPHXfWDjorjeBJt1JH+GgorrmTq5g
         nfFkyZTlGrH02ENEz1rXjLETiyUjnE9qNr7G1yvMw63z/YPP0caj664BNI4w+IEiwQPg
         qsKI0WEDSDd5s8puRsqMLQozoIgdgyLHcob8dli54g8YLxVyoVgUq1CgRa6j5wKsrnjO
         /yiw==
X-Forwarded-Encrypted: i=1; AHgh+RozWaUMX2s74mgrUex4bgtIhXS5k1cNMLSebxP6a8AJyuB9Z+avRcKIGg48DVA/radkx5uEM6lhCtKTF2lJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1iQt8trQI08inAilGGWw5nIbHy+qQ5NBktZeIFBJOfo9g2u3
	M7wRwTYMPvdxFRBK4WK5mmkDzBYemQNYKdiMc82QQ0JGJwTewwOcHJR4BtIAWsGR2cU=
X-Gm-Gg: AfdE7cl4hbX+tO/Fw0OlFIx77DoMx+/V7QkyafHb2Z9/0oO1xRCINEQnj0DPWUbJPoX
	hs0sBzD2K60lqKM5mIEJVjVgcvB6CfioVSC6cs3wL/mxlEfBo47KOvTZXWmkGg6YpQsd/eKuNSo
	pNUrKeORcblylCG718kZ4Qtmf8D9SHxT0k3BjtxfPBG/JtnkqFF9J0crHSsTLhecc2rfGGl6zJ0
	lohSQGofWolbjQoAbFQ6wbNlzHNDb4nEUDnZAINBFHMMO1De/vEuWtQv3/LJaZKOwbtxMhEVqA0
	g5GdtNn7vRbdaOEbq6tbYJruCP0se0VouaLZZNyJI+LMipP4SJalRStb+XqGnTuBHWazwO1hST4
	gc4UFdoV2LR5D5b5MP4KTSeI2taO5b1b+lo724e5BAd6chNm7jYdFh27IPhcVoLb7R4854CYA4z
	lK
X-Received: by 2002:a05:620a:3709:b0:92e:45e4:c6e with SMTP id af79cd13be357-930b3f37283mr1768481785a.22.1784633600331;
        Tue, 21 Jul 2026 04:33:20 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b545e253sm1074421785a.36.2026.07.21.04.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 04:33:19 -0700 (PDT)
Date: Tue, 21 Jul 2026 07:33:18 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Yosry Ahmed <yosry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: zswap: free synchronous-IO writeback folios
 directly
Message-ID: <al9Y_tZH5AzDkK5K@cmpxchg.org>
References: <20260718093723.153324-1-alex@ghiti.fr>
 <20260718093723.153324-2-alex@ghiti.fr>
 <CAKEwX=Nn0dMc1K9drXFVMwt7wMZ2P6KToeh7T3rE1+Xq5yrCFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=Nn0dMc1K9drXFVMwt7wMZ2P6KToeh7T3rE1+Xq5yrCFw@mail.gmail.com>

On Mon, Jul 20, 2026 at 08:56:32AM -0700, Nhat Pham wrote:
> > @@ -972,6 +972,30 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >  /*********************************
> >  * writeback code
> >  **********************************/
> > +static void zswap_writeback_free_folio(struct folio *folio)
> > +{
> > +       folio_lock(folio);
> > +
> > +       /* The folio was allocated off the LRU and nothing re-adds it here. */
> > +       VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
> > +
> > +       /*
> > +        * Gate remove_mapping() on folio_test_swapcache(): a racing swapin may
> > +        * have freed the swap slot (folio_free_swap()) and dropped the folio from
> > +        * the cache, and remove_mapping() must not run on a non-swapcache folio
> > +        * (it would trip __remove_mapping()'s mapping == folio_mapping() check).
> > +        */
> > +       if (folio_test_swapcache(folio) &&
> > +           remove_mapping(swap_address_space(folio->swap), folio))
> 
> Hmm I think you also have to test for writeback and dirty here right?
> 
> After a racing swapin freed the swap slot, the folio might be dirtied
> and swapped out again. We probably shouldn't try to remove_mapping()
> such a folio?

remove_mapping() itself handles dirty state. It fails in that case.
