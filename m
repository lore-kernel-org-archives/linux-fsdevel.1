Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15322EBBA4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760878; cv=none; b=jDP+DMLjf47kbuN+goJhj3x7AIZKCLfP71A+GBdnzzN2BXOpOBUDgi+ydfk4B7LEYOvRwCjteeYnyY4UsccBHWFAOHkF+L/KCBNgNm1cMyKhHNc8bv12ZDkiuiUxi2emc1wSltTKepBDRphrF1uT947BI/gtZHnOvx2EK+nfXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760878; c=relaxed/simple;
	bh=HITamePOFQ6xKFSAF+Mlb/PmV4vIExJ/NInzdHCOzjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fA8eWP9rsg0vtJEOjKp9afrsede7pqkSuxpMHbLgXNQ4Qi4U+kB26SNKYr7LERpIZMtt+Bk7x/gycl+rLpEjZkh6wCG/2WqLZGqMQSZsCEjhnKmNWC1rYeJ53STIG625HjdAMPwnuyams1swp00F52rNgKiO6Nz1Jvn/hYV0bew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZAtJSsKj; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZAtJSsKj"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639IgTxP2186257
	for <linux-fsdevel@vger.kernel.org>; Thu, 9 Apr 2026 14:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=sw6G
	wRk7Qp2WRM++iKaHx+hBQAaMKviN9vTfKu8ETKo=; b=ZAtJSsKjbJ+Hx52hia8V
	5BMqLKGKSsStdVWtGKARsi0D128R4JPKsI86AourUUAoTURwWTj35qcQxipX3bWP
	a6q3sdKorNc6YRrCwTJb/TCMxv3p+mxXbU/gTz0zRx16uUBEfpyeh9ojfIrrl1aq
	v46cmPYqZ9ZsuXvF5ZJpb2hQ0JPDNtX0YlfISoHeTAQyYnZZ09MubrDOhccs0Z3H
	/91KAb3XVWlenwMNgfnasO8BAjtbph26AK473sh5c15lh7ocLkyw8qQDtKZiOtI3
	kyLlhC3ioSigG1ElxYY76Q5lLYGJj27fPkR12FO/wB9Z+gml0Y8wUuiIjTb8Ele2
	7g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4decka3cpf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 14:54:29 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8a4f18b1b5aso22903786d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760869; x=1776365669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sw6GwRk7Qp2WRM++iKaHx+hBQAaMKviN9vTfKu8ETKo=;
        b=SKOYkQeI5Hys+0pVDBnVt7ACQNM2bfsa5YUsvq66Ax11By8rxQRjvuVIqX/3R0zSAA
         0HsgTBY39uWYbzlzNUozo0rDymcrm2FXZ7nVDJ+XNeU3EYx354VFnfTyBTI4l/0kN3hq
         Lva5NJs114+OxkYtV+06FnjRtWiz2625zQ66eadZ01MNrA3Btt6zGZ+xc22nkXxtXLod
         VI3dXLAh7gvVl700AAxxFyRKxQstMt0B/XBe9Ezh6uvD8TGlIcbpUdBdjFnqk/6lsYOW
         A1L+bNqz+RVtdLRwkeAR8sNeQntHFJPJRDgULE78j64nLtaz8tzDbhr7DcZiPPD/oLtB
         NBHA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBJEEBY26xc/4VZRBCCvfLx8v7oTi0lrwYmUHkTsI0dboeA7bD2swFkvk2m34Zzy0mOuN7Vj6CJTxtxk7@vger.kernel.org
X-Gm-Message-State: AOJu0YwR8CDzt/pzuNnKmyiB0leubD8na9d8apPyqClNOk0H+cbadRw3
	4I1AFsqZ88uMkLTOnvue7A7qdMDiDtWpt+XTV2rTbs+NT/p1yBWx4x0YuJv3+kAxTUUBgfBBMnL
	mXBzbpEgTq3sf1QJDNoayOhsVVHYP8ddvUzRUZaPifmjd4Af4rL0FFNURRu09bou5O7shwGM=
X-Gm-Gg: AeBDiesn/VpAEk6QFjbxbwJZS6WHARRngIN8DQYbDjKwVBgCpffaDHlGTqw9eRKAh49
	Y6VNmtHv+nawJQPwfS31357W1Ya+0273kf2p5ki1da10WA9V1puNbWOZLTurNoomFLNFOrR8r/4
	v4LmJF4NpHsPGpihCo7olFb1Ul/nsjxS7HYSc809PtHGQMRovjHUcHxMQpgGsXpx+Ydu32e7at9
	hq5kGYSSeHVDjULsEtxAB3uSUxXv14ALXRT/qnLzkZEDLNK1DfLPyiWlKK5Pp7PuEf+CN25hFck
	kDoaQh1KiPji2gpfFo1xkmK4kl/yl/15kKi8rhGJOYxPvJk3gIttw6Y560r6rHCQN05wyJX6tuJ
	pKXICgxx9rIXVP11kaVIesgtZpn+G/QvlB/0tXIUV
X-Received: by 2002:a0c:f114:0:b0:8a3:221d:9095 with SMTP id 6a1803df08f44-8ac743038b7mr72761216d6.15.1775760868935;
        Thu, 09 Apr 2026 11:54:28 -0700 (PDT)
X-Received: by 2002:a0c:f114:0:b0:8a3:221d:9095 with SMTP id 6a1803df08f44-8ac743038b7mr72760866d6.15.1775760868507;
        Thu, 09 Apr 2026 11:54:28 -0700 (PDT)
Received: from [10.206.71.59] ([129.236.231.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849db4b8sm3093516d6.7.2026.04.09.11.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 11:54:27 -0700 (PDT)
Message-ID: <7e468bd2-e52b-4165-95c6-3f04e1dca21e@columbia.edu>
Date: Thu, 9 Apr 2026 14:54:27 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 1/3] block: add BIO_COMPLETE_IN_TASK for
 task-context completion
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <97b81868-6410-4c79-a242-679a9f04f073@columbia.edu>
 <95F28FA1-5CEF-4E80-BBB7-A429B4437D12@kernel.dk>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <95F28FA1-5CEF-4E80-BBB7-A429B4437D12@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X_xBDRlSOXF4aAsl-cVMm_PfwrXrYF4z
X-Authority-Analysis: v=2.4 cv=BO2DalQG c=1 sm=1 tr=0 ts=69d7f5e5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=RFpAoTwO7tzpE9r8PTiuXw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=y2ETOFklOQM5vU7YwEUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: X_xBDRlSOXF4aAsl-cVMm_PfwrXrYF4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MyBTYWx0ZWRfX4Gu4RS7PIkBL
 P/mtKZnorkJ+ZjtI/G0UpJlxidlEOBA4DjTqCjfmgEMGCtK/VLw894hJS6E3JLc1YrtNhPiS74i
 nNPf7zG/FcvY4+LjlQSiBDvYQkgxAeW9xUY5SSEgsk/bkQrU5QTVulwkgSNgFnHkrav1JCAdJ+B
 bw9jtVWsEkZCk7VdduV/7w9/oD9hB0MB7BLOH140QKg2tTInQSgGqzkrCpQiiaKaJFZZvMcPUVx
 pGH3rpXWmXblYPnT+kkmxo4wlBjZ6RroqSmzbmDmfmiyEpohH8PblMyUVxjMcwrPcrOnaFNIT+f
 +r34pjHVSptHSSKnMe9S8knmq5Utn4jL3GIuog0ur/vQHZBI51pvX5UJZAoAqXur1Io1gbErgi9
 sdfwUI7Qs2oONMvFt+2tK0QLvobHV8qds55bw4y9ebrdM2GSimjY6UMHvVgNmg5n3vRPI7Bd+0X
 6K8XMEg2sjdbuPsuzhQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11754
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=10
 lowpriorityscore=10 malwarescore=0 suspectscore=0 bulkscore=10 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090173



On 4/8/26 7:36 PM, Jens Axboe wrote:
> On Apr 8, 2026, at 4:51 PM, Tal Zussman <tz2294@columbia.edu> wrote:
>>> On 4/8/26 3:51 PM, Jens Axboe wrote:
>>>> On 4/8/26 12: 48 PM, Tal Zussman wrote: > On 3/25/26 4: 14 PM, Jens Axboe wrote:
>>>> 
>>>> Thanks! I'm going to give Dave's llist suggestion a shot on top of
>>>> this as it seems like it'll simplify this nicely. Looks like that'll
>>>> involve turning bio::bi_next into a union with a struct llist_node.
>>> 
>>> Since these lists can get long, I'd keep an eye on llist reversal
>>> overhead there...
>>> 
>> 
>> Going to send v5 shortly -- tested with and without the llist reversal and
>> it didn't seem to make much of a difference. This was on a single-disk VM
>> though, so any stress testing you could do would be very helpful.
>> 
> 
> With all due respect, a single test like that isn’t going to be that useful. I’d be wary of making that change willy nilly and just thinking “it’s fine, worked fine on the one case I tested”.

Understood -- unfortunately that's what I have access to at the moment. I
can requisition a machine with 2, maybe 3 disks, and test more thoroughly on
that before sending the next version, but that'll take a few days. You had
previously offered to test on your big box, so was hoping that was still on
the table :)
(Although Christoph seems to have proposed moving away from llist again)

> —
> Jens Axboe
> 

