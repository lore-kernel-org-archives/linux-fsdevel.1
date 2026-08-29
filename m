Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F940DB38
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788019799; cv=none; b=McMotOkXDbtHr5iHEXX95suu8+0oHjlsSJ73PnVjGhP2IrsbAhha5q5uyU+/Eyy6LtA54ZQPZwP4FvCG1+ImA8ytIAnZG6E4CXfgO2sBhh5tW61Gws1vGctSV4Q9QR+immAI6RC5I+xSbz5oUzqlb4tKMCO4GzNgWI/+l+tc/ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788019799; c=relaxed/simple;
	bh=iUjVyOe/jREG2GHYVoZLwE8SqUmLFyehS+XSyQKX4wE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fZ204WcJZg0Kgu75DKWNHTVNcS7YIpVaI9Zabgce+ZX1mD8/eIAw3P38n20PkrIMuCmdSrePXHpl4Ryja5i5xSMbM9+8Nxhaa6A265iaIGYZljDVLhtHA7EDYhh6pB2cELQFGScvXPzq68O65aw1KFGOma8Ubux1Ar49mdEnPs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cCuEdNbs; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OATNHY6g; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cCuEdNbs";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OATNHY6g"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67TEaNT51021940
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 12:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=+l4c
	yquDZdPm1CRZEtsdD5WsyEM3FltNV4XbzdH7Ws0=; b=cCuEdNbsSPHxSxNaszD9
	0bwjJ0fU1sRllrQXjJOZdhZoZuCbl2ZmpowDV89UeZunY+TwnqRjnLn4NFaN70NU
	OErugq2WxJ4DlIbBPh74RuNVt4NM0z0vg3cnRGmNrf8ncWLeqVQ7Ml9Pik6Oxa18
	g7fSr/qowFZk+Lnu07M+U4Kk63HJOGB9JgLXGcJJuM4CVBnQGlPY/r01B8brU4Kk
	qq2uZzIUQeRvzdpkwQNw8o/0WhG7p3O7KCTXZXiOoFAYIlLqufkLL1CId2ZlUzzC
	oo838p6yO7ct4Q7epkB49MukSs3qsnS1jUQRtp6M8eJjpI7XVqiCjcRI3iSRPr9P
	dw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gbrfbtbh0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 12:09:54 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fa5c5a4a6so47327501cf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 09:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788019794; x=1788624594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+l4cyquDZdPm1CRZEtsdD5WsyEM3FltNV4XbzdH7Ws0=;
        b=OATNHY6gju6XS13YHaLfIpPzox7LI4OxkOTeGrpk7RMixuYEaebAJ8vBrNXqYs6+um
         LnGgJURx6SJkuFgmnY+cJMq3Zyy2ba3GfWHXxJNr3S7LVvVMDgcngS3wRhnL4qeMDZ0R
         qghPJwfX2Wix3m7dYa0JlG7L+Rh5RtL/w3rrGjWlsq5rofYpSXGut8GVXiXhGZpjAtfy
         tek4U6rLImbIUuDM9uYAoXf4J7zeiAjLlj9+y1Vw0hu6LGxox8n/rfVEL4GfxT6sny4h
         tvxb7DSgJsLeFcRqYgcN3SS/uxBIgCGTgiTvY69QuHADD+015Zo7keM6WXkhtsVX2iIV
         SNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788019794; x=1788624594;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+l4cyquDZdPm1CRZEtsdD5WsyEM3FltNV4XbzdH7Ws0=;
        b=ayAu3dmqEPE8Oq6AQ/hHecITJRk+gF5fAsE2u7yWPMOFqJBy0gpSmFFg+hqjI5BRcl
         p6hWaPH92jU6rL/cT/kwCY7fpMlXGE+tqRDeXGxgdzC/1vs0rmaDxKXyXmMm7lMASaQg
         7gt9FSGJ2dymFQrVXp34vCPNB9Efkmt6dAPt6MrN9WRzHbjDUdK36zN77C+LEpalLIOr
         CYrplA9BgkHA+ymCh+3DLEmmfhSK+H1lkN0sqleJg7Dxuk2jGzRiyeUzuig4TmLLcqo7
         DipQDfm9DrZvpAGCDQYtpeR7HJTTii9jy5TdYgKfYgv8bHtAKibaRIO5Pof7LsWUvZ5G
         8tjw==
X-Forwarded-Encrypted: i=1; AHgh+RqDjr+GvH/YNxDf/SJ7tT/45MPQTT9iTpi+ktaW+ulD+iKc4+YrDhNWe7AiMzCkAgSnTr2sNgc4VUwWfC+k@vger.kernel.org
X-Gm-Message-State: AFuF++kyJoKmVPA2Vq71go/+HlT7J5QQqkAbljgGx9OVHChUMay9b8XA
	PegikXQj8gzvoYSXT7nH0Zeq2IocKwLt03weUPAnNcCOtffyZfWJ0IaANrO35VxkroMJ7AT3VdD
	Y4VECtiFvND17nDmSJYoeQc0wB0XZoXzk5upiOWIwK2gnHWlOaTIe0GpUKguEqGG+PlaEZB7NrQ
	==
X-Gm-Gg: AR+sD13wddGoFJpi1xLWPMpG//Lld5uFX7ZJieL6wDwpvA6uZ+X65OVH06QOCN8/qz3
	xBivWh6/r4bQ6U3MfWd1aLX/HAVHMN5kUHklDuTeo983FzYvTS5lVZo3wfPQ1QLS4sRGXEbLHvU
	6SP1qC2oPM9bYnXEe6fPplWkHRvdT6+P9CjNOsUjm6gOu4FRrriKRULEr7usLt4dF474cfdp9qG
	SqinJUdwHGLiPGwsKn7+8Zg+O8sGFkXWGfyFzKSVnkJoV4j6TettakNx0Q3+SUE9PyK1CbyZPl4
	WMWLU0SshwTKh12cFmDqzS0RFUs223UyvdVlKl2CskfpLZ2Vez2AY0Ex4KvMeTApy7ilme1vfz5
	SgJJQCwjeJZ9pSl3lvkFPKGuJEiPQpnSZWoz20H60meVZcfc=
X-Received: by 2002:ac8:7dcf:0:b0:52f:f5f4:e9b6 with SMTP id d75a77b69052e-52ff5f4ea4amr82043451cf.20.1788019794349;
        Sat, 29 Aug 2026 09:09:54 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:52f:f5f4:e9b6 with SMTP id d75a77b69052e-52ff5f4ea4amr82042871cf.20.1788019793958;
        Sat, 29 Aug 2026 09:09:53 -0700 (PDT)
Received: from [192.168.0.175] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b955e7906sm117685355e9.1.2026.08.29.09.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2026 09:09:53 -0700 (PDT)
Message-ID: <37fc5d8d-f226-4885-967c-3e873aaa662b@columbia.edu>
Date: Sat, 29 Aug 2026 19:09:51 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: filemap: retain mapped dropbehind folios
From: Tal Zussman <tz2294@columbia.edu>
To: Wenjie Qi <qwjhust@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org, axboe@kernel.dk,
        trond.myklebust@hammerspace.com, qiwenjie@xiaomi.com
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <178801880005.667254.16521776519325089161.b4-review@b4>
Content-Language: en-US
In-Reply-To: <178801880005.667254.16521776519325089161.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDEzOSBTYWx0ZWRfX25+p9N8DtiTp
 jO4FUGaks0272q6RNNDM/46cRgIp9i6EGhogLf5PY1VqtqsDl6ehpuK3ekev22sBh4Lv7qB6/Ni
 ecqInTZMecRrmYKK1tw0wyYhN+iJnWLBT7MROPv+gBfbGA/qm1gl
X-Proofpoint-ORIG-GUID: c5NGxKJ1VGwOVflFsgNPZPLf-boiOm1l
X-Proofpoint-GUID: c5NGxKJ1VGwOVflFsgNPZPLf-boiOm1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDEzOSBTYWx0ZWRfX1Hf6r+DAK8LA
 7v7tj0AJxH9oizQOVzQrplBCNZ6edvLPSiMzsTmosvt+CATXxtlRhY5O0VY91gES5aEWFkmZraP
 VZ03CsYb86moYFFWPFDMIwMuib2QJV6yWIgLfCfuEFZ0fqfKb8XQuN+N+6RgJ1iea2R8233BK32
 hyxUJuKD9hkxuLH3P7deiUZ747aCuRTT455Tlq5a0Rl6SIlF2uvwgdc9wLEgAbOXffCW3THhioN
 Io96Q+IvciyH2ag1vUPBmB1jJxrwZ9DRaZpZGpC2X4/MLs3wmEm8AURP0XtDCaUg3/pMqVAYwMh
 QJc68zoJBD/FWvG4Gkbn43dB91GSF0sNd0MlwW5zWklUsrSlr9GJZ5gEwryXr3HVPT0tjJv0J/a
 QtL11iSRXkJP5GJ31v7RRBYaH79Y00Wdx7sbDTpmrd74D5Gkdn3UUQ21Ed8fpzGyw32yCjvbu7S
 QMa2MKvKkgy9uaZT4ZQ==
X-Authority-Analysis: v=2.4 cv=beNbluPB c=1 sm=1 tr=0 ts=6a930452 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=pGLkceISAAAA:8 a=IeNN-m2dAAAA:8 a=B8_SjZw1YBUlbbQ4_qUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11890
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 spamscore=0 lowpriorityscore=10 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608290139

On 8/29/26 6:53 PM, Tal Zussman wrote:
> On Sat, 29 Aug 2026 20:30:47 +0800, Wenjie Qi <qwjhust@gmail.com> wrote:
>> Fault-around can map ready dropbehind folios without going through the
>> normal page-cache lookup that clears dropbehind. A mapping represents a
>> competing cached user, so retain the folio instead of forcibly unmapping it
>> when writeback completes.
>>
>> Unmapped dropbehind folios continue through the existing invalidation path.
>>
>> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> 
> Overall looks good to me. It may be nice to add a sentence about the
> safety aspect of this in the commit message. Maybe something like:
> 
>   folio_unmap_invalidate() may sleep if the folio is mapped, so this
>   also ensures that folio_end_dropbehind() is safe to call from
>   non-preemptible task context.
> 
> Reviewed-by: Tal Zussman <tz2294@columbia.edu>
> 

And maybe:

Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
