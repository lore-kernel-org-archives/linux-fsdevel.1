Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCE221FBB;
	Fri, 20 Mar 2026 02:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773974480; cv=none; b=LTZkkjQgVtSoTet0U9TC3JUvMFoXyiB6Oj2l6pu1iGbu1mRWEyCXxnowdAcM/vaOSDCwA9HHH/cjOJIb99qXSTIp8t/e5dewQgW8bWgw6Hwhbsve/3idoobGtpb9rP0QwuTUMoYMR5aG6j57GyisxQ1smA5NiJhGkUAm+txdBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773974480; c=relaxed/simple;
	bh=dW4W0pRhSJJfJO50TMduySGdeJlAKq6w+m3RnpGWm5Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LETyrqKZrGk4FjKfdt9RmVGKElOJN/7gXJvvgCrob4Qas0K0NtkqeAh+CPsC9r2P6meX2GSLoWfRgt7Hz8e4Z1n/srHIUsERi7BHoDI4N0q9Lzi4RH9s9WNuw0rQ0lAaKM0V+ty4d2lXEtGChOh1XctXtD05vlT9HxGYJy3g0pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GaMcRgKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GaMcRgKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1530FC19424;
	Fri, 20 Mar 2026 02:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773974479;
	bh=dW4W0pRhSJJfJO50TMduySGdeJlAKq6w+m3RnpGWm5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaMcRgKCezfkg6LHE9uTNlKAHPUdosSJso9i1Pmj+34bAqDJv+s352xbqtcXO4nvr
	 6Rx/I8vKIZs0LgvdB7mOvngG+Vx3LeFQ/CsLMWO7oUKuw3ev6bWXdDsr8Yr2iLqktU
	 BMsypUk7l9MRqy1788IbGpJ/FubAcnJZ/i/PHIpw=
Date: Thu, 19 Mar 2026 19:41:18 -0700
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
Subject: Re: [PATCH v3] selftests/mm: add folio_split() and
 filemap_get_entry() race test
Message-Id: <20260319194118.3eb42ee3c507fd0ce2cd66bd@linux-foundation.org>
In-Reply-To: <20260319190409.294523-1-ziy@nvidia.com>
References: <20260319190409.294523-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Mar 2026 15:04:08 -0400 Zi Yan <ziy@nvidia.com> wrote:

> The added folio_split_race_test is a modified C port of the race condition
> test from [1]. The test creates shmem huge pages, where the main thread
> punches holes in the shmem to cause folio_split() in the kernel and
> a set of 16 threads reads the shmem to cause filemap_get_entry() in the
> kernel. filemap_get_entry() reads the folio and xarray split by
> folio_split() locklessly. The original test[2] is written in rust and uses
> memfd (shmem backed). This C port uses shmem directly and use a single
> process.
> 
> Note: the initial rust to C conversion is done by Cursor.

Sashiko has questions:
	https://sashiko.dev/#/patchset/20260319190409.294523-1-ziy%40nvidia.com

(this is getting painful :(.  I hope they're worthwhile)
