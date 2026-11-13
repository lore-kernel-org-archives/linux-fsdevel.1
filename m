Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549889;
	b=AvGcwHJs+ohCaUeif0/aHwK8GCd14v620UoeblFtpjZrDBz5TcpbhbiXsv7fnhIhhICE
	 LfAlvd1D1n4mqGgq+EV/OaO0KOPaZBTrZW4cioURgtj3S2mQ9LapkUhfHt8lbjRnEfLUV
	 zWog/oAK7LP4sJXigJVZCaaVrEdE4Zne4VRdfwgXAV3BgjjHc86BVPNlpxB/XwbYAZ+q5
	 fpqw3xq382w6EY4jszAvllIgOJt4fwCZund5dTGVrFsMAG9XasuvkFTzIyqi7X2034Vhk
	 gjJ104Y7JxdVOgESwknZAQmyZOKEG/MoPALmndLjb8GFToh85ScntvzOwUA4mzuw8JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=7xFaxwfpj5KbqoBFMnfOTbn14r38Tg3ox9XxMLJZOVU=;
	b=1CUcKwE/NPbC46jTcuurePwzHm6lD5Vtsfn3xW0xLfJ4dk1OI7AGowFaw8ooQo3PNtVm
	 wSXXun/mxm1i8J/qNjfc4fSUMYya3Mi4zTV+LXSslhuT6nc99NF+Tnm5j/p9ph5JmSKKI
	 ajf2pTFvTTNE0dJdO4IMTTh+RYMtkcgE7mJdUvGaTFnW/hrDU0CCwpXJ5Hp/iQgZ0axrn
	 hFHYm9FPkDUrwYtusJEyfYiepBPBs15b6JkW+GIVKV+I9LhXzIMka4Kd9laIO8mzwiF/7
	 8zwBOu+C0FweKKVbnk98D2M27pGNrIo2uHYGz1scyozS0FN2Vm1bzbupzBwiXJ97c9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="fJwB/xFG";
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F9606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 06:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=fJwB/xFG
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91f0274f88cso9511786d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 22:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794549887; x=1795154687; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7xFaxwfpj5KbqoBFMnfOTbn14r38Tg3ox9XxMLJZOVU=;
        b=fJwB/xFGCSUa1c4sQ0nFcTBxPUDm0vEK4o6+MJileOdSFdDCEI2Wr7/g242Ygl+kT9
         Lxq4nTF8fe5GG5jbyMUmH0KJWyXOf3As3tBnq0G7axZBe9Pz0DoIXUk2lv3O39uQz4Ik
         ec7QwCs28s4Zzx1mG2qV8l5NMwEvL/xrxfIEn9JcVYBEJqVgSgzSHQpd1F8KjEvlMx0e
         TTv01NljTV6NpwN9WCB6mGrZn2WePa4GrVt2gkrszeM08caPpJiVublWEhjQJGFhstvy
         3hj4UpgRgUSehRDwuhfIh90pbVNzoBYBfYUn8V1l8jv9xGBw+qCGO0QvEZpJfEpjiW1i
         bugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794549887; x=1795154687;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xFaxwfpj5KbqoBFMnfOTbn14r38Tg3ox9XxMLJZOVU=;
        b=fu8uXuYBGNhiXV/tm7HJoCNxKhLWfGBrbsYJjmzIecwlCaJeNR6MXLIotS7Vl+oqTe
         auk8BfkfiGx1+cb6Dh11ne1OOioDkyP5siaD/DBudWxYQECg+w9kbFK4GtV5gcS904rJ
         BR2dOK+I0ddchbkd7knjonJUyB5wAYPcR12mu7h8FgqgLSKa9GKebk0QLPD2kzGqCeR4
         dX3+xDGq8+Z/9qB2gjZzqlCxpJn6JbBbgblmsW862XRVYNxRmJyA76rtU67m/M3C/MRv
         ivfff1QuYtxVPtJNCCTiIryuX9LWiM5UOmQahHl+qUCBfIPmTu2zz10qlYldvFyiyByr
         L4Vw==
X-Forwarded-Encrypted: i=1; AL+hErEsJrxXCbhGCyRhFmBClQMZQaKCVTLCeKDB90aAU2S4pER469m8hUIuHxgGkIBYth3ufNRh1CfVXR21TEf7@vger.kernel.org
X-Gm-Message-State: APuU4Z+LrYhReuWvUMbRyQogjB35UOVXh1Za6YraTAdd/aMVDeU1lyEe
	8yd16Yo/4cLMLW5c7DOAHBwdv6TjP5X8dSuLDEpi99Tlq2Rg+gHnPoiPtC6acwYWB/8=
X-Gm-Gg: AYBFou0ix4A1Yd3sVKi3S/d48NRPu6cDuDz+RxRaf9Q2/hiogNreTaZHB+cdl1Kf7xh
	Jazj4g0cUl1+qAWIPZ9nyiFJj/QcLjuVqUDSVcoBq7UaehdOqScEIybKZbvU4ntib//2zEdiOsx
	fSwgVjR5ZH25XFUNqQQQctMvFF0YVfs50tYsBOK7sFHrY7Mj0ZQr+0qFss55BBx1ySCnxAozSJh
	okK4+kWjR4nszfAgHi4gGXqFF2wYdQl+zER4PYImP0uaDF8ojRP5ZWbv8V/1Vt02dI77fj4bpei
	4IufDFfHtnKt7dV0nc/6x3XNUdms0GEGuHi2hOAboZf4x6mF0nkQnt6IxK6/y6wfFGDLe6+D+Bu
	WRHmkk5MxJjLMe2gPkczp9nxfX7xE45CBdbSIpHgRyZzAjrafMQ2qaOtc5wYheoxE03KH65MHm+
	Na80hHuaudsT/+U5zaHDRKTAfhgGI4iHiysyO5id+fNJ27DkO9QMNYtdAiziWlhMwEAUt0nRkXG
	2B/7l+nOK3gk+DCrNEDLINVPObZx86mKNug7gd5Yv9JeclJtYNIKj+4m8pRJZpvNYvgs2iii/EB
	iL3OSdz8MtoLTzYoD1e7WjFv/4auQofRmAoWaKhZfwOfq3typEErBqMsmkNaKdzAwm1Ci9WkP1h
	2xLKBsec=
X-Received: by 2002:a05:6214:3f81:b0:91c:6d83:60ed with SMTP id 6a1803df08f44-91f2424ace7mr21809446d6.55.1794549887409;
        Thu, 12 Nov 2026 22:04:47 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9ade7sm13257376d6.5.2026.11.12.22.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:04:47 -0800 (PST)
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
Subject: Re: [PATCH 08/12] mm/migrate_device: do not migrate a
 uffd-protected zero page
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Arnd Bergmann <arnd@arndb.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-8-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-8-00713d368976@columbia.edu>
Date: Fri, 13 Nov 2026 01:04:45 -0500
Message-Id: <179454988585.482102.2051616940227067987.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> migrate_vma_setup() installs a migration entry for each page it
> collects, which carries the uffd bit over to the new PTE. However, a PTE
> that maps the zero page is left in place without a migration entry.
> migrate_vma_insert_page() later overwrites it with a new PTE that is
> built only from the VMA flags, so the uffd-wp bit or the RWP PAGE_NONE
> protection of the old PTE is lost. The same applies to the huge zero
> PMD.
> 
> Once a driver has migrated such a zero page, writes and accesses to it
> no longer fault into userfaultfd, so the manager misses them. With async
> tracking, PAGEMAP_SCAN unconditionally reports the page as written or
> accessed.
> 
> This requires a driver that migrates memory to a device.
> 
> To fix it, do not mark a zero page for migration if its entry has the
> uffd bit set in a VMA registered for WP or RWP. The driver sees an
> address that was not migrated, which drivers already have to deal with.
> 
> The uffd bit can also be set after the zero page was collected, as
> write-protecting only takes the mmap lock for read. So check again under
> the page table lock in migrate_vma_insert_page() and
> migrate_vma_insert_huge_pmd_page().
> 

Similar to last patch, this changelog could be improved.  My best
attempt at summarizing:

"""
Device migration replaces a zero-page mapping with a fresh entry,
losing its userfaultfd WP or RWP protection.

Don't migrate the uffd-protected zero pages.

Skip protected zero pages during collection. Check again under the
page-table lock before insertion, because another thread can apply
protection after collection finishes.

The alternative ...
"""

I have concerns with this:

> The alternative would be to carry the uffd state over in
> migrate_vma_insert_page() and migrate_vma_insert_huge_pmd_page(). Not
> migrating the zero page is simpler, and a zero page that is protected by
> userfaultfd in a range that a driver migrates should be rare.

This basically force-fails a migration of a uffd protected zero page.

Wouldn't we expect this to cause drivers to fail to make progress if
they require that page to be resident on the device?  Not sure we want
to force drivers to try to handle this special case (if they even can).

We'll need some input from the migrate_device/GPU folks.

-- 
~Gregory

