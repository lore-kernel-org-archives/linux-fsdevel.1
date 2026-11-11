Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419768;
	b=uCO1S/S0bjgtPGxO+e2LICBYFMNiwoJ43UxUM9D3VCKMTtQMtymhH/UDgwT72q19gmZM
	 +6oqZe79gcvwUEvuzBhq5E57G5fx4xW54jc/m2dfU/fuzac0y8hi14gbALqF+Fy20vOs6
	 1jDlC2lYILnWxvg801fiztmcXKMwzN70gNbmte/Taccio6zPDEezfMZOB5aT3rzHiBlN6
	 Azfa0spynWIzqp5zldSMrCquki2esUP/ERDP8jbRMO2MMz2SY36081SFw/+CN6XmyjB+g
	 OFhbEsifcmM119xxlUOFHekpDsvlF4tMHdqOncbhYMYzZvu7+DMbgzZoeTjaQ9McTrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419768;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1m96XzjKc63D1pxDC9K5iULQuRZ3Lw0ONUHaz7lxYvw=;
	b=h6io++HRyDTIcSSoKZ3O1n6LTXh3fhyoYXaP2w8Ap+3YmxiqVF2jDDZM5jTyEcz4a40T
	 lr6jc8ySgoR0M0kzsI6GSfrx8pFGZlEh/y4nN7krHhBMIKUqGL4WVBFGF2xVzIPanoj/A
	 CsfvSdsIepaKYUPcAHbqWdt4lwmGnl2b4zunetbLoNJux0FlsImJM1arbRqWBzQCo4iiK
	 VdEICt7bdS2J+HGI5/2abB2oLu6jXsuAXXEeiu1D7HZ1txema9cmFBZlD6UHkirPL/UyF
	 b5z5uTBkZjwjDE3ZE30OCZv8hZtH0l5Zn0jQ511JZyeXNm9ye2spLfsTL6KxFfM9+vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IoXq6FFr;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LOaw5S9J;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC160A383B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EAC160A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=IoXq6FFr;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=LOaw5S9J
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYOjG1158378
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1m96
	XzjKc63D1pxDC9K5iULQuRZ3Lw0ONUHaz7lxYvw=; b=IoXq6FFrSN+/unNVsz5+
	2Hs3pEW0KIUhrP0QX5XPG4CTvatRl9NSOyvjksHELdcaza9rY7Y7Nbppy1C3nkz/
	CcA5j7A4Bc1X6pknSbbIQLQ9uxpw0LvpDFzvxWx9+MhniCBhp23HqinWZWjykycU
	pCiIqK0isdwNcj1pCW1HjkUcqrHJZLvgF2yFZcowQX7Tu+G3wCUylS9VvSgyiais
	uDySWBgXKNEHkl+M73KWj9a1/eDKUtQQX7yDE8hcPLFI3FTcGaDVQpRKttvF3EI6
	ULCK0IVlrIkvF0XB91wEG9zJkl5SaY5jA0Ah+xuZ1N9VLk88+iHaSMuguwF+yP1h
	7A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvhnsc4bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:07 -0500 (EST)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53661e036a2so69204881cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419766; x=1795024566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1m96XzjKc63D1pxDC9K5iULQuRZ3Lw0ONUHaz7lxYvw=;
        b=LOaw5S9JLreCGGn4mF/WqF9wevzwF31ZO6yeAMjf9kUMEN2uakWxdDfWiEZctb82vf
         iRdoX0Su04pEQo3W+/4RcgtnEB2PInXaJ3FR9mIOlAzHyJTaDSMNflN9SkCrYtiR3rse
         H2+4dxMpWxr9B1+NMzeeHgIeUk0RrlR3iow/i1gd6yXu1hcMX3orQiWNr4afJ4m05hIB
         KLK1EqkUCJQ3KiuN/swsID3T5aMNS/YL/nRULiwuJuud48LnonKoGnGnED0QTFD2LL5Z
         uQQzVnfx4Q+HperPmi/UYiE+tiflUtDhaWdb74EEpJQAXwEkDCGAHKJZQ8PwddWZPFmU
         mXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419766; x=1795024566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1m96XzjKc63D1pxDC9K5iULQuRZ3Lw0ONUHaz7lxYvw=;
        b=m6PY9vWmbjfSFJMT3UuXhlLKZJMkOaF+Y6tnccrCxb8WzDrUpb8vp8FdKatVZA6phy
         AhJ/9ORNA+WHBnYZqUbzRidUdpupuCTEW97KA/NexMQfADYtsQhVtXB68gkrX2ERLecd
         RhggPl53CwcWi6HCXvBMDqAoP2B2svTq+gd3+dpnKuwal/nnH5pBFhUGWaawdnB3/sDn
         1NmwNq0+bxMVbhO1+bLS5G+FJF240kD+Zns88dSDgzmhSF5flESflaJly0xKf5qevzaL
         jFhQcDJP74PQYrkbqxpIRJ5zxgT2YwTfMJYxrVFl9FA0WzkeHji6tiWUxf4wRiQBs72C
         44+A==
X-Forwarded-Encrypted: i=1; AL+hErGUcdm0fTrKQZbB8dwSPiKeSz1In8uxq+qYjXCmV+aFbKpn+U++5bPP8wYVAc7x3nPLco6VZ9dPzfV1776O@vger.kernel.org
X-Gm-Message-State: APuU4Z8gN6Ec2CAdTSeZA8Cz3KON8KYEBi+A5CcEZzLse9TBhojwO5zF
	tIgry6QY4EpxSfHQ2SeTVfFDfxJQ+WH//0o5Tu62qMyXVGz8kuMj3tIEig8mHTuOS/mhcjE38zd
	qiNF3MoEuKVDDiBHVSGDfucUPbJfO6G/yXH6PgUsPjQ8uBP8WjgIpwBRLEz9D6a0=
X-Gm-Gg: AYBFou1PV/dvCE/cTg/eKOdk6PC9Vh7Pv5qxLoxUnfUgJTv70onA2iBma8enGiCFRvv
	aElLWD6ObJLh7vAL+QCGij8IOyhbuuNcNZIVSxin/Cvn/URmJ8Y2pVnv252C7bnz7NgZjD7bLrj
	iuEPfO0z3c2ZQlRIRj9cqJWDQOmSVvazi+GsLIxJEhSV+220jaIinSF4yKxMS4an6I+DX5EG9MQ
	tnhCBtrE/xejouTS8D91bWD7tqvDInI9WAsVarzHF0VPPvpvwSnaePJ5p4qZjcervZPjJ0wQX4j
	Z8X8ZCPuEclcxMdOnx4g1M6R4wKnmWGsftR2/j0ZuoAcP+3Mtn+oqZx6CPNWT+amZkUjw/XrpJJ
	SQx1PcwKEzZ98Sm+/2bE5Tdcijf84fz0TodPOUUoxU87bAxxhfjST9yZI1q8Ze/jHnJ17zM4/vC
	HUQYAxfAtBTdzNs3k6Dg==
X-Received: by 2002:a05:622a:1f88:b0:535:2794:851c with SMTP id d75a77b69052e-556c0bc230emr39978561cf.39.1794419766501;
        Wed, 11 Nov 2026 09:56:06 -0800 (PST)
X-Received: by 2002:a05:622a:1f88:b0:535:2794:851c with SMTP id d75a77b69052e-556c0bc230emr39978111cf.39.1794419765960;
        Wed, 11 Nov 2026 09:56:05 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:56:05 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:17 -0500
Subject: [PATCH 09/12] mm/madvise: let a guard marker carry the uffd-wp bit
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
Message-Id: <20261111-uffd-state-fixes-v1-9-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
In-Reply-To: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>,
        Peter Xu <peterx@redhat.com>, James Houghton <jthoughton@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Balbir Singh <balbirs@nvidia.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
        Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=5358;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=yTu2S1wVIskSQmMr6++Ol3X1oAvYN0En5MUMkhISqr4=;
 b=tF6bHpiOSjDbkZSVUdJQfZcIPbwo3OAGDdUQX3vCXlP6lp7hhoSIAVpEWFKwdmHTKwsJttJYB
 xqu6iE/QaX0ApuabdUF7rkfy9FinxabHI5pcGslbVjJvQWJcG1etnN5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S9lMU4sP c=1 sm=1 tr=0 ts=6af4ac37 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=TbFgO4Jl7eDgA8pY8pUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: ajTuMaQ0VaqNgpcI8S4jrenrZFRg_Yzh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfXyPjxV8aD3R88
 zghdShiZI/3LL8CkBkFbWMARMvwanuxSH4rDXXVSbCIaVXAAfrwaq/Qo4WlixcUwIygbG7QcMDX
 0VG2iNvxzZPJfocmcdS2KtN6eJmEfIMQ+XZElny0LwnYiKejxuvM9RsqzMWxxompapx24kiY6r8
 73mZk63TOzt5bhGnA/D4m+R7fG2EfYDMx8gvoQX8slooogIB8myufXjUC+X1lGM4Iwa1JVfAUSj
 Iv474pvJnr8gnEo+Ab+8ao4D3H98WUKMoUDIuCvYQ0MJAmsTcK3FSbl3UUyTMBgHj+RNJVP4J82
 NlhmOyhJki3exdB/NnOOKulNikLcRb7lWNeQdBEWRrhcEV46agpEEW3LGkVv7ELkWMUiT6CrETU
 agmozwOzCi92nB7tzH5550tPMAIM24LcakJNUpEjg/xvSCFqP7TltH+gjytqc6v9uB5Mdg/T+e3
 MBz0erTTA965j2yLjVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX0taW5N163UAm
 dOLFBpinxEHMXaFtoI5toqTaqUr+gV0nOdPw8NWxK7SrnH+QY4pQCPNn/kEfc1X3inlLNxxT1N5
 9rXTPvJfEiqmSIWlhe4A3b019q3FuaJPv/7wEefgPFDG+MyK8Pjh
X-Proofpoint-ORIG-GUID: ajTuMaQ0VaqNgpcI8S4jrenrZFRg_Yzh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 adultscore=0
 bulkscore=10 phishscore=0 malwarescore=0 impostorscore=10 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

MADV_GUARD_INSTALL can only install guard markers in a range without
populated entries. It zaps the range and retries, restarting the syscall
if the range still isn't clear. On a file-backed VMA registered for
uffd-wp, the zap keeps uffd-wp markers and converts write-protected PTEs
into new markers, as the pages are still in the page cache and must stay
write-protected. The range never becomes clear, and installing a guard
region in write-protected shmem keeps restarting the madvise() call.
Signal handlers still run, but the call does not return until the task
is killed.

An entry that is write-protected must stay write-protected while a guard
is installed on it and after the guard is removed. PTE markers are a bit
mask, so a marker can be a guard marker and a uffd-wp marker at the same
time. To fix it, let a guard marker carry the uffd-wp bit:

 - guard install adds the guard bit to an existing uffd-wp marker
 - guard removal clears only the guard bit
 - unprotecting or unregistering clears the uffd-wp bit of a guard
   marker

The fault path, zap, fork, and pagemap already handle a marker with both
bits set. However, pte_is_uffd_marker() would let UFFDIO_COPY overwrite
the guard, so make it ignore guard markers. Anonymous VMAs drop uffd-wp
markers on zap and never get the combined marker.

MADV_GUARD_INSTALL on a uffd-wp shmem range now succeeds instead of
hanging. When the guard region is removed again, its pages are still
write-protected. While the guard is in place, pagemap reports both
PM_GUARD_REGION and PM_UFFD_WP for them.

There are two simpler alternatives, but neither works. Zapping with
ZAP_FLAG_DROP_MARKER fixes the hang but drops the write protection: the
page is still in the page cache once the guard is removed, and writes to
it are not reported. Refusing guard install on uffd-wp file VMAs in
is_valid_guard_vma() would break a combination that works on anonymous
memory, by adding a new -EINVAL for it.

Fixes: f807123d578d ("mm: allow guard regions in file-backed and read-only mappings")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/leafops.h |  4 ++++
 mm/madvise.c            | 28 ++++++++++++++++++++++++++--
 mm/mprotect.c           | 23 +++++++++++++++++++++--
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 4c1476ae3234..add4968ded44 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -578,6 +578,10 @@ static inline bool pte_is_uffd_marker(pte_t pte)
 	if (!softleaf_is_marker(entry))
 		return false;
 
+	/* A guard marker stays a guard, even with the uffd-wp bit set. */
+	if (softleaf_is_guard_marker(entry))
+		return false;
+
 	/* UFFD WP, poisoned swap entries are UFFD-handled. */
 	if (softleaf_is_uffd_wp_marker(entry))
 		return true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 0214efd2a014..e2c6b0f26672 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1123,6 +1123,23 @@ static int guard_install_pte_entry(pte_t *pte, unsigned long addr,
 		return 0;
 	}
 
+	/*
+	 * Zapping keeps uffd-wp markers on file-backed VMAs, so add the guard
+	 * to the marker instead. The slot stays write-protected once the guard
+	 * is removed.
+	 */
+	if (!vma_is_anonymous(walk->vma) && pte_is_uffd_wp_marker(pteval)) {
+		const softleaf_t entry = softleaf_from_pte(pteval);
+
+		set_pte_at(walk->mm, addr, pte,
+			   make_pte_marker(softleaf_to_marker(entry) |
+					   PTE_MARKER_GUARD));
+		update_mmu_cache(walk->vma, addr, pte);
+		(*nr_pages)++;
+
+		return 0;
+	}
+
 	/* If populated return >0 so we abort the operation + zap. */
 	return 1;
 }
@@ -1259,8 +1276,15 @@ static int guard_remove_pte_entry(pte_t *pte, unsigned long addr,
 	pte_t ptent = ptep_get(pte);
 
 	if (is_guard_pte_marker(ptent)) {
-		/* Simply clear the PTE marker. */
-		pte_clear(walk->mm, addr, pte);
+		const softleaf_t entry = softleaf_from_pte(ptent);
+		const pte_marker marker = softleaf_to_marker(entry) &
+					  ~PTE_MARKER_GUARD;
+
+		/* Clear the guard bit and keep the uffd-wp bit, if set. */
+		if (marker)
+			set_pte_at(walk->mm, addr, pte, make_pte_marker(marker));
+		else
+			pte_clear(walk->mm, addr, pte);
 		update_mmu_cache(walk->vma, addr, pte);
 	}
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ef4e7188e24d..6cc5b99b4185 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -249,9 +249,28 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
 		 * because any access should sigbus/sigsegv
 		 * anyway.
 		 */
-		if (softleaf_is_poison_marker(entry) ||
-		    softleaf_is_guard_marker(entry))
+		if (softleaf_is_poison_marker(entry))
 			return 0;
+
+		/*
+		 * A guard marker on a file-backed VMA carries the
+		 * uffd-wp state of the slot for when the guard is
+		 * removed.
+		 */
+		if (softleaf_is_guard_marker(entry)) {
+			const pte_marker old = softleaf_to_marker(entry);
+			pte_marker marker = old;
+
+			if (uffd_prot_resolve)
+				marker &= ~PTE_MARKER_UFFD_WP;
+
+			if (marker == old)
+				return 0;
+			set_pte_at(vma->vm_mm, addr, pte,
+				   make_pte_marker(marker));
+			return 1;
+		}
+
 		/*
 		 * If this is uffd-wp pte marker and we'd like
 		 * to unprotect it, drop it; the next page

-- 
2.39.5

