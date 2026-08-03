Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205D1DFFB
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752281; cv=none; b=eBLKgK/9i3ayPPp2KSAt5OYoWSk3DjxTeb1Udf2/5O+4ylacQQ8FaA47MaKu3oWfh6NBqN9sXRq75piX3gDMwIqsLOTUvRdEnnhQA4DxbcxqCWW5E6cQuumujBedT0yRvmVJhjeBeVWXWGW/mGQ5F0lFGzpmo9siIgrCZV0+gCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752281; c=relaxed/simple;
	bh=yfbd/LnUFzyVONAmL0nHdpEjPTuPclVvtcKxtlccaJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkEjEKCG/sqyUo8KuaSuC+7hy0++f3Vn7KeQeGLxJrBjXGUoNPSdyJjK0rj5QRjIJMw8QMqU99jc1y0DQoRbOn3JjNyipbc/xDEOoae0AE4O5yDoczxvrfMJXYTS7jCoCtln4v0v5yE+Et6j42XBT9/q6n5/bWsYr4SB8tgtKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MBFfMPgB; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MBFfMPgB"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67390GOx1804073
	for <linux-fsdevel@vger.kernel.org>; Mon, 3 Aug 2026 06:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=VKXo
	9RLOepuEerEoxhJYp3T5k/j3I7Y2xiV7gulHRd0=; b=MBFfMPgBbJ0yIGiWLH2v
	HB974bvrFxozlgqRWYxtC15s3RvfcdcK7vMveioJv4/C7D/+tmmTbthOnGWq4iqG
	iaMzBppt/rCsVLj4QwUmnu9Z70FgaJ4zh/UtDVEKXNCVD0vhuS/6kISKvNu6Yi9t
	YB+jitHakUElGsDL5MYNCeCk+MW+cWXoaD9zNZ2upz7slZWy0NDnpN129HCoClgB
	PbFDi8IJwjggoLhMuQgI+97joQrvWB4tmkayC4vEYVT29APN0xU0omTcgHNgKqvY
	x5WVsSdct5qh/ibjzkQFrgYyi3fQqAHbk0ErQJYGCrBToTEr2h2jzPeQz2ZVv+U6
	oA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ft85433r1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 06:17:57 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso23955601cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 03:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752277; x=1786357077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKXo9RLOepuEerEoxhJYp3T5k/j3I7Y2xiV7gulHRd0=;
        b=SIztpjalANeNtDUr4tC8K7POlfCx8eOum8rsfmN0E/2PRJga0mJDdTPMRvH+oeZp1U
         A0D1+u/pySUPsfRuFjkb+B2EqA0AWesyQd3h/GuM7947L2C03HsgAeyn+qYxbQLkWhGe
         hIFhZtCFdTlmPIkWZMNbBnBSqBUIHycPL0eu2pDzLFGNyVuzqIJIAie0qyDo7E/Kn/zN
         Ni+xoalsYI15mVMkHKQwjBvvErXsmij7nCImbwDuxajHaijPq66sHkDWYcJFdVvusjC/
         e3ElcJYrpAzrcGkxEY1ZTF1ZAjwrWts0GM4RLeBME9rv9Pt0SAI+62aUnH8Wazs6O9Df
         dYfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoafeniLD62e+gG8iJMd6cMHaRAAKMqblPHUb06ecIlOZu6YgvxBr/sqs92Vfy+QW5MksPWyOTQApTc1ug0@vger.kernel.org
X-Gm-Message-State: AOJu0YyhPxDHMAaHDOLlj3cvRNGw5FdHachabbkSsR8sylWlIoNaWDBM
	sOxXTDE7C744pBQyJwkHhAJ9WuP2FDOQO/OyVvyXV4KLO2Qpps2NWzsEN6ZMCaL5c/GK2MQKMWS
	jKhQ46jvh+6oxtfQxAvG2o1/QpbIpkUEPOeHagiQLw3ECnYLW65Tw+VhL2vngXGE=
X-Gm-Gg: AR+sD120hGYwxNeXFuCUPqDs+ydiWeanfFqe19ueyOo9gsAp2rh8GM/HmDF3aKQ16g0
	Go9G+62pEIagp3ANXPAT97yDsQHlWTM3J2LOVDGBdNwmHqotW5gwutyz31sl2UAPrj0LO+/ox3y
	6/trmVxDf8tFKg5Gxb7Z9tXS36h5ZDy4yMSlkYImRd4B3NPUp2dZlL3aImGrX9GR1RrSdsND4S/
	axNCGDxxe98rG76ChyaKSoAi8dM1ZQUHSaK+lAz7dHRdHK9fh0aDq5AuHq0NrAqFYwe+zfpCCs3
	fjReP+zjIxr5r9wfN6DYBdLK0+FTV0/xfWdjyJlTPP9oDQETdkRIW/Rcndk9QDzNSAIgsEaESFA
	WvSAJkyAMGrWxx6zicK7QP+GY/iz98Goum0v4WD3IF0OJNFDl4aL4EZln
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr165492501cf.17.1785752277205;
        Mon, 03 Aug 2026 03:17:57 -0700 (PDT)
X-Received: by 2002:ac8:5850:0:b0:516:d83d:b28 with SMTP id d75a77b69052e-52b4c5ac831mr165492101cf.17.1785752276751;
        Mon, 03 Aug 2026 03:17:56 -0700 (PDT)
Received: from [10.100.102.30] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd456a5a4sm32063433f8f.20.2026.08.03.03.17.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 03:17:55 -0700 (PDT)
Message-ID: <f404ed75-2b9f-42a6-8ee7-b4564f3624b8@columbia.edu>
Date: Mon, 3 Aug 2026 13:17:53 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ceph: add ceph_folio_snap_context()
To: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
 <20260802-remove-wait-on-page-writeback-v1-1-6c35d6b3ad36@columbia.edu>
 <am-8AaWEHm7I9b7N@casper.infradead.org>
 <DKETLELGS8KI.1B0MCAPS99CXH@nvidia.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <DKETLELGS8KI.1B0MCAPS99CXH@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5MSBTYWx0ZWRfXyhYn3obIr43A
 iPmdjr4g0v9eml0VEnBdDs6jnlYbK8siB+anw5mJ1otWVBp2wFu33tEByy+ighPnuaf83ryoRzp
 4QewVTRPpIEcJN18HoLieDacybM3NFXPlXwdxr9NbjOxpYIDtzZCZLQjt20JpQ8E2qUsFho+VbX
 4pU7uhmM0AUPIFDkQLMtbjlZMbxwv2BvDJU51oTJFU0BwFlDt8sYdEeAqk8EAy5R0yKsP3Va+Jk
 aVBD1DG+SJDaLOh1ICzF6yLMZ596NNJxzlLCfIgKVuHo8g16PRR4gmXVQYwILkfw+rQZvsJwuAw
 wqCIfJaZtap7rhSRHXbpm4q89Oe+kVePS/gk8POPk86BhzMW9D2pb99dUnrkLf/V96xM0WK8ueP
 heOc8j+n6g8PE3mO+XOtKdj4sKzxHo0nTq9AT3fDhxPgfaDIfzhm2qqKrO+bpoCAY/4TY/9PVCu
 OwcxU8OdaX1KFjio+pA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5MSBTYWx0ZWRfX+zeDPQ1I7i9I
 wbwWYg7E46FVzqVHi1PzznqCdpUu09pZ7625pIsCaeWBivEicbMaTH2eSEvzEKE/5fMGzpmZ0sI
 FmqEciog6li437CIOMF7elzdFxOD+1gxuDdcXfnxv/slKrPvMOiA
X-Proofpoint-ORIG-GUID: jPEcoCKJYg6pcNgBTJdTf53876spvWsu
X-Authority-Analysis: v=2.4 cv=Uc1hjqSN c=1 sm=1 tr=0 ts=6a706ad5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=DIPjSMOhCAX6BCWRsZYA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: jPEcoCKJYg6pcNgBTJdTf53876spvWsu
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=10 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030091

On 8/2/26 6:44 PM, Zi Yan wrote:
> On Sun Aug 2, 2026 at 5:52 PM EDT, Matthew Wilcox wrote:
>> On Sun, Aug 02, 2026 at 12:50:02PM -0400, Tal Zussman wrote:
>>> +static inline struct ceph_snap_context *ceph_folio_snap_context(struct folio *folio)
>>> +{
>>> +	if (folio_test_private(folio))
>>> +		return (void *)folio->private;
>>> +	return NULL;
>>> +}
>>
>> Filesystem folios _ought_to have folio->private as NULL when PG_private
>> is unset and PG_private set when folio->private is non-NULL.  Now, ceph
>> could be doing something Bad (I believe hugetlbfs does not honour this
>> for various reasons), but it looks like it's using
>> folio_attach_private() / folio_detach_private() appropriately.
>>
>> So I think we should just do:
>>
>> static inline
>> struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
>> {
>> 	return folio->private;
>> }
> 
> Yes, please. So I do not need to handle another exceptional user when I
> am trying to remove PG_private[1].
> 

Sounds good, will do.

