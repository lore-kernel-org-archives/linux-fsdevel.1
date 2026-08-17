Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9115A448384
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994157; cv=none; b=USKOhB0Bv0oCr4VlsVLFwRTXntFKE8YHRSHkVSsOhjdl12OrwbZVnEvNK5vHOWvRQVLMtrOfTT53Vgc0pbRjY4wq5nkPRPTl12ALqX4ra4tpuXf38QLCj+f2Q4+H7dU+KFKkLm6gbQmq7C98O1o0wqKIo2Gxxx5WEN3uKKxu7xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994157; c=relaxed/simple;
	bh=UQQfnH5oUv5WndyYs4Z+J0hoxAEI77yDbsTq+QWKC34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EllGM0rw5xSnM4YldCJ/F5zOnGVix9BgNokHBH7CjuZ2K8T8htnOsa1B59TB5bVC7YCGhqTKpRkIwIqDTION1lWugTgrCLQ368SthFj/y3H20LpKwIHSH/ir4lZjtrBxc8xWEmJmpdIcpCqL3ASrrgd4nrp7HeyZ066QzEOXCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=oJk6CbHQ; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dn0jlZrV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="oJk6CbHQ";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dn0jlZrV"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIYm9t4067111
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rvte
	lDgcI1kH/2E5UCPRf+p2X7037VcyjW/+hck8OJM=; b=oJk6CbHQWAYPKqC2k6SO
	7ruOuQuC6l5zSeQR0kTEx07+l4/MKffLRbjYBCZ0fZH1H4amv1qf+uyLKNeeKqFG
	ajS6Y5FFHyqLh5AEeWNVXT9z4g99ViN9+Cua86tmzxDN+h8JzimTlZ3jXX5j0Pyk
	DggTC2d7/1VP56wxGd3yVrbVUHIiXIclL1lNDYE1c3vI4VlKwUgblhst9uHkMpHm
	xmtmawJ5lMhZ8VJ3F1giL8kX40pEepLQAcjonQFRrfe7fyjZfwSgjV4xgPDV12wU
	a2B68mj16nhav8JvoFXb+YGPDrYrSfHi/NNX3M5FFpT/tzwXe7XtJeyr7hnOGW8/
	Pg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4g3jk2x5bx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:50 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e4f946461so395287985a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994149; x=1787598949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rvtelDgcI1kH/2E5UCPRf+p2X7037VcyjW/+hck8OJM=;
        b=dn0jlZrVTgnTKDdTW8pM5mGU+hWThw9xpRgpIXQ7gBJeddzeiCEnQEaRKo321Rjvp+
         rzQI3H0V86SgFdrZvNLUq3A0sXpVncHsptmECz2aLnoPi1TQ4Rbp/EsTSQtG/BRYE0Sn
         y6UTmO9MFsR/0hfbBtoM9lq9+bfoNUP6ou8hlsKs01hnNsnv/pPryHEHcGARWA03vPAJ
         CZ9Jmh47fcXnvP+kXJw8tiUTWmLilbiE5SCcC6YCCz5dQSjQ5VfBUgaaMCt5MJzS4HMB
         A7KyUkXHQUVkkXbton38jqhVjg/+zDxySE+HGKhleMJrvEBbbiRM9asqahpWNp82iTLe
         v9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994149; x=1787598949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rvtelDgcI1kH/2E5UCPRf+p2X7037VcyjW/+hck8OJM=;
        b=EZRQ40q8xv/FNcxv6D4ohRPSFrRFJ2Z6e+XpqOW3O4cBKIIS8gm452Ju7QrD+zYXyr
         dEOb7waXl2tIRS7PRdHIlJLxsydM3F6gXrEqAnqG8z0WG+jnPNwe2lNJFKhhjFNt+5nS
         ZXfaz5yWXOOq97PMehFxCu1P0RW0PixPS83KMtlP3jyCpMHLAyPtucWU6YuWTjsb5tMC
         hwv5s3LW/x4BLa+KLSJ86KIfRb89J4UA8KNOvLCPHj31c0VffrfgzgLHUrny5h6ikF1u
         4HSgQJsg2I1ssHnELnxstd09xXsDZnJcGm7MUw1PNmopIPHHsRlAmWOE6z4fwZkKIVgU
         LefQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp1Y/quS/FL6ghJbgRmjJ2QreG5lEghmhh9NdhhhzJp4oYiDjXna7c4ctM2w/WbHlbMvDcMpHnYSpeLYzZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdXHeqN1mHp7NyNcRS8ZEpHGZgtVPJewUjS4HwxQavduediTg
	ylKI21ixno8n/ZdkvtOGfSScR0foAK/Se4mzVbwOGaek8+KUrNhvkLAPH0M3zXTx4S4zZ/R35KP
	cWJ61E35w53v0GCfWGmkOUGgN6VyJh0pNIlgP2YZyMHJnX8/KuEM8pv0mTH3Mn50=
X-Gm-Gg: AR+sD13yTgo7RbWsnfr44Q4HybkI8KPhBb3FviNFGtdc4sgWhJHIwdA/Oo4WBH6L3Vs
	14fgKX90atBsLUB+M+swZ9xnGJ95jZ+7Bcy3Vf+Q/9RGgNlNTxTyMc45oizBSqKyFhgyRDkNB36
	wPmyIv56R3bK+E/6qVw/HSdL01U6Ac5ac7zpfgRlSlVdVK6qthfyacr4WgWiFUXrvliVJE47LBr
	kZdudargJ3iTCdJBPC5U+gXG9thshyvjdHG4kk4fqyJrXHoxDU+/9ChReE+eE0A9Non13nyn52r
	gBdlKnmghzXYpVjiPVvFopzD777sqoMcGNREjv6DM2Y6N0OL6OqjUogcsyROgv4FLLG2wyvaa2A
	Ipe3+VfFi
X-Received: by 2002:a05:620a:3910:b0:936:af9f:4c30 with SMTP id af79cd13be357-93704b8dbecmr244835085a.25.1786994149438;
        Mon, 17 Aug 2026 12:15:49 -0700 (PDT)
X-Received: by 2002:a05:620a:3910:b0:936:af9f:4c30 with SMTP id af79cd13be357-93704b8dbecmr244828985a.25.1786994148981;
        Mon, 17 Aug 2026 12:15:48 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:47 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:26 -0400
Subject: [PATCH v4 10/10] ceph: rename ceph_check_page_before_write() to
 ceph_check_folio_before_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-10-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=1302;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=UQQfnH5oUv5WndyYs4Z+J0hoxAEI77yDbsTq+QWKC34=;
 b=b6SAW1tG4Jl7P0GV3rFpdHlh4xB2uPa+WeZWFSPqUDH+h6emiOeLsu5ztyI4BoxstaWB38VyA
 ugdc1n00cnnCTPAiaUPYSjTX970hRVzSQHXW4Ew0kljQcrR37cPRDJ5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXzW1yHDs9UqgR
 E3FNryHwCiJfi0lH41w+hfof+gOk701alEjO57wh2aobY6xYomI+8rptDnXkbTc2Lm458ghT+so
 7J9eyHOmPFuUBQXCEfBp5KOkwgOoQ42XepXbh81mbpRVj44+fgekV84/d2zRmMGj1VdPTCMov5K
 HRhXPfj+B3eqUNmDQtkg3YMjcWuyeeKEgHLU5itKooPTmIXLQBhpcjR8ZtBTtRBU8e234F893Sz
 E0ziMzH3dHfySSklcy8eesVeMqwZTF1wMiozHJonTnrVvp6C/DNpyVkKFrX0sryRLKTLNvJ2/3W
 i+KSkoiaTL/P+i8tFESVss+IatKm9rvXmayJY6ptXtkQl+g97wTYWHzxBwhG+lOgQKmcKJmfGjX
 j0it3uLa8yEY7w1QpJ46f7tAadb/Woly56Gpza/RVv+NP9IvrjuOub1JOfH0vY80qdnkQtGMMqE
 PVJ04I0AODwvj+OgE6g==
X-Proofpoint-ORIG-GUID: LV9b8ooZ-35g55T0Xdtbeyoc18N_1mkK
X-Proofpoint-GUID: LV9b8ooZ-35g55T0Xdtbeyoc18N_1mkK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXw1xemNIfI6dM
 GK7k8R5d1Z33QYpgNCVzEz39GzuI4dp8m17LxaYkMCPs98Eu84SNOTWioHNnP6jIzd1ZwvIc3MZ
 WHGkwYQ87D3d1YkxVDUKSfYGSI9t01yC7SwF2oE7Pv3UYKPK5gmW
X-Authority-Analysis: v=2.4 cv=V61NF+ni c=1 sm=1 tr=0 ts=6a835de6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=V3EFW1AtJEMGhprvICUA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=10
 adultscore=0 suspectscore=0 bulkscore=10 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170147

This function only operates on folios, so rename it accordingly.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e1ff5d9fd121..595c8a1518ed 100644
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

