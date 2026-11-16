Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856613;
	b=djMxdU4hV2tbQEuc2/3Kxx+bmTIxQYN+YYkS+mPCLYrbgi0+SNolKDQ5KzPZxPzb/Hqz
	 xdD8cYzmTW+Hs8/utInb63VHYokP457wmBw8qI9829Tr8totn2PgAxiHD60HmT6xsk/WJ
	 /0fj7Bhf6O2VayGjkqaUpnEy7FW/b/BgCSaFsW/t94qs3Qla+6Qm83bqp4JHfqnQqsiBa
	 EXk07Fk+yZ7ad4dwGucf3QoULqIjwin8y2Qjpwy/T7UFSHFVbAkCzyd32Y4vwpg0nWjBd
	 +jyIAYT4igiPFoMAWN4Qt3TVW2sB4ygT7jXyMaJRGY6aid1ydNR7WfXd0Kem1btDz6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856613;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=P5HgnCAHduXh9UgqrRv/0lyqCC3PeAkYFEaq2vgb4eY=;
	b=ceCKp/T2tJ1seC2kTfCPFHSXl1zJJ8VBHC1OnoKqMlKN9I+cPT0HUClXACdnxEeqYNjy
	 sEPknVrZCrUDg6yKW7hcBWO+I2tzxC/xmmHTOc3iK4gTZBlBY7vV/PjPTcGZXb6NTMKtf
	 AMoLpSmFjAYFHyATH3uhNrhjNz40QwAeJzbnjNA8KPl18Wb9pWV6KM9+hKi6wiKcY8Acu
	 1XqceCxcgrsvKNsHNrb04gR7P4uN4xq9mnETTotqrS8lUPo1FMnS0AlnIDEemJWErHEXP
	 Vb79ZJ1Nk2iBrik6GQ6wL4ZoQCQ8qnkjaJa95oBuhP9aIi8DcetEHkFtAH1otvbplKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aiqJE3oT;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QH4sMkY6;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A42606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70A42606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=aiqJE3oT;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=QH4sMkY6
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGHhVEa1213850
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=P5Hg
	nCAHduXh9UgqrRv/0lyqCC3PeAkYFEaq2vgb4eY=; b=aiqJE3oT4WLEpnGKlDw5
	6nU9q12AZh4AhxbLBellCSSNW7OIJRcJRo7ky6nYY5brJbA4jXMEEQVDfv6sW158
	QHmvam8UOoFJSKT9yyquvDKWXlJPfUuYRznxG7c6Hv3U6ssracVVa49/PplCb/wk
	Ts3jh+b+rmXwnCeLS0W3cbbI7Zc0w3zq0fbD1oiKhYUtIuWnn/bZSucH9CMKwo8D
	kuMalFon03A7MQKqMmZVyBsqKn4cxhmeZSdPLP0cjI085X8byI+EJDSPVse/epc3
	8kcanZhcTJgRsq2z+NAVxWBWB09uerq6pYchs49IGtt8Agq3/8cScxHGeY3WO6yX
	9g==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059hhhyf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:16:45 -0500 (EST)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b2fd108b28so54734267b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794856605; x=1795461405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5HgnCAHduXh9UgqrRv/0lyqCC3PeAkYFEaq2vgb4eY=;
        b=QH4sMkY6lV3a4jLpS2wENZuvImgrEss1SpXtqvRuCxah8IByEE4Hwk07X5bz0Cnvs1
         w/5GTHGSSlECYs2KU9CdkBe/6iqefn9wD/Lrbm114M+658Uux6LMWQ4k2FfYMVqHzOfD
         Ji/vwl8xsIkdAL6MZ5DdHExhoVNNa9DSDwSrudduIE5hefVc7qe/i9Qc0EZ+ZcFNU/Mm
         syRcJwQyJ2BKBqBzPEO+UzSrat/8uuQTRYaKyWSRxjyK0KpQj9f/bqBAm9pstZCit3EF
         TeeCaoJfTzQMVoVyzlIYFY7S9YEkSfcYAgu10pvRcYlFFAy4FtCOKay1QsTlRfdmWd5/
         73kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794856605; x=1795461405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5HgnCAHduXh9UgqrRv/0lyqCC3PeAkYFEaq2vgb4eY=;
        b=sDw6WlWiQQNgYSJGp5nAeWz1eKCE9FxBnxw9vqb+2dB71ceUkkK1PjYz5svRU/e+zH
         j/O/56BLfwU9Y4hgLC2UBs/9m/6rXQCYOvXK0sWAgNbMbRMfiKAyrT+On4W5J/5PQhdi
         /sDk2Ce0A1hnOfWWPONtFcsQioJkpGMoMUfs52jgCke9vi0JEwf5MnI0jvOrahi862si
         WTLUcd6S/hmJBU6J2b8DC8Q5pxQw83y9UDSvLe3GdXdK9di9KLRZIJbXjtmgYwPWFVlF
         7TZh4rnacEb8CggBcnHaFwttOgWKbM2e/gfK6d0NrpQPpATQr39CM/SNetWtP0g28mxg
         xZZA==
X-Forwarded-Encrypted: i=1; AL+hErFfUBk9IIkmMgGTJLn1olJenq6Jjb0x/lqCS9cSVJ7jkMKRlqRg1hS5NPIvOG3XbqGa5k77jW7eUoOGpIsv@vger.kernel.org
X-Gm-Message-State: APuU4Z9TsvwqRP/C+gz/JaKzVtSv5f23qlPeaGk027UE7ASh/dQ5ZpS8
	AeLuMyiDAEfu+LE5CobzcY/qNtfJyRdSqFdllJ3rzGfwfrxCQUpFKgbDyruZJ1673iYf+sqkhp+
	Q2nKo4OS7F8DaJCthCL9txeGMs7rSG8tvz9K40juPeTy1ut6E9GxD/79dZO23WBE=
X-Gm-Gg: AZFdTZeK0uEhQpRUK2PLd1OBMOV4eiCtD5Y+MWGnydBE9un2qzTCIqfzFtd/ARO4U3B
	kl0+YkbvV3xoXjwx4FQvW8AFHFCOD72FEWTXMe5NRkETC5r/AtkOx2eoJZi6TgAhPxADkOMLVzF
	OWzCdj5+CmwyfNWL/3qaJ8zJ9oeinU7zgA50KEYDo+zwM2KQJvAZoSfJIe6ShXJ7WPUm7FZ/fhT
	ntpxc0WDnw7m9mdQ8M2PdoeDM3AtpcHFSZVNSX10BzVTX7tJ9u/nv6A4V4xJPmFledaY1vt7b6r
	nqFg1zDuS83vGhmgp5qj2+kVA64hniVd5HGkk43/wzqIfCZ+oxz79d4EbPhLDw4jVNMcUQm3KgT
	7zxEhk2Q3bpE+8FfwnypqzzjWVdp1hZ5BFbTeENbQ5PbA3lNJH7/AimEZJ3kspr2oF81vxo2aUk
	CKEF5ezlqhrjTRCU2oNzUia9m/
X-Received: by 2002:a05:690c:a089:20b0:8b3:27b8:2bbb with SMTP id 00721157ae682-8b4ee00e3dfmr1847387b3.100.1794856604890;
        Mon, 16 Nov 2026 11:16:44 -0800 (PST)
X-Received: by 2002:a05:690c:a089:20b0:8b3:27b8:2bbb with SMTP id 00721157ae682-8b4ee00e3dfmr1846937b3.100.1794856604435;
        Mon, 16 Nov 2026 11:16:44 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ec4d377csm6303207b3.40.2026.11.16.11.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 11:16:43 -0800 (PST)
Message-ID: <032839a7-ae22-43aa-a065-c7e9aeabdb8b@columbia.edu>
Date: Mon, 16 Nov 2026 14:16:42 -0500
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
Subject: Re: [PATCH 08/12] mm/migrate_device: do not migrate a uffd-protected
 zero page
To: Alistair Popple <apopple@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-8-00713d368976@columbia.edu>
 <179454988585.482102.2051616940227067987.b4-reply@b4>
 <c3a51a9c-083d-4c76-9a62-b7a6fe69a121@columbia.edu>
 <avpHe8sGgnzx6UwG@nvdebian.thelocal>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <avpHe8sGgnzx6UwG@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 66t9vRE1YvAShS9DJwVMmXzV-4JoFfAR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA3NiBTYWx0ZWRfX9kqECm3ZfyyV
 LIdA4Pnx1J/AC8zY/lvH0IUsOKQoaKBkfLAPDhvOEurqq+Gzv/+dm5Mv2xgVeQ/QABfJJiXZNF/
 xmvUuSjpxKUymxEAu+BjMaPY7ddalU2y1TfYU+dtLzXNQGknsAV4
X-Proofpoint-GUID: 66t9vRE1YvAShS9DJwVMmXzV-4JoFfAR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA3NiBTYWx0ZWRfX6dz/O2yhTiE+
 rbndlAFpYaqgdAYYXdjljbeYSOtLC03osw4SQM/0RG+LU9lTvQ/dWtE00+5ivBUiTlK/Nk+OcC+
 +u9u9nRLnt0cppai+VQWm2RQzySbEgbwA3SI6helMCikYuI4jtwpxk1zhRHZO25tgG5m4e3HAms
 SB1gc17a9rPHrUeG7k9d5SX+jTqqSLqBvcXaO//qyBiEmeCN79xWqcAuI4A+jDytBTjjvJkYnKc
 pTTAgJz1nKYt042Zcw3nNW+/HHH0BF5H6N/PjKJfLU3IP45HiIzbFHtS4sMNhjcthZxZr9s909p
 w9JhURJBObwOLYnAUhiwN7iFYYnvzwanznZhxWhfrRXWCYq3CWKJZM9VfDcxFw5tVHjuuisuGOS
 CFygBTQRzoyqFjSR83v8/6yNbD914WwpP1YeD5HsJK0ouXdiAtEbVfDtD/J+ZL+8P26NgoAOG5G
 gxxtUS/weZzQv66Tw1Q==
X-Authority-Analysis: v=2.4 cv=NLlAaE6g c=1 sm=1 tr=0 ts=6afb569d cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=Ikd4Dj_1AAAA:8 a=UXdWbZvvS6ccjjYRLXkA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=10 lowpriorityscore=10 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160076

On 11/15/26 7:11 PM, Alistair Popple wrote:
> On 2026-11-14 at 09:26 +1100, Tal Zussman <tz2294@columbia.edu> wrote...
>> On 11/13/26 1:04 AM, Gregory Price (Meta) wrote:
>> > On 2026-11-11 12:55 -0500, Tal Zussman wrote:
>> >> migrate_vma_setup() installs a migration entry for each page it
>> >> collects, which carries the uffd bit over to the new PTE. However, a PTE
>> >> that maps the zero page is left in place without a migration entry.
>> >> migrate_vma_insert_page() later overwrites it with a new PTE that is
>> >> built only from the VMA flags, so the uffd-wp bit or the RWP PAGE_NONE
>> >> protection of the old PTE is lost. The same applies to the huge zero
>> >> PMD.
>> >> 
>> >> Once a driver has migrated such a zero page, writes and accesses to it
>> >> no longer fault into userfaultfd, so the manager misses them. With async
>> >> tracking, PAGEMAP_SCAN unconditionally reports the page as written or
>> >> accessed.
>> >> 
>> >> This requires a driver that migrates memory to a device.
>> >> 
>> >> To fix it, do not mark a zero page for migration if its entry has the
>> >> uffd bit set in a VMA registered for WP or RWP. The driver sees an
>> >> address that was not migrated, which drivers already have to deal with.
>> >> 
>> >> The uffd bit can also be set after the zero page was collected, as
>> >> write-protecting only takes the mmap lock for read. So check again under
>> >> the page table lock in migrate_vma_insert_page() and
>> >> migrate_vma_insert_huge_pmd_page().
>> >> 
>> > 
>> > Similar to last patch, this changelog could be improved.  My best
>> > attempt at summarizing:
>> > 
>> > """
>> > Device migration replaces a zero-page mapping with a fresh entry,
>> > losing its userfaultfd WP or RWP protection.
>> > 
>> > Don't migrate the uffd-protected zero pages.
>> > 
>> > Skip protected zero pages during collection. Check again under the
>> > page-table lock before insertion, because another thread can apply
>> > protection after collection finishes.
>> > 
>> > The alternative ...
>> > """
>> > 
>> 
>> Thanks, I'll trim it along these lines.
>> 
>> > I have concerns with this:
>> > 
>> >> The alternative would be to carry the uffd state over in
>> >> migrate_vma_insert_page() and migrate_vma_insert_huge_pmd_page(). Not
>> >> migrating the zero page is simpler, and a zero page that is protected by
>> >> userfaultfd in a range that a driver migrates should be rare.
>> > 
>> > This basically force-fails a migration of a uffd protected zero page.
>> > 
>> > Wouldn't we expect this to cause drivers to fail to make progress if
>> > they require that page to be resident on the device?  Not sure we want
>> > to force drivers to try to handle this special case (if they even can).
>> > 
>> > We'll need some input from the migrate_device/GPU folks.
> 
> Thanks, I was halfway through responding last week but Microslop had other
> ideas.
> 
> Failing the migration is fine - drivers can never *require* a page to be
> resident on the device, as migration can always fail for a host of reasons.
> In these cases drivers should fallback to remote mapping pages (eg. using
> hmm_range_fault()).
> 
> Now if userfaultfd+device memory was a commonly used feature then it would
> be worth fixing this as always failing would have a large performance impact.
> However I've never tested uffd+device memory and have never been confident the
> implementation was correct anyway (both features were merged around the same
> time). So I think the simple fix is fine:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 

Thanks! In that case I'll leave this in with a trimmed commit message and
add some more GPU people to Cc.

>> Yeah, makes sense. I can implement the alternative approach, but testing
>> for this is a little tricky without the right devices... I might drop this
>> patch and send it separately with the GPU folks on Cc.
> 
> It probably is worth copying other GPU folk as well though in case they have
> different use-cases. Matthew Brost (Intel) has done a lot of work in this area
> in DRM, but I notice he is already on CC.
> 
>   - Alistair
> 
>> > -- 
>> > ~Gregory
>> > 
>> 
> 

