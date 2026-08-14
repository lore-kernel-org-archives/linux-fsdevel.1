Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675E470123
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714041; cv=none; b=jR4teC8qR/VLAh5EpBfxjKKlLfMrc1/Mn93b+fdkkqX2lttKb0GyfoSf8z0kBLt39SkuMrGyRQAW1sIElCFpk6zsGLdaH1BTeni8U7HtsjJHnMMASp9BiVFmqoBEDbDgNJLW5TEd0wu9uwZNkGJShdIjiQ2Q8s1nFNUUyp/YnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714041; c=relaxed/simple;
	bh=CChEzwWKHqvAbDe82pqB+EpRVBOCxUp7FVLoHlKhGNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NADRigT+W+M3LHH8DGBhtfNoEpujtdOdAp7sXRX8QwT67RNOWP30yOQTilZTzDQTAbinc9X6ltiienfR157uDWwiB1dZLLZ9p70IaHmiQLC5TCFan+88Z80yEoDlKg3VHcZfJr7TZzsauqBiy4P5gPm7/h5cuGFBHe+zozPsA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TCpeiH/x; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TCpeiH/x"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66c70d3abc7so1316050d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786714037; x=1787318837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=TCpeiH/xCWeDcYJotQrUKR+96UF0MG/Njhh1rbUlHRGBrpdQAImKs6oRWI41Q8Eczj
         +mTDkleatlsNeXhOUaGWaFyd3U50OBJvlvu77XCYcYzSq7ARn4Or8iIhiP8w6JBZAK8W
         oAd1trrpj6Ef0CklV1H2zSfBzIviHXmk2sB71HcaujcqJrFDI2zHP23dmMR4YDojp+3v
         GBSdAv+vPbaIHQHbjNZQzTtWNO8h2nh2HWBKxy6PVDPoHfw/brhOp2p2xqx48wXcX9eT
         697sKEtDAhvD4AyqB7mtbV3UuRSbV7yerIPuq30uagL3Wo2jyOy2OULMcp8X/mprik3I
         2+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714037; x=1787318837;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n4ArN/eG59F6/a+Z1l3n9inh5iDgTQHyg71JvETU2wM=;
        b=FDNpmhP7wOhlK0SJhePDbQI3COWQ7Wu8Hd/pXCe+fcO6hRSlo2z6NRuhNUH+fVl48u
         4M0nYKG4SS1ZH4QDvBxoO1akoAAhI/0BWmHcBrIsodxVt8vjxcc+P07554Yta103qVog
         DAiPOvz6w0Y/p8mVUiP22mW4JN/M50m7p9c3EJLRzyPezhwrBaAnnzAaqLC4iChGQYSa
         UveoVe++e5ZusjeC1aoy4zwkTH51Cg33OfsUqGmTrQeSfRL60arI76oPvFfXMC6i3xf+
         9/zIgxoMllhNYpbgv4wPc430P7LWXhhVnDvki5qoi85XgvzLvRzFrc3jQ9z3kY6Oh4yj
         I8OA==
X-Forwarded-Encrypted: i=1; AHgh+RrCfPLSj+XHQr5nC5zdDzz+qJJGw9FZYsAkmD2fy9w4J+eSPwlmAf4pD5wAJiLsSzJfbOFw9oUaodZdmysz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOI/esWIsBV1UV/iUmClrjcWTvk6gV0M0B41+JVhgwLGieA6Ah
	4ByJBwMjsaptwY1tzOTUqnrupX6nJfyDbZTqmam5v8dNMKTeM+Nv5Oq9Tf40yenrtUI=
X-Gm-Gg: AR+sD12KCH2fFk3D7Bjkv0E3qY8QSEbYHbonWqEF5oQHZfMTWFKk65+CXMC2fEM2peU
	SHNfofRVJzosKy/ENTEhmouTRtU/QgO4DEwhwJPaPYF+0Xu9oBckW9Cfu6U1nn4X+8pGOU8cO2a
	2DjkO1ag2kqdjjbZy3SVX5RXMXGwz3qMLn7A9m30Eh5RioFtO9tkU0rShA0J/zW3eQMJV4hXaNF
	UKwNwIVkPm6D6UdBPPIgzjkzu3FeJ3pBLymV1YT4pW7Wy5Q4/Mb6n63QcGEuwrI9r/k7fbPUXD+
	OEEc1xismtXCujLd0i8+24sLeLKvjP3fjqzDj+ZadsdXSQ3l8jVk9ycsmkLVgirmsPho5RWg4Dk
	MgabQBcQo4gw0QpeoEfkJk5UkQITmCdk5UTzQBpfnulFBxbxVhxDutueTTML7FSPGnhr+hnSguy
	SOmxbdkUMn371wA/i3pEXTP32056diYFQgqhY=
X-Received: by 2002:a53:c584:0:b0:66a:3662:409f with SMTP id 956f58d0204a3-66c72ba0d10mr1917799d50.10.1786714036424;
        Fri, 14 Aug 2026 06:27:16 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c75c9d90bsm1010793d50.8.2026.08.14.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:27:15 -0700 (PDT)
Date: Fri, 14 Aug 2026 09:27:09 -0400
From: Gregory Price <gourry@gourry.net>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	"Gupta, Pankaj" <pankaj.gupta@amd.com>, vishal.l.verma@intel.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	osandov@osandov.com, jannh@google.com, pfalcato@suse.de,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com,
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 00/36] Private Memory NUMA Nodes
Message-ID: <an8Xrb5Phmvs0xE4@fedora>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <CAM9Jb+jpJ-Ui4qDHxsp2WiERiv8gmrQfKQ8Z0BmabefeQ6pg4A@mail.gmail.com>
 <an0cAMh_m8ZhGIm2@fedora>
 <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+jmxPdL-CdWQHYMT5G=qmjB6z2WFg+4K8Fod5n=2N6YCQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 10:55:13AM +0200, Pankaj Gupta wrote:
> >
> > A device driver could very well just call memory-hotplug directly,
> > or its memory could be brought up as a private node via a boot
> > paremeter (which I have sculpted for v7).  The former is preferred,
> > but there's a bit of a chicken/egg scenario for bootstrapping.
> 
> I find this interesting as this appears to be evolving towards a vendor
> agnostic framework for hotplugging memory directly to private nodes.
> 

Agnostic would depend on a common standard for such devices.  Otherwise,
there is still a need for per-device drivers - but hopefully the
interaction itself can be generalized.

> How you see this working? In particular, How would the kernel know which
> memory ranges correspond to HBM or other device memory?
> 

Device marks the region reserved at boot, driver hotplugs.

or

Device marks the region normal, but boot param sets the node private.

> Please also CC me when you post v7: pankaj.gupta@amd.com
>

Sure

~Gregory
