Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283235;
	b=Ufj5TeFzsRBLaGv0YSfNdsUitlq3L5rMZ1vPGgBLZ4J2Ph/hEdff0L3BzK9Mji1AvvsU
	 7VzUIEVHJuoi6RH82r69eEg1RSGPJtjFC53CPnqOmo7e3yILphjpHh3OLmZvlQiDeHpcm
	 KBGkgUHT+W+x+zXQEFDsu1FON3mz4zDh86tUDEYHC+m3m+DQjnVl86WmGI2LT/P35o/bF
	 V2x4DghpQ5syc5peneT+LHPjI3Y5b7mxlZ9emr68vxP2wY0c3KtBX34uHuvHCjCS6Qgss
	 UWOa8SEQUo3I/S7GwvW9cqJqZa3jbATqNlftyuwqDQF/wI0StzEKhc3vevyeqBOR62g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
	b=hIeS/yKsBjzyOTYFoJ7jzAR/JjHcPqHmZBLvhhW3j3qyso5M1GZQ/+1bVZlSG8V2I5TI
	 prpqn4Id5xVCy9Qm8DvEU1uboqFQT97HdPMr+4RBlZUGCb+seYDPII19u7K8cD87gRbOv
	 NJtNEqzI7KDT3xyBPLZcmMNxu7RxQqMXxD76F/G9Oslow8BjLPZW4bfjwanUpqIhMyMdZ
	 oQZkAjpcPI1T0fhzBrHr7DphDRMs7j53nWMQJlwhqahaysslrgv6H6W/Idp9y9CakHy+L
	 DKI7qJdgeE35jFlmcAzu2W4wu/Z63TzjLnMVWFsh5mV9kzJIiK9oEM8lPs9Gey/BeAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="e5/0LFuu";
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551F606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8551F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e5/0LFuu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso387773766b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793283233; x=1793888033; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=e5/0LFuukNHW7lzYuFosRJh+HCYXR9pyFNiQxvyIIBVipBFBgPFdS4+6o0e/VLtSHP
         D2NV+uWECYwfjgApOljWOGHKCse0y1GozqH0FgOpVe2BGPs5fNsPIa/znV1SPRUcfRzC
         S2HvVwG+whXsWeX2XViUnh1wbiyPOAgZYzqXUt26yduzQ4O2OmGCssgjZkXAmf+1GtpK
         qCiL3bvCUG1uU/sMo60Z4jhr+nRw7l3FkT58U3zkvqVemdPsgtw1581thB5KWAkrpUg5
         ZQXV5QFXWQJRc25kncj0f/n/AZy335nPp8YBto+psFG1ofitw09eWSoKIi34kVGWTlCu
         Ewrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283233; x=1793888033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=qqpOcY1fRjjspyvORBb5EONbk+WqeBo5tktoJ1NuIw2M8LtLX4B4LIVeVf6VMDHXFz
         0Lqghwgc1AdhEEe2Z45Lvrjss79D6+aO4I8cJP7LHYbXZDI4qdPf4DtGvCAOh0ZlOO4/
         YaSlDDwML4DgDTGMrmYfI35MLwj2n5eXvLDl6eAS8Im98b9FFJAHURRb0PSrOclc+b9D
         m3FqCGlCdxWE+5UAYlwAak25Ot6uS7s3MSlGBSJS07695x0D1dhO3fbeLyACZV59xaT/
         4qGAgPC83uwN80zT8xjwKNVKvalkp1gLgHKREA0WOFHlcEdkXsFpmbHw8s8tJ+/jOj/I
         f7Gg==
X-Forwarded-Encrypted: i=1; AKwUvBx0T2R+kRoqdTjgAzcO1gdSKF0NLWpB99upIXo399zdXqC/O+uhZghSnE8CjmHuPnicbrlAYft9IKJ8NemC@vger.kernel.org
X-Gm-Message-State: AFq9FYK0pVdTDGdlxQxUWowuABM7AYllaqKR4TlvbW0fh1QQa/6b74fk
	jbZ7DK2WxntkMJlPtO1upMZxEdRs69GwWObUn6FMLMIDe9Rq1X568BHKnotzAnu+lSQ=
X-Gm-Gg: AYBFou0OunEX6CrCSj2RpZnH47/b49GzdaMxhF1BHjFxtTE4rycVO4hcLoJcHjTH8yO
	11vzrEaZGlGI5WSbUKy/7THeUY4UZdAfEBoXWkiEpAGfwFrXY6QXwm/wdBXVMfzeHLHZUpBz0qK
	eAvliw7w/ZtsPKXiLyFZ+6bRQf95xJnGaa495qEKwnK3EnS9a7XgpYRfiKXeowm9rHXssTLUgc7
	rVuLjCWKMpHwDVob/cFbnSqndW+ujZOpVOPh+Z77LREFr1y/LjZXUeO3A9YkbulDFrEFFf2ssVu
	BeApR7eDfvIyS68cI1XNUlCw55RxrfmcdtCd5yXrfVf1y36O39YoughX7hvRggDGTJu0LvFnaIX
	uXQsNeMD3MMArdQBO5j5ZcN+m3yGKBJsyanV63aG/btRpavUZufWhdczfXMlVss+Ooi5HUKHFLG
	dJML6qTVKZUvifPGa4geYtFXgQmny7W7HeXSssScFqz0Yi42thX8qwvTHIXfoMo+1+PVVrz/B1m
	4yTpOjKgnLhCpV+PdyulLd1ON1M1o1/hGYEaYKmeJfHMB0gcIH59fEclHadEMprN8NMNedpfAWf
	/lslFp/WsW90WMvfoGk=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id a640c23a62f3a-c49be03a73amr545832866b.41.1793283232717;
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm521507866b.60.2026.10.29.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
 <179323853182.453251.8510731747954180380.b4-reply@b4>
 <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
Date: Thu, 29 Oct 2026 07:13:51 -0700
Message-Id: <179328323124.453251.12177231963891458248.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 12:01 +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 02:48, Gregory Price wrote:
> > On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> > 
> > I get that you want to avoid taking both locks while zapping, but
> > wouldn't it be simpler?  I suppose we don't know what kind of
> > regressions might pop up with that though, bah.
> 
> Exactly, that's the spirit of the original code. We would just block a 1GiB
> range of va space for the entire operation.
> 
> If you think there is a more elegant way of doing it (while minimizing holding
> the pmd lock), please shoot :)
> 

Elegant and this code do not appear to be compatible.

Another look, i think this is the preferred route.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
