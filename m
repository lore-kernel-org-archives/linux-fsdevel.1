Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259114;
	b=x2xMP+DeyzjRQe8gAuRmaIiGRgHa05rBopdExwuba9vIvi1T+c3vohFIOfZcymKR6EpT
	 t1XpTxKgI3fAWGdBzAGvhyRhkA/R2FkeuNtKVgD+x8qgz+/LfMQnZRcsc0+m1TmhhWtKS
	 8lKZTPXf7PsgJMsbL1IcYNAn5XNXf1lq977N11OQgV1OyTacZJ7W0NUaB/osOOEBv/Ue+
	 2tOKD0VcV/URzy86ed8DgfUHdMZI8rmyk7TUjQvx68fhiteXnWjZ1W0Kj5WXlkn07HQZL
	 cmuieANeRnfGoNsZwN09pDVL5NyboVoyYEoRsix0EhkIcv4qy4T2MyKH2WEaNXjznWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259114;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=SjP7vXEfBmu5GFwxYK7lYChg0d8nniaqmFaSK+SgEpk=;
	b=NRyMqUJrql7howEaIL09AmtUPgebw5l0i5Zx/+a/1wh8CrTcteOR0DNETHflGeIXt7Pz
	 rjkdwH4jfTfOQxdfzU4fsUmSQYUK2ORsWfYtt33sO1Hm9hGUjedQ+I2/COq4LY5CiLQ0l
	 Xh6D+l3D53o8kpPl2+jQ8XlNst25mB46toa6dLkt6frNWHjInAdovJh2lJizHZfmLs9Mq
	 ty+o+6JvNoePMa6+ppoMpnDpbz6XWKNegdU10q0GiDC5qaGMKmDxgDMwhfJT6dEaP1g4v
	 c84srnndbWXjfudPHlhWQtHOGMmaHASddHzZDOoqtYZJXwSd3s/5aFyhHj5rKiv5bRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.41
Received: from mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3243606A324
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3243606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DXEk7qFnkBiqsaHKOXTg9XIqQu7fTyhLlV1PlmWC7w4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793259100; v=1; x=1793863900;
 b=Jc8DaRNRuV7sUsRRCf29I0aef6P7zPJYdi3W115kdfpYv4v5EgWorsqy5pjSISuh6odkhk3x
 dXEoSiVXt6tvM2W0GxvQzDOcHJp2eLioFEW60AAkr4mjGrVEvOsK1ZqZ6w/hUSn4lBb6BHufaTe
 iTEoujkDldKZ6aWbKnyx4UKw=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id bb58316c57a2d4df;
	Thu, 29 Oct 2026 07:31:40 +0000
X-Mizu-Trace-ID: bb58316c57a2d4df
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 3/4] mm: add shared read-only vmemmap support for FS-DAX
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261029071206.19059-1-trilith.zheng@gmail.com>
Date: Thu, 29 Oct 2026 15:31:20 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <djbw@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta@amd.com>,
 linux-mm@kvack.org,
 nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Mike Rapoport <rppt@kernel.org>,
 Ira Weiny <iweiny@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Michal Hocko <mhocko@suse.com>,
 Qi Zheng <qi.zheng@linux.dev>
Content-Transfer-Encoding: 7bit
Message-Id: <F2127C8C-BBA5-4AC5-8F12-577346FB7F31@linux.dev>
References: <20260903122128.12264-1-songmuchun@bytedance.com>
 <20260903122128.12264-4-songmuchun@bytedance.com>
 <20261027065723.66564-1-trilith.zheng@gmail.com>
 <4c9741cf-ac62-41d4-9c7a-7d5ceea4a8e1@linux.dev>
 <20261029030511.12004-1-trilith.zheng@gmail.com>
 <2E5C10CF-F3E0-4694-965C-B0E432A1A962@linux.dev>
 <20261029071206.19059-1-trilith.zheng@gmail.com>
To: Yilei Zheng <trilith.zheng@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 15:12, Yilei Zheng <trilith.zheng@gmail.com> wrote:
> 
> I forgot to mention the tool execution case in my last mail. Those
> microVMs start, run a small task, and exit. DAX is there to save
> memory, but the vmemmap is allocated for the whole image. A 2 GiB
> image pays 32 MiB of vmemmap even if a microVM only reads a few MB, so
> for those microVMs the DAX setup can use more memory than the same
> image on virtio-blk. That is also a case this series fixes for us.

Thanks for sharing. I think in this scenario it also saves boot time.
I'm not sure how significant that is, though, since the number of
vmemmap pages isn't large enough to be noticeable.

Thanks.
