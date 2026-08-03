Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9BD3B6BF9
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755028; cv=none; b=Sf+DNMRhcY7XcKkE0NpFb4/poIy6HPMzZsK+tpxMYWWcAQvgyctkg764f0dQPO9dSuL15c6UEXUfNW0iI+wjl+cZaZV3VcmIfVn1tB9YVcA/vMgeYDdH6AdP9UZLmUUdSbviYpSSRHvR+Ut3yIrGAQmQdeaYwX1TnPfUna7QaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755028; c=relaxed/simple;
	bh=EcUm1EZpbOH7hDMFYcgFDbbz1hSfyheIni/Kbqi18G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blFkmwOF+lXdzUbfkdBvznFSd7KotKgPJEbE1bzPg9pbM6+nUjsmZcxomb6k3JzOMZbhrGwctw4UIcx2Ud6MIy20aBKS/VSRS7CAE1H0PfDuFq/PWymkRnbv4tWh76bnRz2P+ZhzG0aPtAzQmc5FawcICpdLdEdMqUF/Lt9KOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FsuiiLhk; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FsuiiLhk"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6739FLpQ2108408
	for <linux-fsdevel@vger.kernel.org>; Mon, 3 Aug 2026 07:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1Ldi
	kCzHnIi62dfq8/K9AYncVOh5mbXj++hGhsLbls4=; b=FsuiiLhkIM09zlFAK1ZR
	JVBQqODgbbTmdK7mFuJSxhXTopBvkbrNFB/WpquLaWIsitYZYWCYXiXaXCfDtTT5
	GdrzCPLsWv6MkkNF+diFTM7EQ6q3jHrYEA0waXyQA+2pz0m76GgQ25G09ifvp2YJ
	TK7Z3mOqNsAxOL4Gm4JGj7cTkndGZrsaU+Rr6SST3K3fa/ONGFVF75rtAhEsCE3w
	5Gd1vyctR+V1kpokQCyeQE9iNs/46Ok3e0MT7tHdxbGNunrFuWPXSPeDLPf+sLUp
	q3Cg85erO9ZtUBIb+jMtk4enoDZODaZH7tGUGX1CRUaZACL2E6BH1fyvMKzP5cnr
	mw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ft9m1txxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 07:03:42 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so27468921cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 04:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785755021; x=1786359821;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LdikCzHnIi62dfq8/K9AYncVOh5mbXj++hGhsLbls4=;
        b=RKwZ2NOca1015L5R1FLaUpvuMvxBSeqFzZrKndlNmYCn32YfvfuJdVhz3G6k2IHkEG
         5l/G2pbZmseemI6V/sW9hNl1aBMm6VFVoPPrU09z90IvVKmiQqdS2++Y9uXja5t3jjiA
         kdXXhGYEi4sJi4ttIkRbJHjDpMBHjIuQQTGhb1V2nXzTvLnAzR7A5D/F9I54qXl3o0yv
         tjuhG0jxB7Y6j4CalysA7SIjRlRIWU6XYvd7jOU3bjvSe0t9b+mCfB3dZrBwtbrlmmRf
         3L+yMtdaX2zw04I8doaEZ70C7AeTK5Opo/ww7IZHM1eJL+f70TPpaKf7kphY4pnqTlId
         xjEg==
X-Forwarded-Encrypted: i=1; AHgh+Rqi8ZH92kuA7wEuo2A2Ls5ZC5YLe0AbieTEYZlM6oSwi2ngfzybXNs8VDVDruJt6eLn4ToAOlZopaML4bSZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXpWnLafI/+3j3x0Gic9bjdNwZs67+YxNpoug5J8os8Yypbmb
	b1SU+1ZHSmOdQYCVne91l2Z896DYowcyf/afTNNA/oTub52QY1VhlNaRs9yfw+JaScCNGc2d6tq
	vuBL0ll8BRCSyua/G3nPxkWhgpmKTgbcKf7E2ar84rs/4cO5wI8IKGXoW1UPwLp0=
X-Gm-Gg: AR+sD13auvbeHcVXxSv2zndJQdAnosnimP6tx4TAJkNka6B2FGLLIL37+WjTF4OUBBb
	tQuITdD+IM3NprpBcdHhoX+XbxLKOxBIWNERa65Bs6TNMIxxBxiIr9J0kaJOKjuz72Z6EuUIFwn
	uc4FX6qOlJLcFypkAZnsKWUhac2bzE6d3tZVmRSqU3c4D+uGWJ51p3PziqnNipaPeErl6zCFA4q
	9dzS2dmunxuhriVBYktIBvSC88CDn6dl0B4lbaB+z3e61RUSONZ1WRwLMznnMBL9bLmDrhHmbHA
	HkLnwwnW4pBeadNGl24bKjiQzjqmhX+FB2w0A25kmLy3pZMW3DorHSqaI3dsEnUIFJllOOQmzc8
	/e5ggz8GU6f+QQKkpHN1S38JdJc42RMS5E23LdHClttqE/mSctqPr5acK
X-Received: by 2002:ac8:5fc8:0:b0:51c:1532:ae84 with SMTP id d75a77b69052e-52b5669dca5mr178425411cf.6.1785755021061;
        Mon, 03 Aug 2026 04:03:41 -0700 (PDT)
X-Received: by 2002:ac8:5fc8:0:b0:51c:1532:ae84 with SMTP id d75a77b69052e-52b5669dca5mr178424591cf.6.1785755020521;
        Mon, 03 Aug 2026 04:03:40 -0700 (PDT)
Received: from [10.100.102.30] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41d0064sm30745913f8f.5.2026.08.03.04.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 04:03:39 -0700 (PDT)
Message-ID: <08c19cc8-c28e-4098-b137-fc9721deebbb@columbia.edu>
Date: Mon, 3 Aug 2026 14:03:37 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ceph: remove page_snap_context()
To: Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-4-6c35d6b3ad36@columbia.edu>
 <am_3oyOJAoFeBFTC@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <am_3oyOJAoFeBFTC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5OCBTYWx0ZWRfXxNQaJ6MHgTtb
 getVg7UvgqQAfnv1ItNiXD6fLA7ZN2h6IPR+UDAEQh6EnjX0W6dAXYbwsFH50J3zSkxdwZ9oBVJ
 L51hWWyd2sQOM1hAXAMjqv9W9AuXka1Vv7p2KbqSvE7SxUKjbGDq
X-Proofpoint-ORIG-GUID: dMXcb6WsMox0ui3pRArEoeb5fRzNli_j
X-Proofpoint-GUID: dMXcb6WsMox0ui3pRArEoeb5fRzNli_j
X-Authority-Analysis: v=2.4 cv=FdsHAp+6 c=1 sm=1 tr=0 ts=6a70758e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=tvZamFcuqidHLa0JVA0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5OCBTYWx0ZWRfX8Z9YLE4dDPKV
 an/kzdOsZyp4uZ6yJp3UOznKTxiJ8PdYEE8A4sWwJzV1xWn1JCU8gcBuChEFf+O1L57wlZfTMBb
 U7gNJ9lSIP+APjaLH4g9XsUeo57w6Ke+o6zr10aTMI3fShpAsGuNio4WQRmGyagDhDjOH/YVjCi
 aAUuy/avIi3QQ9cOKQHDcIP6Z+izegcJ1ETJamP2dxJQQGldT7HGylwurKQ15jByRjWtUrKNZJ4
 2KgccDEpAvVUNDgEy/6JdPzz+V1oQ5uiypBBknKFC3ZybcBQCd7Bu8J10sURaDlzyXA8W2XGCs4
 57SMELEIUYD41roK/VrgMlbtxmWKtsD1Q/X1dYaNAd0ilBpKgrjk1SaC6bFNunhtIzzyZ4QI6kp
 7WxhxY3XTd6lrsCDSJ3/SIaGZFYK3nj6If0Kkos4cllbznwBXRTK+XtURlPyBawMseI1bi7eXcg
 GJQygOQKSHK4B/YoZVA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 spamscore=0 adultscore=0 bulkscore=10
 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030098

On 8/2/26 10:06 PM, Matthew Wilcox wrote: 
> On Sun, Aug 02, 2026 at 12:50:05PM -0400, Tal Zussman wrote:
>> Convert the final caller in get_writepages_data_length() to use a folio
>> and ceph_folio_snap_context(), then remove page_snap_context().
>> 
>> This drops the last open-coded use of page->private in ceph's writeback
>> path.
> 
> This one I'm deeply conflicted about.  It's adding an extra call to
> compound_head() ... and we're not getting much for it.
> 
> I'd feel better about it if it started with::
> 
>   static u64 get_writepages_data_length(struct inode *inode,
>                                         struct page *page, u64 start)
>   {
> +	struct folio *folio = page_folio(page);
> 
> and then we had a ceph_fscrypt_pagecache_folio() function and
> ceph_fscrypt_folio_offset() (we already have a fscrypt_is_bounce_page())

If we're adding these, I might as well do a few more conversions...

> That way we'd have this function entirely converted except for its
> argument, and a future patch can do the conversion with little fuss.
> And we'd get rid of one of the four remaining calls to
> fscrypt_is_bounce_page()

I'm tempted to convert the argument as well, offload the page_folio
to the single caller (ceph_submit_write), and be done with this function
in one go. Although now that I look at it again, ceph_submit_write can
also be converted with the fscrypt helpers (albeit with a healthy dose
of page_folio() due to ceph's pages arrays...).

