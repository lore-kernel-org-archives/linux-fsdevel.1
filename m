Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DED33ADA0;
	Sat, 15 Aug 2026 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786810176; cv=none; b=FCESIoG2b/jnw5RfkZO6IAYNeq3SIZCru7cEwMMeLb4EDEjC91qsXHFA9hj7L1e0pwtOcgauKrjYrJZMTgVKXW5rb9EnWq8MDDRX0mW+Y243dsl0BdGEOKUwasjYABeIGvsbkwj0Cp8quUO9wFKOXZQ+2nwyMUKqjshj2BNFN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786810176; c=relaxed/simple;
	bh=2HZtJ5MrP8KDGrN133O/JlYL+AqZQq/JcEI5bqzXs3s=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=uIiEvEBPiK+yf9A4r1PASVP03u4adxEMo+tPmxZcsZ+HQ7cae8VwkGe4omfC9JgecIt62+lXNcKPcVvB56L+WGo1Ju/AYAhXxs9F0yt4AqW481XfKvCkIprz1g0qRJtZTEW+1bl+uqDM/kvCcQDtPCUyXNjceHINtiBjQt6wm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=WzLR1axz; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="WzLR1axz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786810172;
	bh=2HZtJ5MrP8KDGrN133O/JlYL+AqZQq/JcEI5bqzXs3s=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=WzLR1axz4j6/twlF8xiR93obSNDUtgr8l7RvUwKkksWtyIFGm9j0fD3+C/SjpWUi2
	 N6bFjh4d0t6gGIuj+Ysq15rjqzwKtx6VsbBkCl7VDH0PLrEtLDCGS+tEEZkBYUCm7L
	 mM8oUOI+bDVSVfh/xcHJDrY6XosQG+N1R4BAeApQ=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hMkZ419TdzGp8w;
	Sat, 15 Aug 2026 16:09:32 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hMkZ35ZyjzGp3p;
	Sat, 15 Aug 2026 16:09:31 +0000 (UTC)
Date: Sat, 15 Aug 2026 17:09:30 +0100
From: Bradley Morgan <include@grrlz.net>
To: joel.granados@kernel.org
CC: akpm@linux-foundation.org, hannes@cmpxchg.org, jackmanb@google.com,
 kees@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shijianlin11@foxmail.com, shuah@kernel.org, surenb@google.com,
 vbabka@kernel.org, ziy@nvidia.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/4=5D_sysctl=3A_Disallow_partia?=
 =?US-ASCII?Q?l_updates_of_miss-formatted_sysctl_vectors?=
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
Message-ID: <5F021629-DD85-4941-8263-3C4F51E9D6BD@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit


Copy it, only write back once every value converted. That's the
right way to do this. Went through the whole series against the
tree, notes in the patch replies.

Some nits on the series:
- "miss-formatted" in the subject. mis-formatted, or just malformed.
- akpm's scalars nit still applies.
- Sashiko saw something on this one (akpm linked it).

Otherwise fine by me, the split is clean.


Reviewed-by: Bradley Morgan <include@grrlz.net>
also

Tested-by: Bradley Morgan <include@grrlz.net> for the test


Thanks!
