Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9013624C9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093601; cv=none; b=jjvc8/02Fp+l91+0DG8rXgflCGoAFU59FUOosIIwsq7N/zkhkdZ6n41kzt47ybKK0gMLliqWPBK62yuxDvmZIUSxHY4/YU24g3kuN1Jyz4TT//ACO3mhNOHLGvexl05dfwMFyeiHsGA8TGxZqrFYqYEfBzAHcF+R8/CkDyCZum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093601; c=relaxed/simple;
	bh=ENbFljKVw68AZqog/6x3mb9fPnIVpOTl56N7EZpGlqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUZwCR0f+Q7kYyPUMysNenYSQ+mJxcI6OYZzp0h0r4nis1H2jVJMBzax8ESD0wB7Xw3SKeXq4KneJSKM2/XgeGqPOHrYZvNmlqUT44nX0tRE3ouAPUHB4w8gx+sH4e4mrpDN8f+Izu7CW7MRD5gMQqy07uNUQHfM6+GGXP0oRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=eSTg8+oJ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="eSTg8+oJ"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TMCFl4355479
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iZ/C
	vHIaEtxesqHd176lUmCe2CW9FRR63TiqxgWScco=; b=eSTg8+oJ5fRfpIsx6Tcq
	92PnYHoBuV3eXLxsANRD4phElJOVL5OrwGQgCP77zxwra/FJ30+BKPxbno6PYIIp
	5faeDnrGsEhAaigVZ7MBPyHYqiB3nkH6XrhhfogAi7EAEk2vaZ9IeSxT8CondLr7
	jqJMA5R/00D8iXke54BONNZvImIY+LumJP6u79cKGBhJJ2R+IZI7De0/CNGwfz1N
	ns790QCfOjIVyGPyf7xXcJ8wj3/tGdHl3rB3XwyKzLsbqUIFVrXiB4Rsm6AREvGP
	syQ4v6JgLIluuEfGsF9GMof5QRRNI5Qch2IOEwBqpN5zOehwtmi/QVYxaIhKdF2f
	2Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4efk2f06mj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 18:26:38 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914b5249bc1so1271303985a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 15:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093597; x=1780698397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZ/CvHIaEtxesqHd176lUmCe2CW9FRR63TiqxgWScco=;
        b=mJ1GvrIJkK5+4pXdAaPGMI9yEO03FvCFu2ulaCfjgdTFZFghQmNcFaItvgLbudNPhg
         Pyd23Bl2FnSevKBLBjVWLsEcdHC+UnT2RxkDLELNBITFqcd9wPr/Iwa4IW+hybMSbsJM
         olr167hvUkM5+LB/4BALySvpPnsz9PSwV7TM9TJfE41X4O2Jh518G4R5bd5yJLcBeclH
         lilBwgttXkOePneV4ByJX73pBRqS7ys++acPzB0MVVxNiydkYcGjmWEJbIVhx9dk9Zpz
         YNel2Gh34ogH8tK3rd9jFUL4hZ7FH/i5nsgN29J3mdm2ax885VLByfqR0nh3lfYGvP6N
         u06Q==
X-Forwarded-Encrypted: i=1; AFNElJ9tDaf2CxjtQV4pLZKRDM4ssOaGaobq8gr9A5RI4IzTLLrnrQ5S4hozfVozwTze3oYJeplchUCv16QEzoYM@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlKhFAnB3gx+/bs7eXdl/Igz0pfJqz1geb/QVBSbpXsm0NnEc
	Zl/UKTFkRYYUBXSABQLh/U2TMDCo6rbE8RHcGlJ+a7LtkZY2WTnPcR/WY731gmW3nGQ+uCKb2tE
	LCZ/kB+CZlSqq2HFfD1bZFCrB7UXWnq+pcu4eeethX5fyQIQgtL5/QWvQNSNs9S8=
X-Gm-Gg: Acq92OEQ5NyW+w5vg6VvZ+j8fmEiP1kOfhbJoThqmWo5RpVah9DjWT3DKOT0bNG6yUl
	6294iwxpjfmRIDm+6a2RiAJe+Z828uUB22ggztiHrtOBIhsybcC8PuHlXaBAJU4jUCcwzgOWQl5
	kB6GY8cVjGwLqdcIuUIinJRXe3GBsERqC0aCVMl8rVkzjsZR0wsKGH4YW9J3940BFMohyF6RyAC
	MQ9kxtDfVt0uDxIaw5JXX6oKIeqVFu1Q2PkNKLRMB5iAHu8W1zX8yVRFWy2U80h7KaMbPVbMTxl
	dsBmxqVRF8yytROys93cCY7pTryahWQxVXp7vTrjj+n3PlOsBPGFCVCpGbhhz5UMjK4zAnbG46K
	DsPuQooXtcjxy6L/VvvfBimebPRQHFDhOoc+KXLm1z25hhwTG5tkBusPiP8dXZzkdC7psixNXHC
	x9X52lq9aNMO5XbJ183KBqMEnmHw==
X-Received: by 2002:a05:620a:2a0e:b0:915:2b21:c74e with SMTP id af79cd13be357-9153d9776camr269383885a.24.1780093597065;
        Fri, 29 May 2026 15:26:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0e:b0:915:2b21:c74e with SMTP id af79cd13be357-9153d9776camr269379685a.24.1780093596656;
        Fri, 29 May 2026 15:26:36 -0700 (PDT)
Received: from ?IPV6:2600:4040:974e:fe00:c8bb:325f:9d37:a5f? ([2600:4040:974e:fe00:c8bb:325f:9d37:a5f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915325fae79sm323170185a.26.2026.05.29.15.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 15:26:36 -0700 (PDT)
Message-ID: <205bb690-2874-47c3-b352-33ee96026196@columbia.edu>
Date: Fri, 29 May 2026 18:26:35 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/11] mm/filemap: split out folio wait and VFS code
To: Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
 <3dxzu3ck5y3wxw4pp2qhzwwb6y3f7mwhvgxfpl56sokw4ymop7@xaaoxsa5yu5q>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <3dxzu3ck5y3wxw4pp2qhzwwb6y3f7mwhvgxfpl56sokw4ymop7@xaaoxsa5yu5q>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yJ6rpuTc9rfl31kbAT1YTRukgPTd07r2
X-Proofpoint-GUID: yJ6rpuTc9rfl31kbAT1YTRukgPTd07r2
X-Authority-Analysis: v=2.4 cv=bpF8wkai c=1 sm=1 tr=0 ts=6a1a129f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22 a=aRezoWbpNT72RPsyBYsA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIyMyBTYWx0ZWRfX2F9vz3QEll5I
 6eWPaMzMZIHKi8aUlU9zYTWPxLMe834+YpGYpMI8oI02CUgMqY/rZAy8nlkrcPziNTpDpfcb44V
 dVl+jmZf07D9f8LaWvwIp/vKL+CscjVJelpnGZzZ8m7Q4Q66AHP17bNG1GlhSkEQnP7NTU8w3oj
 1Yup6zqLeCtLzoSwl59mtegFbsnJi7KWClVwWrtwpQOzN2WRy9usIRHbP8/LeBTkb/79y0MOfpO
 FIk8em+CGZzDemtBeTdy8zJLj37qiKzgS+F7Jc7vMqZpPwaPTwF2KHopxr3uSnRCP2zUQ0qW1hD
 TD2idYQNArxfOE7puJsb9lmVkyfkHrFY3AOykZTUL6FZuHYcWjvoLxk1x5ky3YNrpPSBKrIbHTq
 qW9z2y1YthZKcAFE/3ctB05GnnvNroyTPqtkYnIjCcfHGQtxR/A22C7f9g5LLkxuJ9v2eSg/5ff
 GUBOAobN4o6ijeTiH5w==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11801
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=10 suspectscore=0 malwarescore=0
 lowpriorityscore=10 bulkscore=10 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290223

On 5/28/26 5:22 AM, Jan Kara wrote:
> On Wed 20-05-26 16:48:51, Tal Zussman wrote:
>> mm/filemap.c has accumulated additional infrastructure over the years
>> that is not directly related to the page cache. It is currently nearly
>> 5000 lines long. This series splits out the folio bit-lock and wait
>> queue code into separate files, and moves the VFS-level
>> generic_file_{read,write}_iter() family of files to fs/read_write.c, in
>> order to provide better separation of concerns. This also slims down
>> mm/filemap.c by ~1000 lines.
>> 
>> The folio wait infrastructure is centralized in mm/folio_wait.c and
>> include/linux/folio_wait.h, with functions moved from mm/filemap.c,
>> mm/page-writeback.c, and include/linux/pagemap.h. Afterwards, the code
>> is cleaned up a little, with functions and data types renamed to refer
>> to folios rather than pages.
>> 
>> generic_file_{read,write}_iter() implement the VFS-level read/write path
>> for filesystems, including support for direct I/O. These functions and
>> their helpers are moved to fs/read_write.c, along with other VFS-level
>> read/write functions. dir_pages() is also moved to include/linux/fs.h.
>> i_blocks_per_folio() is not moved from include/linux/pagemap.h, as it
>> requires folio_size(), which is not currently available in
>> include/linux/fs.h.
>> 
>> No functional change is intended.
>> 
>> Note: I have additional cleanups to mm/filemap.c ready to go, foremost
>> among them centralizing on the filemap_*() naming convention and making
>> the exposed page cache API clearer and more consistent, but I've split
>> these patches off from that in order to avoid sending these logically
>> separate patches to ~60 maintainers.
> 
> Overall this makes sense to me. In particular I agree it makes sense to
> move the file read/write helpers into fs. Regarding the page waiting bits
> it makes some sense to me as well although there it's more of "I don't
> really care" opinion so let's see what Matthew and others think...

Sounds good, thanks. For the folio wait/lock code, my reasoning was that
it's used well beyond the page cache and independent of it, so there's no
reason to clog up filemap.c with 700 lines of infrastructure for a more
generic interface (and splitting up pagemap.h a little is a nice bonus).
But yes, let's see what Matthew thinks.

Thanks,
Tal
