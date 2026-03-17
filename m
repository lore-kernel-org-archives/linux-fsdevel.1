Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2677E347505
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732733; cv=pass; b=IO3zY7tZkLrK7IFsgpsMY7svnQvx1y0LMK4KYHNEqhaMDxsA0r/LCQuGxA2TlwV6nlfcpjXx72uRe6s2bA/oq66SRvI4UzJz++j+0jKMCT1B37XkUKJBiLwiDOi9NxCw3Owno2GKJRlRHDnnk+7ZahVCgHW2UWe5WT3j4r2SeVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732733; c=relaxed/simple;
	bh=7IxfP5QbYTT3krIp+mLrnX1UG8btjGEjKPBXfVEkPew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0ckfYz8oKduERn4ts0Pmx2kfXUm3Nt8SKEwzDnOA3VhfkwVPNnzFP2/o5qh4dZ/lTjzGu4/Ajm4Ef61QLdKE7IgWjIXsTK4KjInTltYF9zGs+YIOlZrQU9FvKVGV/+nFTlRqkiSEHAl+E5YZLyAsm7S4CJjGYMoqzlZWzqVNnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org; spf=pass smtp.mailfrom=dfinity.org; dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b=Z3O5/jCO; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dfinity.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfinity.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfinity.org header.i=@dfinity.org header.b="Z3O5/jCO"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a4118c4f7so57242471fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 00:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773732729; cv=none;
        d=google.com; s=arc-20240605;
        b=OU6kiBXrdaYI0f5QDGmFqGz2luymd+jrWV5BYsuzzrJ8EXeykMnl+A6OHwBvCWwSzr
         ES4NWnUr3AjXXQWQ0jY+cqso4DaA4Xdbes4p3t1RdXa4IcOF/AawxUxMZKFCBn4RZrSg
         Sf8sTV38ZNkP3zubYZjGOZg8HkdnP7R1JsGhs2652ghnsd8gdPkIB8ubWBx3n/9aHV8m
         XVUAGt4OwooZlRYk25PAjP/xw2IjAygmDB5AYX8HEop/JDxaP9po1okJv7BLrpDWioNm
         13V6VQA6AQ7sy9ClrzLH0AHtKggWQdl6PNNeXQYAy3vxU7N8rnSGvkd7zWSIYHTrZxR3
         MV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8rsh6oTvwvWHqaFGsPw06IxhO9DVzxPM89iEh6c4TMU=;
        fh=/UNiGbh+7r3/PtWkaCRI1+kYlIHUaFntIAiMQqgVSxQ=;
        b=RW4fwfzu2qzAyeGCo5nuU0BdJaARho7E5lBDXRHqIW0SepjTIKQgce6qsBdNwBFH8C
         eb4h7ZW3494cMU2D3epwW4JsvMC2BfYJ2xVQzNFrrH0Mer7II2JdJABGZjqz/9MfTNcQ
         0nK8A1LAY3CejZvA4L3J7rs4OEPH6EgXrJjLjVZMIfOug+hVyIDhIBwrdJIEuaH4yAZm
         ECtRoazQjX5CqlNvbDSlHuh2jCXa5UmwEu/H/Bz5MILY/wjCxdtw1Uyzal5Pc34wuFbE
         BhAH8CmkPnC/tgFfERaNc2M3kdm7qkYYSpriu3rGA8CDcud+ogQ0yjYoU05+UI6a34rI
         qy3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dfinity.org; s=google; t=1773732729; x=1774337529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8rsh6oTvwvWHqaFGsPw06IxhO9DVzxPM89iEh6c4TMU=;
        b=Z3O5/jCOV5B62SgPgXGAo92J/m8REygR435jkKsxubLVjvlNid3FIlvwtf2fJWvCia
         8qU9UQyzsWAHChwvz3n8u8Urf07Wu0yWbVu4cV+BD6hJFc01dCXsibJ74wGPX2OckYhr
         8yA4px78P4sBvv501Y5gXxio19gKqzroK3zX2BMJ1/9UmhXyZo6A1Ag8YSnIwlGYsoO9
         B74xeAh/Znro89URrxZfDCu62iDnjPmI3pjdvc2ICY/JOCod5MJdG0Nqi5RR3ZBGLo+m
         tKKGRU7cLmEsHz9K7zWQN1hK25zbo5DgThi9QO9Fz5dCtSLSNl8BQrJE6SXEbSnZObxr
         V/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773732729; x=1774337529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rsh6oTvwvWHqaFGsPw06IxhO9DVzxPM89iEh6c4TMU=;
        b=NsxF41aK8MZS4Z5qov0XPWLWxEV6aNPcqYHBePf9wf8npjyYyrDwIhGpMNKniYgR5c
         T6sBit5ryoSvxBQ+AULBdAnRG7MS8ko3dcdBvlrgWhICCwBXd/vp0kq+JcvwPJkLfyPB
         0OHFZSBGxOfC+jh40E+ZLThDOP7zh3nyi1+GtLD05k66KQjUqFgLOf+aH0EkPlcEocIH
         WyZLBVv6vEPQjzsrCOKUB6QaIhhdbDdyKJd4mq3SxPLHaj/6Xln3YK+AbKo3enA2Xrrw
         FsYstgvriE92772Umznz+pTgt859nvqiOIEX4OWIUTrvpwgo1uACuHh7UKlyrhVF9ISA
         mSuA==
X-Forwarded-Encrypted: i=1; AJvYcCVXlwabo+V4wEapeb9CGTgmTtGpgFDe4uyvPJeEHEHr4qwph4DijZXVzI/+Vt85RPSlguOaTjh6/TtIkRyT@vger.kernel.org
X-Gm-Message-State: AOJu0YxKk/oIoFhF902sdrHtnNnUbZFwaAhv+qUlu55iU7XlNE82lxA0
	m0SqBEM6JEI70enD51R+VJGeiEA6wDB/uUQxoyECTmxLiNVJ5u7jRQ9wifbWZDpsRzvN5e5frhZ
	PQBjjeWmkqq1CoXpaKEOkuxkr9repsNL0e+Zkp/Z8Ag==
X-Gm-Gg: ATEYQzwnFBJgU3fURcuN1I/U8AdhLcyXUiNco36IkuM/dedQy384EmQLz4RRVaxmn43
	WGZuOGkg+v8Zv/2fWCGq4qSTvW/BAlcNZiGoSGyCC/W43wOWjbj6vmY4WABrPr0J1FfFCfDOLar
	1v4xl+5ZLEiDggwEzGUkZqYBIsnilJC/DH0gW10dTrq35tKw/04HBPyFfu1f/7dtzXi391pC7ix
	nv0BLT9ljG6ejwEr5SUCOtvJFrchgpcqCvg4hmDP5iPEw1lSL5PZpdryXNaRS3yS8sCNuUUwKEU
	rNP6UWFJ9HxFVMi4tIJsl3I+IVQB4puC82MDwvPG4n1ctW3v5ce83gQjKcxbjLr15o+D8/E57Jf
	22QowmCyB9RuUR0TIEw==
X-Received: by 2002:a2e:a44a:0:b0:38a:87bc:1a17 with SMTP id
 38308e7fff4ca-38a8966f739mr39278351fa.13.1773732729015; Tue, 17 Mar 2026
 00:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313114037.3593642-1-ziy@nvidia.com> <EC71CE3C-08D9-48FE-95CB-B6A43B4BDB9C@nvidia.com>
In-Reply-To: <EC71CE3C-08D9-48FE-95CB-B6A43B4BDB9C@nvidia.com>
From: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Date: Tue, 17 Mar 2026 08:31:57 +0100
X-Gm-Features: AaiRm504dZViD7hqCg2k-u2YHFFQqbiH0S47_h1Ehq5i5K0MI7wK9iOBPdrjZQw
Message-ID: <CAON2GcE-1t7pbunFwtymxEiz1f5osT2CSEGw35Lv=7UaWFkZzg@mail.gmail.com>
Subject: Re: [External Sender] Re: [PATCH] selftests/mm: add folio_split() and
 filemap_get_entry() race test
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>, 
	Eero Kelly <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 13 Mar 2026, at 7:40, Zi Yan wrote:
> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages shared by both a parent
> and a child processes, where the parent process punches holes in the shmem
> to cause folio_split() in the kernel and the child process reads the shmem
> in 16 threads to cause filemap_get_entry() in the kernel.

Note that the fork isn't actually necessary to reproduce the issue. I
had it working as
well with the reading and punching in the same process, but just with
two separate
mappings. Not that it makes much of a difference - just in case you
wanted to simplify
the test.

On 14 Mar 2026, at 18:27, Andrew Morton wrote:
> I couldn't immediately find any licensing info there.  Bas and Adam,
> please advise?

GPL-2.0 license is fine by me.

> And sending your Signed-off-by's would be appropriate.

No problem:

Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>

Thanks,
Adam
