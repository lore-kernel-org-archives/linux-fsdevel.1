Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7462989B7
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158390; cv=none; b=QF8svUYRQ+M1WRNAaIIoKph+2lae89VN3GAUiJzXN0nVs6TfYQ1l64anG8+ksXCDYQecjre+T8oTRWceVO8lGfq8I+ecwjwxHKdRR2/cPQTWJNRj5kg3ScRUCmWS34a89O4yY62RyqZI1tHEsnnb/unWhlOm9yScopvez2V47eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158390; c=relaxed/simple;
	bh=sxuqQOtpTIhnsnruCurB+KsFnny3NxywxLqvf8D1RWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4M0rvwhtpqy8zwoZbFjD4tvLLHhL0pqzfzZXCEbtR2cfuSU4oUOx7ia48JoBOHbpb/ShotabTAlJTCseKgHg5AoZbG9XDs9R7MyH4k0gcvouocEWWIf48vJ4zZxZzAkbt7zzAibmkRIinxBbnrhEp33OvsuZgG+2hvhPcabMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=pBQ67VJ4; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="pBQ67VJ4"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632JSY8G407632
	for <linux-fsdevel@vger.kernel.org>; Thu, 2 Apr 2026 15:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1Wma
	Gc9Te9yz0Zibs0J92PxP2axqg3Ucqwb44WM0s3g=; b=pBQ67VJ46+SO5CMoxNw4
	10vf2BWyi8pCFVjd3/INcGVNa2Rx4KtH2rep92OIs2n1Z89uB2lTfNviu+kbwbPd
	DjAPZzTjPlQJxf6aaLj8+55swS1/gYcctqfhFYgYzhKlR/0crQjLSGCN03sDQss9
	4tZHP4P+wILE7QdbAjcgpe5P/Ff4my0GTEA5qtpp8D85WKZQFROup1Kp2l2MpjiS
	9Yj3nNMZauc2U5s34Um9d9jiL/3yeihYWBvWrqrsZRhGbHQbSjGDG8Q5TIp8ZYZM
	cU3Bx2XRUUejxzakioCYxP6G9EC5W5f3QZfaBWft5Fh55KmbHTKoFuO3cCmIUNz2
	vA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d96kcsx4d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 15:33:01 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8d3e4c19307so84808585a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 12:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158381; x=1775763181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WmaGc9Te9yz0Zibs0J92PxP2axqg3Ucqwb44WM0s3g=;
        b=TOr0ua5WLi4yqHVZFbbbtH8dWWsKHsykDswWKDKGymc56Wk71A2Cls9lg5DqwvDaWz
         2nXsrAFn6mU582C9X5thXYPKz2vqICU1Sehc9GKufwhMh3OIUwowVeOMJKRgR/3zCGoz
         wc+j5H5pdEoGI7KNh9lyvUcigTUxIzegq9etHM7KCx3khe9Nwr6Dqm0Ivdz0CZMY/vvg
         Oeti0QYEGqh/vlCq1DuW6Sc0XZV4VNjaHfEx/gZ7Sru7+3wbXaRshG1iTvuOUo7/gGb8
         ObZOt/LWCmKxLZI0Fvbuz/43sSrwWfOUN7F8/Gkb1J8l2NdVFAXTOyEwC53xUXsOy526
         HEpw==
X-Forwarded-Encrypted: i=1; AJvYcCWepP/tga73TSivQpr7meumFkIcik7XmmE2hDeYMgQOIqrLk6nbq0sdnSJ16P2Gl/0HIAjJrV0A3MrEzdVT@vger.kernel.org
X-Gm-Message-State: AOJu0YxpPfPdUoRNH6WUQ1wh5zSHZRmzrsg3T13gLiIX27PqIuqTLP2y
	ksQyGjt8wDFA2nKGJdr6QmyUKklWd5AkQljcFG29nHL3DTJkTU2GhpUZ3pkExaie3lv0mSE3RGO
	Ox+/KkzG6cKkQhvAPmzoaKvDlM3AH1xSHibhe7mqLzg8YYn+ZDo9jAvOsu1nZs/Y=
X-Gm-Gg: ATEYQzwc8qWWmtg7LfuilYUDwuHRdLWlmUzPSFbL24ltxQzRWOvp5LhsnwSvylqznzh
	8t8jInWj8baH2Wtxo0i5ql09sROGo3Z3XY9LO2t02db/mZ7PZFjLO0he5ovSdAMh0CTy5XF//VU
	gFGZY31IAC0JZ2jXRvHmuJgNisua4EruCe2LXCfhTCubLfcVnRunukCvN/4PsHaf1Sti8qFtu+k
	bjgS05sAZLqh0r3athdYFYtyvO2WEPzi+V/Hf1W5SH/sxaQd/QwO2NgOcwh8bgFKymBNYRXjRZ6
	P2hpd8uwXbsssyHPYUCg/r2dbq5peX5yOTRGAjgQn0PA19m8YghJH3lQ/tFbPOU4U1ZirOvlBna
	AXU23CUHJj2tiHzHlW3yn/d/i1Yq900n0oINZ8ic=
X-Received: by 2002:a05:620a:298b:b0:8cd:9599:b7cb with SMTP id af79cd13be357-8d41c6ac558mr84737885a.25.1775158380969;
        Thu, 02 Apr 2026 12:33:00 -0700 (PDT)
X-Received: by 2002:a05:620a:298b:b0:8cd:9599:b7cb with SMTP id af79cd13be357-8d41c6ac558mr84732685a.25.1775158380358;
        Thu, 02 Apr 2026 12:33:00 -0700 (PDT)
Received: from [10.206.121.101] ([129.236.224.148])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a80680dcsm283333085a.26.2026.04.02.12.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 12:32:59 -0700 (PDT)
Message-ID: <6a171abc-ebd2-4ddf-8c36-34c66ca42043@columbia.edu>
Date: Thu, 2 Apr 2026 15:32:58 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] userfaultfd: introduce vm_uffd_ops
To: Mike Rapoport <rppt@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin <avagin@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Harry Yoo
 <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
        Nikita Kalyazin <kalyazin@amazon.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-8-rppt@kernel.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260402041156.1377214-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: J1spIJeeS090KZFooKajBWkLiOI_1bTj
X-Authority-Analysis: v=2.4 cv=bMMb4f+Z c=1 sm=1 tr=0 ts=69cec46d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=k+Kg2sH3hDje3YXt6xVjPQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-OANyN2A5GHSoQQpHzcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: J1spIJeeS090KZFooKajBWkLiOI_1bTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE3NSBTYWx0ZWRfX1R68ful8g4Wk
 +X7/tdmRSrliKUJRPd92f+fuyibB4kFnd4VEW2BJOsAnDaQyoJJGxZWzi/a7fLuosC71ewjYYIy
 PHqh857j/1Rjk+dtNGUgNOcJNdj+T+26P5E7/qEXyR7ZziaUFFLypIa5fVgy7TOgf2ORZoXHjHy
 7Nx66z7ca2rZte2uMXvB52R5C+t5Bx8A6EIdbi7T0t11EuEmnNfPavT2An6AuiYu1qpKgJhxN0Y
 6NJpE51VqBEMp1ptVmxI+gRWHB2bPIpqOu1hxfGyghDqPmnQk+S/AZ6ObcEEeyXmU5Hpnpk53fc
 BDmImB0auBpRoV7OqT1GC66n3s5F1OlsMlYSCR9chpfziDGhIalQU0iPasalsYRd9Oi+1TwocLE
 zfSzGePZWFdr8Q6MAG1jbjh35S4+juYwa/YK/nDPFO1b0DHFIl+MM6kQUuM4cqsGmMU0avzBck2
 P3tOHqs606JVAILJFXQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11747
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=10 adultscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020175

Hi Mike,

On 4/2/26 12:11 AM, Mike Rapoport wrote:
> @@ -2021,34 +2040,33 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
>  bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
>  		       bool wp_async)
>  {
> -	vm_flags &= __VM_UFFD_FLAGS;
> +	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
>  
> -	if (vma->vm_flags & VM_DROPPABLE)
> -		return false;
> -
> -	if ((vm_flags & VM_UFFD_MINOR) &&
> -	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
> -		return false;
> +	vm_flags &= __VM_UFFD_FLAGS;
>  
>  	/*
> -	 * If wp async enabled, and WP is the only mode enabled, allow any
> +	 * If WP is the only mode enabled and context is wp async, allow any
>  	 * memory type.
>  	 */
>  	if (wp_async && (vm_flags == VM_UFFD_WP))
>  		return true;
>  
> +	/* For any other mode reject VMAs that don't implement vm_uffd_ops */
> +	if (!ops)
> +		return false;
> +
> +	if (vma->vm_flags & VM_DROPPABLE)
> +		return false;
> +

Doesn't moving the VM_DROPPABLE check after the wp_async early return make
the issue David raised in [1] possible again (i.e. moving swapbacked pages
into a droppable region using UFFDIO_MOVE)? With this change, VM_DROPPABLE
pages can now be registered with uffd under wp_async, which allows
UFFDIO_MOVE.

I think the VM_DROPPABLE check should go right before the wp_async check.
And it would probably benefit from a comment...

[1] https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/

Thanks,
Tal

  

