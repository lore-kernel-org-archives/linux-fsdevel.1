Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805376;
	b=hmMdCFsE9Q5lHipkMTC253m5fUG6yO+pPAsC09fiV/ujPwGfSkGj8eJ0dT3v9STYHMgC
	 0yHZIHOBlbn2MWNHUkzoTLmGFK1yPOoHmt6X8zaJO6v77jvwU/0CN2izVZ6WWxgu5oxU9
	 NZSm+jFco80TO4JI0Kn7901rdFvSMVdGlf4ubfW3uOko+s3Z+3N20A7RseZSh9AGCUoUe
	 i5GAjROxmoELkHDyWEH1+FHnyegWzSxY/JE97u0KXIYKoAUcPEU2q9DUItojPHadgcPg4
	 LvEiHAFyAk0ItDnF2s6nRACmX+KZo4lPTxrGb+O+B46iwzY8j6S6kkUTKuq8l/GL0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805376;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2QP5qMLgCjzR3Vq+1R7yHnSJoapXAZoBlu3K14T4Qag=;
	b=NRXKTVFd+OtNlf+F8hx9EK4dRPTgHanCPdtA0AZuMt2AAb0AHxOf2VfCAwdTbmMWNNwe
	 ZivU8KNOP/HFbYjLqY6Mn1BeemhhNkO+2UE97ICGAEmIvT0Zu6ZYfzqqDOIGhC7UB9ofN
	 FN49u5BUWH35LdUIuBFA/1USJewan+op563TGaccxXBBFkL5kVJfugu3rqoxLf86OT88I
	 z8u2gffcVuNHS5nucNrf+78vZdB+vhJ5SMbb64iTQThRI9FEWF77pHTpl8FFaCMRDTPeg
	 9JTyBHNo2py+2mLbNeDC5jCw5GPHauP57lj1HOgExOtXJPaiMji4EvwfBSHWCSwrocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwrHw1Lp;
	arc=none smtp.remote-ip=91.218.175.247
Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207F9606D81B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 15:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 207F9606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NwrHw1Lp
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Y5MODlRDl3QiqtxOx5uVZzRjMa3zrlbQrFa1R/TJtnc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793805368; v=1; x=1794410168;
 b=NwrHw1LpmsBIwswo5wKeYjRD/cJXqjYbwgfklMVriQ9oURLjlDTfl/zLggxdnvTYym/OnKq1
 0ax6B6z/14WfVvEc4TcGopfGKXxJiVbo00QdorFvXj0s8F/6G2IoPSpEn0xuxlFtmrdc2kI90p5
 JXzmGZYYZB9EOGWk8F536pXA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b99bb3eec717c0ce;
	Wed, 04 Nov 2026 15:16:07 +0000
X-Mizu-Trace-ID: b99bb3eec717c0ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb136360-bbeb-41e2-9dc3-96d783e6dc81@linux.dev>
Date: Wed, 4 Nov 2026 23:15:36 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 43/47] mm/huge_memory: split huge PUDs when adjusting
 VMA boundaries
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, usama.anjum@arm.com
References: <20261031-fixes_core-v3-43-d6437171ecc3@kernel.org>
 <20261104031245.9524-1-lance.yang@linux.dev>
 <45508a75-7549-40e2-a71a-807a824ea026@kernel.org>
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <45508a75-7549-40e2-a71a-807a824ea026@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/11/4 17:11, David Hildenbrand (Arm) wrote:
> 
> Thanks for the review! Please do keep reviewing, but note that more trailers
> (including this one) will likely not make it upstream as I am about to prepare
> the PR to get most of these things here upstream.

All good, no big deal :D

Cheers, Lance
