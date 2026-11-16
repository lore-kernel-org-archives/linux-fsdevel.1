Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859466;
	b=boEiLHegch8PZ5kngBiukm3AsZxMdFNQrUA2mJIyDVnQvqxLtqZxWZ8yHQgoMoEFjDwI
	 Sbgj8fw1H7TJUvGS7r+8P9viqTvkt/c6iUDWWLpYvAbVEozaAy1aoYfYtLIPundiec2lu
	 jXwE0H2dlDof7ykZrX2mHrkVgz8hgPMlBgHMBCilh9rVZQ/0mZzfoY/yMs/OeZT/CAZ93
	 AbBW/rW92YGwb9EwuQIgV38nJsCCXBdALh9Pikqab8JvyTJHJvWqljEEZqrXczdaT/QyQ
	 ufsE6sMaBKfhisNKRNWqiTdsGsXutxcJ3oSNJRIyNMwQ0cHlTWM8+44aMQY2kio0EEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859466;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=x1GSlTdxCDOcwaCkl039quhS7jO/y0dxq7PSFe5uI1Y=;
	b=NahQFMeuuo+BVJFNDVA/zxyN8ZYCKOmN7vUqd1Og4fkcGDC2so1p+VaJamERfTdYY6g8
	 BXyuCK996Ht5/2Yt5SDqSlxWbJPhw/tNpCeq8ITinoufkbCf6FbF6Z34axUiwn0/96Ic6
	 TD31eL8L5fF1j58juhMELbH0UOtOOweDPSoFHNHG5hZ5Xhdnnn9xxzbslZhfwrLbuocfW
	 njWBAV5wtyt50QaHz28r+G1TxqjdgXbFAN52xSa61OLqIiS/u1GkgcvHQ6xqklnh0dD4b
	 jHvi38CdWq3sfUjftjsFmRHcTTwowR/+9FcVoTC7LJ9ju/qoT1lTDNFy0eQH1ufwq7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IpXx2n9+;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=A+bNrbpW;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AAD606A8BB
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 20:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98AAD606A8BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IpXx2n9+;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=A+bNrbpW
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGJXFDx715762
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=x1GSlTdxCDOcwaCkl039quhS7j
	O/y0dxq7PSFe5uI1Y=; b=IpXx2n9+RamcocPRGOPd8XPboIKjiztrAkZU6DcuMR
	owrO1L9jYZPfd7Bix1u2o6xBqkvtiLeQSkquPaLF4IvEnS52FWTuHflsrx6FB9/p
	/B9pEuUxFFNQmGfo8VUZUjGlIsXMKi7dBRHWAdp+W2JfP1C5b+6ic5mq0PCMhvqr
	4E+5fohvAFveb7oCnY0baP2Zj2hHvARpdMapPW47/6QRXbCKyU17S9hVOf1jPaKE
	Eb+KHBWE58OnqIkTxmTlfbP/A9yuNf0uG0wB1tQUjv5iZi7SlNyV3zJ6lB6lyAJB
	NDxqTJoECbwU0nuSRrbFAXkldL6eVYJIxY8e7Knd+nDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j059qt4fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:04:24 -0500 (EST)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55ca6405c20so3028151cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 12:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794859464; x=1795464264; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x1GSlTdxCDOcwaCkl039quhS7jO/y0dxq7PSFe5uI1Y=;
        b=A+bNrbpW/Fh/gjzb0bd2i2ukXiJAFhZ6ks2jB92oz2DwKv4ih3bs1ShddyT+m6wIHN
         5dEfQUU0zPiAP7BxtNH7/2N2ErGbGqK15gDmuhpKlrJPp2ZRutfQ0NHNVyreQ5qEPWk9
         NQho0fIb46L8bbCaoRcyhuFs8wBFz9mIU+X4oN7yqXx9Oru278J5gj4LpS2lbGKmzJ36
         VWbEbrN5Tyr/H6DzGHjTAeB699Y1ydILMP4rHmwobJPXwbLSCbXVqAYnT/rs54GmDq4t
         FWDgYtiTR823eRiK2EweXc8w8PG7RKnxcy+s1BVEeqdBVoQDEEWRXE7BZclHrxcU0lZn
         efJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859464; x=1795464264;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x1GSlTdxCDOcwaCkl039quhS7jO/y0dxq7PSFe5uI1Y=;
        b=22BIRgSrb/W4Oo6xlo9AuWebsmaJTJsR5oMlIEf1mOTO6XXAy+ABFEePCXnYVxmXyr
         NPEUOnxvfenJNsHP0cF8RxQf8/fqoJdse5t22cLZJo2vQbWpte/ioC/Ez0n3TcuRjFom
         CyEWoZNx9s0tLzKsH9Z5X1u3OJKqAPjE7JoZHwmeOzaLC54gGlbl8te2SzSTSDd87j/V
         pRi+MIGcGMUmFTP3KsiCGjAxQ0pWooi0bq225GU6zM7wFYqn5PaQcpfQdL0w02dUYWKU
         LC1mim4BJD4MQkus3sfVj5yV0RWgK3oo3uBhjuqEKfJ/zx97pdWYMzd33XFS8BlYOOAy
         A4nA==
X-Forwarded-Encrypted: i=1; AL+hErHah1zOPJ4cRxE41xPDuu8b43GtSvIXmuju0ELlxUGjJWlL2Lb2psNrl0eaYYZl++j2AqtYysA4ooEPGQYx@vger.kernel.org
X-Gm-Message-State: APuU4Z9qm26KeF0NYLmraMSOGSNoxpgYKA0HEoiVTobTrchBXzfB1TxP
	sLHfdZTkC64PZKoWK5xsrr85cMiQnOLUcGIMvcm32cfGR8LsWChJU9PSSZwtzsG11N37r44Uxz+
	5I5eeNif5i973hYugFP85BsV6/vMq70wv9VizVAxFzDrJkmqN0ftxlo7pu3Z/Ubg=
X-Gm-Gg: AYBFou2N9ox/aWMTzT/c/FDMh1nPy4FkFEMByAnojkfqBZBIoWPPRYfJVMr43sBgfFo
	C8+QJWvj7wDEvntOMi5NPhQOvcMtPivoqmjV/1EfZDyZF4h39wJGdD3XeWtbsF6Booulk8Y7I1B
	r/KoDh1A+sGftFpwMxrzYUb5w1NuppHieTj/wuQnX/GZgvJ6nExS83/NdW3KoxOhW8bhvKXxkFm
	G6CglJ7KsQ+yIJ7X/UikvNeizKkH78HBljynzBPceLO6+TVZB5XXqRCIv51s8z2Ou94/s322G8Z
	mXtSZQsqKABJ7JZzTxugdUbBu/IJZRi1ay1Y6f3bYzSyabjuwH5xgta5e/P863q6DdcyDzfYR/e
	To6wlBtF1zSzBVp/HRx6szAmHuFpo1ie7kMke8F7fNlxdQAQQRG3nBmOxOjwvhzhHkOGTe1Ln66
	KXWjp8ByHmHFCifEI4unJq
X-Received: by 2002:a05:622a:5883:b0:536:723f:5de7 with SMTP id d75a77b69052e-55d49300e66mr9489481cf.4.1794859463697;
        Mon, 16 Nov 2026 12:04:23 -0800 (PST)
X-Received: by 2002:a05:622a:5883:b0:536:723f:5de7 with SMTP id d75a77b69052e-55d49300e66mr9488661cf.4.1794859463022;
        Mon, 16 Nov 2026 12:04:23 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-176-174.net.columbia.edu. [128.59.176.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23efa2edsm93065426d6.15.2026.11.16.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:04:22 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/9] userfaultfd: assorted fixes (part 1)
Date: Mon, 16 Nov 2026 15:02:42 -0500
Message-Id: <20261116-uffd-state-fixes-v2-0-4397a0196479@columbia.edu>
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
X-B4-Tracking: v=1; b=H4sIAGJh+2oC/2WNzQ6CMBCEX4X07JpuMQU9+R6GQ6GLrFFq+kM0h
 He3oDePX2bmm1kE8kxBnIpZeJo4sBszqF0husGMVwK2mYWSSiNKDanvLYRoIkHPLwpgFSKSMq0
 91CLPnp62IK8uzZdDam/UxdWzNgYO0fn39jnh2vvpEf/1E4IEKSssbanrY6XPnbunR8tmTzaJZ
 lmWD8zFP/bFAAAA
X-Change-ID: 20261106-uffd-state-fixes-d2111e2abd48
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
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Breno Leitao <leitao@debian.org>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794859460; l=4488;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Q9vtBat7EPzKier5uhGvIcHrOmBQit4JDniJ4SvUP3U=;
 b=PuIj7+LRsMk4tLVOsesIjArbol6E2+mE6zXf9UwUvZaWh2Se6zEfg4r4N9uXEER+0YOQl25l8
 ZbFg9uq1kztBgkEFbRdYqBvvGW1Tl6vFNKqc30ZQz4B5pydamoG5nJC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=L/qI0OT8 c=1 sm=1 tr=0 ts=6afb61c8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=KPY1cyGZ6h6m4ASiENTC8Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=bC-a23v3AAAA:8 a=zAoRp05x23iGVPMylqYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: cu-n2JFmoK-Bv7hOIu29LGPgqDMHs5mW
X-Proofpoint-ORIG-GUID: cu-n2JFmoK-Bv7hOIu29LGPgqDMHs5mW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX0LOon1sd4rih
 SkEL/h3lVc3GXCkzhEQdzM3LC9uzs+z/AmD57LYNqi/Cv+qiYs37UN8LngNc55ytqQOwME2soSA
 PJS7VUm0D4JsS5DDjSUtM/fEPPQLe4IrCPwMyWAzol3e00jq4n6R8Xlx5NDz6YkiB7UlhXG6MUi
 nB8YCTTQ47BV6osReLQsPtkMrqxv0TN2h2awD6vdVQZJRmD19DVY2rLVxN4WZek88Lu4CoiupO5
 0B2F/0qlP1XhKQlLJsvpoEuL5GK8aHOhXXBocqXHLxUkb2Mx2zUl3Q73uoMhrgRCyKE1gUagXvJ
 4J7dSLG43M9/OYIAwgA8oIR4krX32iO55KWL6QkS3uWnm2SYXKpIAaZd+XMP0TztW9GCO5KSB36
 42/2HX9vFUshYhDNV6csYqi/SlRZbKZHuA7+zAYoFNDmgRnR8boIxPywis6hFig24JkaXvmdvXD
 tEpmo9sL2rHwPqMm/1g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MCBTYWx0ZWRfX8/NFFU2p4k0S
 b8cadybUj1SEwIAXWcIv4niwE/SjEYsUu8YHbKjFrZSdRdnDelqIAeglpdRY0cITDT2vr6JDZfr
 F4WIb8ccShxy2bVz3FcaJ/hO1rqeCwIJWKO06lqido/UvfHLV8X9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11968
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 lowpriorityscore=10 adultscore=0 priorityscore=1501
 malwarescore=0 bulkscore=10 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160080

This is a first batch of userfaultfd fixes, with more to come.

These were found by a mix of regular old LLM review and by having an LLM
write a TLA+ model of uffd interactions with PTE bits and other state
and seeing what issues fell out.

Most of these fix places where mm code loses uffd-wp or RWP protection
while moving or migrating an entry. Userspace then either misses writes
and accesses, or gets pages reported that nobody touched.
There is also a hang in UFFDIO_MOVE, and UFFDIO_ZEROPAGE modifying a
file through a private mapping.

Patches 1-2:   UFFDIO_ZEROPAGE and UFFDIO_MOVE fixes, cc stable
Patches 3-5:   PAGEMAP_SCAN write-protect vs. migration and
               device-private entries, patch 3 cc stable
Patch 6:       UFFDIO_MOVE of the huge zero page from an RWP source
Patch 7:       mremap() losing uffd state when a move fails halfway
Patch 8:       migrate_vma losing uffd state of a zero page
Patch 9:       UFFDIO_UNREGISTER with a misaligned hugetlb end

A few of the fixes change what userspace sees:

 - UFFDIO_ZEROPAGE on a private file mapping no longer fails with
   -EEXIST where the file already has a page, on an mm that cannot use
   the zero page (patch 1)
 - UFFDIO_MOVE returns -EEXIST for any huge destination PMD, not only
   for a present THP (patch 2)
 - UFFDIO_UNREGISTER with a misaligned hugetlb end fails before
   unregistering anything (patch 9)

Patch 6 has little user impact on its own. It is included because,
together with patch 7, it allows removing clear_uffd_wp_pmd().

Patch 7 adds spurious write faults on shmem and hugetlb after mremap():
when dropping uffd protection there, change_protection() makes writable
pages that were never protected read-only. UFFDIO_UNREGISTER and
UFFDIO_WRITEPROTECT already behave this way and lead to the same
spurious faults. This will be fixed in change_protection() in a separate
series.

Based on mm-new.

---
Changes in v2:
- Collect tags (Thanks Kiryl, Lorenzo, Gregory, Alistair!)
- Patch 2: say "softleaf entry" in the commit message, per Lorenzo
- Patch 3: add softleaf_is_writable() and softleaf_mkreadable() to
  leafops.h and rename the helpers to say softleaf, per Lorenzo
- Patch 3: add Reported-by and Closes for Breno's report, and cc stable
- Patch 4: explain in the commit message how PAGEMAP_SCAN set the uffd
  bit on writable migration entries, per Lorenzo
- Patch 5: use pmd_is_valid_softleaf() rather than open-coding it, per
  Lorenzo
- Patch 7: say "write faults" rather than "minor faults" in the commit
  message, per Kiryl
- Patch 7: trim the commit message, per Lorenzo and Gregory
- Patch 8: trim the commit message, per Gregory
- Patch 8: Cc the GPU driver maintainers and lists, per Gregory and
  Alistair
- Patch 9: use IS_ALIGNED() and a local variable for the VMA's ctx, and
  shorten the comment, per Lorenzo
- Drop the three guard region patches, per Lorenzo
- Link to v1: https://patch.msgid.link/20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu

---
Tal Zussman (9):
      userfaultfd: use anonymous memory for UFFDIO_ZEROPAGE on private file mappings
      userfaultfd: refuse UFFDIO_MOVE into a non-present huge destination PMD
      fs/proc/task_mmu: downgrade writable migration entries in PAGEMAP_SCAN write-protect
      mm/migrate: keep the uffd bit when restoring a writable migration entry
      fs/proc/task_mmu: write-protect device-private THPs in PAGEMAP_SCAN
      mm/huge_memory: build the moved huge zero PMD from the destination VMA
      mm/mremap: resolve uffd state when the context is dropped, not during the move
      mm/migrate_device: do not migrate a uffd-protected zero page
      mm/userfaultfd: check hugetlb end alignment in UFFDIO_UNREGISTER pre-scan

 fs/proc/task_mmu.c      | 42 +++++++++++++++++++++++++++---
 include/linux/leafops.h | 51 ++++++++++++++++++++++++++++++++++++
 mm/huge_memory.c        | 31 +++-------------------
 mm/hugetlb.c            | 27 +------------------
 mm/migrate.c            |  2 +-
 mm/migrate_device.c     | 23 +++++++++++++++--
 mm/mremap.c             | 46 +--------------------------------
 mm/userfaultfd.c        | 69 ++++++++++++++++++++++++-------------------------
 8 files changed, 150 insertions(+), 141 deletions(-)
---
base-commit: 67f3b04b277373438f17300e056306adbd9edf7b
change-id: 20261106-uffd-state-fixes-d2111e2abd48

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

