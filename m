Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015620;
	b=pbTqpGBvKIJm5Co+xO5bzlj6vIpFjEiV3bgNu+vaMaK9fz79wl6OF0+R8BsfP71y6a13
	 o0fUYyMb4tx5qDhVVNxTjJPnqhsphf+8EFFVCFWKc/Ata3hgTHVufzUKmSf49XtbVHhTY
	 wI6276ljD05dy4o0OuWvTwH3C2ojUGtReo28pbc4YFGkQWBXloZKR8lNJZicxdbcvl+6T
	 Ax8ytHsO6pvZxsS7VTCHNDLAh/VYLiFu9cirfmjpF6OECo/D3EmwBoST3Jp9pHWR66d9I
	 0TgJ2vAYk8sqx2Ml/pItDaSjvOTdYLkYlRm4gPaxmkdPa3z4l2UafTymdNIp7snkk2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015620;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
	b=tDWoRNACSsSQVx92RLhTsfQJu5my0FSJHXcn19eNhAw6tSmFlOFKAv+kvMeCoSkESsNO
	 ABiLfIPep4VYcscnm3br0Cqa4akZA2aBIKEeLbVHObq8Qt1ODWL5CZiVvq2WUitFOiU+V
	 yDhlL6TWAv0pw9ZUY0oH3cnWKiSZyjsPLwV4+3Gtthe6H5gQ61yz7BgfYNWvdv+IeVIWa
	 GoX84+oFdKyke5yTZ0Pzg9w1QCzhm05c0V81eHCiz7CDhXjQpQgAl52IKHBqU4QnVc90Z
	 jIH0MHyamWE+bw99RJIz8fO+JVMpYv8m0wFwfkwlrcxSj35qxNGuUIcN3sG4YFAI17w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=eNGLzMnc;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BB606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 15:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F5BB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=nkgzzLi3;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=eNGLzMnc
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIEgHaB128504
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 10:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=y03Y
	2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=; b=nkgzzLi3h9HeG8fKyYEG
	uDh31vyXH1oYKrz4We4FN7MFzIgxKgw5bbl/1yYWvjel0KI9TY0DcA4tf8wyHfUO
	E9S3VBpfvNnGIkq1nWd7rxaJV0Lqs7OrEOCpyx0/oBVIQHwhYGWzDerPT+uUwcIw
	UNDOHrTbQpKsrdIawLbTecxwoOgThMzBSetvGLfhD1Fr+I+bJ8XjXzV/tn3a/mwj
	WnmC1oaXxkPmI1tAL5NMf/NM2XxF0DEM+oYOVbl6k3afNC9MEBBmKm7ao0MfRmEk
	9PYcQAKRmMuhT+Cw6VRw5kLAg34WlAdslNZkvKUYJ/1MhKqj8LIxnHzWfAB0TDWa
	AQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j0yu74ck3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 10:26:58 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb7f9bb86so242386385a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 07:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795015617; x=1795620417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
        b=eNGLzMncLaD/gULnBB44zNnS7Dv4FStMKpQi/7xu023CAaSTwBI7HWkCyE1E5YWhC+
         1kiFjXZKFj8+RgDAZ1hdk51QxLbNs0CSM8RpFrIqBwwxkAk7TRswMjEi+QwoiZlQzazO
         e4z1u5ofToDqWcNa3NsjffkxTXBgxKwMe1iOFbCGp47iXjVmxNabEo6YnrEjLS96p8WO
         3WvT2Y2QGwdYCKhXPFfoREfs5wZyUi9d5jfAUhZdX5N5/Umb6g65IMdcisZwmY/nudM4
         XMHhjw0eb2Bt7y6891a4kwtTFuJuWObV6UANmwVG+eqh6f0a/YRlJ0+S/NtJw1R8SOML
         Ur2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795015617; x=1795620417;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y03Y2WW5oPTNmKuWLrWXmR4s/hn2HFIbPEH/c3XFLbg=;
        b=sqytQ26XQiksHmgezx1TP4coFxZWsoPqKQmcWz/ewITMP1TnmjJE1cwJMGG5cI4YlJ
         eV3UcXY3P4dpZeHbSZXMldQpNA2vPf2dxxpt+KpYO8R6G8G9PcAGWG5CnOldwlKRvgd0
         IxS8IMOu7uQCkGTXhgRjbsLEeuOD+3Ea9HrgeXbIJD78gkvfqC2rPC523RA3E3SVxDlc
         yGE9AjA8TxakEKCyrtZFO8603lOUsSBsDCY9BkLFkQfjrbpItTlH1QOos1sL+1BARjvb
         RYy2KCVbex0UgM4WcW/zfOaNySmgxLcYCkv12Tfa88KyDy4YPFcdZs3ulZxZtCZenlrY
         Tjng==
X-Forwarded-Encrypted: i=1; AL+hErEzGUK2QLdkUxU9gSALzDaMptTX46jldSwe/6O9abr9AocRYQPNTfXjoloB250VrieGs34dZCuhRzcS0mJB@vger.kernel.org
X-Gm-Message-State: APuU4Z+ojuBwyU4rWBfhovi/r3YX3Otc3l4dx4MtK9UcRqLowMQW4tKq
	WWYuOQmT/tC1yvC4GgILYt3MYIgWbLkEraQ71mPDzhD8f7iu+hvXVPqkPAHRPZ/Awiu+sDIg8Ge
	Cav1ktnQJEFd15ER/gPiWUmhARox2nweFIH+95q89l5aOGJplY6S6jfC08jh2Ghs=
X-Gm-Gg: AYBFou161p7vCs32EK2eS3AC3A2vZPy2oRPTX+mwnyJCj8VHaJSpFWbt/zaKeuKp/sH
	3Mq3kUY2uZ6U3v18PL2VvpwWNQjem2KFN3oGCfJeEgSMaXJNJxjoMIZI9fR8UYtkH4KTI8nt70V
	5YPI/YDjM+uSsYwr+Kj8OTme/eh8j3FV/nmv6c18u3yai+UjyP8lPjDpCws3qqHveYPuPwpcGHy
	/Q1KWalNzpnJVA4jmWFsW6kkEeNMdWv1TiWnUgXcNeXc2/CisvIe3uthWADwXukDv01iL/cS3eb
	GnV5PoVq/B7njPkYZBhqzrlwplwIHayWTR/MejlH+Vbd+8Pe6d2/aB5Cf6ejI0fWVyBLUgf4qFP
	3J1xHYTTbsO1RFNxpH8hO2Jj5qA1k21RLBlzmdzNvAASG5/gpzhIEVWZ3YfScrvzxyrtGzQ1Czb
	g6hhnvykKIEqahsPU9Mr0ksg==
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id af79cd13be357-949995f04bamr536128685a.59.1795015617486;
        Wed, 18 Nov 2026 07:26:57 -0800 (PST)
X-Received: by 2002:a05:620a:8395:b0:947:b201:faf9 with SMTP id af79cd13be357-949995f04bamr536117585a.59.1795015616695;
        Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-14.net.columbia.edu. [128.59.176.14])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b72055bsm204599485a.12.2026.11.18.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 07:26:56 -0800 (PST)
Message-ID: <7d31ba34-8b5f-4eb2-9864-145ea80c3412@columbia.edu>
Date: Wed, 18 Nov 2026 10:26:54 -0500
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfXwoCJ3u4PvzrD
 tQ6RplAPQGTi2Q7MSWoGT+8NAyk4RhABOmufZuw0Lej+A6PBJiOYXZ1AZjaSaWzAhrx6WmQnPKE
 gxbRw1dCep9SSY2MkdypuRmrkqk/v/2GAfuddvWrBBIT3fkpS/wPIjzs1YVCs1Mr5TT4IbztCGy
 m3+ZJeo4zzh4Lpee7bRruMdKa3iIMVyzRIk0O7qtpZwIZcPgYMtwobOHiqhJWWum0KvqT0qBTaP
 tQu/NExh5QdHJqzRiP4l1yTsZg0wi+MMK8R3YkFra33y8yNvMedDPuppPjnZfb5+3OnIabX1Pw2
 jqmYHOOwSyOU1bh6BdVmGEZ+8mSg2RMH7sbcbx8SDUYGhPnvBJ07ASusxa+86oNkIgP+WtMYTDx
 sFdpEMuCE59wOSX1dsMY2Y+AfZjVfN9CwxFVvCkrk2obHs/qzFb0i4S2EvgT2xquIF1bhwXgXtO
 CAYdFPCC+M+AN2ggKDA==
X-Proofpoint-GUID: qsZ7bfGvoY3R-XvAYKVtJUEyjVBZPRGV
X-Authority-Analysis: v=2.4 cv=OPayTiaB c=1 sm=1 tr=0 ts=6afdc3c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2zM0HjzktFauw5hoOd8SpA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=Z7cX3StJxvrjZLnT-lEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX6SMSx/pmvQSW
 +blbDG1SJldAdTk6FChcFgQeZaaGVTiVf0lj7GOkXQGHpo++N2Y6t95DQ7WYELByv75SsXQnm8R
 W0QDTTPKkU3Lzpg+WT2/wcbVwrIA8def9q1HuRyy8s+WwDGRpvuj
X-Proofpoint-ORIG-GUID: qsZ7bfGvoY3R-XvAYKVtJUEyjVBZPRGV
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11970
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=10 malwarescore=0 bulkscore=10 impostorscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180061

On 11/18/26 4:41 AM, David Hildenbrand (Arm) wrote:
> On 11/18/26 05:28, Tal Zussman wrote:
...

>> Patch 6 has little user impact on its own. It is included because,
>> together with patch 7, it allows removing clear_uffd_wp_pmd().
>> 

...> 
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

So my one concern is that (as per above), the mremap patch removes 
clear_uffd_wp_pmd() after the huge_memory patch removes the other user.
Splitting them may break compilation. I would've left clear_uffd_wp_pmd()
alone but then it throws a nice ugly unused code warning :\

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
> -- 
> Cheers,
> 
> David
> 

