Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660066;
	b=skV3rPTew1gIOW+dD59VUKKrFGmBwIkwc5IzdPri5p3aJ480FKnxsE9Q4YcXbz8ugIy9
	 zXH2VggM8dmAC0rIl0Zw2kciY1kBaJ25Ys0doJcraOU+jKesbBl1zmv/akdtVfKorunig
	 tMIxa23PmARD2Z1FZ8DwoSroFcybYj6zm9L3pf+8cT7PBni4eHqvMtdNP4Rf/8Tj36Tqb
	 50OQsRzDeLVwH1/5IORLmrwHtTpdq6BSNsLeNMhtY0k8dRc+fekuDI7yiwUmtSKwxJECg
	 +5NM5EKd7GvPnlBJT+iRf/ANKzWI/rYFnlK9zry2ozpYkrmBbQiJd7breTxRkg45YQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=5sbOCMDhjH6xs6PfuYcn/1F/Vkftc0vzSyYkPk5CQWc=;
	b=SCnpMd8ajHG9OeiKzT64T5vqZPRFXCZG96q69I3BGSvqAHZaENbEDVUhWBr96TQwhoOg
	 SpNaBXECDDzGkfy9kT8QSnanBO4pWm+M/rPUILB+yryvsLN+haKNrxiB2ENp2kZGPU9s9
	 JOxeKLYV1RAkmnyH8+amQ0L3xjUVuQs/9SDhKELNXyNV0kyO3FaJBqrh+xVOG3bIPqvlG
	 uDVnoNwRdtwxhRAPBgkbGkq6tPkJAx7ufk6Z3gGHTQoNQDptL+o263t+5q27ABwZ/G/oY
	 dxRN4lrz+uL48pQY/R4m53D5VZtpmAHi6UZfIgsl8LTlH2e8HUF2nOLtyjW/ygIRtoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=JQJRUwEP;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SXQ7NMwg;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963B606A32F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E963B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=JQJRUwEP;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=SXQ7NMwg
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2MHEYs2430892
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=5sbOCMDhjH6xs6PfuYcn/1F/Vk
	ftc0vzSyYkPk5CQWc=; b=JQJRUwEPyQiLxEVGHM4Ratl59KiwFIpdw1D0lRKm7s
	zbX10Ts48hSZk1T/N4anutoMyZK468rvcgAFo6PfRUz74NCmdAdpr+BHUW+2YEIi
	7C9THXlVGe1Mg+jNAEmg7ndNFP3+MsCHBykeqyG7yu0JPRfF3DuEZ8Cxrt1aYoy2
	TfTRYX+frhAO1tQBpNJr5VNdonZXZ5frZ8uSgFEOh8Fq1WRxOlV4yK9Hs4hguTKE
	W3enCqdryBK4aB4kW1Et4ed5jxVggsW2cwSuK1BhhbHwOuHZyI5NOCuAWHnYGT49
	zqVCVIKKNOiYpt3Q2oNIIn9M1gPYnXqXHbvGTocGWNvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hq36908sj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:18 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-537548b8342so79016661cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660058; x=1794264858; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5sbOCMDhjH6xs6PfuYcn/1F/Vkftc0vzSyYkPk5CQWc=;
        b=SXQ7NMwgq4qeM9Lc9Ltx6WMo1+Me9HIyRcI9XmC6y63DMTOi3I1799TScRKhi67z6/
         L6tuV3DgYAbRioYqh36c+OhQ1eZXm68XqGMcLFvgkSnXfTpp3LCrULywBATz7LYnjM1Q
         8+Uvw1gpdVR79QRzr03+13DGTsjb3r3r608T8bRNF0TdIUQPzH+FWhH/CEF2XUncpNT9
         J4a6GayFqT3o50cjcTu/NDPtPlqJJfgKvmCzCAhUp+cbSTIJqAqgDjq/YBc4ANx4t2z6
         MHpZBPm7U3jQgbHgv++G+lEJOfC/7zey7hlMjXpvtKlRJaXHboXZ7ERFQwZHSWT7VIZ7
         hYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660058; x=1794264858;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5sbOCMDhjH6xs6PfuYcn/1F/Vkftc0vzSyYkPk5CQWc=;
        b=EA1jd0b/byneNq8oD6IkatR/NgcBou5/VqvER4zV8RxTvFseTO2vVlBDpHJfuKL89v
         kUAo1V8ELZ0Sza8/K3rLPACkjeyO8+cTHsN+gqPi3vJlnh2QFgo3vQ/aV0GnpzBlO9ik
         KPESC7RpRklwAWqGrG0IXh5ybuyFRt0nNYWiJZxIxRaXHuKcYKXuXJ9HvhTNAoEo3w5S
         fox9ibzGm1p7/wGHnp//jgrfPrblKgBubkLr2W6i5ezdaVGNLp2XYafjnwtKUFQwalRX
         OKQeUi0EQuNcpNPaAC6W8qD4nBAHRpSxprhBbOlLVxNO8W6X6sflYyCcwPaYSWFBqXSI
         X28Q==
X-Gm-Message-State: AFq9FYL3irbygZTf9MmuZqjmGwgZrRGjkaTbdC/1GDqkqDkJzYUqxwXl
	uIvDlDH59RrSJwXPYscWJSjqC33jJ51eQ00daNgd0VgoOHnl1RR7cAUBhngnd8VkwQyWzrxKM+H
	ESfDt3Wi+RrGrZKtmiE4W3BvqqSAlXDJtq0nYCv1dpysvYtree8DmoTWvxhqcktY=
X-Gm-Gg: AYBFou1zxaAfm+poFk/ybUn4dNjrC3CboFuPZU4/2GbLnMWfMm5hBnfGi/Rm5RQaWBR
	RyJLPtnrF1UmeIZnPZeWlu/ufgwnfS8Q/CkIewImcTbK3bcmsgcboms0nV+OHa8Myoc3KXJEktW
	AI+HEMlh2zghQvqzWgh3+OhRYZmyRVt8QV8423ofYubb+BYAqp6142AQYa4tB5bHkyzH8YFtvA0
	likL0kbbxCLSlZgeS7PIrbkKR/aCMbo9Ai/t5gmIU5ccdDsVUdkq3YO0T2I/eDvUYEqtram8qyo
	hj+E6a6kTTVvzeGlHXaMJi5HDb3KKa3/v0Vw/RbYsPlfX7hN1a8ckS5o+4e2+N81/s0U5zppHgF
	dUNL2wG0963u6ZMumBUSyjk8kIimxoi3TA0niD0dpGHXYTRMtHjtRxZXBtVE=
X-Received: by 2002:a05:620a:2984:b0:93f:2e7e:c818 with SMTP id af79cd13be357-94421799c57mr2002811385a.59.1793660057772;
        Mon, 02 Nov 2026 14:54:17 -0800 (PST)
X-Received: by 2002:a05:620a:2984:b0:93f:2e7e:c818 with SMTP id af79cd13be357-94421799c57mr2002808785a.59.1793660057322;
        Mon, 02 Nov 2026 14:54:17 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:15 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/8] mm: remove newly-unused page wrapper APIs
Date: Mon, 02 Nov 2026 17:54:05 -0500
Message-Id: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAI0U6WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA2MD3YJEoFh5UWJBQWpRsa6xcbK5hblZoqFBooESUE9BUWpaZgXYvOh
 YCL+4NCkrNbkEZIhSbS0AkhQ/lnEAAAA=
X-Change-ID: 20261030-page-wrappers-33c7876a10a0
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=1410;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=xHmePMIFwKfnW6rP/IxD2rFrXi5dM4an870KORSbnuU=;
 b=lG6joMyHvVMs3XovIiL7A9A/jTYzjW8jix0W6c/VcH0NsKuUnCsyuQiQ0VA4GdCMpBG15G0Te
 VA2TieMfdb6Cn5Mgy/khnHItW7rGq42QwrVCPc95P/HiD8C3OfrIONw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX1+3NgRW2KvoJ
 BMsazzt4FSeSCwmp7FomTRXqhtRBp2AniVQ8BEwOt9sHnQmMV1wootl8EgFwcjtkc2BLOhIvBEv
 mNnSPeSfmKJD4y+Vz7P2OPgR+jqQ1UNTk4OfnBPfbUaT/gCFuW6XszOGSWfM+6CIkLJo7VyfKzK
 sEmt90CQnmmwmbWtM4GEr4hrl3QaVmt3gsLKqkPnlK06D3iNeUDy2+6XZ1XlrUh6TVn5o7zbedz
 KZ5AhFOMyUsB2CkY2mXUJRDh4rslNXLaTqcBGXVyFJMNqyjcDSGdufK9nHYmRih5uEMwvCgvts2
 4qy06qT5H1JcKTu5RA3/81boRGl4n+cCLe10iC1tNOXPIhFsOTea2+N15wUmOv3LFw3bI0Ll6PM
 yeCsP7ANLW8vzYUaN3nMnIQVJY5UniFDt9WhRwDZXn6lMnLM6aLoSlXUyyFFeOBDGTHblLLFrRZ
 LvdRFjPKH4DmMH8secA==
X-Proofpoint-GUID: UpzHqkHCTpg-ju9PxIW6MfpnoagnBXVr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX5WbIh5F6Guhl
 93ppJWWrp6Sp6wul9w3abFAVn7DEHnlB1Z62+n/xHjUlU+VlURIhBxPz7F7DATlqZ9+p+mVCi3w
 QosTZOti0KLg20PWuAlTO3zqp52hqXY7zK5EVR156oS5EUrpJv5k
X-Proofpoint-ORIG-GUID: UpzHqkHCTpg-ju9PxIW6MfpnoagnBXVr
X-Authority-Analysis: v=2.4 cv=RKEmjIi+ c=1 sm=1 tr=0 ts=6ae9149a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=e6GcmG5u4wsWJsvmOGMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=10
 impostorscore=10 suspectscore=0 bulkscore=10 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020090

After some folio conversions done last cycle (namely ceph, f2fs, btrfs,
fuse, and page_io.c), there are a number of newly-unused page APIs.
Let's remove them and update comments as necessary.

Patches 1 and 8 are taken from the ceph writeback folio series [1],
along with tags.

[1] https://lore.kernel.org/r/20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu/

---
Tal Zussman (8):
      mm: remove wait_on_page_writeback()
      mm: remove end_page_writeback()
      mm: remove clear_page_dirty_for_io()
      mm: remove attach_page_private() and detach_page_private()
      mm: remove find_get_page_flags()
      mm: remove find_lock_page()
      mm: remove read_cache_page_gfp()
      mm: remove thp_size() and thp_order()

 include/linux/mm.h        | 21 ---------------------
 include/linux/pagemap.h   | 40 ----------------------------------------
 include/linux/writeback.h |  2 +-
 mm/filemap.c              | 23 -----------------------
 mm/folio-compat.c         | 18 ------------------
 mm/gup.c                  |  6 +++---
 mm/migrate.c              |  2 +-
 mm/page-writeback.c       |  2 +-
 mm/shmem.c                |  4 ++--
 9 files changed, 8 insertions(+), 110 deletions(-)
---
base-commit: 0e02eb17f263e4a3ae6bf1fe45122c23361f0cf7
change-id: 20261030-page-wrappers-33c7876a10a0

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

