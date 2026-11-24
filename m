Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549041;
	b=XGC9OwJ4LWNgpSmkpdJoV1cSaF+7h3WjTXVksklO8KNlCR2cMkotCY8RETDDy4l6g+1h
	 HhBhC4IzqSKnSDeysiiUSaTWq+pRVJt+SQfjs2a/DJ5iZmk68CaMSfGpCRF12lkidCzfo
	 pclc6Jy4L6yvKMuvWX9SHCUxGPkY4D5t2DVO65TAkwTY9vTiHOVc2z395IrWj6EmBbpqP
	 EqU3kAah9GC7qskkyxcBPEfBC8JN758uvuekxhGW7sSK/2cosReJDJg5Jp3vLIFlXYgGx
	 fVXokAiNg7ClCZez+WJpMgc58i5iFIVPLA135fgwmVvTazku4cLAEevzy32Qcu24Uwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
	b=uyxNXh3y0duRSMDjXEdYeOrCV0OFH+UB0p60E0xa5CTvuu6vI8MOKIuLr/tzpI751mT3
	 Abn+U8jZCjM7i9Ek4C66FFTcGuGu4n2weY78cxDlT1WTtrgw9ueYbDiEgECYuZbghtHgI
	 b3hfhyZflpJszLInQWJmd2iLcnRv16HjgUgmUlJqayspcwEB748b5VdUo49i2VBOGD4z4
	 cpNv7L4Bb1jgExfNYNRjxxIrldNhj/i0AzHqGfhmTqtPu80PGT/alQxY3etlCGbTDjv08
	 VctInvSX2yOnL2oDglruI121EMl7yVGKvfaiVb+lI40H81+K/hHfRfzEQ/ZXEmc7HMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b="b7CR/Rfv";
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD9F606A339
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 19:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD9F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ArQqb01A;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=b7CR/Rfv
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOJYBZI2439409
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=OMjg
	nMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=; b=ArQqb01Alvqy+ezQ3O+b
	wFGaLKLkRPslDfTTnR/1n3YHEnzFvpSAXsSLtAema3OMBGvQTr8MjsfnQdizF1DR
	Y35c9K1YbdbrokVp6lJBFIYVrUHqLLS3WYYBtEDDKg/6m1bODWncA+LZwiNP1MH8
	Z3bx2LUxG6sfpmxDdUI+/kyZI7guQlRgIUWOBYQ6reZ57nqjYw3JFREOmJXGhsy0
	5UyyJqrfI8VjX2MlX1xqtk46jQix4pqRNZv16i1aL2PIz3aAJytU8fQlN33iF7Uo
	xruvXaD2EFNKvtzNiOaeLj7AUiUNlwagsbKMIv+l5TRcoparlTssaELubPi31AEG
	DQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5g7bge5g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:37:14 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-536778a8137so87210731cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 11:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795549034; x=1796153834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
        b=b7CR/RfvfQFhd7RLSUV7lty/ZLnME/O3SIVBqogZpBKc5kWbTS6XOXLLtHAdx6qPnr
         GLx9wIF4Ww4QBBzLi1rfOBnuxr0JAv1yTnG4pUXExvThtMqTc97cKp+Z1h+pCVB4nXRo
         tgx8ds6qPdyVt2BG0hZu7Js1CUMYgRQoXbcHZ2L8eyOM8lgOjUJPCl7yqCAjRMmEMl8w
         7yEG3GKOnP3k9k9ABIteGqF13sEWTiupKHLO7WWmzv6jE6HmUFHqQtTtep4guibr4fvN
         fCeMtXZBo8LG9rK/kdXoR7e8/Boax5ngkEHQ2+xMkquXqR4MIvpygOuBEgr7JOmObhVL
         QKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549034; x=1796153834;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OMjgnMOdm5LC9Ve7tJbATj56ZsHM2zVs1s6tMJ9jz2Y=;
        b=AFouOLAqz3vNBrrqeS+9x1wi57QStXFBLaVAVz51lKAbKasAtQktAQ/37R01d7mCWu
         KUDQL7ArBZuoy8HzQBwMPr571JaaoaFceTqMmQy35ZLBLBontEIHyNwAy/YAGn7AAsX6
         QDQnpoiXe8dKPqs+KFJHMAzG1O3I0VS5Ccz4Z1If//lpPsd4M3GURCS4P59krUjcGww7
         o0fwNnx4radcm33sH6QvhdeRrEHR101133x3YE7Q8hd8EBsgXmf3N68vPUPIkBw3s/Wl
         qulOQ/Iik002iZm7Bd2TQ/Hylg+QmaOYRb66iAwH0gRTPz4etvQaVdmLyREjhYpgxlwx
         riJg==
X-Forwarded-Encrypted: i=1; AL+hErEElGYUeeG/wDN3mR75SAAT6R9f37id9L4RcV9oprHFv3GE4X8pARWXZlQq3lx7ZVI5gMyWqiA1SWabnLEf@vger.kernel.org
X-Gm-Message-State: APuU4Z9rRtFZeLSYLl7w1iVQS5dE59X8bwDlF776VGP7Tt9CmVB4gEq1
	AsTx1am6cHxqQJzwfDfzrw/JU9XALFSX1c5COX0UQzcGdTv7xW2moXFIkK1rhHVjLNtcs4hWcJJ
	sfjFWXQP96Rutd2pOEgas1QABxK+zCwPKpK5BD5ve6yc6tuYSVgqDQE/n2G2AQbk=
X-Gm-Gg: AZFdTZf1CnCdSoE+V3Pxmag0qES1DdftIRBsvL2g1TNCqxVa+Pn9U9Yy2pI5AHkcD38
	nJ+XJP6sjSVaZsJnoWSxLCAV+lTjVf8p4uSphFEJu/yEkqf2MwNJOfC8TyTgf34z6iDpQK28VvI
	Na9CcV0UcHA2FcUpWM6XZDsrEET0z8vFSUEZ0PrPTNfqnncCY3q7NGOpmToqYKpV5zL/vxPZ7J8
	u3qrMvDFL5UDnWtnWxBCLrv34xi7frgsB95V52/LD/2W259X39Qv+u4T0QSskwe1JCDmb7pwkyb
	oczELXVjeaFP1MsXaiOfDYG0qPMwqMkJ+yQ2NEol4keU1q7zW0L10ggSG5T4tiTUs0/FA04h3mt
	Orbk3Ay0oDpueLkquhCmHmYImehb+Iuao+soiKpguwWno/n127ZZ4petj+/R+YsKhjw==
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id d75a77b69052e-55d76a5af8dmr288718121cf.49.1795549033799;
        Tue, 24 Nov 2026 11:37:13 -0800 (PST)
X-Received: by 2002:a05:622a:313:b0:55d:1944:a2ab with SMTP id d75a77b69052e-55d76a5af8dmr288717631cf.49.1795549033344;
        Tue, 24 Nov 2026 11:37:13 -0800 (PST)
Received: from [10.206.101.158] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm140631006d6.41.2026.11.24.11.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:37:12 -0800 (PST)
Message-ID: <3ebb01ea-fe77-4467-a1de-7f30a91593f3@columbia.edu>
Date: Tue, 24 Nov 2026 14:37:11 -0500
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
Subject: Re: [PATCH v3 0/9] userfaultfd: assorted fixes (part 1)
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Breno Leitao <leitao@debian.org>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <4f23b0bc-b89a-46c1-b8cd-853e7815b7ac@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfX161IAw7KQ6OQ
 OfjHSp5pO77tQr+HQUL0gdQZNSxhLaFQPgj+hFaGs7zyVugQZifK/UnFyfBhrCXFkmKXWUxWG3M
 3X0rYBQYBBBe4aJJzd76CFK2SPenbqXxr0Wy68380NROZeaSaRr/ge/FQSkEV8OHIe8SW+Xp9QA
 +5+0ybT5es3scPYeZEt3bd9bdKCsdZWhmgMcCw/4dNjjgeTgK8kHM3hfn74Wmz1TWYRp3jk5sP6
 eCskFi3fQAriIq77cTVam3k/3GNkYa5LFsucZXMwq1jUeHqOfLwEZ0w6XVIhuD9BW1ts/pItGRI
 cnT6lNqVfHTRh++NVjymhb7TH1zIlT04fIxKjtK44/ps7tbxJDJVfglw8Ycd6/BA1WmE+17UZ4W
 fZ4eXfM9yFRKuIoff9gf4PLF+UA9rUfgpA48HZNiHhEqxxJBbckwG2ZEXl8LJp5IWe35HcV9ikS
 C3bpTbGA7yNkLRXhV8A==
X-Proofpoint-ORIG-GUID: wPZdyCAnQRoAFL6JU9zGT8W_HHQr0L3W
X-Proofpoint-GUID: wPZdyCAnQRoAFL6JU9zGT8W_HHQr0L3W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NiBTYWx0ZWRfXxRixMNREFLTa
 tElBlVq01eJnLBDhvrhteqC77BDxON2MDFv6lwkYX4EUcBSEFsV+vYS666SQDUWmLiXJS3TeOet
 aVmFzuXpWolidY04/bAkfs647CTcpyxSYL74dgolmCGJfFuMAISm
X-Authority-Analysis: v=2.4 cv=RIcmjIi+ c=1 sm=1 tr=0 ts=6b05e76a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=10 lowpriorityscore=10 priorityscore=1501 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240076



On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
...
> 
> So, I would be picking up ...
> 
>> Tal Zussman (9):
>>       userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
>>       userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
>>       fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
>>       mm/migrate: warn on a writable migration entry with the uffd bit set
> 
> This
> 
>>       fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
>>       mm/huge_memory: build the moved huge zero PMD from the destination VMA
> 
> This
> 
>>       mm/mremap: resolve uffd state when the context is dropped, not during the move
>>       mm/migrate_device: do not migrate a uffd-protected zero page
> 
> This
> 
>>       mm/userfaultfd: check the hugetlb alignment of every VMA in the pre-scan
> 
> 
> After waiting a bit longer for more review. Andrew can take the rest.
> 
> 

@Andrew, could you pick up the rest of these (everything but 4 and 8)?
I'd like to send the next batch of uffd fixes I have on top of these.

Thanks,
Tal

