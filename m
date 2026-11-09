Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794240276;
	b=SDk6tAvQUNfyBBCOo0iW/4xtz4JU7G6WP94zOpkCFsMYHSbd6G98C//tpgDcPDY5VgfT
	 iEMiYi6e8uEtk3IedNsRTcwl7u6OwRdTlmetzFj/ZxGA17T15M0KaNpgigR/mccUbB/sT
	 hQDyF39gaBOpHgj+DzWbeVI/5j+/kMOd9ry1hlyxQZipiyn0aitSSURhjK7jhH3Pqm5bd
	 EzNRGnVgY9h89YOi5H1S2INgmL5xVCVuZV3LSRghLHxJzJRyPUqpgj8Wi8F7gjez2oEPv
	 31XIZTEYX8rvr3/XMyjVWYiyogoLQyv1F5epI1ulcngRvJ7zSjwDXfGjHVifsfzrygg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794240276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=MUbKECMWpbH5Hktz2WSMdey09BNdQaJCNvxGCw4T8OU=;
	b=Crg3S0h9FtBlXMate+hjgR5MkbzSGV6+kFkI1vfJhjWqirdRpZ7j3pZSaNo0zumIfjQh
	 E8gzdjTU9YZTm967MuP14k040RdZdqucc2Yl342A5Ks6l5Q7f9kDHnRAt4Ehf1uW059Wi
	 e89jKpc98F2hHHzQfqR/JhZdA3Ev0FKOExmcz3eBfBFSbfh52Szsr0Jiqngbkkme8W03r
	 XtY8IV9fBLTncB6mmTXuxfYMy9sNcNiRLFnBLAsCmYfpunKJrnR3BqshVUJxxDk3oxOIm
	 sOHylORncWdEl1BsUa6z4Mwr1Z6gMPjTSLDfoaGzzEu0rn+JoQYKM4U9aM8dJtLKs1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="GIOF/b/+";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CBD606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 16:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4CBD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=GIOF/b/+
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d5cb1b181so140205266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794240273; x=1794845073; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUbKECMWpbH5Hktz2WSMdey09BNdQaJCNvxGCw4T8OU=;
        b=GIOF/b/+F/QwosGTahROEMonZb3g98K4gCltqrruCE0PJC25xJuO3cKnYlXzTe/7eT
         Gmm7j8EmlhmDMqxZ89SoFY9iXMXqY6HCayTjIC2s5l/eIhX8Drh99yuIBf7T/Y18bqVe
         cKXm/HxsJ4jGpvyko0SP4EHw2N2o50jGAJLew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240273; x=1794845073;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MUbKECMWpbH5Hktz2WSMdey09BNdQaJCNvxGCw4T8OU=;
        b=kvdBSJkTUT9OVrJC1yWMvi18MhElx2OIlbxtAXQHyXrD7oWq0lSpnwJJ6cl1iiydb6
         k6xtqZd9x9OOFR83bnr1RAYjhVmXSMTLrYk+ZgXYGtj8Pu7qVRj34/W68tA4CbqSNzrn
         ZnHuEp6tbHzUFA8pqdZ+Qe9hQy888/NtYEVJGzp7VYz39XRpHLBCt8wjeWORUGnAzVKU
         i8QC0eB+YtwpjTa1rS4mChtERa9q0OBFCgBO4grEwQxiE/Sl09PoDAfeqbeyfQD9fk8y
         CSB26cEVyAm9eeJsjlWGHKGK9Odm47nR11O8mHQzjhYYuvAQQgpE8Zkiz9vr78NBDjOl
         rb6A==
X-Forwarded-Encrypted: i=1; AL+hErGQ7XJFkmn6+C+7P8xlfzR+z8WRhZfeCfQWSuPhPRPGMIqoiTDQxSMBGzZCMhcuOXiHxEqHLbtBPKZkTqm4@vger.kernel.org
X-Gm-Message-State: APuU4Z8UqCJF9PA85VRr1Yw3tg56+rYX2u8PZ6aFIixvDacTMzyFkZqC
	2lMqyBMfoHiXMEpWrb8xXzdJW8C+mrRiNZCQt+V5JJAtA8btRLvzcCI0zX/G/Z+ACBdp0TTqrRE
	XkuluDXs=
X-Gm-Gg: AYBFou3okVGbRxvNOPboqyNf5xUg43uZRTtunvgtcn/JLzaT1f+lnzs6yRG+3SCwely
	Awoc9/cqC9x/AxmD3IXqqMJUW0hjyyTVHxyOgD1azFRpV32kmb8Y1Oswk/pP6jGTRVISWKrexSD
	DJ4JnnR0nN2/22TDALn1bPdLiFoczTUn3xh0BP4NQgGupfxt1HWkZsTweTJK6ZduXxjIaX0vEd/
	snjQ5GWCGDydlowwLEO1+HtV+MzMjMo+MiWe86OfbfO9eLjSa1aGrwLQjqGGXTyY3dO1ImE9MMh
	FEtvO2Cm9niztEsnrfMlk8AwcvLQBg4/NijGULii4b3nL4uX9AokfMt/RHlEruFhZSoBW7f8KNZ
	ARwXmwKX1ivSGvxUDCm+S3/JTxlUQ0Rs3Hm6wYvrzDg3DauxEkt3F8q6yaWqIYGVq6Z9lIe9EK9
	fYNpynL8nYfGe4pvzXlcr3wlUFhmwiZ4/oXasScAm4sV/iraEjhkkAZjnje9Npf1uPeVirAQLiV
	dF/meLlicqAe8ZYmoRbYV1REO3E+2lxp4WUdL52edjBzt6qZywHOg/shpfLktLFw19hBaF68ohg
	JgcyX/Vvw0tHwiscANg3AjCSvLXweHNRNcNK/mwdJ3CWEGQAUp8rYGRFNzr06xajhr9JHdTcrHr
	Blw==
X-Received: by 2002:a17:907:d90:b0:c46:74f6:e149 with SMTP id a640c23a62f3a-c4d6d49221amr322220066b.16.1794240273055;
        Mon, 09 Nov 2026 08:04:33 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a4af563sm189818466b.52.2026.11.09.08.04.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 08:04:32 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b596afb4c5so1187879a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2026 08:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEmooUpsTnE00nbfaw1Q+WeXIvwNPcPt2wRNdJoGrV9dMQsc6avLiSmVn1sy9tOxlpf/vPqpvkmqynYMtId@vger.kernel.org
X-Received: by 2002:a17:907:7f93:b0:c4d:18e2:e66c with SMTP id
 a640c23a62f3a-c4d6d4d1cf2mr342046766b.18.1794239795407; Mon, 09 Nov 2026
 07:56:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104130118.2507513-1-kas@kernel.org> <20261104130118.2507513-2-kas@kernel.org>
 <ecad7b3c-7244-425a-9413-04d49f221057@kernel.org> <au2lsbDkyWt-To0C@thinkstation>
 <aa2a1e32-9b1d-4545-b2e0-03d213593023@kernel.org>
In-Reply-To: <aa2a1e32-9b1d-4545-b2e0-03d213593023@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 07:56:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnH5qLJH3Wd3bOxv--Ei6674Jo4iifGD_MqzyJg2Jm4g@mail.gmail.com>
X-Gm-Features: AclHuK_KlZ4s0u4OfgGD3UZtJodv62VcuanWvSl4PYVPZCnpCpWEdwdwFyjepNA
Message-ID: <CAHk-=whnH5qLJH3Wd3bOxv--Ei6674Jo4iifGD_MqzyJg2Jm4g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/18] mm: free PG_rcu_free folios only after an
 RCU grace period
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Harry Yoo <harry@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ilya Gladyshev <ilya.gladyshev@linux.dev>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 06:43, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Can we just rework that code first to have some clear folio freeing path, IOW
> doing this in a folio-specific helper?

I think you're making things worse rather than better.

The whole point was to hook into *one* place: the page freeing.

Trying to make it specific to one special freeing path only makes it
fragile and less obvious, and results in anybody who then uses some
other freeing model to miss the RCU thing.

It also means that suddenly nobody else can use the RCU path for their own uses.

Look at all the kmalloc RCU freeing: it's used all over the place. RCU
has basically taken over the kernel. Every single performance-critical
lock-free area of the kernel wants RCU freeing.

I think trying to corral it into some special case is the last thing
we want to do. It only makes things less potentially useful and more
fragile.

                  Linus
