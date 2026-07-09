Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD14D9900
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618345; cv=none; b=AgcRgvRNJk/3VierjvfH5EQlbAKONuCgbn9s4ocIa8MbgKPzDTkek3LEZpob34XIK4RlaeR9vQ9RBnKiaRF1ALXwyjAfnyPwmK45sFWdsUj7EzPvzEbgMsXwux6lXWoS+jduJh5HZLcdfEqp1Q+ek5rqjTkaTNfdIyc9d8tRE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618345; c=relaxed/simple;
	bh=OJblW/zJ/WS9mfpHNcYitjgBnj1lEOBcfj7Gnv08iwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIGjyY1wrlx3VdEb3Jjd5iKv+7SoShYyMQxEIXOD8vbYN0lO3dR0JL1YRA7wIo65Vyef9iHSLbki14w5cSaC17Wmj4L0S1XF0AfTEy5ZW0fCbHCjreojPu7R1XhZU0fzib1+4B7ygmIt20ne1x58+MgSlD0tFGu45JdkE7zki/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XWfSiQti; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XWfSiQti"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e50a650a0so1447385a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783618342; x=1784223142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+iygNm+vh0afSLVE9tfBUkC6Dh/o/QFksTzffYOLwxY=;
        b=XWfSiQtiSAfSqHfwyc3/MQdxI8wukJnQj0m7m9GRj7sht7lEes0ETejdEQk9LSlUgN
         RC2PKWeVZpmKOTeZ8T6UrLkUlYs3VWDGvdAHNMDEQn2o4fbEPoSuvHt18jjSuyZ0l4oX
         QEzQ7qJQcQbCz/tL4OTCtFhxp+f3LyEBcyX9jrP3pDXFQ0Ks8idk501NgekjshYylMtC
         1Lktl/1Zf3jE0qW4o6fpdakaGrWKubDZJoNZNXCtL4dHxQHQEog24l26y7N4dNIXHpPB
         AsTa/LyUfpoMR/hj42ZNhddzDnu7zFEWqHzI4aqbDgv8BTOa9z1PIVeXNAT9RKmXn6fA
         evRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783618343; x=1784223143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iygNm+vh0afSLVE9tfBUkC6Dh/o/QFksTzffYOLwxY=;
        b=VZsj1l2AlHaodsgpXPI7L+pFlsAoycK0pXmRkKfDXPjzD61scC0ITdqsHXRC97URvn
         scfGaCLueJjjrWVy1i9Dd0bPcn6CTGj42UGZp8SD4RNOxAwKTJivqJlZ+Lzs09+jqijM
         2oLpbYz8NGcrnKBpWTxFIZeeANkyAA9zaKAbdQkdWb1iry9yHLwBm1lKnc+iUcPaVNyv
         A9T7fFikWmJ7IeaSXCY4xtbPydsNdeBN2/xWyb8M5pC74zwm4x9KCax0h1oXAMk8uW5B
         DEID/iZrbvctHQdgGYhOUs9Xzl4tN85wKfAiVoXmXokTG/abuaE20GuzHUvOV/3rYUfl
         IsbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqTUmqBOgiO3gmZju49CwBKaBa0uHGOEy7XUQxAlTSGBSXxsAG76DLVMqmtzGCEwbb9UToHiQyVK8yT3rYt@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA1xbd/dzYpmut7xJWBy3+qilDhrglnMOgMO9zJKEBwkzX6jt
	g3WqQGxh0/CMfDzooHvos8+Y4nqpn8nDGT2B0BlxDnSOalP1nVWfmsgXojCQqVoVwCHEeiEJyXc
	Zce0/
X-Gm-Gg: AfdE7cn5voOY0wfbeh3X/ApQ3EernB2rMLMULGPphzUIuSVYhNjTKXC/9valG4wUcNj
	+rqNhE0pnXyyBZYLGrv4F1VEneDsHP+5DkWKEYUTUfmqX1uwdOSmHaTQg63KQl0xD1WljaHDuig
	WejA7gStNXcs8NHBaphEFpmV2yyS30N1slcJ+bYFzbnIDz93QiZS13qE2XFbnTEqmZ/qMt9x+7S
	B1BoliDIUwB2MeKcHROgAKmLfDNwODgQN7C5x7ytRsM5hFzCPgKjt6CLaFbSm031lChER1eGxP9
	Mv8ppOkh1OeAT4pFUOlmFaytAeKaPjbsba34XE0YMn2V7GX0lO07Tqw+5WmUay+2GGsf6xV+WCS
	Z4qurOj480sDpExDJSUA7+uLcZB4UiHedgMRKdxKeMO/ger4KcCIqzmBcFX6CcOYryr0xqCvGbu
	DQ4AJTVvzma2a505uyibv5hQhvkXumEpmyJR2t9f/0MHXe+DiZBxe9gcMbz589MqvBF9X6
X-Received: by 2002:a05:620a:890b:b0:92e:7c3e:26fe with SMTP id af79cd13be357-92ecf67b0f3mr805067985a.64.1783618342643;
        Thu, 09 Jul 2026 10:32:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1705974285a.20.2026.07.09.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 10:32:22 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:32:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	apopple@nvidia.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 0/2] mm: don't apply task mempolicy to unmovable kernel
 allocations
Message-ID: <ak_bIlYWJsEWx1P1@gourry-fedora-PF4VCD3F>
References: <20260701222112.2820098-1-gourry@gourry.net>
 <87echco1w6.fsf@DESKTOP-5N7EMDA>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87echco1w6.fsf@DESKTOP-5N7EMDA>

On Thu, Jul 09, 2026 at 07:09:29PM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > The unmovable unaccounted kernel allocations stop following the
> > task policy and place node-local. With no policy set, both place
> > node-local as before.
> 
> Personally, I think this should be the right thing to do theoretically.
> However, you may need to find some practical issues that this resolves.
> 

I don't entirely disagree, but there is at least one scenario where this
is an obvious improvement:

  BIOS-configured CXL memory brought up in ZONE_NORMAL. 

An task interleave policy on such a system will end up with unaccounted
kernel allocations landing on the remote node, which is just not
preferable at all (and uncorrectable).

It's not a complete fix (fallbacks can still occur under pressure), but
it's one piece of the puzzle.


Forward looking:  This patch makes private-node's with ZONE_NORMAL
reliably hot-un-pluggable.  But that improvement is obviously predicated
on work that isn't upstream (yet :] ).

I need to send a v2 of this with SLAB_ACCOUNT fixed up, and some numbers
to justify dropping the pagecache fix.  But I will probably sandbag this
a bit until i finally send out v5 of private nodes.

~Gregory
