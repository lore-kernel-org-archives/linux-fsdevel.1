Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2640587A
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371722; cv=none; b=kZfC6NhXU/rtRlJqIb47JqYMm8WlcSADH82q8d3XAwRNGNz5dWEKNo5WktobIDQBcez8XZ1mM6i3+PdF80NVfC8nORjS4JPUofhn80w72z655k29UEEc9cZvIEUSUGtGmQwcxSmwK0fW4walPlzlRjwCIZRmvomW+rGfs917K3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371722; c=relaxed/simple;
	bh=H+WPEAg6fNk21OMcWq4m8PpfVy6prUL5jC+rlshnioU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyGRXUgJ0Y7r22qudyFBbyMmYu3aQ2Ix76z9znXspmOjlh9NCO6FaNE/Rx4SgokWeRzpO391O9CDCP+ohoIVifMrvIIM0aMxmHQ6eQNW7bmmJ255l+iKhQ3WHh9dv5MPpUD8MX8C/9kolAVYv0Z1o34Y/nXFKDm/UMfcR/3jQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=bojn0z/I; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="bojn0z/I"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaLIw3029497
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=HS4+
	+7SfsgCqjVhck++B6W9XvkcEaVeM763sEjq4goQ=; b=bojn0z/IAr5WNLmoq+w7
	vS/X8WLw0/NTfqXqTGcamUIQWo4g/1L1wzi+AIV++Dhbx53xF/eodzujqjggv/dp
	Wjl0FEdLtxLDhDIo31SXiluw+6npK4Acz30nLDsWhvE/jjhT7xs4fRSt1DLPX34s
	a0p8FYeF/EvPTQo9DDd0DA1sr543nK5+qGslCJcvF4AH9g+k4Zqi5OnxofRnM0cf
	dC/eTYsHibBWFmdQWofYkVJ1z30MDCp6hzDaDdibLrbeqEbrlElFkVTP9CieoFIX
	yR9YAZg9zzfGmOkedQz15nZ1R/gVgQxhGlD8I0nopJIAskQHX9nrh1vLNO2JGaZv
	yQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxv0pvdep-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:38 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52769fc3f2eso26673641cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371697; x=1786976497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HS4++7SfsgCqjVhck++B6W9XvkcEaVeM763sEjq4goQ=;
        b=WVcvDzu09MDunWbUM7FP5x2GzrLWl1xf44OGBz/UpuLfb7a3cpqJKGbZVozMHEs8pp
         HtPFe66Bo/iPoe7890IQwHYQYQHPuGq8KmY/ONPkLngxzZG2c+UVyDnBCc3AZDS7A3ab
         CAF1mnepdgxKWjRP4Kvgbnqy7eLf4tQAgrX8VLj8Ox+8/q3d5xdPQkmn7LctbH5jxyRd
         nzghy0tZPfe+m5dZ2K1f5ixz4QmW6Jy16Sbc5uyK90GOHn968HjsWixGA3AdPeue2O51
         TRzBO1Lt0BIeqU8AtVJNr6NGOqbWXXKQGDzqKzliqoxoqnMLGYvgUy2MjT6S17sE0rKH
         ls6A==
X-Forwarded-Encrypted: i=1; AHgh+Ro7S8j6H4k+ThH5W1soDm1XelfQB4cooDbA4XaszFw3ss6TKoDsppgpllIlih0bU4FO/3fJTIg8/Hy3vAaU@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpvAzQiAQbAYKu2TKxiBQyejhKBEgA87y/wreOEARCB76ni2X
	g4ega3bg49N6FbVTRbLJKcGV+xQFNWbURCZjhqqZOsJ0usguOkxttpmt/ADv3Bo5/wtNVFqBb+q
	TsppXnUzWFhGqmhdB2osS5awM4CpnwQoHDv9bPkWJIOXtHfTXK3fUUSONP8PiJE4VGicliNJP4g
	==
X-Gm-Gg: AR+sD10HNI2RRIATayVltqQF7TLrloHRXlIdpimyGRAcVfVslnaGtBoEF4zzyc/Y+iU
	KdKifWmYZeoHH9529oTUWKxvfmsuIalDunzZYHz9tlTEfE7YPPHIgPOZIQLVD68Axw63a8VdfP8
	HRylLS8lGF5uErPFW5qOnZZFnrysaZlwjQDwZ7nQjTUvw8HCOeBUVl5iFLjuVysk3Z8atFAzfzv
	Y1aZE/lDXgWSmwJszG6eGI2EMpYufZgVeSfbu68HnKt9AYfgATU+Dn55pHVp/xXkkCog+Ds1GTJ
	XpmThO+ZSXdselAV7iOvtLwPHGXleAqwIw0bunpFHkRSiY8nUz79SkBrIMp9ggAUcmQ0YoYa06V
	39QHCmhFV
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr479946491cf.0.1786371697310;
        Mon, 10 Aug 2026 07:21:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4811:b0:516:d60f:6438 with SMTP id d75a77b69052e-52ce5e01448mr479945641cf.0.1786371696835;
        Mon, 10 Aug 2026 07:21:36 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:36 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:23 -0400
Subject: [PATCH v3 12/12] ceph: rename ceph_check_page_before_write() to
 ceph_check_folio_before_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-12-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1302;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=H+WPEAg6fNk21OMcWq4m8PpfVy6prUL5jC+rlshnioU=;
 b=Wb7zxOOE2mdK7NryczQ1B0RD/gwzEja+WEduJUoRi/Dwu2V70eerTkzJiLplKw68Da/YSBGCZ
 nq/6m0GxSXwBAU0HM+984/XsYO0YrPj3RTxev/kZTfV8Wr3VvludnS1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX+zU9f20rgEFm
 QoPo+IW5CjweYL67UwUx2o9ijt3Lzch4jfjz8cKXbS1IQOD2z0XGTS/WYNSQ0kILRZMRk6Wm1tm
 ys/WDOArbYPEFok/DgLfpMCB69AJYbNbiW5bs51VfKFC/iL/HBLZ
X-Proofpoint-GUID: r-3EtdZ-XQhG8NV3CzsU87jQET6c-x1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX//SGbkCYUh1v
 zBCmRmqLa4mmGeudmIwhhPnkdlNG29EDUoKE2GE2u5ksc5czVaykKMukU9JDUg4kuoq2VWulqf3
 tKpAtzAth0wVOMcfVB172OyEp1LSz1xpTK6r88Wpfzv3Z9cc/8bhcb+Z1egB0fIBv0qVGluN8Ad
 xswu8mBo0C9uP3PBqdG2Ho2aiKR+XxDPd2JaMAhTTze/lPR+UfqTTuY6B0xJBzdIe75rBT3lXRt
 fI2xiKA39h22e5qRGjihLvASicxc9sZUTXUjXEO2Bcj/bqP2OkLWsjPpBwUkOsd3/Eaao+yJjiy
 LWnEedxHT9HIGdeoxEMWpWSprQP7Mi14udTOu85MY9LKBa8z6Fx955zLecE5FYZ5VqZja5V6nSr
 NQ1vEXHM+xQ5nlRjeM4PIXo0HybJSJeiu1wkvsEBeIEsBokA60bteNfVBMc2+DvHF5WzRYg+B69
 NXrQYYDIxSNBZEtWQDQ==
X-Proofpoint-ORIG-GUID: r-3EtdZ-XQhG8NV3CzsU87jQET6c-x1v
X-Authority-Analysis: v=2.4 cv=dcuwG3Xe c=1 sm=1 tr=0 ts=6a79de72 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=V3EFW1AtJEMGhprvICUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=10 spamscore=0 bulkscore=10 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

This function only operates on folios, so rename it accordingly.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 708343a8bf35..68018fc097c4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1164,10 +1164,10 @@ bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
 }
 
 static
-int ceph_check_page_before_write(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 struct ceph_writeback_ctl *ceph_wbc,
-				 struct folio *folio)
+int ceph_check_folio_before_write(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  struct ceph_writeback_ctl *ceph_wbc,
+				  struct folio *folio)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -1351,8 +1351,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		else if (!folio_trylock(folio))
 			break;
 
-		rc = ceph_check_page_before_write(mapping, wbc,
-						  ceph_wbc, folio);
+		rc = ceph_check_folio_before_write(mapping, wbc,
+						   ceph_wbc, folio);
 		if (rc == -ENODATA) {
 			folio_unlock(folio);
 			folio_put(folio);

-- 
2.39.5

