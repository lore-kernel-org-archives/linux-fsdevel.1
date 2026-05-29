Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433D2475CF
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088995; cv=none; b=aMIF+4Mwky++CU1lQwFXQkv9aRumO2ZbVBzpkmtZRf+NQ11NEccbLchxmlygkePyerm6iqsW/6O05LmBj1f62jWIiAzsTfIAjaiWpRd0gPjHuXr45Anyi+arLFu4kYRlwuH+8iC+Gd1QVdPN3WdQpzkHCHDr5rOSPE3D8WO8zvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088995; c=relaxed/simple;
	bh=O5g6xMsaAevqgY/HknheMpshVHdDuxz98nTfkUwVwd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pY8W+wJ8jKI0dY6WisNSuStb+B2bX69I3tJinnWQgNVlC6aYNOMiq6HR4+eLkIAkB3ponGiExmbsEJDC1CA337UMrN/mPsik5LDNX0scu5G1T4yU36f58yaY83VCycCS9nU3ecrmwEqxnUeRbP2efwFT/ndofoec5ejl2MzLeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=oJVKQcRD; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="oJVKQcRD"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TKvVtI1242361
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=qoTz
	5OByYLW8ASq2hVpbIv/Hf6reoFP/KvxSksZK3HE=; b=oJVKQcRD+34m0jMSKpMl
	jBnema6zmL09G2+2vFmo8x9sHWu2Dkv91PcEJuZtp+kBmypWAuZ+o5Jfln9taBii
	GStJvRHKtxtlf55KXidP4D1OwHeMR2krZeS4FSzBZL84yMHMm9NsWh7aLP8JNu1R
	y0PvsO4Zzarid7swIWV0MYKdml7rWA/zPKL4XbJ0kiP3yC0R95aeXkYbTK6qDJAC
	VDaaWR9Th3JuOOvh/TNf887qgKZlz63+cU1stSEJ2cYNbWaCgFFL+zSNwoOxAWrX
	fixnJwqYyJpFu3zrVGGQwL5sRaFqJn44CRnrrtzpHARDU1AkNlxF8Qrokpdks1lJ
	SA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4efj9x032m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 17:09:53 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccdcc89495so40357626d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 14:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780088993; x=1780693793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoTz5OByYLW8ASq2hVpbIv/Hf6reoFP/KvxSksZK3HE=;
        b=A9DZLC34+G2TxxV6RDvNYdcYcjEGV3iT/LOYOW9+RhtX3+DgzSHcSo1vwqr/1cQrRg
         DtQP+EXS7Q5CdQBHPT3V9nUqmAHSfvtQJJDHHINhyB+K9lgKQ1VsETBmjIMrIjbdkwq7
         rUvI3RdKGnOPgR6qnsVOsngXtQuZoZusZdIJxHPEMHEQtsSmzQ2G3eQGR5Ez/4I0qezR
         qYBkdeUX4zvPuAmIQTBSPQ/CkeFXx1iyPTCJvkIMg+yuhbnyVgS9/g6fnNxr7l8O0NVt
         VlyzNHqRXQCbXag1+CmA+r0ccx+wS/EdH8H9cfVZbyqY3e0o6/3GI74s3PeaIz/7pZXy
         zD9A==
X-Forwarded-Encrypted: i=1; AFNElJ9JTWMWOa1wurfrN2X6clSKc/9OmDB1fRJ/sqgzqok2fbyLc0yLvRiv5DFcqECGw3Mu9hJZbHeaCpEpSNIR@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4oHyIrZsk6SzXzwyM1VssUqgtl68t5DVtO8PW604eoQYbg7o
	3g1T6XhZ/aa4jjXA24KW/ERLQ763a63pc/+lRkdbf8kkBQcw84lxCaqf9A2XMRwYlhZF1fJcWIm
	qD3/gXf37gdnqD7eI4b4FSJc4vOM4pVpXwlog5knqXI1IaB03Zdm+FgkJiIGRpgI=
X-Gm-Gg: Acq92OFQuBg4VR82NFBHXB5PI2j9RGkleeX7lo5tCqsiJUUMEhULRubz/tXDS9tum/V
	KdVHREcSp1tJ/yS3ERTCZuue8eUW1kPcKTrHItZzyVisz/VXNMLTv79nWi37QoWvlVQUyMCOeLY
	+d8RtmAZ8D3r0K/gEPA6LTbM+bGZNvMfDvSY47+epAT3iVPr1qHGAjaB7jTBnX64pA/NmJSmmXB
	PHx4Kwley5FqWnMmKvUu2zc0br8SE4UZn9tqGkdvQ4q2XoG+R/RLxtjwspucmYv/3O1YCpe3+t9
	HVutYcPxzU094qHV+0CxUnihsuGNsToGFgsQYUENH4o55kdt7rA6w08U9Wl5d0VaRuebGeNynxr
	MymDjZ7RH+cPPpxdnImeCQc1xn6ElBFhl0O++QNilKPryCmZuP/YgW1eDB+uHtjndBQ+VdnPj5I
	pyZ9Uqj2v7+a9M5k8XVkZBXvyOwg==
X-Received: by 2002:ad4:5949:0:b0:8ca:2711:f3ff with SMTP id 6a1803df08f44-8ccf03af60amr16675366d6.22.1780088992835;
        Fri, 29 May 2026 14:09:52 -0700 (PDT)
X-Received: by 2002:ad4:5949:0:b0:8ca:2711:f3ff with SMTP id 6a1803df08f44-8ccf03af60amr16675066d6.22.1780088992447;
        Fri, 29 May 2026 14:09:52 -0700 (PDT)
Received: from ?IPV6:2600:4040:974e:fe00:c8bb:325f:9d37:a5f? ([2600:4040:974e:fe00:c8bb:325f:9d37:a5f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0663fesm27208736d6.14.2026.05.29.14.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 14:09:51 -0700 (PDT)
Message-ID: <5bdfe6db-b5cd-4b1a-9dc5-50869198b834@columbia.edu>
Date: Fri, 29 May 2026 17:09:51 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jbd2: Remove special jbd2 slabs
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Theodore Tso <tytso@mit.edu>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, Jan Kara <jack@suse.cz>
References: <20260528171413.1088143-1-willy@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260528171413.1088143-1-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RKeD2Yi+ c=1 sm=1 tr=0 ts=6a1a00a1 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22 a=JfrnYn6hAAAA:8
 a=VwQbUJbxAAAA:8 a=0wBLy_mAbSS78rUt_ycA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: oTRiO9zLJLBBXkSK9wtGjBkQAfjewFl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxMSBTYWx0ZWRfXwfZb1DaJNg3u
 pUcwphevTgiIqgskvjTxgpH6EfTOpBX84Zv/hgFmKdn8MW+PdrGrxFQqymX2hltGrc5OmMistc1
 GoGqvY69waTF8RtRgEJs7TX1OQcb2cHqwebhbejlRylt0uGebs2G+9343aoEHLocfA9WBPdquoG
 41JxT7sHoxijozWhUS+kAnPLYxmrQQ3D4ZLe/Db9Aj20XF7IRlNzuP/2SIjuUfJiCEZJbaIJ3Kq
 p1cLjkip2/degMeXcP1gIBTBlmV8IoBXXsSu5xHvTCVy+fSUhVv9aTkihrtXHpu/NC03AOQCCfZ
 dcm5gKgi7nvUsO77ZNP7h2FKyQq9Q8C3YtFbKfNxqm6zlFP0pctCw3THLUQVgbabsD6wRM6vVS0
 A7bwT7L+cyiAAzNNsGMmFbp/Qh8G0xnt3QW3tnGl7kHLFMKjXHfjkPuFPU4Hm9gb53vZxOW5757
 kCDzUV8RtOJ3Wv/JeRA==
X-Proofpoint-GUID: oTRiO9zLJLBBXkSK9wtGjBkQAfjewFl-
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11801
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=10 impostorscore=10
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290211

On 5/28/26 1:14 PM, Matthew Wilcox (Oracle) wrote:
> When jbd2 was originally written, kmalloc() would not guarantee memory
> alignment for the requested objects.  Since commit 59bb47985c1d in 2019,
> kmalloc has guaranteed natural alignment for power-of-two allocations.
> We can now remove the jbd2 special slabs and just use kmalloc() directly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

FWIW:

Reviewed-by: Tal Zussman <tz2294@columbia.edu>


