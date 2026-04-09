Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3079336EA9A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718373; cv=none; b=QszAdgmMhr4AsTHMKEvfR5W6/D1efwvwveCtnJGYjmMV8KZhLmtZUnxYMQKpkidZpoEsMlvggiYXiVfjiZHgxkkM4xenD7jZutZC1RP1jXbfz4dgQpMNNBJI0SEWRvIJ9VusJtc74nSSnwpDlMAc4a5bUEAdfT+FzeZEy1QHKHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718373; c=relaxed/simple;
	bh=3Hkdtw7FlI3jNXz2BuJOtXHmOmcNXiHzke+A2dwg2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX1/KO0Ew1JY1JFmraa6qvaQu8RpMGOU6s3jk9caCnuEoJXkNpS9LBiOAWGIUc22ps+yMHU3C2bWvaju9VE5BU0dIHugVfw4QOb1zz76h7bGYF7tFFU7lR2h+nn05FFeU+/C3Syyr9uyb3RBgXag9RGgmKJx41DxTKJcvw3zy1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sb/NcT3P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sb/NcT3P"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so249613f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 00:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775718370; x=1776323170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dy5EeN9qSfn22BVboyr8Wmy0B7KXY6Q4JMGadQ6/5IE=;
        b=Sb/NcT3PKFIUjQptvJ1Hk2mbsH6daprkSw9pqe0WoNJlbjI6wr1s7AA9D+51kROXte
         QQrJmwbMNpEU+QLxvC1RNC7D3HSxSJzI8NLejvwsBdxwSt5djXlYF6PCg1hv/M7QK0Oq
         CG4YAwgJo2tie+CkyLxAVFgLRThzs7JwhYN42FTLEyw8GPT6sFj3IVBUggCKUXJhxYva
         qWUQ6UsQYFgWwEJiwU8jQRmWcX4rApwCc1anrMhGwzgUE+IE6V1auB/yw2Oaf9Kp7BfH
         zxFOBjQH0VyiMdssaqr4+Pe9WAI27S13N1tGv7FLdv6wcixgqS6LwZd2zYkK2WdldwNd
         yYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775718370; x=1776323170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dy5EeN9qSfn22BVboyr8Wmy0B7KXY6Q4JMGadQ6/5IE=;
        b=NLlfepEhoF2N+4AiTkj/biod5xalwdnNS1sC31B9UQLwaH++ltIoIE+TUkN7NWaVi/
         sIGwy7QgVoutdn4jRTgTxpLxSnuQxbldZjCzUh+q1e/eR/Tikxdkm09UiAIotLeGQwqR
         jwhI7+Z+Xx3vXI5L/ulF79PZsj2ZevQxATQ4vbWFmPjKM39esbrXil2SOrhRg6tE61p/
         SNFxoKAQ1N3P115uml9jnMnvhdcAnSIBECT5OqP9DHoC1Z5KwkaMGNxL0fSzqK01AhLu
         PoBeOHYqiD7giCCwunaldCyJtCKbPE5GDq6/VNqVBRBA0hAG+JPHApUZTW17kUTs46op
         lu/g==
X-Forwarded-Encrypted: i=1; AJvYcCUTTfaS6c6x4uSVKYEV4N7Eg8S32kGNG6pGJtmeIjiYPkfNNzV9RgoL1wC/pu4FAd3ObwtMaSUTV91M0B8V@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+Nt07L1mNp1e3CkrJBJj+i9u18jPK4BWqErQKvSVa5CGm9PH
	0+eB2AWdWQXydkSfUh3CA4zsW8Rc/2Jv9gHzn7/a0aiuWigxbkjPgNnufCZ4hctV/ms=
X-Gm-Gg: AeBDiev4Xys5KlSPBaemFVSgLLng2v6+PsLtiSDdFHfA6ERU8ne+gLNkXw3t8JwCc41
	4GxTcoeHGhBZFHLsaPI6WJhRCVQtJgUM70QAyZQtSmTMdQXBT+wL/ahQUE2r2hABftQVfD1FUQk
	kMCT6wd2BowGMSYu10MzuK/gmrwUU89GFOIwx2+E8LLqCfOK+BHLpzO3Z+3/Nnwm6qiWYK/wDW/
	DCzeMveGKq3Qk7m2X5YbaXSWwAPfv4I4ZqKpqDlu9p8bt+ucX5wckvoJNjTUgGQ+N27KXgDbf1h
	fgWiWrV+isiQ0AOWINYCmbIhp/blvljmTXrU6tektuxtWjgh6KA5e+rKN8HOefJX7ARcZvHXOkn
	Et7HDt4Pr17deI+5PmP2k90ibsCQ+7vlEWDk2nbY0HBMBqIYBMNx0ZNrwxZSB8X3nCkgJkmzwBw
	KT3AdI76xicQLgLL/jRXfzt4JVfg/eKAwgYQ==
X-Received: by 2002:a05:6000:2282:b0:43d:6e0:9458 with SMTP id ffacd0b85a97d-43d292e2734mr34408893f8f.39.1775718370368;
        Thu, 09 Apr 2026 00:06:10 -0700 (PDT)
Received: from localhost (109-81-92-28.rct.o2.cz. [109.81.92.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d282esm64612996f8f.18.2026.04.09.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 00:06:09 -0700 (PDT)
Date: Thu, 9 Apr 2026 09:06:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] fs: drop_caches: introduce per-node drop_caches
 interface
Message-ID: <addP4MKmA8zfSN1o@tiehlicka>
References: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409063503.3475420-1-wangkefeng.wang@huawei.com>

On Thu 09-04-26 14:35:03, Kefeng Wang wrote:
> Add a sysfs interface at /sys/devices/system/node/nodeX/drop_caches
> to allow dropping caches on a specific NUMA node.
> 
> The existing global drop_caches mechanism (/proc/sys/vm/drop_caches)
> operates across all NUMA nodes indiscriminately, causing,
> - Unnecessary eviction of hot cache on some nodes
> - Performance degradation for applications with NUMA affinity
> - Long times spent on large systems with lots of memory
> 
> By exposing a per-node interface, admistrator can,
> - Target specific nodes experiencing memory pressure
> - Preserve cache on unaffected nodes
> - Perform reclamation with finer granularity

Quite honestly drop_caches is not the best interface to build any new
functionality on top of. It has backfired a lot in the past and we have
tried to make it extra clear that this should be used for debugging
purposes only. Extending it further sounds like a bad step.

> One use cases is hot-pluggable NUMA nodes, during hot-remove, simply
> dropping pagecache is far more efficient than migrating large amounts
> of pages to other nodes, which also eliminating the risk of accessing
> potentially faulty memory.

Does the per-node reclaim interface can help with this by
any means?

-- 
Michal Hocko
SUSE Labs
