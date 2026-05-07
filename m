Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1996132E6B4
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778135722; cv=pass; b=ens5SliB17koDLfM5C382s0b2NKMrSMTXvk1J6QR6AQKRfee/juumSKlB++0JmfxKToqkUfqZVSoXvpkgc+XEuToJf+Wf5M63c6e+5hMpSpz6/k5IKD0xg+XikvCY1cY2h3XM7/6jAn10OHiT+wgjvS8ZGNrgDA6clyo80rVw0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778135722; c=relaxed/simple;
	bh=1e5QWdJdXYo85SIoew9kJElgC5BVkyxCQhjqgrYoXKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTeSts788P1rUfyqI7/n8QZxYKTtX9C7wzRjnVxGKysPB2MqGHG4NeZJhISIv1KQzooo5toIcuBbD0LbTH3JdwK4rQZVNlpk/cF1zBDl6nyGYHMu+YRD+au/pqwQxKH0gdvLo4UVhnVU20qXYaPcBsZ1HOMyiJ7brju38d3FMOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KFFihbVI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3IjTEko; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFFihbVI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3IjTEko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778135719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmF8e40h90ljVl04zACNPWVQcQh3Q1EW1p6gC9vnX28=;
	b=KFFihbVIJG4kE9rDZOUB7cYtWDy3+tbLM+pJfHzh1QZwgX5tUnv4g2hIOqE7ZFt63RLv7o
	upPwq1l+xfDBRbqEHbUISAZoWbtMSHCPZ2qv7AVhn1mPIysh/DsJMxzaMZHOXHoAZGwIcp
	nh2NIjg6cqBNnk5tDtDbB06ygTTWMuQ=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-f2dfTeyrOYuBqDZtuqELHw-1; Thu, 07 May 2026 02:35:17 -0400
X-MC-Unique: f2dfTeyrOYuBqDZtuqELHw-1
X-Mimecast-MFC-AGG-ID: f2dfTeyrOYuBqDZtuqELHw_1778135717
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c5afaff48so1143546d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 23:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778135717; cv=none;
        d=google.com; s=arc-20240605;
        b=Ij4H5RkrDfR+vrHiPmZtDSIlANY4OOixSaRX6+MnoSd043RCa+Fae9XHuj5iUmrtpK
         3y7I568r2wJrDBmICRcyaW3byQ19EcOX2iWpAUU2pAffsu+9t0fuAHe0OfSdL4ZBVtkT
         d43jcwc0P5os1uxw1ygPwzita8Rq0gi8AmsmATDjfP/o6aLeSqdpeehqWdjdPYNwzgOd
         WL7mvzLW7Dqs58+RCxbA6Z+SZcw+xM9sCtfRc6FDjyB2szRm15OMWiw2ntFPdLU7s4Nw
         qHlZkb9cGppkeak9BS8/GOrpyRebaFuU8yEPHy/nbRQtoghq8P1eBZcghJ46Uo9e8i4W
         eVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BmF8e40h90ljVl04zACNPWVQcQh3Q1EW1p6gC9vnX28=;
        fh=PbYlccvlfVoOBhSJaRHvn/hc/mM4CUBxW1vAJUD4ErQ=;
        b=Ml5deaswlqKs+YxXC4/w5hXy9yyKnRcOJT+pka3GAUR5jtfpup5JDpla9M3Hr63oR7
         Ng7tuR08PmOe3T0aXcEBMc+Dv/wpVIw7keaCZjTpLnEBvbIJZAKV7VKBy37XDUjvCvpX
         fW/BkVLYHJIxbbBVtEwyclHkOwBisgZtbrpOTueRjcgikJ66i5PjVYHC962cNUGbXfvi
         wFb08Oukz2iFW/czyjVIeXoH+N8XYf7lGv4LMOH7VL6u58Zjd2Pc5uJd8teY2as47azy
         8oHTZAyMm7Dlv0wG7MnkfrTBm3sNoxfRtaM8yJhP6/xcj4MyDhKDPIXNqkEw51MEivSc
         6ghQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778135717; x=1778740517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmF8e40h90ljVl04zACNPWVQcQh3Q1EW1p6gC9vnX28=;
        b=B3IjTEkoYCKaxqLOVvghrAWTGPQ+CSJAHZDruS1jDc34+tlAtlnFgojqh6cUFopktv
         At1lJiEMpIBnSIFXUci1VdrTeftWTVo3ZxOzYwP7WI5db3xAKfn0xx3OFvLqKQzQCD8K
         1YaR73w6pecOa7I/WHBXeH2lUVoJ7cF6e3HM9HyRW+op0XDscsTndK4ddGj28Gjvp/xe
         jvXsZIQAd6lDqEvLRC5QJzOBVtQT8RtUp0RhZtS+sksgpGS4PAfbsV1wT81rVzQ3T2F2
         PpEUJqqlTuxE3sJJ84dR/ud5LDvvL9O8K2rb1yW6KTTZo+zPcKz1vcBHtNArvscxJozH
         Ie7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778135717; x=1778740517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BmF8e40h90ljVl04zACNPWVQcQh3Q1EW1p6gC9vnX28=;
        b=nlQbu4mA8sW99fLhjGR6p5HiFfvhrgjiXT5CYRYExpbgGEqrOgYb//A/cDwH3pu2dC
         4L/oNGac3tKHdQ0h7URuT4HvjJNtwxqIEKu3H+qMxOaBJJZyNNpFiQU4Dd7oiPjffAU1
         Y98eIID3p5kgceEfegcSQWKiZGYvLZNeRl9+iKvUm+5ZDnWHeq3wY7r0qCjBu9m5FEvP
         VrsZczrfDNFMhyyDbap60FyWjW8Sc5nFmjxoZpp+ogzqOlLBLbrHmyEHsq6CI8A3IF1J
         ztJOpMSsskY8bIDlCtyKR44zGC2ACPa5kjt8anWZPPV9CwGqYnoXFfFS76vurqnaSdyv
         +ZHA==
X-Forwarded-Encrypted: i=1; AFNElJ/IKrN5lt/zUyZRq2Qdtd0h0tj99r8+/p9N1QKuTgXUSjcQD1ho/PrYFlRVokdd+6B/IAypYNj2b1ggdzBc@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUqO81P+f/HzBg6604Kaw0LMeLQ4IjaGCbGAD5YQ8Q/OMn/cn
	RtBPfClM7cwWF8a3X8xy2zHAexryV7kId/PoviXCOQDyDmXa9p4fKdZh3mOzAyDqvZ6OyVwTLeZ
	Tn+lDGCWkO86VkOXu0XQx+ksYiJSvrmp+FIcKKa05ecs1w1qZMyrKQhYYGZzekOBUGSDe2KTmDC
	JjI+XApcY3HP66sZU4HG1lJzW8c8pBNzNyXtlGfc5yZw==
X-Gm-Gg: AeBDievkzJHECf6In9EX1t4Z1o6maJ+ECSKOLPvwD0h6UDUQS7AxH1iMNppIRr1maPB
	ymPDnfPHhCS/nYcDNwUs77xphkZsmyu5uX/JEJuIXMKiT9D/5PCjfLdhBG3qpPyRXPbKgaCsBgy
	BJSKzUnF7pdA7l8aB7oCWmyUAgvNu1IJjFLpyWqkSzCdKt19QZeOBQAGqRLaa6aTX8bS+4tr3xz
	R7yQDl5E4z1qA==
X-Received: by 2002:a05:690e:4145:b0:658:e45a:e477 with SMTP id 956f58d0204a3-65d7e72eademr1206493d50.2.1778135717198;
        Wed, 06 May 2026 23:35:17 -0700 (PDT)
X-Received: by 2002:a05:690e:4145:b0:658:e45a:e477 with SMTP id
 956f58d0204a3-65d7e72eademr1206480d50.2.1778135716760; Wed, 06 May 2026
 23:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429152924.727124-1-ziy@nvidia.com> <20260429153538.727855-7-ziy@nvidia.com>
 <7e42faea-9f55-4722-a426-94be7fc3a49b@redhat.com> <61FB928B-03FD-4852-BED5-4E453ABB706A@nvidia.com>
In-Reply-To: <61FB928B-03FD-4852-BED5-4E453ABB706A@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 7 May 2026 00:35:28 -0600
X-Gm-Features: AVHnY4Lrljxe6KvxlSyOqNI3gvAzejJ0XLC-pzb1vAYqjO_YkbxwJ0hvJkZ60ks
Message-ID: <CAA1CXcDj7Y7Z26f2o211fYewgrfBNOS7SfZ8Xroiv1ObC8dDRw@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] selftests/mm: remove READ_ONLY_THP_FOR_FS in khugepaged
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Song Liu <songliubraving@fb.com>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo Stoakes <ljs@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <shuah@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 7:15=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 4 May 2026, at 18:11, Nico Pache wrote:
>
> > On 4/29/26 9:35 AM, Zi Yan wrote:
> >> Change the requirement to a file system with large folio support and t=
he
> >> supported order needs to include PMD_ORDER.
> >>
> >> Also add tests of opening a file with read write permission and popula=
ting
> >> folios with writes. Reuse the XFS image from split_huge_page_test.
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> ---
> >>   tools/testing/selftests/mm/khugepaged.c   | 131 +++++++++++++++-----=
--
> >>   tools/testing/selftests/mm/run_vmtests.sh |  12 +-
> >>   2 files changed, 102 insertions(+), 41 deletions(-)
> >>
>
> <snip>
>
> >> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing=
/selftests/mm/run_vmtests.sh
> >> index 3b61677fe9840..854c5c3e3a6ae 100755
> >> --- a/tools/testing/selftests/mm/run_vmtests.sh
> >> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> >> @@ -490,8 +490,6 @@ CATEGORY=3D"thp" run_test ./khugepaged all:shmem
> >>    CATEGORY=3D"thp" run_test ./khugepaged -s 4 all:shmem
> >>  -CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
> >> -
> >>   # Try to create XFS if not provided
> >>   if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
> >>       if [ "${HAVE_HUGEPAGES}" =3D "1" ]; then
> >> @@ -508,6 +506,14 @@ if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; the=
n
> >>       fi
> >>   fi
> >>  +if [ -n "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
> >> +CATEGORY=3D"thp" run_test ./khugepaged all:file ${SPLIT_HUGE_PAGE_TES=
T_XFS_PATH}
> >> +else
> >> +    count_total=3D$(( count_total + 1 ))
> >> +    count_skip=3D$(( count_skip + 1 ))
> >> +    echo "[SKIP] ./khugepaged all:file" | tap_prefix
> >
> > This leads selftest runs to always litter the output with SKIP when run=
ning this with the wrapper
> >
> > make -C tools/testing/selftests TARGETS=3Dmm run_tests
>
> Yes, this is intended to let people know one case is not tested and skipp=
ed if XFS cannot be created.

Yes but it prints after each test case run, not just the khugepaged runs

>
> >
> >> +fi
> >> +
> >>   CATEGORY=3D"thp" run_test ./split_huge_page_test ${SPLIT_HUGE_PAGE_T=
EST_XFS_PATH}
> >>    if [ -n "${MOUNTED_XFS}" ]; then
> >> @@ -516,6 +522,8 @@ if [ -n "${MOUNTED_XFS}" ]; then
> >>       rm -f ${XFS_IMG}
> >>   fi
> >>  +CATEGORY=3D"thp" run_test ./transhuge-stress -d 20
> >> +
> >>   CATEGORY=3D"thp" run_test ./folio_split_race_test
> >>    CATEGORY=3D"migration" run_test ./migration
>
>
> Best Regards,
> Yan, Zi
>

