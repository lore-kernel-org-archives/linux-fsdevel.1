Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7364CCDF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009304; cv=none; b=j0+KAZqwpAXF6aUApNim2UIbLlc5yjVgOuk2KBXgfyUvNuk/jxu2O+ID9FXNRek07EJXTnHqNVKNONeFKCsHxazKJ8kd8AUv2mCQmS89mh9lzLsJtT+/YkAL4e4EOO1m8RwkbHaEuPLN1UrLza+LBcS18B9s+UXT7z+gy+TXy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009304; c=relaxed/simple;
	bh=Y281zkM/Qmo9OSGui1K8yVeXfs0hDkEf9zNmUTSMONA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnf20qFtLB71O1hnMiOVqTg3qE2/B44DSMZAzVCLm/mHKPDRUkxrloUzsnP1yOHhFfnzhcsgP+q0H/rnDNBeYj0bfezi4+quxvnTfIKFkZVapHNZTCWy/UMlENKb9uPMyzkFlmmoLHfRhWwlNWQdMCd+KT9KEPkB69xzxA7SJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=TuEzdBM1; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="TuEzdBM1"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so2715058a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1790009298; x=1790614098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PmR+gFnwjwx9HRJSW244xTdy4CpVHKmXxMQ0vpvGnEg=;
        b=TuEzdBM1RqSjnQfGCo4oUzwJm20gls065kDY/IYkqBJzXpgjEyw1gGVn3pbsKWzIg/
         qGBMKJg7dcMMy2inkFUMCXM7LQI5NrcN/NhItzXo2MtTxz7iBnze0QNDoeOf0HFGhyRP
         LCg8LApIkh+fNqsBBTsWrYTA/KwP/K60N0x5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790009298; x=1790614098;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PmR+gFnwjwx9HRJSW244xTdy4CpVHKmXxMQ0vpvGnEg=;
        b=IX7ogZHbCZtCUD+e0xNW/9qTZlHEcydwhGTFD+a9wV90TtYamfXMfUjg4Z7fWpTJJ0
         VEEIsCF27I8qsLvc+CHHT92h5cCj1fXUSt7mz6HDcxAUwPVb1BCqJUFmvgcWUO9aXO0J
         /jE4Jgk+TU6bC/05ZdTN9QYt6PImRnZWfAqV/3WEd4H8azaDcJtDXJz33VTIABdlNe/k
         yyVUueTS1Xzk8K4X0/NoonUwixq1WjVXTHsGiFS1b+76X9ftG33JfVszkt5j+Pn5pOo9
         +yhRExdtR9/z5UZxqrabT2oRQYpju3ALrtSOtI0W4RjxhP9ISEMXuPb1qJg4bjOg1uUF
         ZHOg==
X-Forwarded-Encrypted: i=1; AKwUvBxhdBAOtMeAjz3/1Oh9jUx9qn/x7oYacONMSEaWMJTt/w7Qc1gpSbFzWPPmEIC684gYfF2p9DE2dvBEPv+D@vger.kernel.org
X-Gm-Message-State: AFuF++m+BjzjowiseSvPCoxBk4HeBs8srLRNzMMDPLMkClNFenc3GOL7
	0xBFMBuju3dXNkxI980lcFQjfsnYv4fIV4OSPiVOeQ5fR3SQi6Q1oSI/Y6DUu9Xcl4vCeGpeVPO
	cdAhepk9NVw==
X-Gm-Gg: AYBFou1Rh9kA1KP9KZjk2eOhAtVglyW3p/AlfVjZCzz+mpJ6SgV0WIG55UxsXizpLWX
	8+mxTyrOHnHz607M91oI74M9JwY3lu9wx71k1xzkjF3e6DHYq+AozfufjSWI/7BvSaIv8NlKifO
	kItlUQg7wUy1MWnQJVqP8hqZ5BKqxyuUdHaua0dJRtL3ZkN6/GOGrWF6o+8DlMYmQMQDD1uFLYN
	ksIFsqqHMys8nNG6k4OaL7YiacNpgnEn6hoDaMxWI7I85HM5lgpPrTzhkSpu3M3GLBWrhafpJlg
	lUW7tNWe3AFQUY3lSZ5UJVJ9NeSG77Fxw2gS9DgaVgNhpp8Hm1CQClpp11JczH5NhwPYgSvq9Ac
	qXTwcw7PpzqlXl4mEVUaNl3LxQxGmx5EvS+21qhJeMktHgRO1E9I20OEiRmz3d2a+ezCeZTIVac
	ub/M8f6d4zBxQ62dl0SAxifRWBr/V/Cn/iY7Q6tztocsCP6PJmNs5Ksaxl9I9POhD9Cg==
X-Received: by 2002:a17:90a:d888:b0:39e:4c7f:8b16 with SMTP id 98e67ed59e1d1-39e54cf8bdbmr17750548a91.27.1790009297592;
        Mon, 21 Sep 2026 09:48:17 -0700 (PDT)
Received: from 1c1aead48890 ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0673209b7sm148455a91.16.2026.09.21.09.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 09:48:16 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:48:10 +0000
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/12] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <vpz5zqg5nwbpolxbkip45vxxdt3lni7j2haal7q42skc3b57tu@uh4cec4x32dq>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>
 <aqK9S1hBpPnujgz9@gremlin>
 <eb5b465b-c256-4454-84de-517aefcd6d59@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb5b465b-c256-4454-84de-517aefcd6d59@kernel.org>

Hi David,

I'm sorry for the delayed response.

On Thu, Sep 10, 2026 at 05:11:36PM +0200, David Hildenbrand (Arm) wrote:
> >> +++ b/scripts/gdb/linux/mm.py
> >> @@ -76,7 +76,7 @@ class x86_page_ops():
> >>              self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
> >>          except:
> >>              self.SECTION_HAS_MEM_MAP = 1 << 0
> >> -            self.SECTION_IS_EARLY = 1 << 3
> >> +            self.SECTION_IS_EARLY = 1 << 2
> > 
> > Seems a bit strage given the code is:
> > 
> >         try:
> >             self.SECTION_HAS_MEM_MAP = 1 << int(gdb.parse_and_eval('SECTION_HAS_MEM_MAP_BIT'))
> >             self.SECTION_IS_EARLY = 1 << int(gdb.parse_and_eval('SECTION_IS_EARLY_BIT'))
> >         except:
> >             self.SECTION_HAS_MEM_MAP = 1 << 0
> >             self.SECTION_IS_EARLY = 1 << 2
> > 
> > Whereas other variables must be available with no try, e.g.:
> > 
> >         self.PAGE_OFFSET = int(gdb.parse_and_eval("page_offset_base"))
> >         self.VMEMMAP_START = int(gdb.parse_and_eval("vmemmap_base"))
> >         self.PHYS_BASE = int(gdb.parse_and_eval("(unsigned long) phys_base"))
> > 
> > etc.
> > 
> > Is there some weirdness with gdb? Or is it maybe because there are some configs
> > without these symbols maybe?
> 
> TBH, I have absolutely no idea and I was asking myself the same thing (but
> decided that I couldn't care less about a python gdb script).
> 
> This code was added in February:
> 
> commit 55f8b4518d14b7436f70defe27faba4eca0cd4e1
> Author: Seongjun Hong <hsj0512@snu.ac.kr>
> Date:   Mon Feb 2 12:42:41 2026 +0900
> 
>     scripts/gdb: implement x86_page_ops in mm.py
> 
>     Implement all member functions of x86_page_ops strictly following the
>     logic of aarch64_page_ops.
> 
>     This includes full support for SPARSEMEM and standard page translation
>     functions.
> 
>     This fixes compatibility with 'lx-' commands on x86_64, preventing
>     AttributeErrors when using lx-pfn_to_page and others.
> 
> @Seongjun, why are these conditional and the others not? Trying to support older
> kernels?

No. TBH I didn't look at the gdb script carefully at that time and just 
wanted to avoid a symbol lookup failure. 

It would be better if we remove the try statement.

Thanks! :)

--
Best regards,
Seongjun Hong
