Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556029;
	b=GpMM7xBiqvPRCOsrQecgkTAbXKz6JOu0nsteHBnLYSJTGHPb6Mv9bWTKdrBMRixWcpj/
	 R5o4fEcq+ffsJTapu9RUeuiZSIh8dHmb33rOjWkWf6Emy8Q+porL+jxzx2v7HTK4Q3+Gz
	 Eb6/RN3QRKCvuUYmsefcH+7B6iwyZYCv/otnzrQOF6xs9p5hIhbAO1fhAYJVG1Ckv87RA
	 pLbdZ9c8CimkWVHDSmJtdGghz5pOz9mh9MYRCADI4pPb5Rg/AYNKKlRJ4aiSqjakysuRc
	 YUbMq/H8BjqcJ+vxDBKRq7HcNKUi8tLx4F7f3sobRfS/lh+IW3mfcXbpARjtzGLJtVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556029;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rzs3vXtV1f6glRfCbRyWQ0qJwRwJG7R79LUnSb70XXY=;
	b=0Ge7qmOoy8WLrBAdtvwADsnUNr+14Ym0ohYrBITVPqCyZxZG50VVER4NOi+p7mQnq6sX
	 QwXfFKc+nCNrLmkS2Nn0dUor7W4JCBg5Gm42ppaABKmFd3KYIGNrQfzBj3XY725Tj/Usi
	 ERYuxxEA7snFCtcVQwWzncxW1wdMAQ44Y9WjQ/bTx4F5ngZbMtYmErHuPG+Td14FSXc9R
	 5e3rZ5fWzxdOEIKgtqLHpxZVk5HQ6EmVcqML828mPz2ZYFpWeDKSGaHEa36Qnn7V6fwsP
	 BUf77Anf6RHs5NaFtPqEZxMxDNepZUK+Pxy0CUTXKsyqgQ72pxJ3Oqg8YSLY0LDhIPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kSOSSptg;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=qs5iwDns;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED77E606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 21:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED77E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=kSOSSptg;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=qs5iwDns
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOLXT9B992105
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 16:33:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rzs3
	vXtV1f6glRfCbRyWQ0qJwRwJG7R79LUnSb70XXY=; b=kSOSSptg03PNAGft46fI
	0u8m3JFtsUQBmcPW8Y2leohVFkOf7foSZk95k8rFf/kFtHUSanpwx0t/ugSl9SFN
	c3NNzsoNngeXMT4KbGM7h/y1CMr1BLNUsVadlTTnbuOhmKJVAByccPWBiccHzYAy
	UBiWEXUXVzizUoT7E/zrXakX7q9pkGSLZvkqJW5lf6WKPWEWacErCcZASbtOzPGG
	3sW9wy3xWsbOtSDzEIKjUFed5DLQACMV1FRPeQrbWfaq/zMqO1sKf5F+zJqOUanJ
	NrIcQp/xzTCKhsNEK/0cB521vEVFeeNbqNYBoP1BGFWbwqpN+sk0j9ZqLi5SNEIz
	gg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j5bwjmkgu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 16:33:47 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-947a607ec40so486128585a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795556027; x=1796160827; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rzs3vXtV1f6glRfCbRyWQ0qJwRwJG7R79LUnSb70XXY=;
        b=qs5iwDnsetN6f44XCjqu+ML5LMoMj4pbZ0AHrmrIXPA9Okv+NgRmZBgSziyV94ZvYg
         rChh+SfJvG5OjG4Wo1opxFZmVLLMmPkw1buWHj3lPgxBTMCNot6AXu0rGiJfuekRjCZG
         +2mniKv+bzhzq4mZwcmkY79ajtZ08RBa6DAx5h5fM3AX8cOdU0vaKMqEO4z2aGNfG+kF
         TJVuuDhLcXxgg5bjV5R8wwIOQoX1ruO8vqv1N206amA1fELGmthmhYUkv4KTl7Gwn0xL
         dgcgHhvZlyF7qzk3XyC8N60G0vOpznAtaAQIuPuHeSvRAyi6Zvd/nn8Gu8axtIlXsfCC
         5kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556027; x=1796160827;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzs3vXtV1f6glRfCbRyWQ0qJwRwJG7R79LUnSb70XXY=;
        b=psixpWnb9tDinKslFqtyQXRnbQ/sQQCIwdx++GUDB1P1ZmrwFcEchXt8eIjBAA/0tB
         MqhCPHWzPgUIHSQvLRurwo/HvalZ6Vlp0I4BgVh9LWtuUTDtcqfTlmv3prLguruJTs5L
         1p8jMjTGYrsqBY1CB5dcdnqgU9rJ6ogSnBazHsR+5d6o9tR+B4J9q1Ii/EnZyuhyPten
         y2OUlWnIHQS4Pdfz2LpVUNlrHlxkQynpKUtieyUrL7KWWODYh58/bWfuAxM1hC+y3Dje
         aNGY2JvZv1qzFHLlWrTEKjNvCPlvJwat/vt9LJSxTl2440CFq2xfEk+39M1keWNCNbOr
         n/fA==
X-Forwarded-Encrypted: i=1; AL+hErF7eXZmGbrP/UJnthBDVDLZM/sUQjL/xV+tSbZeNCgVWUoiPzXJYuZkyH2OirxCDUIrTsKgNVgQaX+9LcJT@vger.kernel.org
X-Gm-Message-State: APuU4Z/EsV2KZjGDi+rXK/rleyR+MDLIajmto2JKi5zrgZzZwd6sVA+Q
	2jXErmH21PJEIXojL1EIxtIbgl5znkCGwNzvYECMxDUaxC++k6qHQU4xwywbsnY4Nz6cC9Swf8f
	kk8WF9lPo14BMC+2YY3LaigyJNHlT5jLypI71SiQcENVPn2GuMu3E/3I6nL6WG2o=
X-Gm-Gg: AZFdTZeFrPE3cV1TA/MNLqfAzw43wWIfrx6BarLTbopkiCApxCcvUoiYEDvzTWqGy4O
	1mRjMbtGlZN3c9EH9xYWL8YuETTYc2ZlVcsMPm5BAsCpWrqw2hzG1KwhcpJz/0G2t3TcYECATOG
	g21Fjy9qSTOSKqJz6ihGKpA0J2tkzbL7swcL0dkp5OF4rv5BnI63cMr67xsLrydX443MvcQT66N
	KM28xIBMwCbw1VyeAaszg0RRl0GyrafIHZUFIrwSI0sj77saew8G5Nfwi539/ik7QtJqr+BujuX
	xDSp+Z75qo5hfkfsIPuaUMVzv2oVdC7Wf4d/D0ft7a/ly/LO1GPARnPk4Fqth9biObZ4vbNB4Di
	KSdGgCB4l10RWlXmOIeRmHbS/12hiOMowU8hF907VpITfzIZL+kUvfFMdsZQu6EvP6A==
X-Received: by 2002:a05:620a:46a4:b0:949:70f1:de35 with SMTP id af79cd13be357-949ba825d86mr2914937985a.7.1795556026853;
        Tue, 24 Nov 2026 13:33:46 -0800 (PST)
X-Received: by 2002:a05:620a:46a4:b0:949:70f1:de35 with SMTP id af79cd13be357-949ba825d86mr2914934585a.7.1795556026424;
        Tue, 24 Nov 2026 13:33:46 -0800 (PST)
Received: from [10.206.101.158] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40efc4sm1138097285a.36.2026.11.24.13.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 13:33:45 -0800 (PST)
Message-ID: <da1f8a21-9250-42cc-bf87-072eb28ce475@columbia.edu>
Date: Tue, 24 Nov 2026 16:33:45 -0500
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
Subject: Re: [PATCH] mm/filemap: only drop dropbehind folios on uncached reads
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Tianyi Chen <hi@tychen.cc>
References: <20261120-filemap-dropbehind-read-v1-1-a373ac3fd993@columbia.edu>
 <awDGsqkIaasAjaNB@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <awDGsqkIaasAjaNB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4NCBTYWx0ZWRfX+O68LBxRiCHB
 aeXGqolooIaB71+eKN1afvOC3S70o0fJw1BsiPUBRwV5S3qZl3f0mhdggoQCBDjq1NSi/uVPQgo
 m0EEo80wwHyGsia6wUlEUrxrvZfCQpn+FUJf65fD20fbDaLVR/q5YKe0N8ml/MvjLvkanTGhJlH
 oSRDiHTK0v+Iw5ivZmfvWwoNMXNK+coG1P2mbaVzBaXMc1IZcv+ur81hqL1okPwdvBPTzxKRWcW
 VhF+cz2MwZCVF4bFBPui/ASoXVhFtziEWwdcTK+qcg9cKPBhJGdAqKYHVUrpwD9ZrA7K3BGuql4
 /Ekr10JW6x2R3hEqRm2aLstSHqWn0bvUUJyARBIBllTde50Flw8+D3UtN75DzRBlUCueuZRhrqw
 Ps4rp6E0zigCTVlusiBNcOgTFrxuW1F7S3LAXW/dRYV3rRUQeaOt+CTVaDGV0VfSkEdpw+hbSVr
 UQfqyYYtvEupMlAprFQ==
X-Authority-Analysis: v=2.4 cv=VsC2kO2n c=1 sm=1 tr=0 ts=6b0602bb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=jlrA_JLHis1J6U7XA0UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: TSHEL3SBElERhS9MP_rTGz1R9g9bxCs-
X-Proofpoint-ORIG-GUID: TSHEL3SBElERhS9MP_rTGz1R9g9bxCs-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4NCBTYWx0ZWRfXyN8siNwEWEUg
 11SH/AMrSun/+jT5hcLMxHvsBIsENK2iiyAyGo815+LJ4O9hmoxpUKvRmAmn/ff3A0A7VULyAne
 ZXgInEWZXuh/OCbjYDVTryszD2VUx9KN/YaRMvUSRHXHEPzfIQth
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=10 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240084

On 11/20/26 5:16 PM, Matthew Wilcox wrote:
> On Fri, Nov 20, 2026 at 02:51:17PM -0500, Tal Zussman wrote:
>> An RWF_DONTCACHE read marks the folios it brings into the page cache as
>> dropbehind, and filemap_read() drops them from the page cache once it
>> has copied from them. Readahead can bring in folios past the end of the
>> read, and those stay in the page cache with the flag set.
> 
> I like your patch, but now I'm wondering whether RWF_DONTCACHE should
> trigger readahead.  Yes, I'm sure we want to use the ->readahead entry
> point for filesystems, but I think that an uncached read should not
> bring in pages that weren't specifically requested.
> 
> Something like this, maybe?
> 
> +++ b/mm/readahead.c
> @@ -590,7 +590,7 @@ void page_cache_sync_ra(struct readahead_control *ractl,
>           * readahead will do the right thing and limit the read to just the
>           * requested range, which we'll set to 1 page for this case.
>           */
> -       if (!ra->ra_pages || blk_cgroup_congested()) {
> +       if (!ra->ra_pages || blk_cgroup_congested() || ractl->dropbehind) {
>                  if (!ractl->file)
>                          return;
>                  req_count = 1;
> 

Hmm, wouldn't this badly degrade streaming reads with DONTCACHE? Readahead
wouldn't bring anything in, and reads larger than a page would be read in
a page at a time since req_count is set to 1.

If the goal is to avoid having uncached reads bring in extra pages, then
the forced read should at least cover the whole request. But I'm still not
convinced that we want to completely disable readahead in this case.
