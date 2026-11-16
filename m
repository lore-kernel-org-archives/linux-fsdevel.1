Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859480;
	b=GsqkMO7aE+yNPde+KNoWIiz0DQ5ubYyquyH8xufZuPvLLzYq9G/mPytA5PRmXCj6DdtN
	 /gasdHz4jnNUhROp2rBzOBkx9uWh//L8lVvMyg9/HdVL2R7ZEXWO0pMQi2HYSLu86p1I2
	 mOmFAh2iYVaWonVfRTcrdfw7XueHi/05af/wOKhUrli/40So2WXR1ASRQqSBveL6pXhEO
	 SJKdN72P5hUhDEI5Ub0bPqCmbdIijusOumAOitQvTVUSQ8jDaWowLZyZJJUihmdX00U/T
	 cc8QvSN6LWwu35hRzh5RP7tQH1DbtslSv5Wz+JgiSeHZno9LrTo1Tt1Dtq38Uns0S7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=OoLTYMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=;
	b=w58u297O/WnFOaUFeS96Fjh5X/6/yjVwEpCHDsT/wFQrKE0skj76iWUrx02LQB42yqHS
	 n8L6DTqrlfC+QFWV6xI5t2TiXUa2X3e70Q1jwfcgda0FcJ+pKZXrQi+3ugwCwQuQ4C81U
	 oAu3Ad36JO/21uLmFCOrz75ip4+eCiRfVGlagTVo9IqBQ8JAV/k58kp80y8lnzy+eqmjU
	 DSvUG6t7WYs5pSWtiXCQg3VSi17VgQXJFNFjaE38JjNlN0yAw20KO7gRu3mRRGvCrymKK
	 K4RwbaeRAQTaic/iFstfYuyBkdbecC4tE5iWOkgof6ow1ab/nu5REDGiUPFN+PYq3ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VmPp7q7i;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xdinjiwO;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF8606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03EF8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=VmPp7q7i;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=xdinjiwO
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXbdN1468003
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=OoLT
	YMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=; b=VmPp7q7ixR/GQmSlNvEE
	kjmcyohLdB0C4sFEehPP88ZgwKMUFwGkFDkqrb2shv1Cy7FPgg0x0r+Z9sjlHc/U
	NuVTsGNgAkBRak1je4y8WwazCm93d9hmEu/dCxQbQ6BBI9tkC8MGMN0GJDzDzYAo
	HXE0iPoGzC2ycj9VXVdzPX8bPAyV8R+vEwZEIpKQksNa8VmYKjUSxaECMxx4RK5y
	MrHC1Dhn2b4sQDsej82n76kYp/RVPD1H3+7ugnCS/qVwCiaN6+h17CRFn6ZUWi6t
	zHDCuP5vvBjNK3/GrhKIuVowWPwAE7dn9kj1ax/2kXEjEk1RejzlGDP8vTHQCmbk
	yw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j059hj05h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:38 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91f10c68ccbso4725026d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859477; x=1795464277; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoLTYMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=;
        b=xdinjiwOvh7Rb7Usr2P1YViDUWn1ukgLwMG/13NCKu37z/AknGIRXqztC/QuPi+276
         hhyrVKLqAd7qwKR5u6UAadzONhD5PDLDffII9lsNX7dHeUqt2X2ntXCrfsWWPtvql/5l
         a0rK3JNjk9e6LYHwmHGp7QV+4AcPjej6ycH9ROlexlawyevDfYQTyAkOHh8ArgSerFvK
         Tagrc7b7ZqA/T5w/JML3eDgD2G6t0FOUYg6zmyahkQGr9syO4GzCz+VOEAdoZyGDcPG6
         ho40FHfDolDXDxSGGFXggkWKddAlurFnbJNUNyFwU8WAECLA+I3sCKW2za5PhHLjLXsi
         phJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859477; x=1795464277;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OoLTYMlr0lZV4JPJ0qpA2+2MwBJd9qMSNSbWYReUmv4=;
        b=rnyC9CMjBEFSajzpGEDlM5imX4h00FsW9oRdSy9ySGZJgIvn+hnyVKVGjtyyxSKURT
         TFXSumEeLE4MSaz0n2vopuGBhVecJqSYiit3p2pj/LZDAWzLAnJWa6ZoNXbpEcyj4mnO
         gDyD8DvVQgXDG6vmJdmF7lmmNao8IKYpAG3lZKIUNoa3rNmDtRVoHskVoXf2+0BwpNtH
         wBixtC+IxpJG4NSDT3yScdO/FZI/t9hyu1jNMK9NfNX0gUtHnXGaNxnhGUtSc5p1QFfX
         kblpEdFmo39uzs8XGfZXfPne4Oc0lOA4HHuaGZkkC7UL3rX4PX3YVweb7H6Iyhl/Iow5
         BMjg==
X-Forwarded-Encrypted: i=1; AL+hErE3QZwKrCbCvLNKUt1mFxmYiqS4hRe8H5q80snDSLaIKHARcIJLoxgtrCVp5yor8R06QefMI4vOkYK69NT7@vger.kernel.org
X-Gm-Message-State: APuU4Z8Hir+5Ss5gluSwgzJVeS6U9xDuRksKotb7jq60FrFFcxeuzpn+
	KhV7m72FHd0AKO9vFhhsHa2T7dKCXk0ipm12BAm4EiKC51kr1ZHEVTDk/b6hQgdpox3J8/1AAwh
	43j4/tSYZwNX1GtTW4hzWYs+faMEeYPUP1l/6nosCBTsl+/tD+Y0zG18BgY3buYg=
X-Gm-Gg: AZFdTZc+f8iqYfTpR1Pt/TkwbBvzvh3FQVPvHqrMIszqbC4uQukA9I4qL8tTNQZk6Xv
	siW06ni0yjjuUb3irXwaJD0K0MDM0bnIO3gRcLJaaiDel9YcD7f/RgyFosVXU8A6u05iOsU8njY
	aM6Yv36GiNQrV3wHTGdb/vDWySoS7y4aOd0/4QJyKhKgo/95PraSfMzesx8LXL8+DziMbZd49AH
	CYLPj0I7eSol2zkYwt5X0tKQxVBhd/uW4lRnkZrUccH4sSSOrXr5ajEDGeBoOPGpmcMABdnMTN8
	px/UDSZOqCSNpVRXWQFhRPMxhq0eAkkgKIFyDVhAaAjisauqGbehV2Si8cKSXxaRrMKPoIqStMa
	hEvUsOV7rT5Fts6By3P/tSgGGWV7T3wUw92NF01YsO+27AVi11+PbdEmkKFQlaiieRSxXcVeMqx
	NV5E72gcPZqdOVv2U+GQcI
X-Received: by 2002:a05:6214:404:b0:91f:3063:6b2f with SMTP id 6a1803df08f44-920fd34f33cmr9007456d6.17.1794859477454;
        Mon, 16 Nov 2026 12:04:37 -0800 (PST)
X-Received: by 2002:a05:6214:404:b0:91f:3063:6b2f with SMTP id 6a1803df08f44-920fd34f33cmr9006626d6.17.1794859476833;
        Mon, 16 Nov 2026 12:04:36 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:34 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 16 Nov 2026 15:02:50 -0500
Subject: [PATCH v2 8/9] mm/migrate_device: do not migrate a uffd-protected
 zero page
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-uffd-state-fixes-v2-8-4397a0196479@columbia.edu>
References: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
In-Reply-To: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@suse.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=3477;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rmChA7WgdOrC/88AxZpfJODdWq+Xphq5oh6yqVMIGRQ=;
 b=Aq8YehfZb6/OHRe5fm5im+wKKZvGIc/GWSlOLY0dwMWs4pJkhwuqJqx9nc8S+eDs6q4djpisX
 UCoLnNhweecC9FQQb7bS+LJGWbllO0Kys1HABgExaohJoPu9hSmT0f5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: g2Ib4uJ7mgjxHT2BCtrm3lA09gdQwxx_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX9WVfbL9YLZp6
 wEwVLtfLJF67ECfbU2D3iSDP/9XTdskv5Ud3LhPwmFxtScwgMMv+RYh6wa9xZSimIMz9cgqe5ie
 78DBavtQEYghg9wJw/rmAjiyKdcpCe85UB84ECDSHiC9Z5iJzien
X-Proofpoint-GUID: g2Ib4uJ7mgjxHT2BCtrm3lA09gdQwxx_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfXzxQ5d1LSojbh
 Vn9dko0ce5i7+hnUMzKnevu4G2l+gwVETJ2nWEpZjblrusfKf0q4+NTe+qLMSg8gqAPhodC63bf
 Zf6VMrMdOfQn3Dwz1G0QcOLHI5J9xAGaz0DJwxaoinUo2CSRHBf/GwoYEnDc7LBIPBHEpnZ8QJ8
 FJvLYYjAZmaRNjYp7tNVn5fdwbwS1pU7SwOYYMHUgbR+S2sat3/IDyf848eD+Qv4fYxas/c5YVD
 HkijikiqSOtta0BaCCQ83wFHYRpOtAvM30N6t7bZgtk7iAPflczfWWoYjZK3SWboFcEnDTP7uX2
 37gY3Y6dhBuFVu14m+KHfMAy75zMkhTuEEzKW2ww05X7ctcAcFowKLEGQYcZcKWw5b6RIna9mq+
 ePAq+lU43xLjFhhDxHxysNBPRSTPkRviaOF/8bnhb/+4tA8wywBKacOK+lg3iRkB3hrVWEVwXyH
 ymh/XntnFJTYibwHzbw==
X-Authority-Analysis: v=2.4 cv=NLlAaE6g c=1 sm=1 tr=0 ts=6afb61d7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=QyXUC8HyAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=9jRdOu3wAAAA:8 a=e5mUnYsNAAAA:8 a=Ikd4Dj_1AAAA:8 a=El0B2wc1DFe8a7cR29wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=ZE6KLimJVUuLrTuGpvhn:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=10 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=10 lowpriorityscore=10 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

Device migration replaces a PTE that maps the zero page with a new PTE
that is built only from the VMA flags, so its userfaultfd WP or RWP
protection is lost. The same applies to the huge zero PMD. Writes and
accesses to the page are then no longer reported to userfaultfd.

To fix it, do not migrate a uffd-protected zero page. Skip it during
collection, and check again under the page table lock before inserting,
as another thread can protect the page after it was collected.

The alternative would be to carry the uffd state over to the new entry,
but a uffd-protected zero page in a range that a driver migrates should
be rare.

Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/migrate_device.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c..140b99f72508 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -159,7 +159,16 @@ static int migrate_vma_collect_huge_pmd(pmd_t *pmdp, unsigned long start,
 
 		folio = pmd_folio(*pmdp);
 		if (is_huge_zero_folio(folio)) {
+			/*
+			 * Nothing carries the uffd state of the zero page
+			 * over, so skip it if its uffd bit is set.
+			 */
+			bool protected = userfaultfd_protected(walk->vma) &&
+					 pmd_uffd(*pmdp);
+
 			spin_unlock(ptl);
+			if (protected)
+				return migrate_vma_collect_skip(start, end, walk);
 			return migrate_vma_collect_hole(start, end, -1, walk);
 		}
 		if (pmd_write(*pmdp))
@@ -337,6 +346,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			pfn = pte_pfn(pte);
 			if (is_zero_pfn(pfn) &&
 			    (migrate->flags & MIGRATE_VMA_SELECT_SYSTEM)) {
+				/* See migrate_vma_collect_huge_pmd(). */
+				if (userfaultfd_protected(vma) && pte_uffd(pte))
+					goto next;
 				mpfn = MIGRATE_PFN_MIGRATE;
 				migrate->cpages++;
 				goto next;
@@ -871,10 +883,14 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	if (userfaultfd_missing(vma))
 		goto unlock_abort;
 
-	if (is_huge_zero_pmd(*pmdp))
+	if (is_huge_zero_pmd(*pmdp)) {
+		/* The uffd bit can have been set since the collection. */
+		if (userfaultfd_protected(vma) && pmd_uffd(*pmdp))
+			goto unlock_abort;
 		flush = true;
-	else if (!pmd_none(*pmdp))
+	} else if (!pmd_none(*pmdp)) {
 		goto unlock_abort;
+	}
 
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
@@ -1074,6 +1090,9 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 
 		if (!is_zero_pfn(pfn))
 			goto unlock_abort;
+		/* The uffd bit can have been set since the collection. */
+		if (userfaultfd_protected(vma) && pte_uffd(orig_pte))
+			goto unlock_abort;
 		flush = true;
 	} else if (!pte_none(orig_pte))
 		goto unlock_abort;

-- 
2.39.5

