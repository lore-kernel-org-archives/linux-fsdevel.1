Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB131716A
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208766; cv=none; b=SC8u00GPbpO5u5RJ6UJaegvVn5701KklV7TBdVl0TceVF1Me09R++I2NBCbjoTEPHL4+jP7TxIH9M7OgD4YQPDjuplOMURmJDGs5cT6GDQizqjcmbTytYDuWu1jJTBH2SMt0eVHBVA08hmLHTnw1cBCGVZydTgUd1PsbUPYo1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208766; c=relaxed/simple;
	bh=5tuHRWT0CLBIJ4zZVHWsRg/dbgwcFG4nTUPisJljfos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAa2XUxm5MpTG1uaKjdSAKVNKs6GTbTwIeJwqPG+gjlhz4kBZZIXn0kQWmL0FG0MyCe5v6Llf33Apa/E93t/zLrW3NJhoEbJmF2N8N8QqFpIg9TRme833tXNp/+VuxOYsPb27n5toPI8vhoZBPYXPodX9NptlB7ZYY2UFx6/fVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SIPGtjQB; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SIPGtjQB"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9061a795d76so34965106d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785208764; x=1785813564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gc3BaOWtNJ3jTzSBfuxoRtvMLkn1PeCp89CN3dg9r1c=;
        b=SIPGtjQBM8oTbqZmrsIOyq/WCjV+056Jafh815n6R5rfzavJnOrVq4nC5K6bKbKOz6
         uaceBwToYXuXZxvm3zsj2wSpwdPv+0v+LyDgbPlbBrQkaIVtM4gbZ4It40f5aWLjzjzJ
         MC2vTGMVrsHZ0CLoocSkWWqlaBkZcP3LATsgXn2za+m6btz/et8W/F6is3XQ/TOBhL8h
         UEQQkU40xWA/qdaX+pMRLusk2Q7ToYhtc3HCr04EtTKSnUXBdE23PafzDvLYOLQhAYUG
         QedE2rB32aRg05q/S6jk9ER01GVzDE3ZceXFGi4riR+UzTANxgKvCJTbve03ZGtsOzWa
         o2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208764; x=1785813564;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gc3BaOWtNJ3jTzSBfuxoRtvMLkn1PeCp89CN3dg9r1c=;
        b=TytVmQq2FwbAxg6QGbuU+KIAgOpLMd8gkTQ2i1tI7ZDQe9LFL2qIIPWet5NBatNSZs
         QQjkzFFUxpWNx3rWUzbmhcWM9YQCJ/nUFj8Xztcj1Ogm/a0CHsjtP0++WFUqfS/eYqyH
         y2xtyQ0lHgsxQLtOiFP9qnVyIWjL+SsFbEnP84s7uXFK7BGZKUfuyfd9Q2B9D3+wu0O0
         2Fiv+bHEpEq0y42/O2Oevd/AlzIRghExAtW87zRGgWjwN2ONFDW19p32BsGgOb35NZGL
         GBASt3KuOMa6hinGw2FBHGXb+cKoEfqH7KpZw7Ju8Qxd4pGqxqqooJXTQBOfooM3L1l/
         7p2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp4Hq7Q9MCqln+drtqCZHZKThsNZsm8DPMGkziYpoTX55cvaM9z2Vbkc6vRi5MACmlqzNW9sN8aLSMoJSYh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzv+VTU63YEn5excQzlSq/kpPAHRmun1FJRacZOv0LhdqkANeU
	meRW7gQerB+CnJXk3hgwAsafi0K96NZ/BRGnH79N+5GXPxereIep1TvYdl2JhFzRr612nTa/8TI
	BOEx+
X-Gm-Gg: AR+sD118LYkH0KTTxm4V5jmG/AzRCerLVvSM444HkchPup0h7SNqynKf/4ys3ZazfSi
	ymvyiwVOYyXWPapUx7HQotJGjg+MONKQixSy9r48VHHQFbqx3bO2EEhkz8mGH28PdyGwIKMjk/W
	X91nGzjVJoHvx2T3qDSSjxY29j9F3Yviqye2OYwA96h/lqwPJVN5+7mRZL28aIdT/qQIg2RgYA9
	a1enZoiwFV0HOs65r6CYQ+4GzM+8lH3kLbOJkjGGpjTYvkWUtif9dLl3lZzJgF6dAFWFtR7YVlT
	apHyyZiLG85s/mWdQowByvHJYcSrNdMxgZjKbLjBuL04oi2pZcsxf40RCLlJPShMLbVpBkus6Pg
	jwAn7b41SuAss0T8gxEdoW+40+W/EvnT0BNtjiR+pfYUFdGEAallJDjHGi/zsQdcRr3ltMF4yLz
	BMZAAItOazcQOiNvC4J7I8ePC13FwD6NpO7gYzEF30alzDne7ZrXB+eQEVGg==
X-Received: by 2002:a05:6214:1c4c:b0:8ee:88fc:e0ba with SMTP id 6a1803df08f44-908170b5f04mr6466126d6.6.1785208764168;
        Mon, 27 Jul 2026 20:19:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e86d7207sm81369626d6.34.2026.07.27.20.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:19:23 -0700 (PDT)
Date: Mon, 27 Jul 2026 23:19:18 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v6 10/12] hugetlb: Set mapping folio order
Message-ID: <amgfohLFK_05UP7l@gourry-fedora-PF4VCD3F>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-11-willy@infradead.org>

On Mon, Jul 27, 2026 at 07:13:06PM +0100, Matthew Wilcox (Oracle) wrote:
> hugetlbfs currently uses an fs-specific way to determine the size of
> the folios in its page cache.  Thanks to the support of block sizes
> larger than page sizes, we now support this as part of the page cache.
> It's somewhat more efficient as we have this information directly in the
> mapping rather than going from inode->i_sb->s_fs_info.  We can convert
> the rest of the hugetlb code to use this at our leisure; this is needed
> now so that we can use filemap_get_pages() unmodified.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
