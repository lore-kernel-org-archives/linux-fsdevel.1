Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C9353A75
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727810; cv=none; b=Tta/1rhh/Xj62sqsrN/LzzXDVnM0wqxlWSLpcXYATiLyojQd4L8+dIw0LthIpZQKyAzdjb0dTMZ5VLwojgdtIg4Z8jdMzr6FNaybMgJO+0EPG1roRcj6xZnHcal9eZq14rlQQNlCMsOyF15EDrFY2jcBO3YI7YPQxKZBFi2yLSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727810; c=relaxed/simple;
	bh=PYGMpBdbfrddSWhi8wSkhjZKYMi0cam4nIYPZarnXJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/mt91xJ6RKKcn2jcHSbzD8D4uszSWI7/4jDFK5V/mvpSJKbIYXd/fimCJbgPq1yXRdxcaLy7gRPzurmldBjQS+PyyiMT9JBlqjma2DkOW+bsrcLaH5L86nq8O1eLZTLH/KMtvB1oSaPHKg0uszu2GC6dXakF+sSp57RRLQ/W7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QG1gO5uC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QG1gO5uC"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c2a449c57so125983251cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 06:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1784727807; x=1785332607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqGzltcyJPxwfdEhPSjMSETzXly+gOy2t1lReGVE8tY=;
        b=QG1gO5uCmzfckS/4hrc8GaGFjBboFkrunoc3JyezIFVZDpSfgRfasKH01+RjgBtnW7
         oNviLvafLrI+ny8eRATwbyYk8NPOzuWTnrVKeCqOjPgPr5ijUDKHTORpByWhRIJooYlL
         Xwp3Cla/WAYyuwmkhBcwzLaRLmP8eTSeUEDEgRHqcn8hSeJ/2/aXsmMnakunQbWq8sgM
         5WgEbzekaktHb9KZqu4HrgyPmbSPconuKte38ex1GDbA+5zx/Gl4DKgVwM61MEJcZzXi
         SnaijE/jQgrTohKRpeo7PkHDeeCIREbeou4mPGxOwj5JtWYd1bKRCfwW96yEkcEEsHHF
         w/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784727807; x=1785332607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqGzltcyJPxwfdEhPSjMSETzXly+gOy2t1lReGVE8tY=;
        b=U4ReVohcIcil7N/4xlJC/AnK2fCczmpSOl7Sj5c3SDX9q5E+0pahHarHNIGh8E0WSQ
         sVh7MdwqflsQQh9UZEURu6rA6tPWWvmA3GtTFbbkEZf+wlm3xXX+LEk34sn12cz7mj/g
         Zg0XOesdf9Ze07tm1zJJZzJMyX8u4WezAvxiJpL/V0QvULGnEayT2PG/7qv4Jby0PFXn
         LnRmcMIq/gbZj4MwDETgjsCHCxbi1HciRW4fej21u75zxhDBTEYeN+VqhR8udv5x8kD6
         5LrkXo29QkEuzy4Y4sldSDkTV04jqCRn96OQaThKHjIyPV/xg2qdguX6i87gI+vHlxzn
         JsBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0EwsYLwEdDBYPWqo3OVtLjIO1POJcRrJYcBUYGHMjrIpBY6WjILItbekgl8gN5cWYfdwj6ZGz5UwPeKes@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlVYJ1hE6zhwsnaa4nOvjBe2NxpcIPJXN2SFs88+Rkrtef6jT
	gaJenX/CTwigttm+EwHthl/cXr5Artk75A3OZqreGyf6bbtTqW+OC/0zookGmmnkRNI=
X-Gm-Gg: AR+sD10OfoTomn9UUD2E6PpXQADTVJ7hQV6Njci752NRB9A7RCLCfy3QqOQ2iIp3sip
	eUYyJlSISn7fUd/RkODY0RJOQYeVkvCraUXRdTKPHjQFcMEfc4yhFZxkaIfpAhz1CB08kfAc+9t
	AgUong4ujiCOi5NF7vut7tkQkgI1hsMZjda3uHT+uDsOYqIHjJSBzrvhhm+VAIfcdKYlLlRtcZ9
	xHvBUxmEiNRk7vVPMLD0sB+RzmULw1cDiylMCnnwVO4nPxO7QmqAe9WyJQVPQQz29kjMCq/XiLn
	fqaFCcGCI0Y+dWtDSYOcL1FAb+nWALcQ7DhzxlL6dRSVgCAadvNuBsV794LRf0dL0Ci0WRCB8M3
	2FWaHA2JgO66fpRVJJjE8Kr3RuVezXCccWmdoAaHNKfhMzFeQ6puKeGDSSXK+5CwA3wCXRRPOse
	n4LWHbjefk2OWmYgYT9qKgD5MGLixcL12LpzjtarVBgzt26AUlqGjI1mEx9GQg3KxcMl9e
X-Received: by 2002:a05:622a:1f91:b0:516:e152:7a59 with SMTP id d75a77b69052e-5213e08256bmr218014961cf.42.1784727806950;
        Wed, 22 Jul 2026 06:43:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3b3f66dsm15332181cf.27.2026.07.22.06.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:43:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 09:43:21 -0400
From: Gregory Price <gourry@gourry.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com, 
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com, 
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com, 
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org, vishal.l.verma@intel.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, osandov@osandov.com, 
	jannh@google.com, pfalcato@suse.de, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com, 
	linux@rasmusvillemoes.dk, longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org, 
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com, 
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev, usama.arif@linux.dev, 
	xu.xin16@zte.com.cn, chengming.zhou@linux.dev, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, damon@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 32/36] mm/khugepaged: base private node collapse
 eligiblity on actor/cap bits
Message-ID: <amDIuZSsOPjRkywY@gourry-fedora-PF4VCD3F>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-33-gourry@gourry.net>
 <amDEEnTv0QumcDJn@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDEEnTv0QumcDJn@MWDK4CY14F>

On Wed, Jul 22, 2026 at 09:24:37PM +0800, Richard Cheng wrote:
> On Mon, Jul 20, 2026 at 03:34:26PM +0800, Gregory Price wrote:
> >  
> >  		page = vm_normal_page(vma, addr, pteval);
> > -		if (unlikely(!page) || unlikely(page_is_private_managed(page))) {
> > +		if (unlikely(!page) ||
> > +		    unlikely(!page_allows_collapse(page, cc->is_khugepaged))) {
> 
> I think collapse_scan_file() need something like folio_allows_collapse() check as well.
> 

I believe you are correct, sashiko up some stuff here too.

Thanks!
~Gregory
