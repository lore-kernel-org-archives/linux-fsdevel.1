Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E637B41A
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677011; cv=none; b=cPrXpKXmokmVRP0vJ/3csrD9TCvXGy3e+4yadKuvdxiDNB8e2ur0ZsrEPEiSb+eRYm0x7W/kN0kFqw/7XT8qZ4x78W7Ep6Zy4d1+TEAiJ+H6pvOK9uXk+mg9p4lmH6SKoyRGy34Jtnay/61CKL0JBesXTHcLySBbFq25/TQQBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677011; c=relaxed/simple;
	bh=XwPRZu5Ld+QTZqlV+HMue7Ds/fH2LaUK/cZVeqKosVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBFevBDxWHTHdia3GqfR3gudPttju6mkArXPWmRnopZzq4erxlwH1u+XO3UNxu7drnhDvYXOa+ibHIZ5Xg1ABXVj9UmEHIYQNpveqSYqiYqWbcxtzPNfDKclySdoZxUXWbtKn0q0n0SNu5RNAB1yxfKtUCwN64vkymPjTtcMO40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QA99faMh; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QA99faMh"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638JXV743289963
	for <linux-fsdevel@vger.kernel.org>; Wed, 8 Apr 2026 15:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=96l/
	i7uyqouj4dytN5MpYVZKfSy3eXi7wDZWJb62Zz8=; b=QA99faMhBQ2CRLNNFL8L
	qRU0KP4xnwNqn7cMfDQW5hCPv6hts7r/Xd5kZaAY3dSC43v6ijdCL1tNUW26zeG0
	i00xv5/w0hQP+E/6FmGItYboGNRG00oqthfvGcLHUjewrJYPfEU7rIUhb+rrH3ZI
	E7MY1V9FjX/Rjvqq6Buhdtpm+GujTj7zgsZPqlGlaK9OmmMVEoPJ8/8i9H/r++Ew
	xasVMLD228PIgjw2pkPCzEZbfiWSUlXyI0hlkxJ+Un5rnqSYBqPbHFeq+tEtIyhj
	R4oX1MgQkBQVvA1CNbDR1nsrNcP1286385FwkRZAdf/g5IG6aI/qI16ZN0btyleO
	5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4dda3mfc1x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 15:36:48 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b44f7b7bbso5160881cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 12:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677008; x=1776281808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96l/i7uyqouj4dytN5MpYVZKfSy3eXi7wDZWJb62Zz8=;
        b=osEC+CdW9Eu8YQuGW4fI71ZzFi6RsLuEbm1ixh0EkhHysxHcrttMFCFu7L3mqb9w7R
         iiGzPzFMVKMdTVMHnftandmxkcSLOTcrjL45vG9ysPzhLDt+ouC6dYrQ32sKUTjowZzs
         JeuRCgcx0ATLV1WXYE9VnXGNBGJ8P2taDjOK5pK8sZYwrduqe688D/cio7D/J4hwGaen
         hfXVucMDC4vNhBgqo7vbTNPqXl8NWNpngEO8fI/a5a4kxNq8GCa+8MkpA4fOUCLNndMn
         wAl2a7nF5aZMm4LS40Rd+UfVBBVrxcvuQbLP4arej52ofX2XwnFtAbnIfGjFtgc8pr5W
         SfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnJWwqMWnkk74pxkXaFqf3m6Yad7MMKBKG1VJ7tPBHRr54nr/ffjdkW/KWXK5GqeLgZ4gOYUINPkaP2Pdr@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOtAkPrvUOZmXHhj/F0f3N3zdg5xvAQZpQW2r+BramGTDLOez
	7dE5W60kRjSALEQJjGnVmbEiu8h+GbH95VIuVlh9N4mKdWBT27Ul3Ly7Z4nOJzEwUy7x18xAEoh
	BFB2OgPjgPIxFpg1pBWZWvZtaCt2alASHb6T9GGwNCROLZgeXvH9Mx09+SmHKAcU=
X-Gm-Gg: AeBDies9Rr49o/H/VVchE6prp9XYkD8GQF6uOQLbxHyXJeYaaJT70/sTtUrI1AeTvAA
	mKySTPFGhtwOC7k8tm7KAbk5QYVSjrOiyPIJ8CkqJM3ZF1T+EQFOOziN0puAfuYgPUvluh5BLZn
	3f9qZX1dE9qUlZ9PwgV424h/8zGA+Tt8ij84nySm+ZHcUQaXKQVlfBP6pdajje1h0SEwA98R4Pa
	V7FBCDaA55eaTN7nNZS8Abx4qPsCnnKOzoUT5aT0v6przaYjDmIfQacRR1n/jP3O2qYV7KFpPn8
	jfWicCvdz6ldaTsNPloUILK91OsiKXn6pBVbwjyr+CqO+ZoF6XYbLJEwchKB1s5TPo/WxwiiY27
	MD4LW7qelFQIhS//KxCUVNY3q4+rYbyC4/3hCehbK
X-Received: by 2002:a05:622a:1a86:b0:50d:6b6d:bc17 with SMTP id d75a77b69052e-50dc212b2e3mr10299341cf.23.1775677007877;
        Wed, 08 Apr 2026 12:36:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1a86:b0:50d:6b6d:bc17 with SMTP id d75a77b69052e-50dc212b2e3mr10298851cf.23.1775677007355;
        Wed, 08 Apr 2026 12:36:47 -0700 (PDT)
Received: from [192.168.129.206] ([216.158.158.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d64752857sm142454931cf.21.2026.04.08.12.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 12:36:46 -0700 (PDT)
Message-ID: <c7342d7f-5c92-4a2c-9d00-5f9cf478f4e1@columbia.edu>
Date: Wed, 8 Apr 2026 15:36:45 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
 <20260325-blk-dontcache-v4-2-c4b56db43f64@columbia.edu>
 <acRDyJrkJhnHHMSe@casper.infradead.org>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <acRDyJrkJhnHHMSe@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OdWoyBTY c=1 sm=1 tr=0 ts=69d6ae50 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=mD05b5UW6KhLIDvowZ5dSQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=fDzNMwFgse8Xf2NrkjQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: jkL-IPW_7Fz9Lkme5ujtIVx6uq6z6r1c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE4MyBTYWx0ZWRfX6GZAM657RxC8
 WX/UbSQZwkFc38lNXezMIyzt159CEn5xAs0cSxWZVIQFxAGw1Ruusr11/m7lNP5Dj2SEdJ8V6UM
 CzNaPU6pRkTkG8q6yWlF93/r3HtNIb2KKbATBAcis+M0LwYN35WVB9ZqN6i1Q7GioAtoPZiZJD8
 RRsRq9/W4jUw6S5mbBAkGl69RLZdpR16m55qiTWbMp9duD4Hc8m0KDyMDSIjbDnK24iE/vE2G0d
 bFmNj56gASzbS2Kki9SpjIU7ER28gSGQK+CmzbtDEmmd8A3QtzIsNoexP3UaSZ8NfxYEOwbSeuo
 8LHY5fiCCG2R+pyQ1lSK2gV6Tle6rir0hI/eI3mMOs5cef5ZjCg7RO0MokHVOKHNO1dUc4tpRbw
 GR7teDGXjhP1SyrgIFWMomy1ubxc6HI1eiIMLZZuVqjEe4FwnzV0P4WW81J6B4od5SWzzkwJUOE
 wyFBOU8IUOgzwmi09kw==
X-Proofpoint-GUID: jkL-IPW_7Fz9Lkme5ujtIVx6uq6z6r1c
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11753
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 bulkscore=10
 impostorscore=10 lowpriorityscore=10 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080183

On 3/25/26 4:21 PM, Matthew Wilcox wrote:
> On Wed, Mar 25, 2026 at 02:43:01PM -0400, Tal Zussman wrote:
>> Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
>> IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
>> context, where folio_end_dropbehind() can safely invalidate folios.
>> 
>> With the bio layer now handling task-context deferral generically, XFS
>> no longer needs to route DONTCACHE ioends through its completion
>> workqueue for page cache invalidation. Remove the DONTCACHE check from
>> xfs_ioend_needs_wq_completion().
>> 
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/iomap/ioend.c  | 2 ++
>>  fs/xfs/xfs_aops.c | 4 ----
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
>> index e4d57cb969f1..6b8375d11cc0 100644
>> --- a/fs/iomap/ioend.c
>> +++ b/fs/iomap/ioend.c
>> @@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
>>  			       GFP_NOFS, &iomap_ioend_bioset);
>>  	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
>>  	bio->bi_write_hint = wpc->inode->i_write_hint;
>> +	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
>> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>>  	wbc_init_bio(wpc->wbc, bio);
>>  	wpc->nr_folios = 0;
>>  	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
> 
> Can't we delete IOMAP_IOEND_DONTCACHE, and just do:
> 
> 	if (folio_test_dropbehind(folio))
> 		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
> 
> It'd need to move down a few lines in iomap_add_to_ioend() to after
> bio_add_folio() succeeds.
> 

Will do, thanks Matthew!

