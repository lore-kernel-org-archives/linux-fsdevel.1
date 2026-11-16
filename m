Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868930;
	b=vNVxsjj032tNvrL1TcVer3Wi8fp819Gx1QjSQPGYr4ldL8YXMC1bWFny7Qyac7QFgXYl
	 Pxu/gDGRwl22LODqVmJoJZl67KdRVa0MG7QN+Hu13VI84zYHOp3Sx98AdL7ZVYI0FgPZn
	 6mtqRfdLSb+UOzTFiHMcIknCCh830kp+UldOuwVGHxgFi7JLTi1x3jZJp6r/UOAwjf1cd
	 Xc6lQS9PCRQ7eeOUa4dVRyWk95TmAMReZ3R3ZtfBzftMl9vj0E+fNIMJUjuqrHX8TJsnH
	 ZVEI+6ebpRG5qgE39uYnjfiwZUnzKoMwYA7VXPVzYaZhMIlDsvfZ/uYwq6j3U4FH1lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868930;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/Pvmf2QgU+wzx57dWG9Br6WnsjJQgcv6TqcH2LlhKLs=;
	b=Dp9SlEwOarJZ1F9aDbm7cwbBNeUH7fzE8F1eNJfmnsCUcRX/5b83QGfKw2zfsDDyRd54
	 jeS+F6/Uc2mcvjrATv1p8y9I+WSaGKPicsaqAqBSFFC/AfLNtWHIAOZ/WGEyVUpmYKFSz
	 h3ZhxwyOan0MHJ4lzqrCIpDoPNcy5niWcxLJwkNfTyJW+TuMr+RCT5hiHnRlk4/AyQ2gm
	 s76vi+mnKLBzyZzrLIf34cBsmRok964c2VUhvgTj4q5QOpFKHUyZStcF9xh1bAtK8Fggy
	 Zygr4GYn8/2dh9BZw26LKhNCMil+I5umaIskiI9ADPj3li4969Ro/LbDz4hnkB2caww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r7SYfRIX;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zHOQc7xt;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02421606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02421606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=r7SYfRIX;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=zHOQc7xt
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLZ71V2349959
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=/Pvm
	f2QgU+wzx57dWG9Br6WnsjJQgcv6TqcH2LlhKLs=; b=r7SYfRIXc1lV35FnlAKy
	CcS20Cp9MBQY7KQfCLwo5jc+H+sLCfA3JaK0l3iqQPv4Ao8Gj7gd3k9Q4/rXO7xW
	cu9ZEY0g8gIIOXFg2GDvtU8esuALh2Zgy+XX7kzA4Gu0F/xKLAdp9G4NZCjmqKn5
	TF72zUqCeLZ8xpiJ4Z0HC7LLV5RoFl0m0LnR0IIFdAY7DZezHVWPqkSQzMNYtGG/
	/9vnz/Jlk/DRB/iR+qxvhFWfNqpDB+Zu95beYkx4KseANWS7paI0icHCme/BZW1T
	uofCn+74bfRxh/BMVeaHFE5lWepd48n493hK7ao8hlxDiZ2M/g1pqZL/nBkqN7Nk
	OA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0583kg6t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:42:08 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f26dd2165so1207065285a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794868928; x=1795473728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Pvmf2QgU+wzx57dWG9Br6WnsjJQgcv6TqcH2LlhKLs=;
        b=zHOQc7xt1nFzD+kJyhpWCzORYZIo7+UbbZDgUyzZQYprKhbtJq5T1WkReoA4ylzIOP
         H8UtbDEsfEsULruFIk7ApFAUgRD09ez/NYONVih5uhDGN58g7FouRTvkx8tBJzRxSg07
         eynuZY11ik4oNHVRV9zWGqapmWppEKg54xNJ7UowXN5hbyfoiQ1wTBMfABMXVqHMDtMM
         5KN8s1oRLrvN/od/7vfLmmXR1ZpTV71AUDLMSttZiDgMe2Hc//l4FRsBrUyWTELip0lK
         c2AdxOmri7i+0GAatQNGi4KizRRXAwCpGRVaAFNImkRii9SjkVmcfsJVR26hlrvDZZNH
         68qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868928; x=1795473728;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Pvmf2QgU+wzx57dWG9Br6WnsjJQgcv6TqcH2LlhKLs=;
        b=xfqeIB92z+uawktvWH5HCCdQYg9jasoC7MZF2yHrg9ER1tGPj877o6vtZqcfDqaLFd
         X+DWkhW52kMz5s2uY6xwbTInbZ8XHD5c0P1sEULVWRjIRp/m2KftnMbLISUegipcB0Bx
         2l48teNueKtWd6qMbdy+79i24AEBKA+ji3WEq6WmPr3tdoEQfH+/Uq1cp7O+NTzwecyN
         E2fXU4v91B/aKWUYX+OOCqyl/7ZhpivDbNKo1eTnN1qdZJhJMLddgDTgADSsJ5gaf4MS
         RCUhYCdfiQCiDqLdFbdrl7AZVZYCkDXyypgd1Pic5FSG8WsRuQ8hNV/8lKQgdje83hgo
         jt7w==
X-Forwarded-Encrypted: i=1; AL+hErEtUh3gZk5SXJqeJQIBnoCwArLFt22Htemn0Fj+Qpa/MunnhhdjZgMSzs0b4x7D9IAYgWpciwe9P7q9sF0G@vger.kernel.org
X-Gm-Message-State: APuU4Z9/qCQqgK8aHatmao1FLRJpsYsJcbIBeTcSKoXURN9ofNQL9hfV
	4WrPrA1cUWyaKjVeWU9skfbsoqIw/CgaICKaTzZrNahbV07BMBLXoZ9C+EFSchRp6e+qmz3LvOa
	lwMP6rVbX+OQNNvDb23MyXFXHyEIQuuYRMdYYsx1TBKvc3GlmFllK38st+T4LJ18=
X-Gm-Gg: AYBFou1xEDaGz5oywiPeaYfPLUKvS0RQUw/BSXR5qL5y7ax9fBZTPVT02gG9yNWDRg5
	2A+lJrKaG4JIsPvD9CVw85xDoprjY226RuVVbgi+lX6k8E5bSpZkUZkGjmZpRBdZrCxeGcaXTNh
	4o/2v0mPVlKfV5+CoauisVD/Q9tnckyTXzZWkccSt0xj1Z4aSR04KjyhTJADAiy5VmfVj+CDmJJ
	Wq8KfaAQdCVBlG9VLLzJJXGo3S6Qbc1Ulm/8YRggF88Vq2eqpnlbZkvvP45jYfknB6SacvTjWxR
	F4hYPPe2Acao99XETYvumAVgGopAkmpAoP6GVDc2V+zWrtU5Ogdqcj7cgMqeNt9/Wb+btPd2oeM
	kKyNg6n4r3Q6A3aLViPb3KOrOK6gxtoyHIA7N/hOuw6pyXMk23Q+MrPDbFLqPcKvyCncTEcHx8X
	iMe9zyy0F+TrdbKWQnmijLzk+8
X-Received: by 2002:a05:620a:280f:b0:93f:11ee:ba5f with SMTP id af79cd13be357-9494bca42ccmr1857373885a.79.1794868927904;
        Mon, 16 Nov 2026 14:42:07 -0800 (PST)
X-Received: by 2002:a05:620a:280f:b0:93f:11ee:ba5f with SMTP id af79cd13be357-9494bca42ccmr1857368185a.79.1794868927364;
        Mon, 16 Nov 2026 14:42:07 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949800ff73fsm312012985a.19.2026.11.16.14.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 14:42:06 -0800 (PST)
Message-ID: <20e72944-108e-461a-b75f-d8c4f8edbc9d@columbia.edu>
Date: Mon, 16 Nov 2026 17:42:04 -0500
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
Subject: Re: [PATCH v2 4/9] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang
 <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
 <20261116-uffd-state-fixes-v2-4-4397a0196479@columbia.edu>
 <2d9ec2ee-8867-4ac2-b2b5-654bf2441513@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <2d9ec2ee-8867-4ac2-b2b5-654bf2441513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Mvw0jn_0Y97ELGdKFE10NjQx5Kvga03y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX+uoXLhWLUhlR
 oDH/IrChq3sPFJhvtef67YyMu98H52K7ahEI8wbtqXkkghLqjERUlB6yWrHRDTaIcdHavXMtT+f
 bmySbek1aIMwBOBY9zPjzWCjQoW5K2R8W100e96lOk3hSBaMazek
X-Authority-Analysis: v=2.4 cv=QfjzLcbv c=1 sm=1 tr=0 ts=6afb86c0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=J8ctEq-HiRDkW_MkF-cA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: Mvw0jn_0Y97ELGdKFE10NjQx5Kvga03y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX4i5mm0MpBrUT
 1k+FGkU/bRez+cnxZmutQQ/ucdfbMnG2x+VqDtIfBF6UUtutBaESaSR2+FZmBMnJQaFQS1BIh42
 NWEpePJQtjf+ygR/hC3Wl3/M0/1sChOFTE6vQTZNbZoWY6ppmmziFwdPajSKWqk6AROQk8ehiH7
 GJNrBxYOTKBQgsbntutKxFM9Q6gtbpaX9ANvUdI28XjzuBLO11nTCg8yvGHs8Ee3Jvx2W0yd1Xb
 l/2u+OW1nn9QfSmSsFkaY96SQsM/e3acZGIUlt0SVmDjjbVBTPWUM/ef+vQcBJ8M9e7hwwDl8b4
 +Avj6Yl5o/tJOWkRz9tUzUfl7dD8Nw1erT0jJhAs/I+t93QhYIgn1Sziv1eQJ1c4dZZFV2Ct/RK
 sdVmYE+Hyu4bXX8JpBJnIsTZKUNHp5HXo3X6csWEYDJ/3XyouGvNmYnaO5PyAurvRgggac+YI0G
 lZNM3MAcNI19oM35vlg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=10 suspectscore=0
 impostorscore=10 adultscore=0 lowpriorityscore=10 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160090

On 11/16/26 3:23 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> remove_migration_pte() makes the restored PTE writable for a writable
>> migration entry, and only looks at the uffd bit of the entry otherwise.
>> A writable migration entry that has the uffd bit set is therefore
>> restored as a writable PTE without the uffd bit, and the page is no
>> longer write-protected.
>> 
>> An entry with the uffd bit set must be restored write-protected, whether
>> the entry is writable or not. remove_migration_pmd() gets this right: it
>> makes the PMD writable and sets the uffd bit as two independent steps,
>> and pmd_mkuffd() write-protects the result. To fix it, do the same at
>> the PTE level, where pte_mkuffd() write-protects the PTE as well.
>> 
>> The only known path that created such entries is PAGEMAP_SCAN. With
>> PM_SCAN_WP_MATCHING, it write-protects the pages it scans, and it set
>> the uffd bit on a writable migration entry without downgrading it. Now
>> that PAGEMAP_SCAN downgrades them like change_protection() does, we
>> should no longer see them, so this change alone should not be visible to
>> userspace. If another path ever creates a writable migration entry with
>> the uffd bit set, the page now stays write-protected instead of losing
>> the uffd bit.
> 
> I am severely confused. If it was properly fixed, why should we do the below?
> 
> You should WARN if we get the uffd-wp bit set on something that is writable, not
> silently swallow it.
> 
Yeah, so this is more of a hardening change than a pure fix. I think adding a
VM_WARN_ON_ONCE here makes sense, but the uffd bit should still be set so
writes don't go unreported (which is what remove_migration_pmd() does too).

remove_migration_pmd() should probably grow a warning for this case too then.
