Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9033A9C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779732391; cv=none; b=BzimA9MNDyf8atF6GQR01tDv3EnNljrK9Bp2R8Rrtb6n1WM1eWH6Q+EuPI4mBlKR0S4tBwhn9LWosEGsluNi79C/+0j77EiSf7JkxRiTsclXDWnwOMUlvOZ02j/Ug1h5wpFTvUCYneTRccMBpHNmnv/7O+wOYzDPBWlKNxEtGPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779732391; c=relaxed/simple;
	bh=1pp+Hr16Pf3N7l0d/q2W+xea9I/gy+MmginnCOpfNrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWYumdVVUFrZYG+5XrnGDTpNn/VYaTYZhnPmEq6/SEWsYOgwCeQBiLSL2cjrztfAvJBQHYAqIlmsoc68GvD/SdHswaQlKKmpHHkfV9NGF7qbCMGmQrdAnybn8npyTOPr/cCeNqbscsggjK9AE2XZOGjNO3iFjnUtHXJiXT9jXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=LDGGlSvn; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="LDGGlSvn"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PHPMM1108101
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 14:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=5dou
	ZQvAFCZqdwJptJlzHlLbYqFrEBFAQblRV8bjPPI=; b=LDGGlSvnVwPgOU4r5HIX
	Vm5NLt1fPlF7jAwQrDVvRFtcUNaPLFY0z4vFHzF8KvXEAANZI70k+v0RcNbZ0hB0
	6g4puXZgHGEPugavputida2cXCM/mE4ZHs2PDRKSB62pgVTfHyArD0xbxdNakbXS
	KE/vTIjo9ruSIpd0EQJg/cY3nDA/83pNowZVYvqOrrSEwU5duvcgQ3009GAqfAfN
	dkEvk9SYCVk8mUvDfbJBStXJyg4S1/qMbbPEZudpe9MYTh+YK5MJleWd2E/NlDwV
	NgB4/9N3hqj83Dv+gYm9ZpQhehAs2aspWH660TK8R8F/Q7S72bwrWAZWjmePpXZ5
	qg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ec5tre2ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 14:06:23 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b552610488so48371896d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 11:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779732382; x=1780337182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5douZQvAFCZqdwJptJlzHlLbYqFrEBFAQblRV8bjPPI=;
        b=dSopa32I3adMGO0bdzr7fNFquxFUJtfJwfcB3o+es1d9Czo+AoYeyID5ii+Rq+ddDt
         CBEL27dKqiF3cpQ8n7PQLrBo0P/17WvUkVIbPzTln3lrziMjgEXXIRdvVyWqkFxNPmH5
         ckBYnAqM/CR/Kz/yhQ/HaH23JwVeDj40N09mhTM14NsyBLLPwaQK+buhysGj833+C/cM
         bA84wy6XYzbtw4nf6tldLP2kpifLMkPg+tZahRLC4SSQlAB7qreRxEWE1UTgPKT5nuNb
         hxG5KVO/GQlDclTzPzhM3pWhOZYKWm1C1iYyp3rneJHus7a4xBz+6WbM4HB18xhiqNNr
         6ytg==
X-Forwarded-Encrypted: i=1; AFNElJ+b+R3B+HDedeMeFEdpKD8zRsqG5dN5eJZmJ7PS9/1FqRavcscElJ31YM7QkGcnTcv10F/JrB4qkmSPnkio@vger.kernel.org
X-Gm-Message-State: AOJu0YwelhqrsRjX6QJSnUzBh9N0skGcdCwf9ixSN8lAWh4vCrNMuuEf
	djbfejqK0yzd/6Fp7qZqNkqYstI2DAd5BKDEblc83zxZfzNYfmqS8j7MWJRiBX6tzVD0KBVV4XU
	M6rMc7ca0RJYGFVmMfLhVX7R2eY/526hd+yeLAy8VBM1O4NWZPhgjGgnK2UTr+t/RNYntfHU=
X-Gm-Gg: Acq92OGX0dFcAd6j5R5Z8xpzO+sBI8hFSXh77MAFHZthLHR+AXoV/DF/ovq3JfCUM4k
	UvejeQbI0fA974eNM/lAAoQlii0fA47f4b75+rXMGIrV0qbTe9F6vFoinEBBflK2DzFlDV+N0g4
	3NOQ/jETHF+Ka6qFBsZ1CeBBJcT0AYF7QYjLIGZHuLdmE3e0JKiKNIqcjk1JK9EljCOEiL8nsnk
	aYa52B1wboyAszRXUmj6XwWqt0LcD5sJ+rW4GuLgfDmXMNdm0Pg+WuP6tf7zvgRNum0sefEB3ec
	ADlSfNWBBK/d/o0BNlwmsAd1f4URjtpuIJeSzjwkpE1+JJsXVAJLEaGmCDkyCNwBsms/4XbI3sC
	UuTs8maTRhwZbwCawbl/tXDk8Z3HYND3KYdFbjarZK2jLrOf2Z1pgVExb1eTD/9g7SeKnHbQ=
X-Received: by 2002:a05:6214:5a03:b0:8b1:f8fe:507b with SMTP id 6a1803df08f44-8cc7b540e74mr240941666d6.19.1779732382476;
        Mon, 25 May 2026 11:06:22 -0700 (PDT)
X-Received: by 2002:a05:6214:5a03:b0:8b1:f8fe:507b with SMTP id 6a1803df08f44-8cc7b540e74mr240941006d6.19.1779732381967;
        Mon, 25 May 2026 11:06:21 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm127335106d6.24.2026.05.25.11.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 11:06:21 -0700 (PDT)
Message-ID: <dcba754e-1c29-402a-980c-f9fe3e57a0a1@columbia.edu>
Date: Mon, 25 May 2026 14:06:19 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] block: enable RWF_DONTCACHE for block devices
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
 <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
 <f8d509c7-c0c0-4196-9a82-a6f8ae24ffc2@columbia.edu>
 <ahPejprWrEjsh7aC@infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <ahPejprWrEjsh7aC@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE4MSBTYWx0ZWRfX0jEj/8WEdK08
 fhp8EaS2v1rrhSA/zXLCezDfFRko09AbVEC5T3AZk+zN+esNZvgQhG2b9e6WeX5H8PYSvBbZhNS
 +pbWhbjZtVd/MyR4kfOPVsJVCOnHQMQT+5VlArbDHjXFyOs3NXFsRrvfLb550mSKLomD5TatWgH
 hy8JNqi0In14lTndciFP4KVSi3wmjc9inWdAndNLyosxRRcrcPDd6ahisUPTDVSAGIZ9PzqgQLD
 lasgAS2w9eWJLAwhHJG4GixOzXM+TkTX0uVYnr3GVXeZGJvhiSCW9lWPuLuE68CAXB91EdYYLA/
 30ji33ipuoc5KU86+Hyztb//Ubpqm3tLmRiFR9SjqqreWpyLn7IkZgNatsIrGdIAWd68UIaeN8D
 CX9gRzccepjKrDuZx321QFg0uL+18Oi5Fy3MW4Gvqh4TFgeBTgY6RhPBqPo9NDGtUzVNUNSlfWO
 DpdMPkxLk6TiqhOFJwA==
X-Proofpoint-GUID: MJhUx1Qoxi32xT4JGj5KvkvtQLwWc7lO
X-Proofpoint-ORIG-GUID: MJhUx1Qoxi32xT4JGj5KvkvtQLwWc7lO
X-Authority-Analysis: v=2.4 cv=KLpqylFo c=1 sm=1 tr=0 ts=6a148f9f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=V2gEwdiY8GOwGPefXFgA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11797
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 bulkscore=10
 suspectscore=0 impostorscore=10 lowpriorityscore=10 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250181

On 5/25/26 1:30 AM, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 07:17:15PM -0400, Tal Zussman wrote:
>> A: So this actually seems legit... doesn't look like anything actually calls 
>> blkdev_write_begin() or blkdev_write_end(), unless I'm missing something.
>> block_write_begin_iocb() usage seems necessary for bh-based filesystems, but
>> block devices seem to use iomap for writes unconditionally.
> 
> Yes.  Maybe send a separate patch to remove these now unused methods?
> Or I could do that since I forgot to remove them when I should have.
> 

I'll send a patch. I'll also drop the block_write_begin_iocb() change from this
series, as it becomes unused.
