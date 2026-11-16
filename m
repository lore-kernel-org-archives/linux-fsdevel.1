Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869331;
	b=D0Z9QmwM+f7Vq0wXN/dTxreDL23pIaFZF4QfMChj8uLN5IDj2ef4+hjk89iBm22gqsB/
	 9MXrcpMLURY8vqOjmrswDqZSXiYcIhrUYsWcEwA7yqzxcLFW48xU5Rkf1sEF6kxgNwBra
	 wIYM08tUyasiRjWyMTiFcJ2eXZu0iPXSWP/jMdqeLEFAR8BMvuCdYLR3vRZEz7ru9dk53
	 pHY2mLekjRFY2aglVPrAouDbM8gqXDI6px3B94S4nJl6tp4F/RHV4wbUL4hkgt0Vkoa5I
	 RQyLW2SaRVDhj8sNZ7kClVrkVDPN895jpyo5R/Bv3jpQ9PNou4pexzhWaen4IBhPLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869331;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=60pDhYqz+P/R0qO3ME/ENMTcAYUA1szCxs7zb9TkRHQ=;
	b=iwjHOKVM7or2AJK0gCE+D8xGKEMs/2J0vHFxmDlh9sDUc/v3MsNs5ieXGY1+LWJLTPdH
	 z1qEfpAuZiCpmtHiLzPRaFkzTbzemAaHBk4u6QoLT+1+lnQDWCAfwclxWOckJI/yjXLrk
	 7mpYsC++6h0GTxrisOgX9pR2MfZwsdzXBpRlIuD21p+lWIu1So0GAVGlV8BGY4jq+u0eo
	 Eh5BkjCIWpipnmlOYB/iOJgr2dF9Ji+Io6WGbo5ZKaiNxo89hE2eIFafq2bX0LPpFMWsI
	 QMsB7XfFpCfmrFdhxWwiTXhuMMMK/okyyXpxrFOr4XRJQe19og+aN3DkPw9t/U0/5Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=k1WbxU0l;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1v6bl3wp;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA9606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2AA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=k1WbxU0l;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=1v6bl3wp
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGLYpBr1009165
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=60pD
	hYqz+P/R0qO3ME/ENMTcAYUA1szCxs7zb9TkRHQ=; b=k1WbxU0lT18UNmrfrowr
	y8lYOCZNHg2XrgLX4thXOcJ3RlUAb8SxGwHDhC8PUYAt217320UMYud3I5p4Srfm
	6QU4bFrowB3M0GGpHY1i5fHPKf0r/2A/9nafA3zaQt4eIk332NNa8mXs7Bbdw50x
	GZfTUn8r8CbEoyvCeZsHbO1sHQ1MFAUp2W75qr4SM59U+9IXrFDIarJ25YOFlOs5
	KSCyZBiQBywR8GQ/XJWEMnvcwGuVYsylasbbZEMQF23euFbKRbjtpOxTwhgLeF+L
	abnUcCxQdOEPOXg7VbMNASQC3fjzwuBCdtIrhjHTxJ/l9hgbTjBWUHePsKCTXmaF
	AA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qujhn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 17:48:49 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91eacf20364so80030956d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794869329; x=1795474129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=60pDhYqz+P/R0qO3ME/ENMTcAYUA1szCxs7zb9TkRHQ=;
        b=1v6bl3wp+bhTl3341mBPh+f6SHAGIDaLKD1bTfrwn/id8e/eHOeAbYeWhj8Q2nIpPX
         IWXvyO1G3msOQzCIxxGA/aDRe3WDDDjFpb1RkZP0q634agN8YoMfBAzm3SKWXPQTtREP
         yFTCBeSQNSISyoAnIqaeDIdGiswTbVopqQaDLTZWPffPcaM9X5kTNKhs5rHOlV9y7Jov
         cu6nTxvDZq/tWW2KHOVk14QvsYIavpnWX/PKB6lLU+PwnsEB6adsQDEF+N8SZjR7PFi5
         5+j7l9u3C4avaWiHQirZWTNupyMrtHWQ561bYN8a2ZopBXAsQFY29ljAQ2+mMR8r+Tdf
         H9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869329; x=1795474129;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60pDhYqz+P/R0qO3ME/ENMTcAYUA1szCxs7zb9TkRHQ=;
        b=N1GB9IB2X2EZOohUKoUeNLZrRMqsk/Ez8npCXd/JB9DwavNQC0I6f8p4jr45PMBseq
         q4TDs1sICOeehQLfKbXFg5w03K7mQKbG6eH7UXvwjMC/mhUtxiwrneOufSZJ2POgElTg
         /a3XIEAQQsGtZGR+90rgTYoK4k1gbOuC/9lc3BasapYbQMuu7I5lp/vRtnZPv1SIkHAD
         GpE5Q0QkXJzFQXtveIdYJo2L+ikPMRPQ+GRqwKPoFfgXQoPzGCMHV0To82lKYTIO9ygo
         BXm+DRfGft8yJMVOx8/pG1+vItxHpU+w+Bl5d+OWEsiWGxbmKTpcPdbdaAYwYp6yH5Mj
         ws+g==
X-Forwarded-Encrypted: i=1; AL+hErGn//LiwmeiZN67PijyNWMf34VRHw75nBhksJbU3xeavhnk1VhP2BB5f1PH8wx3mD6deLFRxAwGtCnq6Orw@vger.kernel.org
X-Gm-Message-State: APuU4Z8RTr78B/QLTFmKJGZvwK4ox4aN/0KduX2AbicdA+tL1i3/6yLM
	SQroHU94mC3Xp9QTT5CSB86g1lRHOgx+gqWwqx5zbQ817qYOzwajcOe/mQqpwN86oyzT1/kMDP1
	b77zq7vAbFNPrCt6T4qWxSKHs9nZtiu7EVeyFO6MNy5/bDe238mKfa9Sksm0rPtU=
X-Gm-Gg: AYBFou3EbuRJOsvuAHUWpXPcst6eKRJfHt+Lqknz4vGbELf3R/yQtuXI/8+oCqn34fr
	U97PDQjLyE82iJ24WPSatyMdfc8dUDgcBB876x9zdZhAE0h5S1WtGP0C4P1IihOq/3fc5l09dOg
	dpEq45iZRl0bTdl09pr34bvCPtZrrMFoKAvZAhmlHpZuJQJKWukaYNs9Uz/0swmuQrYk0Tjg8MA
	0LrHKpY7SVuca+rkdgJnKwtnVqUGCAUm2KvhjlyVHo2McXHt3NqU1Y6THnzeXruLXJyeZPYhASa
	FCVwJHZre2dmviQ/bGW3WXfnhTU9ccaAq+m9Sunzh/NCWkvqtQfhPPVw63szLLEXfI1Xo8Qkedr
	QFqzAyRscRKLomsu0V1waEnGmp/Ma0C8gzVI4vQZ54I0gLYA8xo2Nx70iQm54//rGI6ARK1UVwh
	+0jb4+GDzMxNGfAUkKGAyfw3Ks
X-Received: by 2002:a05:620a:2b89:b0:949:7781:6a31 with SMTP id af79cd13be357-94977816f98mr830657985a.76.1794869328827;
        Mon, 16 Nov 2026 14:48:48 -0800 (PST)
X-Received: by 2002:a05:620a:2b89:b0:949:7781:6a31 with SMTP id af79cd13be357-94977816f98mr830652185a.76.1794869328428;
        Mon, 16 Nov 2026 14:48:48 -0800 (PST)
Received: from [10.207.2.125] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c804f9esm954860185a.11.2026.11.16.14.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 14:48:48 -0800 (PST)
Message-ID: <cc8daec0-c3e5-45be-9af0-d58719a43953@columbia.edu>
Date: Mon, 16 Nov 2026 17:48:46 -0500
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
Subject: Re: [PATCH v2 5/9] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
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
 <20261116-uffd-state-fixes-v2-5-4397a0196479@columbia.edu>
 <38750bd8-6bb3-40f9-901c-44cef40a9de7@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <38750bd8-6bb3-40f9-901c-44cef40a9de7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb8851 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=tHa68p0SAAAA:8 a=qGNAzR1j6OtaQhhBgNgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-GUID: 67HpqsyVnBoSWbpDZhiJPxjbutX10Rel
X-Proofpoint-ORIG-GUID: 67HpqsyVnBoSWbpDZhiJPxjbutX10Rel
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX4GWDUTv05dx3
 NjHHFlijVDKViRn5vIaLMllu9VDr4CCYy2pVD/kD5St6uJQIjfJAYOkCNYLORQsjo0ZRsVfoL62
 QuBTGt+lCp/lbfx2rHU4sZ4j8raF/CeLJklseSbs6ZxXbpJBcBuBDbkblQ9Kw5micrD7yXO4VcH
 6if6v1EU0++Iw1bVpT0YzvxYE0xriLvsprbFE8dV51Uz5ggabLxD/X4rHWylf8XZrMzTfL5g+l9
 ZUNbriTdYalb4g2rDkIPzdxCWyEytPsxbfgUfeOjIV7wNRuSOPag8TGKuDdbOPRG8SXrHwO7uA5
 PgBo6X7a36e1VnIZRyYlgwkOxxL/okPfBNeS/ceYq483xDFpHS9SqSfkGiO9F2vW6YgDV9OojCT
 KJapG5QFPGvkQwl/vvjQC5+WYRRtEIHhkaHrD/3YnnAmGS7PjiKOWLR4Sa6XpbXYduwQ+NFDRt8
 z0QmK+ObOOXNeq4C5MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MCBTYWx0ZWRfX9nvWMzjmtz6e
 xLBk9c2YzPSn9EDvnnX20o5qAogGGzrHolIYmyqfYLHazK6R2fbV6yhplRMakAcB2cKdjHHVc/O
 O271Z4N7auOGNBuCo5hJoiMDXMC5nxbQzWKKL9hJ13Kr2ylZiW2q
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160090

On 11/16/26 3:26 PM, David Hildenbrand (Arm) wrote:
> On 11/16/26 21:02, Tal Zussman wrote:
>> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
>> make_uffd_wp_pmd(), which handles a present THP and a migration entry
>> but does nothing for a device-private THP. The PMD never gets the uffd
>> bit.
>> 
>> pagemap_thp_category() reports a non-present PMD without the uffd bit as
>> written. A user tracking writes with async uffd-wp therefore sees every
>> page of a device-private THP as written on every scan, whether it was
>> written to or not. This requires a driver that migrates THPs to device
>> memory.
>> 
>> A device-private PMD must be write-protected like any other huge PMD. To
>> fix it, pass any valid PMD softleaf entry to set_uffd_wp_softleaf_pmd(),
>> not only a migration entry. It downgrades a writable entry and sets the
>> uffd bit. When the THP migrates back, set_pmd_migration_entry() carries
>> the uffd bit over to the migration entry, so the write protection is
>> kept.
>> 
>> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/proc/task_mmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index ee7f509d376e..013eeea7d1a3 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -2520,7 +2520,7 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
>>  		old = pmdp_invalidate_ad(vma, addr, pmdp);
>>  		pmd = pmd_mkuffd(old);
>>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>> -	} else if (pmd_is_migration_entry(pmd)) {
>> +	} else if (pmd_is_valid_softleaf(pmd)) {
>>  		pmd = set_uffd_wp_softleaf_pmd(pmd);
>>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
>>  	}
>> 
> 
> This really should be squashed int #3 I think. Or what's the reason for keeping
> this separate?
> 

I viewed them as separate bugs with different Fixes: targets, one from v6.7 and
one from v6.19, so it seemed reasonable to keep them separate. But patch 3 handles
device private entries already anyways, so I can squash this in.
