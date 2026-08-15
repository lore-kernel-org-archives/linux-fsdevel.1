Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA7371CFF;
	Sat, 15 Aug 2026 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809964; cv=none; b=Cuvzg8R5j0XV3yJ0KU8A7dq1HaOXKz9al3Ge0TmsDmXh03V4rxSNSVYC53V4awYT1FNJ1M7XWWAf9ABljq1KxIbZ6JapWEhzxrseMUyTlUUEIqZK7Zxz2mZIcPFt57LN3rvXlw5K54gU0DZnVvBjkxfvyMWP0QeY+0OwYue/zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809964; c=relaxed/simple;
	bh=5WQm4FOrSKWLlpnxV/luviAmOHGf4ebZ2NYMpvK6LrU=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=bGd5ITdZsvGnjCaIG17ROeN6/ofDBLUkgd6WPuutwvFcSuCFQU4lSc2cv36o+zBEund2BPyRT/Oo4PG9G2rNtKKL+JRYaGbgdTKsRlHBn/h50uqNa8jlDMmie6lgpOk9L5spb5bdm9Rvugi/UQf8FSXWosOl9OMYDarMVd96WVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=CcePYo4R; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="CcePYo4R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786809960;
	bh=5WQm4FOrSKWLlpnxV/luviAmOHGf4ebZ2NYMpvK6LrU=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=CcePYo4RSbzzdbeEAv7fwt9PVJLoZVRTCNV37C7615ZhE8ZQbjvvTGcR10vdpStJM
	 d2i0ajFa3ztqTRcLTYQguz/2w9H2xHWuHgpIwYT6ZGTuceJ4O4OxZdeUD+eVeypMWv
	 GD+aHVsPkx7LhECOXmJrcUS5XIkUOW2CWYwq25Nk=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hMkV06bzlz10s3;
	Sat, 15 Aug 2026 16:06:00 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hMkV03P6Vz10qy;
	Sat, 15 Aug 2026 16:06:00 +0000 (UTC)
Date: Sat, 15 Aug 2026 17:05:59 +0100
From: Bradley Morgan <include@grrlz.net>
To: joel.granados@kernel.org
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: Re: [PATCH v2 4/4] sysctl: Add 0013 to test partially updated vectors
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-4-9df50d26e477@kernel.org>
Message-ID: <1EF80864-F479-44F2-8CD7-28383515F483@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

The test covers the parse error, the out of range value and the
first value failing. That's the right coverage.

The shellcheck disable should say why. The test functions are only
called through the dispatch string, so shellcheck thinks they are
unreachable.

run_int_array_no_partial_update() uses spaces for its comment lines
while the code uses tabs.

reset_vals() has no case for int_0003, so sysctl_test_0013 calls it
for nothing. Drop the call or add a case for int_0003.

Nits aside, the test does what it should:

Reviewed-by: Bradley Morgan <include@grrlz.net>
Thanks!
