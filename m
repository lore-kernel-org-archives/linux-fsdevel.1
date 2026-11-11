Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419762;
	b=rAePpG2SzUPZiU9FCTpf/6Z/STHxl0r5G16Utcz9zKDaizhCmbExFryF4rVEJE0ieb/d
	 dVb5mPVfmm0CpTPJSAqxn1YgfPgazsAZpHqsx4ImajBZsEQOXFMTUrYrhFVGeeL19UyGE
	 TL4jEC8RkDidR3jv1F8elSkRRjYeVWGRaeR6D+C5TIYVkXAOmUiJ3kZ3/ox7l0neVSYt/
	 bS8lXnsklLRoUJEyO+bwROE2KJL/c3QMhJOmaJZbV+YeV5tJc/ff4IxrHEwtJktsOvM/O
	 2/yXcT3FLS/SqXZ7q1AFvD+AJGgatHC44a3UsKc3QDVu2BaGNWNUGZn3wXxasiY3Pag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rLh94H+uowZr10Df0hSuV88QMtwxibroooekC03x3n4=;
	b=qi8d9SjZAwvhodZoKoXC1dE4Yl3aYV6OR9h4PVtpeVE8mrTlfeXrL//P3gn7/NljdQTi
	 /xlTMhgOuY3lWhC1aF8flvQoiHr7AGfXp1lJeEHwdQpdJYHi+y2U544NOLaOjjprynBp/
	 caMaY25oppI5/g4MIAlvi1ugsZT1DWTG9p5Oz+K1nPyNHc60RWDp5CW/2gDxdIvxP5hBw
	 RazJfxoT5WACRMOGeequD7PCoG/L2hpVsu/CnhHxZDECm2BMpBbRWP739+HaDr0EHs31X
	 eAA3FRZOBatlv/fXHclEx4edPF3jNSa3h+a4GUS+bV8AeZy5qn1wpQh5U9MQxVG1HnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ozZsnQja;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Z1oFmQTq;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C64606A337
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 17:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C64606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=ozZsnQja;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=Z1oFmQTq
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABHYoAc1159254
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rLh9
	4H+uowZr10Df0hSuV88QMtwxibroooekC03x3n4=; b=ozZsnQjaNao2IqvZc6Rp
	p6roRzoRRGYKiG5ov5adX69nBBasWdEBDyp0z0QyW3Dp/b3FaDI9jOFWyzJ7L5lQ
	kxUYD+50KoCWnx1pGiUz3eRe+M5/mXchhVX4ubsbfNylzlcFwWl+mD6Eif42+mRF
	rKdRROP+hw0tztBTXHYMZX6Jpe3gMYBvddxoLc1Kkt+xFNw68pI7CNvwEjdbAFW/
	Du6hbii6NLqESVcxNhy+YFzC9JFj/f3mtis+dqrI+tDhoQLu92QKRKICrg3iMEWI
	H+gXgL1kR6iomPk3qpMmkE0HN8uaQHtiJV3D1vTihkcrm7Ig9CPKP0pODnHTmLn3
	CQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hvhnsc4ah-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 12:56:01 -0500 (EST)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535131e4c25so70414981cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 09:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1794419761; x=1795024561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rLh94H+uowZr10Df0hSuV88QMtwxibroooekC03x3n4=;
        b=Z1oFmQTq4JGf2NAZ9z7okE7264JQjutVXu/Q7HGi4oseCGejj1D3/KecL3/HaWs1TV
         qlkH1AQCCDJ0TrM5VSnuDrGTJFw6Jxghd8IhfOutIkkUfVZ0FzzmFlxVhDSRzQ6U83b0
         rkipFzXRO+8n1Tw4lP/4MTct2chSjIT+Tte+iakCQQjAM0BUO4pvAlZ/Pn5+F3JLkp8M
         kmbZijc1jKYC4fgCaz8UV7FCZD0K+b1ndl/vob0bvQCrspxzYtolX94qSYYspXoGAUFu
         TNoANmqTS3eei1NI2kEovuSY9a4yAtIjeV943nkBRJQIsSi+gKFbrU7ciaNw9vHFsP9o
         IjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794419761; x=1795024561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rLh94H+uowZr10Df0hSuV88QMtwxibroooekC03x3n4=;
        b=hVKG6a/aJ+gRwK9R61Q1qrE0zKsejYmgeninSCKYba7sT+Bz0MQPJVJNg6BnFBAR9U
         soHl06u9Kj/eukjvcF4QtXbwoqr01n82dp7blHv1U3r5g6zla/y0xWCNzzKLsGuAxxK+
         m6J+6vRhTKr3TkqbAm0rZZb7xZ/YirB9zqBHTCtpFRSEGRlvrK354utHfr0ViUh3wooc
         iEOQrD0gUt1xG4E3ivGnWfkdbPEWnS1CRO0ETctY/5r4fQv9wIRgPA+6lbXmMhhdt+v4
         cLLPt2/VZA1msMQgSZvV9ee0ZhrSM54Abnq4lcBUp7CoFZWwzVcXaQQWpSJ0XvQ4Ae21
         1pXA==
X-Forwarded-Encrypted: i=1; AL+hErG9H77AL54PoXoyaw3Szq9SXHUv7oFehXulPYBbWK1u3jw8q97a+agiN1zC0dpTYNKEACzrJ/jBdGI0wuc5@vger.kernel.org
X-Gm-Message-State: APuU4Z+GfFOVeIdnYe5ykZCZbhQbsmK4CM610VIMvJO4VOS470yIfwcb
	ifereFY9ozQO5Xlm1gTuh8ugjzUe7A5KlTGFv6+rKw9LF5feh61+02nwlOBaVXfREnEZ2zHzaig
	V+gWsy/zfj+bXuyvZEeFlKOr3Ab1Z/jLHqDXabxQZIEWSczKei3vUT4BFthAFJ9o=
X-Gm-Gg: AYBFou1USn/gPJoxtO7a3G79PyRdDGU9vGzXnHPggg69Hm+2PragshuKYEftRN0TMpy
	gDXvDiT/CfntxqYdlAiWYj+EjIm+NPWbySj3BMGQn/z9+kTi78fU/cvs2D8HfBVAzOqX7Mo3wFa
	/PHopqtLfyUEvzDj4R2Z9ty7lH5pD0VwVtLh3mezJP3jeAZtClD+Qp94GvhHExPHTHfLWzMrANv
	4M16QwBEaJ9TWdTAUOqG6AjnnCQ3wMVWWN2RpX68JSYuUsevHTJ7Hf5f8X/Ag0aDMc1TaP4UdL3
	64l6z3wvRBCcv/T03wysx0Pl4kHLSSp8p5srwJGFORAtHmI2A64R3psS1D63VZtQHb0mmlEnV8Y
	i0FNZLRzbTI9NJ41Df8pfOt9TUc5Jc57ONfLXnK9rLmwIUcghDGv3uf0PZCZTddqFFMWWNyi25H
	qN9zT1Mge5FaZ8S+z7yw==
X-Received: by 2002:a05:622a:1651:b0:537:dea7:adb1 with SMTP id d75a77b69052e-556bdce0a89mr46732971cf.4.1794419760705;
        Wed, 11 Nov 2026 09:56:00 -0800 (PST)
X-Received: by 2002:a05:622a:1651:b0:537:dea7:adb1 with SMTP id d75a77b69052e-556bdce0a89mr46732341cf.4.1794419760108;
        Wed, 11 Nov 2026 09:56:00 -0800 (PST)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550b93ee00sm54974231cf.16.2026.11.11.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:55:59 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 11 Nov 2026 12:55:13 -0500
Subject: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private THPs
 in PAGEMAP_SCAN
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
Message-Id: <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794419750; l=1653;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=NMR1mZVf/ZZ1dsMSsUl85Q0wvIFNRvQkQz1f9feUbD0=;
 b=BLkWdBWcFR7ZCJE0naCht5rRXOwRZShjmmEWgb1C0a0/hRfETNoET5Qey8Nyu32VSu0C6gbxs
 gyF1eLl4PuWDGJEVmtlYVSl2O7uJ3n3l7j1NMSpNDb9jBfiLHhcZYAw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=S9lMU4sP c=1 sm=1 tr=0 ts=6af4ac31 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=RyLRxA_qM0uo8G8YelwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: x-qbWox_P6AjzCkf0JMAvykuRiLQRZwf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX4lHKRJuF/gQJ
 WP9c3ajmGupTKa5K5/TbQTKrjSaQ0grfwzNANXJ3wgZxjlc89MyTd1PSXOyPvpbSE5oDKYd12gv
 hAcn0WIJU9hNCUCLoPrgvv3GmvL5pGezKTkED/opzXQSO0Cnq1Gru8OGhpzq7HTeLZe4WhVCRHA
 YDJPYU8nLm5qfInWQGAoEpjC2n4E3HfC6ggTvkkCwfh62GEkuzsgakhTkiybwgL07aKns0s3FU7
 IAb64Wwb3aEu3Wv44WSbr8D9S40WxghL+swVmY/BZ9pXK+58NtraXvvXM908yANZPV9oTwOH9tY
 ax58WNmL2+dDoot4JLAyqqvbRg0BqVRAESXsrH4vL4yXN6H83pdJgACk3G0Q/uaQrCAcoDpFwXM
 wzsEtWgHeOR8VVrMVxUmWoHsH71jLyiKdNaGyUHRAHUFKkMr/NmCnXsLl87mSleY4gHJpu1yLuW
 pGd1AEYuk7bPiPK+9IA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MSBTYWx0ZWRfX2xCmINHehTlo
 exUX38NlEKMHr0rR+1+I6Xn6eX/wRU+vGpmyqyp+Kvbks4y5X6mTts/CgWMbS8cmMwHI/fsH21V
 1aZrzw5gdFcwo9e4LDj2q4PfsRcW+dg0X1Qx5p4WS2XraioAAi3p
X-Proofpoint-ORIG-GUID: x-qbWox_P6AjzCkf0JMAvykuRiLQRZwf
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11963
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 adultscore=0
 bulkscore=10 phishscore=0 malwarescore=0 impostorscore=10 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110071

PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
make_uffd_wp_pmd(), which handles a present THP and a migration entry
but does nothing for a device-private THP. The PMD never gets the uffd
bit.

pagemap_thp_category() reports a non-present PMD without the uffd bit as
written. A user tracking writes with async uffd-wp therefore sees every
page of a device-private THP as written on every scan, whether it was
written to or not. This requires a driver that migrates THPs to device
memory.

A device-private PMD must be write-protected like any other huge PMD. To
fix it, pass it to set_uffd_wp_swp_pmd() as well, which downgrades a
writable entry and sets the uffd bit. When the THP migrates back,
set_pmd_migration_entry() carries the uffd bit over to the migration
entry, so the write protection is kept.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 53780a454432..752f1b13d47a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2524,7 +2524,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 		old = pmdp_invalidate_ad(vma, addr, pmdp);
 		pmd = pmd_mkuffd(old);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
-	} else if (pmd_is_migration_entry(pmd)) {
+	} else if (pmd_is_migration_entry(pmd) ||
+		   pmd_is_device_private_entry(pmd)) {
 		pmd = set_uffd_wp_swp_pmd(pmd);
 		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 	}

-- 
2.39.5

