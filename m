Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539A3B47D2
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689615; cv=none; b=GsIAthTtNia9IH3HWPDve8Qkv2uqQp3YDQW2EmPh8xzvYkwQYJR9OrahRSmfara3nqgzHq+b35y3ji94q0bBvb2jucctUGb6GBDGbn5CSZD7cV4Q4aO5fOoIOGizGn+3gJ7Tox9SBXYa5y+W5O6PGULDmIDkB8KrOobLVaFkjwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689615; c=relaxed/simple;
	bh=4gWj9P/Tx5A8TCUYXaCRC+u4Ad2C15i9Z4yoGnfAAOA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pgiA3d0uN/PxZl7D1K+K3Yk3emBt9ZE/7XegzoJemRGvqp7qHdEA1v44QftNA/nMYPT993gFbMREZxvZoHdlMEruD8QZxhnvOH7aqxZTq9RFfeSW7E6Ei1DUn/2WNAZliagHoTOLeurodlhc9lqzefzPrTvvL4EdwbnG2IwlrTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=P+geTUad; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="P+geTUad"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672GFa9w1600194
	for <linux-fsdevel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jdmVuzsAgoF8ZG4dTGff/k/Wwa
	0EKprHUxiw6VPwyFs=; b=P+geTUadJWXWXd0dA2+8ob4HxWiNc2WyVVpMG4hQSU
	qr95KBa3NoopgGnmbqtW2mmrseQbEcv+epsnSR9qfdWOapIld9M30o+ljxAGRkk/
	bM07HYlA2/D9rzTvymRtLeZV9VgC8sp0r6oPDhCcniV2oBfmbdHyS3VmKOGUizxq
	BzDW4xOpn7j1pJLc4d6yUQNf6FqMCgeBWJEz2d+cikXG3oOvMQLNFAvkrKUD38l5
	myDlDbQ5yLL9a5xEXQGQAaATwAC6dqd1mohF1RHOfEP4kYFKmQRpnjh4WmLrx+tM
	5STlCqtdwifU/iV9N3YP87mbWpUgj5A0+idRquIfzzqQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ft9898403-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:31 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-907b38aaad2so28567766d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689610; x=1786294410;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jdmVuzsAgoF8ZG4dTGff/k/Wwa0EKprHUxiw6VPwyFs=;
        b=UqYpZ9XTwO6aG9dnSVetoio+J6AwzTZSC7Ggd7+62fOul4o/yi3wSi34jg3IvzYwCL
         A/JU//BqSMWR96WAHi2K0CqUCfbiJtM1mEacSQDEQkfgD212YKat/if4HlAghdR5dhs6
         +6mKZWLKy2y2D6euhxzxpZYhIWhmPjcZFso/Tx4WlIBs9EWNvjLdMR06l0AuJB+voC2D
         X8cEJIaK/PPjPTl5D2xg0/fQ08CPO0CoLNY4JM9LG+Uhg36T/1dkdFA/eEqP7uD+oy9H
         Yt2dHvt3d4GOkWDYYCOfOr7VyMRBS6nW2VWInj/KUlcDbYKs53wYlpCnuokePoYcCjtC
         Jt7Q==
X-Forwarded-Encrypted: i=1; AHgh+RphZ4Vcl1wCUrkxk3wdFp83l9l8CCuhBdR6wa2MkuF3tYG6GZ30t3lMsApGSBQHgZ9qTNn8/k5HNXvLOkdc@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfeGYEYKSjHZA4kxbFrTb32oPgjvA1z1jrUFX7vZj9arIhjbg
	8JrDpslgqdICJxtNfRxmnSuDJFBNtlNJhPj405CREalxtG4bcfAJr0gujZrEDOo9JNx/v4N0bC1
	bcQ5oAFe7iBsrUuNwDA5teMF+kpVlBBrbh6fHAGbcZjj5R4aZadG4KRACAuboFkg=
X-Gm-Gg: AR+sD11kqBzwZqx6Q4Z7W28Pwugd8p26eGfsFzDzexdI3M9PpCCd+OecLy1mO8n/sSG
	OwOloWhqTbtHxnbmdp1Jl+KgSBPEt7SetR9665jjL9W5GT+8y/p2YWyeNhrNUqhgOCZ3i/YJGUI
	7WFv9oJD7HLr1ozK4u7uhLyIK/dWpLeBKS0OsjpjZiOy4jdTE65Ezk1utqQWc2bhy7hqDH09Spq
	Duv4N9BT9pRPxyPoqA5JbLzGwoEvd2pOE1Uj8Y8T4uol8B5/AoL6E22qXIgB2qP4bnMygW65LNk
	L+Q+muyrUm2iqEFvOcKzaRlj5PWI0a9lc/LoF+etWU/VVllwCGNOPfbGmc3mnUvmQisw+y33SHO
	0IFrWOcIoclbeNmc28wkFV8SGaM7CquYHkOhURDhZYCId2MHCr94=
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-52b56845401mr153860821cf.41.1785689610160;
        Sun, 02 Aug 2026 09:53:30 -0700 (PDT)
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id d75a77b69052e-52b56845401mr153860481cf.41.1785689609667;
        Sun, 02 Aug 2026 09:53:29 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/4] mm, ceph: remove wait_on_page_writeback()
Date: Sun, 02 Aug 2026 12:50:01 -0400
Message-Id: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADl1b2oC/yXMQQrCMBBG4auUWTsQg6TFq4iLJP3VUUzKJLZC6
 d2Nuvzg8VYqUEGhY7eSYpYiOTXsdx3Fm09XsIzNZI11ZjCWFc88gxcvlXPiybdkUakIPj54gIm
 hd248xJ7aY1Jc5P37n85/l1e4I9bvlLbtA85vU1uBAAAA
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1390;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4gWj9P/Tx5A8TCUYXaCRC+u4Ad2C15i9Z4yoGnfAAOA=;
 b=pNASrzhNLQvlvnBF+sfz/L5yPNAba9F0lNWjDHJrGgXdSZk5xP0Zq2QRt9cBu7U85CTudE8Ym
 7MEugh8NiYDB/Q5bk5LCgMuVuLJcddMU/E9la85P5BX0kzWs6U2bS8O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX/Vx244m66Drk
 alEi9MeltfYmdPUah31I51o6LKx7EOfpwMbPU2DCl0cqQk7A9R45UMavRqbjvi5CG4FMi7Fnbqr
 xrjOFGy4zYfpCVJQcAqZd9tr+pVGAAY52Kh7tgo9qW9qcx+YxZM9
X-Proofpoint-GUID: qRkl16E2jwWMhxq_HX-Jnejzwb05mEBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfXwzDcgbenFBX3
 q/+ouoNSSSPNZyCrv4vFlWRubGqYu/yE/WOPurjBEu2/VaD777IsAAInUzMnDna3+IYPsnfR5gd
 bFeoKKYWUMlff9p1296SSnrfHuP7yCmVhQWJXRgTMgXKJF59enOti2WXqlc5yRO7zIWc0ikH7Ld
 1DMGDcVH5hk9fcVnEXJW2yH9+ol7JPdcujRsdtM7v2Sb02YTr787Z3+ImJ4CCwvJmrZWY/FxHm5
 CAxJtdj7K/HeLQnpBrlz94JbawCDlkViiTXG0bIQFNGh1is5mK9oa73vDrXD9VxfM8EcqrgRnke
 LmvsciHlL3DCNpZnX5GYci4M0OLx0HjCzjGekxBgfzGCOfvAn6z55IqNSyOXYF8v4/4YYfECt7d
 IiAxA2kqgIv32wsFENWWepMJK+WlFcjfjyCuy6zbV0JEIK5H1bRwHW71IRfTkMM9dhY07XPiH4Y
 03EZcFx/JMB/PrXDDdg==
X-Authority-Analysis: v=2.4 cv=G6ss1dk5 c=1 sm=1 tr=0 ts=6a6f760b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VNIlXpW_hWjJ5J6HzMUA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: qRkl16E2jwWMhxq_HX-Jnejzwb05mEBS
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=10 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020153

wait_on_page_writeback() is a compatibility wrapper for
folio_wait_writeback() and has a single remaining caller in ceph's
writeback path. Convert that caller to use folios and remove the
wrapper.

Along the way, replace ceph's page_snap_context(), which uses
page->private, with a folio-based ceph_folio_snap_context(), dropping
three &folio->page conversions at its call sites.

No functional change intended.

Note: This is currently based on mm-new. It may conflict slightly with
Zi Yan's series "Remove PG_private by using page/folio->private checks
instead" [1], which should allow simplifying ceph_folio_snap_context()
further.

[1] https://lore.kernel.org/linux-mm/20260731-remove-pg_private-v1-0-142c97ba3562@nvidia.com/T/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Tal Zussman (4):
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      mm: remove wait_on_page_writeback()
      ceph: remove page_snap_context()

 fs/ceph/addr.c          | 28 ++++++++++++++--------------
 include/linux/pagemap.h |  1 -
 mm/folio-compat.c       |  6 ------
 3 files changed, 14 insertions(+), 21 deletions(-)
---
base-commit: 1dbd7c34bb92dd9c0b0363b75f6ec444299af108
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

