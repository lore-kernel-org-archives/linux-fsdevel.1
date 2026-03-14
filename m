Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967234CFD7;
	Sat, 14 Mar 2026 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527273; cv=none; b=m8RxttAqLs8cVmTB4LBkrCxNBTDmO9F0DuyQ5mgvT2uOlyN5vnbANyRDya3S/aeHPRj9B7G9JayClo5TXv81XZYDJgC5yJTbN40uB2u9lGOvajZHFXoF29ciALH5C5WdNCJu/9L9DYq7Y5Z/Wq1OPCAbiXosa0INsLySEsO/9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527273; c=relaxed/simple;
	bh=X38QD4+JyXnbtGHLHFF9MNkaPpIwI09kD0O+bLsHuws=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OHPi6DNM1AnDdGLQhyML4KxhY5p4dWc7LfCudUleYlEORrw1kVb6JqCMO4ELSAYGxdEWWL9wSajYMwYBExYE+v41aHRJinQ02WCLlPO+m/npwfApquLLzAdMXQBBfqa3N5bAPVI++lRlK0K16MnURV2HEVshikkhNDQC33ifldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sjn+o12p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sjn+o12p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECF2C2BC86;
	Sat, 14 Mar 2026 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773527273;
	bh=X38QD4+JyXnbtGHLHFF9MNkaPpIwI09kD0O+bLsHuws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sjn+o12pPgun6HUvrDrwzcQoQeLDcZZpgkEXZ7PKu7/yBSWp15sPVc5oqNahiQ29K
	 DkoMISlpj0nlBMuSRWVRb8qboVs0ApNzzkzD/7R7dE9bqNEjTaugZiWeqNh7XInBbr
	 mj9J5LKlZUITc3HqFOulrx6blNpkLRXXHfKpwR30=
Date: Sat, 14 Mar 2026 15:27:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Matthew Wilcox
 <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>, Eero Kelly
 <eero.kelly@dfinity.org>, Andrew Battat <andrew.battat@dfinity.org>, Adam
 Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: add folio_split() and filemap_get_entry()
 race test
Message-Id: <20260314152751.101b5d04d3753f75027b9cd6@linux-foundation.org>
In-Reply-To: <20260313114037.3593642-1-ziy@nvidia.com>
References: <20260313114037.3593642-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 07:40:37 -0400 Zi Yan <ziy@nvidia.com> wrote:

> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages shared by both a parent
> and a child processes, where the parent process punches holes in the shmem
> to cause folio_split() in the kernel and the child process reads the shmem
> in 16 threads to cause filemap_get_entry() in the kernel.
> filemap_get_entry() reads the folio and xarray split by folio_split()
> locklessly. The original test[2] is written in rust and uses memfd (shmem
> backed). This C port uses shmem directly.

Cool.

> Note: the initial rust to C conversion is done by Cursor.

Hence the CaMeLcAsE "struct SharedCtl".  Fair enough.

> Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
> Link: https://github.com/dfinity/thp-madv-remove-test [2]

I couldn't immediately find any licensing info there.  Bas and Adam,
please advise?  And sending your Signed-off-by's would be appropriate.

Thanks.

