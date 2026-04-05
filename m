Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537D2701BB
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Apr 2026 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775410723; cv=pass; b=tjAvnTiOwZT9wyRUjYh0qwFC5kYvQBC4XzJ/lnhQ31u3/S+CoXAEAuBa8mqeDS2P6j9Z2GYbUomSkNvwsD+51Utr5lVoqlw6UhxKF4SwHuS15m/VVzpLiHtJ/9wHcQHntstQ/gdslod/emjO4kW2jc1JPJN721lFX8KzKa7wznA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775410723; c=relaxed/simple;
	bh=M0fGNUnxdPTPfMB+NZtRovqgahD9QFR1fhA41vPhX90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii9sLLdRx/iuQw4DwwE+XilGsDM1KyP38I0dQ9zkKY8RSaOELLiqw57HUb4D3FPgKVOM78ft/YxLLsMAZMGiJTH6QonfKHkUs2rPzwjzK569fpKxzwWiyDXmxZPQ7e4zxSMPic1dWOSD98tyj5QxncSY6bQfY8GIBr6oTF297O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUra9IOd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cTEclwI9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUra9IOd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTEclwI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775410720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPHyJbs4uiXMxYGli4epDavO7/1nm+agc9OgX+7C8vc=;
	b=ZUra9IOddYLypSRePj+QyaRZ9Dmp+GqU4JEs5MpsbbpXQTCPMtXTELfbfmVc8R71iZZuN0
	xAFVH/U9gcMxwmrp8c9fAD6Lmru1lytU4elGVmEmrot47hN8ZFGJH8QpwZ6qyCrnPzjbJe
	eFrvSRm4Qgp2yx1Te/1cOT18BDZ/1Lc=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-qHfmpkOLOdy91E9zcBcexA-1; Sun, 05 Apr 2026 13:38:39 -0400
X-MC-Unique: qHfmpkOLOdy91E9zcBcexA-1
X-Mimecast-MFC-AGG-ID: qHfmpkOLOdy91E9zcBcexA_1775410719
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65015facf88so6482592d50.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Apr 2026 10:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775410719; cv=none;
        d=google.com; s=arc-20240605;
        b=UEwGvipIr9+PEHC93DVeNpv1vxeOMaiTAFbk6RsMtbbz7hb1HBEhErWHtplSWHTOyQ
         yGW3yQGtk+aZZCqfJjXEdvVB7WJmXhECVomqg/aFecS9VQNQUmcqTGSdb3ByNF+H1xq4
         ULRYPseua7PiYD7RgqseJ69NwRbER7zzACb21pP6atTBo8Jb5OPfqEfp5iW+gUK7yGWQ
         sm8sFZ5u/0N2S5SBe3zGSpYI/HeFah8Xce0g/3pEAvP8OQmit4yjPYu+EJmUhjdpGSPD
         RRGoEKSE0J1f9TBRUtBLTM8v1Atkgr4cuGVn5SiNUz/r2unPJq9Sdkwdi3qXLMCfLeKp
         G+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jPHyJbs4uiXMxYGli4epDavO7/1nm+agc9OgX+7C8vc=;
        fh=mY5BjUFcgZailLNR5s33u7gGybFPwVcxpcEa8keSQto=;
        b=R06pO2yACAyEaXSqj66yjMVccS8yAP11eWhpSjMiCpkOBhYVh/d5GfkCOg3tKGy+Uu
         S6KMjCpsK0cqAoNzePQ+gEvW1WhmA4MpPIPy9dd46iXYgdfR5LnVZfCHGpEK5pdEKvU1
         ws/y8f7B31yWL518phJPY0aJDE5OQIlMQuaXTVSdoCzpaR6NiA0WxzIXbtu2XCLvnwho
         1uQmELuUufLHlviKiwyvPy45RET9VEEb7M4OX8bshXGb0ZD22bzxUgzLMq4KMEAYQcDr
         rr8tDr4G22L83Hd3tGcTNbFJJyY2JIn5YYWt28kud4phVk2tU1lMb8ykFajIGW41/GX8
         EC2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775410719; x=1776015519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPHyJbs4uiXMxYGli4epDavO7/1nm+agc9OgX+7C8vc=;
        b=cTEclwI9jK8i1yhwW5Qc/jNuyQDsKfydKPul9VKuW4T/+pZhR0wbXXqv96pDzb08EV
         SdZUT59raZtr9UtXZV2FrQ0+pg/xOef8e+zVhmdwzW4Qt1Xyf2lAZkbNsvIlcV7tx2Ct
         kYvS58l+pwJeV8vMPjlgfdqRB4OY1gL17INC1G4RzhM4CP+UU4/BhA0prxCcBAGd2SoF
         yLZi2OfI/k3TjMFGgRVzclQl9jW7A5Q3DSZzy6uHD9kK7KPEKOaelIf96jS1v6a4SFMt
         qmSNTKCyijkFRY0f9oA7nSVGkr1dRgmisQqAbHbEf+RrXTlIDSWlyo/6vPS4MuTZHwtP
         IUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775410719; x=1776015519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPHyJbs4uiXMxYGli4epDavO7/1nm+agc9OgX+7C8vc=;
        b=WQA/r8yciMkM9/vG2FPAAR0vWlM/grF/2WYyBRpXRXsCaFemREtWofCk+8X7OHq00r
         0QH59vnx3GfGCAh3tsL6xVP0qSorB3d1uT97evrEd/dL1Gw7mkMUeguRR8crqbjp5Qyr
         U4sRL+CJMw43i0oNHyi0MNlsC41qYqQLmoFV5ShbvqSYhJ49xjxektg1RToyU2PChnd6
         iG7mV7LXryvUUjeVHzVzW8+MWGhTWfBr0CelxKJMZUA7xEhGFjrEiY+cPzRmBBHPlHfm
         E4NnJyQ9drIr7y39633wC7ctQjxgEd2TXTa1s/vCtEL0/cxU8K8m6W0J6T8i7CXxo/7J
         qXUA==
X-Forwarded-Encrypted: i=1; AJvYcCVr8AcPUnx9eolnLp6Ps6BJzdwABxefE6IAWXS1xHvedMLzSdvFx1KEX3EekfaHDu8I5DT6Jr5XTaJNyYjH@vger.kernel.org
X-Gm-Message-State: AOJu0YwsHTw3q/LGwDVDg5LAEBJynnQLODueqFWLlU/99sLjDl0OYi/k
	OaVIweSqeAu9fQWtliBhPd/hI1KMwfUvilzMxlt5+5TDfivn9B7OQdb2hXwYMRv4r6oGQk0rVsF
	zdLhsLHXxrabCSNR5USD99jMI3nJ4v3IGBCNlr6cw8ssKBSQT+Os/YcY8E9L+2KclqRRWbBkXTl
	heTA20kHvYq4uc7SCPnBNoA3JMmPqlOCbreLs+yKYw/w==
X-Gm-Gg: AeBDiesmzCLto/AEQR9m7Canwt1hzSZmucBAyy5FQ3ATHFnvNFRyw9Zo1RAyS1X/+Z9
	k862jy7vIqAiHwdLRKS8Dd6II2v1mq4KmUsC9qilxBLx+DdZJv+i/0T0HUYfRmsFTgcmrhbuR7N
	xUd9PlIEb0UBcCQ2U7QRh4qWwkzKOipP+QdSSyFPB98lbt7nN203IZobYs3fKqUh5bPcCVMXlCy
	0SmB4q/
X-Received: by 2002:a05:690e:1246:b0:649:c36a:a9b4 with SMTP id 956f58d0204a3-650488246b4mr9221007d50.36.1775410718590;
        Sun, 05 Apr 2026 10:38:38 -0700 (PDT)
X-Received: by 2002:a05:690e:1246:b0:649:c36a:a9b4 with SMTP id
 956f58d0204a3-650488246b4mr9220969d50.36.1775410717507; Sun, 05 Apr 2026
 10:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327014255.2058916-1-ziy@nvidia.com>
In-Reply-To: <20260327014255.2058916-1-ziy@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Sun, 5 Apr 2026 11:38:20 -0600
X-Gm-Features: AQROBzCPtZOBkOnc2jS1i15igfbub3Mq_1a1-pEjy-3xwa9Wl99L5UbfvWnok3w
Message-ID: <CAA1CXcCmue7iX3O9RLo7wR5EqASvJGCLraw1+iQMZ98BiMJwrA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Remove READ_ONLY_THP_FOR_FS Kconfig
To: Zi Yan <ziy@nvidia.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@kernel.org>
Cc: Song Liu <songliubraving@fb.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Shuah Khan <shuah@kernel.org>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:43=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Hi all,
>
> This patchset removes READ_ONLY_THP_FOR_FS Kconfig and enables creating
> read-only THPs for FSes with large folio support (the supported orders
> need to include PMD_ORDER) by default.

Hi Zi,

Thank you for tackling this :) Ill try to review the next version as
I'm a little behind on this thread.

Should we guard collapsing READ_ONLY_THPs with a sysctl? My fear is
workloads that convert READ_ONLY THPs into writable pages (assuming
this is common/possible; my understanding of FS is rather low),
leading to storms of thp splitting. Do you think this is a real
concern? I guess this is also true of read-only-->writable fs-THPS
even without khugepaged, correct?

Cheers,
-- Nico

>
> The changes are:
> 1. collapse_file() from mm/khugepaged.c, instead of checking
>    CONFIG_READ_ONLY_THP_FOR_FS, makes sure the mapping_max_folio_order()
>    of struct address_space of the file is at least PMD_ORDER.
> 2. file_thp_enabled() also checks mapping_max_folio_order() instead.
> 3. truncate_inode_partial_folio() calls folio_split() directly instead
>    of the removed try_folio_split_to_order(), since large folios can
>    only show up on a FS with large folio support.
> 4. nr_thps is removed from struct address_space, since it is no longer
>    needed to drop all read-only THPs from a FS without large folio
>    support when the fd becomes writable. Its related filemap_nr_thps*()
>    are removed too.
> 5. folio_check_splittable() no longer checks READ_ONLY_THP_FOR_FS.
> 6. Updated comments in various places.
>
> Changelog
> =3D=3D=3D
> From RFC[1]:
> 1. instead of removing READ_ONLY_THP_FOR_FS function entirely, turn it
>    on by default for all FSes with large folio support and the supported
>    orders includes PMD_ORDER.
>
> Suggestions and comments are welcome.
>
> Link: https://lore.kernel.org/all/20260323190644.1714379-1-ziy@nvidia.com=
/ [1]
>
> Zi Yan (10):
>   mm: remove READ_ONLY_THP_FOR_FS Kconfig option
>   mm/khugepaged: remove READ_ONLY_THP_FOR_FS check
>   mm: fs: remove filemap_nr_thps*() functions and their users
>   fs: remove nr_thps from struct address_space
>   mm/huge_memory: remove READ_ONLY_THP_FOR_FS from file_thp_enabled()
>   mm/huge_memory: remove folio split check for READ_ONLY_THP_FOR_FS
>   mm/truncate: use folio_split() in truncate_inode_partial_folio()
>   fs/btrfs: remove a comment referring to READ_ONLY_THP_FOR_FS
>   selftests/mm: remove READ_ONLY_THP_FOR_FS in khugepaged
>   selftests/mm: remove READ_ONLY_THP_FOR_FS from comments in
>     guard-regions
>
>  fs/btrfs/defrag.c                          |  3 --
>  fs/inode.c                                 |  3 --
>  fs/open.c                                  | 27 ----------------
>  include/linux/fs.h                         |  5 ---
>  include/linux/huge_mm.h                    | 25 ++-------------
>  include/linux/pagemap.h                    | 29 -----------------
>  mm/Kconfig                                 | 11 -------
>  mm/filemap.c                               |  1 -
>  mm/huge_memory.c                           | 29 ++---------------
>  mm/khugepaged.c                            | 36 +++++-----------------
>  mm/truncate.c                              |  8 ++---
>  tools/testing/selftests/mm/guard-regions.c |  9 +++---
>  tools/testing/selftests/mm/khugepaged.c    |  4 +--
>  13 files changed, 23 insertions(+), 167 deletions(-)
>
> --
> 2.43.0
>

