Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660082;
	b=KogdYBJpR5WWQS4oIHW2DfqDdro/KpAqEEyOta4zKRZg4/WJ7pVP8/PQqs4QxhQ06sTx
	 lZaoYIDrGMNJ+hDC0P6gNQCMu3V4bB9hg8GCv7srihQliQIx4Nn7/XT4Ku9qxHGny6wdR
	 uiOvRaXtHFwQADyv1pGfyJdvtFlvIjUwcBXUqjEZwk2MZsKiLI+13bsXq6+M6It202CbS
	 jZX78jHe1oTlYKTfPNod4m/5xluYXGExx7XFQAl4JfS4iDjXU05+CERUDfm5DXHF1mPwf
	 LUI/5AIYBwwJ1P31EPb94mFbU4DsaKoTaXRaelAFgHKVMjYT9VHbolpXbAvCXz/JecA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660082;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=4WodIHx+o0x8mOdMhlt22k4lCyVvacVF3CF8lj/COxI=;
	b=MOnRiisfDcerXFBoX/cj4cz/gqkGa90GmMccIT6ODq7e7b4OoUskdaMO0LxYpNDPtrZX
	 B4OIez6AKeEsVEUD/LIKYrMCLXxJcVTOPyFkC7Dl6GoaUwJeDnPvEzLsYqE2STSzvKIaa
	 B0B5VjNb8Mrk/M3SJW5jV3TNc0chAUBsEL9A6zKVem7VJg5o51ZBAixVNxxbmJgx67FvS
	 0vauBtheKku0YoAF8CUC8bC6Bpn4fh8gOwrIPk5enUFPGZ8IPI3NBGOo2MTzQVRqtocGM
	 OwlFQrOdB6z61n+N/ZVmRbRBKtHoGdhnKVHdrYrRL+hFGzIeRDNNYE42ZvVfgA0zYcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=P2o0hyyw;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=kDsr9upH;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99818606D802
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99818606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=P2o0hyyw;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=kDsr9upH
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2MHAcA2430730
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=4Wod
	IHx+o0x8mOdMhlt22k4lCyVvacVF3CF8lj/COxI=; b=P2o0hyyw8W2kWy+48HDx
	MmkDx4r55EcETld/+U38+TsvF/8ZuYQxAVMYMQKHrgxHBhicoGUiqM3gkkNG2pNx
	nIkW7AjPZR0vYmT1moFXQatNztBl3G4x15DBxbJBEdvlu2MBv/XJRngIpzckrjZL
	1zrOuMlH5MkE0iW4bqhmlLzQnKeMMBXBzXP2dEhuedkoqrfiZXDDRczMCjCA7hpA
	xbvSZKuZJ1Sb6d/JewBK6U8PIKmKkJNoOnPXCSz8JAU0ouGSdPdXiJYuwgvmkAiF
	Mp9HdBMiwW0bt6zjGKl2XGFP0mceNq2eCbYZ1TtdwIrlxS0hROPdc06QXw9Zumkt
	UQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hq36908wd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:39 -0500 (EST)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caf7856ffso717937985a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660079; x=1794264879; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4WodIHx+o0x8mOdMhlt22k4lCyVvacVF3CF8lj/COxI=;
        b=kDsr9upHJc2Pl37vp5mByiicqgoU+GUkEbRyxay9+AEFJ+/O2NPuTc2Tu+ob4t41mx
         rTpYl1KDjXvUEvmnQt6JNrG6GFrwrf2ShNKYTdIRdHPLfvhbpuHVmKMuZeUm9pnDtYhy
         tI/XoR1XhiMsZiJmiMLl7qiGEvnKSBrcSTaNu42fQrff1PS8OAeUCH6c71TXCCD9wqGt
         M4rlHo867qqYlO6XM0x6ZaLqKaE8xUxHKab+eJC0V7zZV+P4AUtSEIbYtJ/F90Jx7Dwi
         14GGy9BTi/bxeCmj7eY48Y228nkALjwEa3U7ZPRB6GJPtpiCPOfz28JUy0/C9/1uKC89
         HOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660079; x=1794264879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WodIHx+o0x8mOdMhlt22k4lCyVvacVF3CF8lj/COxI=;
        b=fKWnlxSOz6g4B/c7vWZrEDwqkl9QsiQXA/u3cJS+0bM1ZzusvWNqcdRlhkOQD5OJPj
         eaS87dAQYf6tF4gGu4qmaEbvZvFB+WlSLxplTBdZsmAznd4jjHfmkReCTmrpIBuoBCIh
         h3jawzW1owfzz4h2FvW0IVtnPG7DpXkmOqoVhP+prpXOI2OAK+nRpTIS71xoRlJACikh
         Ve5lNGIvyuIu1B6VG5H0sblWOyASF86TgrQly3FhWm0ZAEvHuNZ0MHn1zIU91vctG8EA
         ECRQTV5t+LQ8oqLHDrYApqC30zERXIu36XMxM66keotiHsQcBY/Fc6jbp20XxrT8dZpL
         P/qA==
X-Gm-Message-State: AFq9FYL4aRNong1j3vOFXeed/NT8dw1ectE+xNiKvi8ZAM2o9lGMZ3X1
	wS96q1GMk7LHOAq41D13nd/Rovia9UZYuk90XiokhRE8N62vgMIE02cBIYog7/Gx1wC3/zc3/Bt
	ZXYsDAn5EYOfZ03Ygx66OL23DEF3OyKHk2KW29/w+kCWT2Pbv+/1I/lasWuF0DLk=
X-Gm-Gg: AYBFou2qtbUe0bQ3kDNb7qtJLFtRvDmcZdH0hLqL0ucxf0xEiVLAYHM/YRDHvIwl4Ix
	I2ona9qYzGJAPbaehdbmyDhZmJ5FXe5zB9qpY3seiX2/X6wj1VXDbe4D8AEfp7mpPJ2+PiKAhDY
	0/icPNL/vbFsVdo9EWqcj4X+WVsfh2ZFrXk1AesjdnRPLwNA/lkAnd85T6ZLaBYbkW9EIoz6q43
	oUCOzpuz/ajhHAMyB8bqYyYaSyM41bTzKBqFuAtzdBU/G6JGis4ja7uPX8mxx3ZdBF8pJKEIJI5
	AYYN0U/kxk6hrMUkb+9mbI8/XE5Kc1KgambKFqCmKHXj8rJNW2UuqkzPF6knJV+WYY7qt2i5YSq
	4x2aTi2IapEzKquGT/qNACO7nJDKg148mqSozNKlyYDNxhxvjrvv+0zry3tg=
X-Received: by 2002:a05:620a:2609:b0:944:dbd:8253 with SMTP id af79cd13be357-944217f72c8mr1693642085a.59.1793660079316;
        Mon, 02 Nov 2026 14:54:39 -0800 (PST)
X-Received: by 2002:a05:620a:2609:b0:944:dbd:8253 with SMTP id af79cd13be357-944217f72c8mr1693639585a.59.1793660078879;
        Mon, 02 Nov 2026 14:54:38 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:37 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:10 -0500
Subject: [PATCH 5/8] mm: remove find_get_page_flags()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=805;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=n+LSToSjOm7X2+ats/vE55AtTanVeZ9G8sfdj5eY+qI=;
 b=SLUwpgSXGUPwLxafx3YfP9ua2lMfAyIM7MGJHk4+fQuEir/y/Mm7DSEa79ds9kqwGshw7+/nv
 eDd9qzMfmilCmG1z+7o+2ocLmkVs8daBhezdzyb2sTGJqXn6Gm4KKDe
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX7CeBnOKvqEsB
 RVhEWeKzhX9cSQ9+Kdodlm53ky4xgaJBz0FT4NOV+p0TRaokfeAPBrHXUhXJ91+y/0X88he+BeH
 PI9qxOxjhVrEgvAn+zRYeZQEYAWhOkzFWuvKMIY7Mc0bGHans9OUVvRipO+OM+jZmC6d4VvQuod
 bkMbey2tNd1UrwsyojhAMz96034zvT4CEkgxAv5fhH+v8V+wq1QsJYc9HKjxwugjb2QEwKKgJ3F
 OmJnRn73lDJiDXi/xBf0gawLQ+OiHvcEEsmlLaRrk00c5shxFY4BA/MnDNb4WshWJfIapKfVUFg
 ZPb0MVtTmIDkmYufLMMcqHjeeYhl3eglYz9b8Wg++E6gEJxHFIHte74PIvJfubOxtftVVuqiosK
 9uUdAaJQW8AT9Rs5z6LE1kWXg1Z/QdSgVSTr2RFXacguartwDn9kt9EOykS7XRoMxZdWEmYg4Mb
 mayWI3RV3PiVQ6L3IUg==
X-Proofpoint-GUID: Dy_hLpK-w2NvLqblhUEIEE2oViqOZ-uT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX+Ro1Zk5r5qOA
 w3ALf7wJ2OAwLK0y+y6DGuFsfQGBeaFqxKOgTqy5be89CRPxPYMBavArlYY84ClGwKJvxaLoFeI
 FLqyi7j+F8vErX/NeeoZKW/Fm/WPeNbTUALdtPigUy9EwGdR622y
X-Proofpoint-ORIG-GUID: Dy_hLpK-w2NvLqblhUEIEE2oViqOZ-uT
X-Authority-Analysis: v=2.4 cv=RKEmjIi+ c=1 sm=1 tr=0 ts=6ae914af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=odCjmUfI5hfCSXoyQxQA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=10
 impostorscore=10 suspectscore=0 bulkscore=10 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020090

There are no callers left. Remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 37b7786350c5..00e32f96b459 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -846,12 +846,6 @@ static inline struct page *find_get_page(struct address_space *mapping,
 	return pagecache_get_page(mapping, offset, 0, 0);
 }
 
-static inline struct page *find_get_page_flags(struct address_space *mapping,
-					pgoff_t offset, fgf_t fgp_flags)
-{
-	return pagecache_get_page(mapping, offset, fgp_flags, 0);
-}
-
 /**
  * find_lock_page - locate, pin and lock a pagecache page
  * @mapping: the address_space to search

-- 
2.39.5

