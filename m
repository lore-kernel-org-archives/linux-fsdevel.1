Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4F41C2FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523353; cv=none; b=j9thH3kGM2aT4ROvDKC1OdpetRMqQugFuoGf0EMu8Fw8rVPVWHN0M+PZsTYKdg2paCwMFhJlfk8qjnfsW/LDoNBLeKiDxQLlPb/qoZcpDpJvgQVTQDFZdfiwrzLK0TTCgmEI13rFyoLulUJdnGbSDwUgD+Bg5U+IJgAyWS9RS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523353; c=relaxed/simple;
	bh=iIJyvYdb0mvMcIzFudM1xOo/1cP6jmXUp3LxZlvJGt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYlRzg5kSmL4ig90l61lIAkAacB3GaSDjEx0JgYMY2SBj4QE/4yOyPaEaa798iCe/kpfPdZdh69VHoWYIZfy97F2CAaxC3w9P4orqj9wGvU5wzbwt/U53hQW6w3xJFxWRSZ874zzhuk6bTvuOP/vxu4ciFu//r7ThukPAn2N5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZnvkrCI7; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZnvkrCI7"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BHvnVT2575601
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=nNMh
	459Qb0NBOZf/rMrLKlp+eY8nirwVRRGfS/oMrYc=; b=ZnvkrCI7Es9dc9+kR4dE
	Nb8psOyeAAu8H1CvJTJ8r5ca0bG4Kd08AL8wqlGxZf79ol0E+6aey1eMXP9AsQMh
	L3NJb4cOM7rqH2DrleUAJ/N7Xu+gWwvW2r13sZBRDhgQRSaBqHLKwmtGc7sGTnBG
	pzc+l9DgH2CVbPUhhUdUokZimUJItAKr7B6VJ+vTcansyhZ9cvOu+tX8frtiIhzP
	8mI++TFt9lvGgOuoo1N5rLWNBRymmFivAZ2U3+rdr0exTevZl3sNg46C7PMii90D
	ZnjVAs8FrAFZH3pOUaNhlnRO2kgdLn/KPgQfMlfYnrzMokYlMavoTkTI8kJcPE2O
	Mw==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e3k8n0esm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:15:43 -0400 (EDT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bdd1ef8648so103777427b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523343; x=1779128143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNMh459Qb0NBOZf/rMrLKlp+eY8nirwVRRGfS/oMrYc=;
        b=HzauZsPas0WRgVWerWSQGHGPRmhdfEktD5+4q7oV9hCL3Y35OiUcilxCGvP9AMI/Mb
         QE+aSl0ylzllzEcFlRqKP/QTVd5/YwndHpOpHQQHfo0qBiS/kIHcJ2en3y1MS2Gwf0FF
         SakcwcDJzfxA/l86j8CEguyKZI/yjolR83GtoeNikh9nEM5BmutNXoRVbW4bf0K+f8PS
         pfV00+u/s1+uxrjif6Gp+xSO+MWs+LDWMhIkR5xS51jMPDJDyrjvvIDY0w/gvVTsJIMC
         O7/zbjAXGEExpriAiTTyn2DSGmtnuoWVm279uNAog3pHTD4SVOz5Zy2K251ip1URkrZc
         lH8w==
X-Forwarded-Encrypted: i=1; AFNElJ8egZFyC+ltTAuPkIVf5IlvOlDuliDXyxhor9NLHOU5zDzWRpwLk6NNpP6JIcfZoEqFQDVlW5NXYcs923Hv@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVex1vqk6fUN3XLzu0vW1AGmAIrV8U9MYU1lJsCOts329fEYg
	Yzov/Z/G1s9jReKt+OX/3XX5XGCyokOWBnjqOGF8RjTPr+UdSem19TOHMYXH1vUN4Dxmf4iU8vR
	4OgixHVL97kgUU6AsqJsUwQDOr/YFRJVOZ8cXPOEp15ueUS8nfcEbBkhDwjJUn9s=
X-Gm-Gg: Acq92OF62NKshlHkVhpTPu+lR2147FBk7m/3NedoZ7DqM2GXY2naGq2BEe2zKJE9rjH
	BJ5t0ZUBjFqPQ5uCMu718a86SWtzfBYhu1V3FJNq6+zoicayonTvgSGse9oDRtiTFZFhfV8DbJO
	KWMiOS69D2bj8Qt4lwo52QsDTRTeo5aaWBdEza2BEbkc6/X+jKQskh8prrYSUTEMT5cjaTsHwW4
	VjKv47WOYUtU1DuCmwutfcEJ900HaLa3Gb3Tn2eZTKs5ulYZz6jCiqf6jjQxZsvFncvr/T7RT9L
	tFH2679PTsaap2iMOjHFk4l1lzLPS97fnnklBpenioIsxReV3822Qvtu3N2Uu9u1WQrnDkaywmh
	0fxr59bpgSfp04HPAePyW3kEqzRtYIfkxPam6
X-Received: by 2002:a05:690c:6983:b0:7ba:a726:57a4 with SMTP id 00721157ae682-7c10567accdmr99156417b3.36.1778523342831;
        Mon, 11 May 2026 11:15:42 -0700 (PDT)
X-Received: by 2002:a05:690c:6983:b0:7ba:a726:57a4 with SMTP id 00721157ae682-7c10567accdmr99156077b3.36.1778523342322;
        Mon, 11 May 2026 11:15:42 -0700 (PDT)
Received: from [10.206.149.208] ([129.236.224.3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm153053607b3.0.2026.05.11.11.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 11:15:41 -0700 (PDT)
Message-ID: <5280b6f9-e6d7-4854-bbdc-ed5349a478ed@columbia.edu>
Date: Mon, 11 May 2026 14:15:41 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
To: Jan Kara <jack@suse.cz>, Vishal Moola <vishal.moola@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
 <agHPIcZHHyzBjcGN@fedora>
 <s6hnqm4bbi5j2ergudihydboj3uw7gsu7te4dfmjgv2qeosfbd@yvhp5oy3r3b6>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <s6hnqm4bbi5j2ergudihydboj3uw7gsu7te4dfmjgv2qeosfbd@yvhp5oy3r3b6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE5NCBTYWx0ZWRfX53qDq1TPgdsU
 4voHL3P4YJmYTyyd1fdrB2IcCReo5k32m72Hc+jGWZChqKQh/G/VZbga+kOvG0ibFtkuSTf/sgL
 LCdjhI7ekTRnv5yF9E29t1BHWTgFJIkLy4Er3hN4Vf05afW0bUM0As9jRdYcudacmQSHHkMQyC+
 xnymc1Hpx9g2fLobC6TT5p94Qt4p9oXWpCjDKh08NGrd8XCr+Vcq78fMYja6Jc4dIxy+bcRfoDI
 0FuTY6uYCd5XWWsOl4MX2kk1PINCXZi6WcGN/DJXSyt6M4PGHfYLJX1LhMGgshswSXxENL1kzbr
 yZyCarWsqAnvFdEbL1uY1vFvmWultLN3bY6VMIyGIs0f/daHzLnwlk9XCSmEef8UgO5EYJTbjDI
 GZv7mrwcFvGhnnUxlCZkDRwQd1bROqw18tKg1QnLUxLLyUqquh6iMr8cqn1E0CPKn6qAX5+GlwS
 1rMcaX7WIXLbYHVWQqg==
X-Proofpoint-GUID: awtV2eXRh5TAlQmo7PgyXFI1PMEejsfB
X-Proofpoint-ORIG-GUID: awtV2eXRh5TAlQmo7PgyXFI1PMEejsfB
X-Authority-Analysis: v=2.4 cv=evfvCIpX c=1 sm=1 tr=0 ts=6a021ccf cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=uvjyHnA+wHnVBzamt/20/A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=5NEz3i_17GglibqS5w4A:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11783
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110194

On 5/11/26 12:26 PM, Jan Kara wrote:
> On Mon 11-05-26 13:44:17, Vishal Moola wrote:
>> On Sun, May 10, 2026 at 05:54:17PM -0400, Tal Zussman wrote:
>> > page_cache_prev_miss() is documented to return a value outside the
>> > searched range when no gap is found. However, the no-gap-found path
>> > returns xas.xa_index, which after a successful loop is the first index
>> > in the range. As such, that index is misreported as a gap.
>> > 
>> > The sole caller, page_cache_sync_ra(), uses the return value to estimate
>> > the cached run preceding a sequential read. In some cases, the buggy
>> > return value can undercount the contiguous range by one, shrinking the
>> > readahead window or pushing borderline requests into the
>> > small-random-read branch.
>> > 
>> > Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
>> > page_cache_next_miss() when no hole is found"): preserve max_scan in a
>> > separate variable across the loop and return `index - max_scan` from the
>> > no-gap-found path.
>> 
>> IMO, this way of fixing it hurts the readability. I'd prefer something
>> similar to the fix in the original commit. Or...
>> 
>> > -	while (max_scan--) {
>> > +	while (nr--) {
>> >  		void *entry = xas_prev(&xas);
>> >  		if (!entry || xa_is_value(entry))
>> > -			break;
>> > +			return xas.xa_index;
>> >  		if (xas.xa_index == ULONG_MAX)
>> > -			break;
>> > +			return ULONG_MAX;
>> >  	}
>> 
>> If I understand this correctly, couldn't we just do something like:
>> if (!max_scan)
>> 	return xas.xa_index - 1;
> 
> I think the easiest to understand would be to do the above two explicit
> returns instead of 'break' and change below to:
> 
> 	/* Return start of the range - 1 when no hole is found */
> 	return xas.xa_index - 1;

I can do that, but I think it should be consistent with
page_cache_next_miss(), which does index + max_scan. If the xas.xa_index
approach is preferred, I'll change it in both functions, and also get rid of
nr.

The nice part of 'index - max_scan' is that the kdoc describes the range in
terms of that already.

Thoughts?

>> > -	return xas.xa_index;
>> > +	return index - max_scan;
>> >  }


