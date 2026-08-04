Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959C420D4FF
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886423; cv=none; b=YUvdAQUyYW7lfjGOJs3c/n+JAOogSB/g9dkYabyjHakDv8kWjbq/Wz+usj7zpepnhJNi+2c6b3rZSZLUyBrJRcU6ZQCnEVo82y79k8Q9KalqeX3v6tJ28whlcxuzsv+RBAhjCFkMO8c2hFbCrobHpQxJZtazYz5dVq3oN+HBnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886423; c=relaxed/simple;
	bh=6T7v1hzF9YXNjAUxl1yFby5yNPcZRt7DY8JF/ulqRyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbAwGeyVv0rWqXURIlrqRde4yFDVTV9XBS1gMSvcyl038ihyXljuSN6gOxGycFlZtFfwqccZM/FAh0cbmAoq2lecYur+7rhpVpODYMEs4DsmrKL7B6ks4uioaTSPKvPuFCpC5E5OgFeNRQjA4EPfgJPykr78XjsRHLwKBiHxEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=e5vywcvT; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="e5vywcvT"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674MnrAd3051269
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 19:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9MJn
	2efyYx+aesbUzNhwwCfbZijkW5RJZCFgDwcElxc=; b=e5vywcvTTA/6436SInVl
	fh4GPAFFlzbh13Di6M3azfwc4Kdd/id49TzXyk8HOp9qbv+kKN7K7uuBjSAb9Mzz
	Ha23tt9rZQKSBR3C3T5yb1OD9dSELc61LwFL/eu3I/xSClWsSkgqdzEOx3wyHxcL
	Y5EJgfBihjsgKa51KjZuNlA2wjZFMMmEgpQucGP8zO8NrljKbNy73K7zVS2EDwiK
	gL3w8hHJTB3fzaEO4+qpiAaySGzAVnaMyZXb5r+ATS7NvscoG68CvqjBI8w4ENLF
	pRDN9f2HObDurJgkVTCojapDlretvOmu2bjD1iWvfj7201eT0BWKxqCBi1A1M45f
	vQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fum1pjhx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 19:33:39 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c12e43b98so4076981cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 16:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886419; x=1786491219;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MJn2efyYx+aesbUzNhwwCfbZijkW5RJZCFgDwcElxc=;
        b=gfNtxLfcEC/FtgCIQ2YjfPY/IZe1aKGCHthwJHsZMJz2PXsEVMBCFY/ewVwoBgXbmt
         QDT66D1eBDyR5ZKGKEKvXEZ/dwft1Rsfs9PzRcl0k3Rn47gJMYIiPyEwkhZAYXI/O0Ql
         8hH+daP4ZQOsNDkfDMAVSKOmFbpdOpwNfUFW0THl1SkKkQnpe0Zmw85CglMCQaeU09zA
         9+OR5Hl2ASI34rwpiJJgO1L2nA2X0TQotEWknVgaf31gKSbJs6ufS4u+y9qMv+Ng2Rwo
         FL7IECLNhc5D0zGztYxwehWGeAZ2T7bvzUqDmwwdoGFSAhsRYyWoCcz+ba5LY3wJmZGh
         PVFA==
X-Forwarded-Encrypted: i=1; AHgh+RpcQYeYHUTRyl1xesl0HwFWIqz1ciUl7MRUHsgCShVYQOWqgztO9tyjazwe8C5crGmUTWMuXpPcMwlW4Iuj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2teWH8INa/cRmyc2tYbBOBmEwmN4iqpYr2SNIs0YxPOnPZp2G
	2pUlC9wIffxt0Hvbo4VZrycIvRYkDQ081fWlJzJk3WPGPNcZQrgmHnoeJIhLER8f6J/Ow0s2Riq
	Lw+VV0LZL4JmtTXbgaPH/s8dO71m4iXwZInmPMg/Vx3MUo+ekjlGiNYMUwJrWPzo=
X-Gm-Gg: AR+sD132vbyT1UGYvmQJvG1uPNW27rMhiRjzjvNgX8h2e7i5+xc0gK/Ih1xsP+6YyiZ
	gUkp+vJE+/bcKb7o8PX+IxRfqXUiKKKY0WZvTwJ4G2OwIU0DFBZrq7g1RBTk6KnFyfX3Q+jkcMP
	nJYpDRwCv5+6QBpFKokXRzGdZhUEBivrZGR8wCjK9Nb+iREmOW1j3nix/80ziDA4oM4U8seEV1x
	QONPqOUybbkbntFzgiiHfQSaeEOiHNPVukL47LdHljuceyo5qvPl8ajyFKLivWyw/8yAfZk/YsZ
	ePYe/cigrkhBWC9ThmHVqm34azTHY8gNHzgvWaIUhLARbipCY3rbQlI4bnNeP/QyS7d9x2/Kg54
	FDUrp+YiCL3AtleAU7rcbDO3wP0MkLK9Fx0v7SQFiUt+hXPHMDSjbmTsAAUZP2k2A
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr28750541cf.20.1785886418760;
        Tue, 04 Aug 2026 16:33:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr28750181cf.20.1785886418238;
        Tue, 04 Aug 2026 16:33:38 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:a06d:5a37:92fe:4fac? ([2a00:a040:199:782e:a06d:5a37:92fe:4fac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e533sm3873005f8f.28.2026.08.04.16.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 16:33:36 -0700 (PDT)
Message-ID: <c0cc3539-be7d-47e0-82b7-9d7239c37907@columbia.edu>
Date: Wed, 5 Aug 2026 02:33:34 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PII/P/qC c=1 sm=1 tr=0 ts=6a7276d3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22 a=wrtZYR0IVx0RtIOIqSwA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE5MSBTYWx0ZWRfX0REVMBjDhQ/P
 CO4zaejSIQmGZn7I/3fdhOH2rfCTwFjfUdz2zy7vKQgi4D2DSSZccRA4v93GY8WmWhyNyZHYi+r
 pTvDNJlH1ODzdBtBN9vhGtkxQ4elQdWTQfhjXKElulLtctLqgSX6Q+MuioG6Z96mfTwrGHSQSw0
 prIhG2KyJmerb/SUSYHWCnwgDxzgeXTe60U4oXBFQmcFhY7BBlgHBqPG/fbA2By2npQWY3vJ/mD
 inCszlR2YhLUahS9XlX+3PXf0/SeCxkqmWDofJOP4kEuDXoxkyn0lFKazjHxDu5xubov8RvGCCv
 /Ee1nbEujI/87z44TIAqDJnuoHnUuU8yJZWIJU9I7DK2b97Yl+ObaYhirIMgbqD9x+uJIC0HgTd
 x7VF78vnCJig1PIwdesEEe33VBe/O+3qSfi27QfGGs5xvU+yihb3CveBiUoiR0qFRAOeX2cEAUR
 KIjt6auwpy3AjUvzhrA==
X-Proofpoint-GUID: OCQtKLWnrPWHGFPrCeYWeK57lYjjSe1S
X-Proofpoint-ORIG-GUID: OCQtKLWnrPWHGFPrCeYWeK57lYjjSe1S
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE5MSBTYWx0ZWRfX4AP8OaAbgY6e
 Wmq0II3x3Bm9CUTEUZzHv1NS78SJsVhDCVMbtMDG6y4ohwoDlGgs8ipXvUagSd3qISnfTECYo9i
 NkPhSxSPF8unb85i9O0bf8OzaC7jDtvYLZo4Ar4dZplf+vjaGHON
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=10
 impostorscore=10 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040191

On 8/4/26 2:52 PM, Tal Zussman wrote:
> Convert the page cleanup loop in writepages_finish() to work on folios,
> resolving the folio directly after fscrypt_finalize_bounce_page() has
> replaced any bounce page with its pagecache page.
> 
> This removes a use of detach_page_private() and five calls to
> compound_head() per page, while adding one back via page_folio().
> 
> No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 59e559bdfdff..eaf5b3f6d13f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -896,7 +896,6 @@ static void writepages_finish(struct ceph_osd_request *req)
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_client *cl = ceph_inode_to_client(inode);
>  	struct ceph_osd_data *osd_data;
> -	struct page *page;
>  	int num_pages, total_pages = 0;
>  	int i, j;
>  	int rc = req->r_result;
> @@ -943,31 +942,33 @@ static void writepages_finish(struct ceph_osd_request *req)
>  					   (u64)osd_data->length);
>  		total_pages += num_pages;
>  		for (j = 0; j < num_pages; j++) {
> +			struct folio *folio;
> +
>  			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
> -			page = osd_data->pages[j];
> -			BUG_ON(!page);
> -			WARN_ON(!PageUptodate(page));
> +			folio = page_folio(osd_data->pages[j]);
> +			BUG_ON(!folio);
> +			WARN_ON(!folio_test_uptodate(folio));

Sashiko complains:

"Since page_folio() invokes _compound_head() which dereferences the page
pointer, won't this cause a NULL pointer dereference before reaching the
BUG_ON(!folio) check if osd_data->pages[j] is actually NULL?
The previous code checked the page pointer before any dereference occurred.
Would it be safer to check the array element for NULL before passing it to
page_folio()?"

The BUG_ON can just be removed, as fscrypt_finalize_bounce_page() cannot take
or set its argument to NULL as constructed, so the check was unnecessary
to begin with.

>  
>  			if (atomic_long_dec_return(&fsc->writeback_count) <
>  			     CONGESTION_OFF_THRESH(
>  					fsc->mount_options->congestion_kb))
>  				fsc->write_congested = false;
>  
> -			ceph_put_snap_context(detach_page_private(page));
> -			end_page_writeback(page);
> +			ceph_put_snap_context(folio_detach_private(folio));
> +			folio_end_writeback(folio);
>  
>  			if (atomic64_dec_return(&mdsc->dirty_folios) <= 0) {
>  				wake_up_all(&mdsc->flush_end_wq);
>  				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
>  			}
>  
> -			doutc(cl, "unlocking %p\n", page);
> +			doutc(cl, "unlocking %p\n", folio);
>  
>  			if (remove_page)
>  				generic_error_remove_folio(inode->i_mapping,
> -							  page_folio(page));
> +							  folio);
>  
> -			unlock_page(page);
> +			folio_unlock(folio);
>  		}
>  		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
>  		      ceph_vinop(inode), osd_data->length,
> 

